using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using WebChat.DataAccess.Concrete.Entities.Chat;
using WebChat.DataAccess.Concrete.Entities.Customer_apps;

namespace WebChat.DataAccess.Concrete.Entities.Identity
{
    public class AppUser : IdentityUser<int, AppUserLogin, AppUserRole, AppUserClaim>
    {

        public virtual ICollection<Message> Messages { get; set; }     
        public virtual ICollection<Dialog> Dialogs { get; set; }

        public int? RelatedApplication_Id { get; set; }
        public virtual CustomerApplication RelatedApplication { get; set; }
        public virtual ICollection<CustomerApplication> myOwnApplications { get; set; } //для владельцев

        public async Task<ClaimsIdentity> GenerateUserIdentityAsync(UserManager<AppUser, int> manager)
        {
            var userIdentity = await manager.CreateIdentityAsync(this, DefaultAuthenticationTypes.ApplicationCookie);
            
            return userIdentity;
        }
    }
}
