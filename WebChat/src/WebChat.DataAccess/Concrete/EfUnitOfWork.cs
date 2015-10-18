using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WebChat.DataAccess.Abstract;
using WebChat.DataAccess.Concrete.Entities.Chat;
using WebChat.DataAccess.Concrete.Entities.Customer_apps;
using WebChat.DataAccess.Concrete.Repositories;

namespace WebChat.DataAccess.Concrete
{
    public class EfUnitOfWork : IUnitOfWork
    {
        private IRepository<CustomerApplication> _customerApplications;
        private IRepository<Dialog> _dialogs;
        private IRepository<Message> _messages;
        public IRepository<CustomerApplication> CustomerApplications
        {
            get
            {
               if( _customerApplications == null)
                    _customerApplications = new CustomerApplicationRepository();
                return _customerApplications;
            }
        }

        public IRepository<Dialog> Dialogs
        {
            get
            {
                if (_dialogs == null)
                    _dialogs = new DialogRepository();
                return _dialogs;
            }
        }

        public IRepository<Message> Messages
        {
            get
            {
                if (_messages == null)
                    _messages = new MessageRepository();
                return _messages;               
            }
        }

        public static IUnitOfWork GetInstance()
        {
            return new EfUnitOfWork();
        }

        public void Dispose()
        {
            
        }
    }
}
