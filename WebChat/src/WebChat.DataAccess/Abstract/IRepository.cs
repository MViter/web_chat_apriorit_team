using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebChat.DataAccess.Abstract
{
    public interface IRepository<T> where T : class
    {
        IEnumerable<T> All { get; }
        T GetById(dynamic Id);
        T Find(Func<T, bool> predicate);
        void Create(T item);
        void Update(T item);
        void Delete(dynamic Id);
    }
}
