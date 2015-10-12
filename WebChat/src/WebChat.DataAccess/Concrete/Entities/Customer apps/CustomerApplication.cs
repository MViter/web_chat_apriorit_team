using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WebChat.DataAccess.Concrete.Entities.Identity;

namespace WebChat.DataAccess.Concrete.Entities.Customer_apps
{
    public class CustomerApplication
    {
        public CustomerApplication()
        {
            RelatedUsers = new HashSet<AppUser>();
        }
        public int Id { get; set; }       
        public string AppKey { get; set; }
        public int OwnerUser_Id { get; set; }
        public string WebsiteUrl { get; set; }
        public string SubjectScope { get; set; }
        public string ContactEmail { get; set; }
        public virtual AppUser Owner { get; set; }
        public virtual ICollection<AppUser> RelatedUsers { get; set; }
    }
}
