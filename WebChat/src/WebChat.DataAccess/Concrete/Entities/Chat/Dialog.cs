using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WebChat.DataAccess.Concrete.Entities.Identity;

namespace WebChat.DataAccess.Concrete.Entities.Chat
{
    public class Dialog
    {
        public Dialog()
        {
            Messages = new HashSet<Message>();
            Users = new HashSet<AppUser>();
        }

        public int Id { get; set; }
        public DateTime StartedAt { get; set; }
        public DateTime ClosedAt { get; set; }
        public virtual ICollection<Message> Messages { get; set; }
        public virtual ICollection<AppUser> Users { get; set; }
    }
}
