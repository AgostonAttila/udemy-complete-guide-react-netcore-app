using System;
using System.Text;
using System.Threading.Tasks;
using API.Services;
using Domain;
using Infrastructure.Security;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using Persistence;

namespace API.Extensions
{
   public static class IdenitityServiceExtensions
   {
      public static IServiceCollection AddIdentityServices(this IServiceCollection services, IConfiguration config)
      {
         services.AddIdentityCore<AppUser>(opt =>
         {
            opt.Password.RequireNonAlphanumeric = false;
         }).AddEntityFrameworkStores<DataContext>()
         .AddSignInManager<SignInManager<AppUser>>();

         var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(config["TokenKey"]));

         services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
         .AddJwtBearer(opt =>
         {
            opt.TokenValidationParameters = new TokenValidationParameters
            {
               ValidateIssuerSigningKey = true,
               IssuerSigningKey = key,
               ValidateIssuer = false,
               ValidateAudience = false
            };
            opt.Events = new JwtBearerEvents
            {
               OnMessageReceived = context =>
               {
                  var accesToken = context.Request.Query["acces_token"];
                  var path = context.HttpContext.Request.Path;
                  if (!String.IsNullOrWhiteSpace(accesToken) && (path.StartsWithSegments("/chat")))
                  {

                     context.Token = accesToken;
                  }
                  return Task.CompletedTask;
               }
            };


         });

         services.AddAuthorization(opt =>
         {
            opt.AddPolicy("IsActivityHost", policy =>
            {
               policy.Requirements.Add(new IsHostRequirement());
            });
         });

         services.AddTransient<IAuthorizationHandler, IsHostRequirementHandler>();
         services.AddScoped<TokenService>();
         return services;
      }
   }
}