using System;
using System.Collections.Generic;
using System.Linq.Expressions;

namespace Cinema.DataAccess.Repositories.Contracts
{
    public interface IRepository<TEntity>
    {
        TEntity Get(int id);

        IEnumerable<TEntity> GetAll();

        IEnumerable<TEntity> Find(Expression<Func<TEntity, bool>> predicate);

        void Add(TEntity entity);

        void Remove(TEntity entity);

        void Update(TEntity entityToUpdate);
    }
}