using System;
using System.Collections.Generic;

namespace Cinema.DataAccess.Repositories.Contracts
{
    public interface IAccountRepository : IDisposable, IRepository<Account>
    {
        bool IsExistUsername(string username);

        bool IsExistEmail(string email);

        bool IsValidLoginData(Account account);
        
        Account GetAccountByUsername(string username);

        Profile GetProfile(int id);

        Profile GetProfileByEmail(string email);

        bool IsExistExternalAccount(string userIdentity, int externalProviderId);

        void AddExternalAccount(ExternalAccount externalAccount);

        List<ExternalProvider> GetNonAttachedExternalProviders(int profileId);

        bool IsAttachedExternalAccount(int profileId, int externalProviderId);

        bool IsAttachedExternalAccountToCurrentProfile(string userIdentity, int externalProviderId, int profileId);
    }
}