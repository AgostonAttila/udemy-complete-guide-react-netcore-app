using Domain;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace Persistence
{
   public class DataContext : IdentityDbContext<AppUser>
   {
      public DataContext(DbContextOptions options) : base(options)
      {
      }

      public DbSet<Activity> Activities { get; set; }
      public DbSet<ActivityAttendee> ActivityAttendees { get; set; }
      public DbSet<Photo> Photos { get; set; }
      public DbSet<Comment> Comments { get; set; }

      protected override void OnModelCreating(ModelBuilder builder)
      {
         base.OnModelCreating(builder);

         builder.Entity<ActivityAttendee>(x => x.HasKey(aa => new { aa.AppUserId, aa.ActivityId }));

         builder.Entity<ActivityAttendee>()
         .HasOne(u => u.AppUser)
         .WithMany(u => u.Activities)
         .HasForeignKey(aa => aa.AppUserId);

         builder.Entity<ActivityAttendee>()
         .HasOne(u => u.Activity)
         .WithMany(u => u.Attendees)
         .HasForeignKey(aa => aa.ActivityId);

         builder.Entity<Comment>()
           .HasOne(u => u.Activity)
         .WithMany(u => u.Comments)
         .OnDelete(DeleteBehavior.Cascade);

      }
   }
}