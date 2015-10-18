using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WebChat.DataAccess.Abstract;
using WebChat.DataAccess.Concrete.DataBase;
using WebChat.DataAccess.Concrete.Entities.Customer_apps;

namespace WebChat.DataAccess.Concrete.Repositories
{
    public class CustomerApplicationRepository : IRepository<CustomerApplication>
    {
        private WebChatDbContext _context;
        public CustomerApplicationRepository()
        {
            _context = WebChatDbContext.GetInstance();
        }

        public string GenerateAppKey()
        {
            return _context.GenerateCustomerAppKey();
        }

        public IEnumerable<CustomerApplication> All
        {
            get { return _context.CustomerApplication.AsQueryable(); }
        }

        public void Create(CustomerApplication item)
        {
            _context.CustomerApplication.Add(item);
        }

        public void Delete(dynamic Id)
        {
            int id = (int)Id;
            var dialogForDelete = _context.Dialog.Find(id);
            _context.Dialog.Remove(dialogForDelete);
        }

        public CustomerApplication Find(Func<CustomerApplication, bool> predicate)
        {
            return _context.CustomerApplication.Where(predicate).FirstOrDefault();
        }

        public CustomerApplication GetById(dynamic Id)
        {
            int id = (int)Id;
            return _context.CustomerApplication.Find(id);
        }

        public void Update(CustomerApplication item)
        {
            _context.Entry(item).State = EntityState.Modified;
        }
    }
}
