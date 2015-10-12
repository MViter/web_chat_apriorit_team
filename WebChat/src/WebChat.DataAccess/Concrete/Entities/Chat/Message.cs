using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WebChat.DataAccess.Concrete.Entities.Identity;

namespace WebChat.DataAccess.Concrete.Entities.Chat
{
    public class Message
    {
        public long Id { get; set; }
        public int Dialog_id { get; set; }
        public string Text { get; set; }
        public DateTime SendedAt { get; set; }
        public int Sender_id { get; set; }
        public virtual Dialog Dialog { get; set; }
        public virtual AppUser Sender { get; set; }
    }
}
