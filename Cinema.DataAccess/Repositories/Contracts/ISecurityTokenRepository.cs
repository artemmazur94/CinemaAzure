using System;

namespace Cinema.DataAccess.Repositories.Contracts
{
    public interface ISecurityTokenRepository : IDisposable, IRepository<SecurityToken>
    {
        string GetUsernameByToken(Guid token);
    }
}