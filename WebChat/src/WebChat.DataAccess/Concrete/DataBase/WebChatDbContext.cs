using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WebChat.DataAccess.Concrete.Entities.Chat;
using WebChat.DataAccess.Concrete.Entities.Customer_apps;
using WebChat.DataAccess.Concrete.Entities.Identity;

namespace WebChat.DataAccess.Concrete.DataBase
{
    public class WebChatDbContext : IdentityDbContext<AppUser,
                                                      AppRole, 
                                                      int,
                                                      AppUserLogin,
                                                      AppUserRole,
                                                      AppUserClaim>
    {
        public static DbConnection dbConnection;
        public static string connectionString;
        private WebChatDbContext() : base("Server=DESKTOP-MBAVH5O;Database=LiveChatDb;Trusted_Connection=True;")
        {
        }
        private WebChatDbContext(DbConnection dbConnection) : base(dbConnection, contextOwnsConnection: true)
        {                         
        }
        private WebChatDbContext(string connectionString) : base(connectionString)
        {
        }

        public static WebChatDbContext GetInstance()
        {
            if (dbConnection != null)
                return new WebChatDbContext(dbConnection);
            else if(!string.IsNullOrEmpty(connectionString))
                return new WebChatDbContext(connectionString);
            else
                return new WebChatDbContext();
        }

        public string GenerateCustomerAppKey()
        {
            return Database.SqlQuery<string>("SELECT dbo.GenerateAppKey()").FirstOrDefault();
        }

        #region Tables
        public virtual DbSet<CustomerApplication> CustomerApplication { get; set; }
        public virtual DbSet<Dialog> Dialog { get; set; }
        public virtual DbSet<Message> Message { get; set; }

                                        #endregion

        protected override void OnModelCreating(DbModelBuilder builder)
        {
            base.OnModelCreating(builder);

            builder.Entity<AppUser>().ToTable("User");
            builder.Entity<AppRole>().ToTable("Role");
            builder.Entity<AppUserClaim>().ToTable("UserClaim");
            builder.Entity<AppUserRole>().ToTable("UserRole");
            builder.Entity<AppUserLogin>().ToTable("UserLogin");

            /*--------------------Customer Application Table----------------------------------*/

            builder.Entity<CustomerApplication>()
                .HasKey<int>(app => app.Id)
                .HasMany(app => app.RelatedUsers)
                    .WithOptional(user => user.RelatedApplication)
                    .HasForeignKey(user => user.RelatedApplication_Id);

            builder.Entity<CustomerApplication>()
                .HasRequired(app => app.Owner)
                    .WithMany(user => user.myOwnApplications)
                    .HasForeignKey(app => app.OwnerUser_Id);

            builder.Entity<CustomerApplication>()
                .Property(app => app.ContactEmail).IsRequired();

            builder.Entity<CustomerApplication>()
                .Property(app => app.WebsiteUrl).IsRequired();

/*-------------------------------Dialog Table----------------------------------------*/

            builder.Entity<Dialog>()
                .HasKey<int>(dialog => dialog.Id)
                .HasMany(dialog => dialog.Messages)
                    .WithRequired(message => message.Dialog)
                    .HasForeignKey(message => message.Dialog_id);

            builder.Entity<Dialog>()
                .HasMany(dialog => dialog.Users)
                .WithMany(user => user.Dialogs)
                .Map(m => m.ToTable("UserDialog")
                    .MapLeftKey("Dialog_Id")
                    .MapRightKey("User_Id"));

            builder.Entity<Dialog>()
                .Property(dialog => dialog.StartedAt).IsRequired();

            builder.Entity<Dialog>()
                .Property(dialog => dialog.ClosedAt).IsRequired();

/*-------------------------------Dialog Table----------------------------------------*/

            builder.Entity<Message>()
                .HasKey<long>(message => message.Id)
                .HasRequired(message => message.Sender)
                    .WithMany(user => user.Messages)
                    .HasForeignKey(message => message.Sender_id);

            builder.Entity<Message>()
                .Property(message => message.SendedAt).IsRequired();

            builder.Entity<Message>()
               .Property(message => message.Text).IsRequired();

        }
    }
}
