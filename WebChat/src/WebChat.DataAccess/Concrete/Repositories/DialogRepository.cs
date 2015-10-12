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
    public class DialogRepository : IRepository<Dialog>
    {
        private WebChatDbContext _context;
        public DialogRepository()
        {
            _context = WebChatDbContext.GetInstance();
        }
        public IEnumerable<Dialog> All
        {
            get { return _context.Dialog.AsQueryable(); }
        }

        public void Create(Dialog item)
        {
            _context.Dialog.Add(item);
        }

        public void Delete(dynamic Id)
        {
            int id = (int)Id;
            var dialogForDelete = _context.Dialog.Find(id);
            _context.Dialog.Remove(dialogForDelete);
        }

        public Dialog Find(Func<Dialog, bool> predicate)
        {
            return _context.Dialog.Where(predicate).AsQueryable().FirstOrDefault();
        }

        public Dialog GetById(dynamic Id)
        {
            int id = (int) Id;
            return _context.Dialog.Find(id);
        }

        public void Update(Dialog item)
        {
            _context.Entry(item).State = EntityState.Modified;
        }
    }
}
