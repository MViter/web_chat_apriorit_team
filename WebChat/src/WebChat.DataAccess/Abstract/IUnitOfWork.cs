using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WebChat.DataAccess.Concrete.Entities.Chat;
using WebChat.DataAccess.Concrete.Entities.Customer_apps;

namespace WebChat.DataAccess.Abstract
{
    public interface IUnitOfWork : IDisposable
    {
        IRepository<Message> Messages { get; }
        IRepository<Dialog> Dialogs { get; }
        IRepository<CustomerApplication> CustomerApplications { get; }
    }
}
