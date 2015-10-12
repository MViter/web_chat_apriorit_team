using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WebChat.DataAccess.Abstract;
using WebChat.DataAccess.Concrete.DataBase;
using WebChat.DataAccess.Concrete.Entities.Chat;

namespace WebChat.DataAccess.Concrete.Repositories
{
    public class MessageRepository : IRepository<Message>
    {
        private WebChatDbContext _context;
        public MessageRepository()
        {
            _context = WebChatDbContext.GetInstance();
        }
        public IEnumerable<Message> All
        {
            get { return _context.Message.AsQueryable(); }
        }

        public void Create(Message item)
        {
            _context.Message.Add(item);
        }

        public void Delete(dynamic Id)
        {
            long id = (long) Id;
            var messageForDelete = _context.Message.Find(id);
            _context.Message.Remove(messageForDelete);
        }

        public Message Find(Func<Message, bool> predicate)
        {
            return _context.Message.Where(predicate).AsQueryable().FirstOrDefault();
        }

        public Message GetById(dynamic Id)
        {
            long id = (long)Id;
            return _context.Message.Find(id);
        }

        public void Update(Message item)
        {
            _context.Entry(item).State = EntityState.Modified;
        }
    }
}
