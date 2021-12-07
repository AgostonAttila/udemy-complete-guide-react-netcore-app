
using Application.Activities;

var builder = WebApplication.CreateBuilder(args);

//services
builder.Services.AddControllers(opt =>
          {
              var policy = new AuthorizationPolicyBuilder().RequireAuthenticatedUser().Build();
              opt.Filters.Add(new AuthorizeFilter(policy));
          })
             .AddFluentValidation(config =>
          {
              config.RegisterValidatorsFromAssemblyContaining<Create>();
          });
builder.Services.AddApplicationServices(builder.Configuration);
builder.Services.AddIdentityServices(builder.Configuration);


//middlewares http request pipeline
var app = builder.Build();
app.UseMiddleware<ExceptionMiddleware>();

app.UseXContentTypeOptions();
app.UseReferrerPolicy(opt => opt.NoReferrer());//
app.UseXXssProtection(opt => opt.EnabledWithBlockMode());//cross site scripting
app.UseXfo(opt => opt.Deny());//not use as iframe
app.UseCsp(opt => opt  //content security policy
      .BlockAllMixedContent()
    .StyleSources(s => s.Self().CustomSources(
        "https://fonts.googleapis.com",
        //"sha256-/epqQuRElKW1Z83z1Sg8Bs2MKi99Nrq41Z3fnS2Nrgk=",
        //"sha256-2aahydUs+he2AO0g7YZuG67RGvfE9VXGbycVgIwMnBI=",
        "sha256-iv4u281ryDFvLnNHPRS71LdIH1GQfkYMSMdyLM24i2M="
    ))
    .FontSources(s => s.Self().CustomSources(
        "https://fonts.gstatic.com", "data:"
    ))
    .FormActions(s => s.Self())
    .FrameAncestors(s => s.Self())
    .ImageSources(s => s.Self().CustomSources(
        "https://res.cloudinary.com",
        "https://www.facebook.com",
        "https://platform-lookaside.fbsbx.com"
        ))
    .ScriptSources(s => s.Self()
        .CustomSources(
            //"sha256-HIgflxNtM43xg36bBIUoPTUuo+CXZ319LsTVRtsZ/VU=",
            "https://connect.facebook.net",
            //"sha256-3x3EykMfFJtFd84iFKuZG0MoGAo5XdRfl3rq3r//ydA=",
            "sha256-9/w7jvgjQw+D8m+9ldkAdMiCh4jAt6zdjD6Zig27Prs=",
            "sha256-3xI/RwSu97oTc/z0YwU7hP7sGn7xhd8/kS+brVdThMM="
         ))
);

//"sha256-3xI/RwSu97oTc/z0YwU7hP7sGn7xhd8/kS+brVdThMM="

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "API v1"));
}
else
{
    app.Use(async (context, next) =>
    {
        context.Response.Headers.Add("Strict-Transport-Security", "max-age=315");
        await next.Invoke();
    });
}

// app.UseHttpsRedirection();



app.UseDefaultFiles();
app.UseStaticFiles();

app.UseCors("CorsPolicy");

app.UseAuthentication();
app.UseAuthorization();


app.MapControllers();
app.MapHub<ChatHub>("/chat");
app.MapFallbackToController("Index", "Fallback");

AppContext.SetSwitch("Npgsql.EnableLegacyTimestampBehavior", true);

using var scope = app.Services.CreateScope();

var services = scope.ServiceProvider;

try
{
    var context = services.GetRequiredService<DataContext>();
    var userManager = services.GetRequiredService<UserManager<AppUser>>();
    await context.Database.MigrateAsync();
    await Seed.SeedData(context, userManager);
}
catch (Exception ex)
{
    var logger = services.GetRequiredService<ILogger<Program>>();
    logger.LogError(ex, "An error occured during migraiton");
}
await app.RunAsync();
