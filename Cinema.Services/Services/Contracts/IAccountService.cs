using System;
using System.Collections.Generic;
using Cinema.DataAccess;

namespace Cinema.Services.Contracts
{
    public interface IAccountService: IDisposable
    {
        void Commit();

        void CreatePassword(Account account);

        bool IsValidLoginData(Account account);

        bool IsExistUsername(string username);

        bool IsExistEmail(string email);

        void RestorePassword(string email, string restoreDomain);

        string GetUsernameByToken(Guid token);

        void UpdatePassword(string username, string password);

        void UseSecurityToken(Guid token);

        void ChangePassword(string login, string newPassword);

        Profile GetProfileByUsername(string username);
        
        void AddAccount(Account profile);

        Profile GetProfile(int id);

        Profile GetProfileByEmail(string email);

        bool IsExistExternalAccount(string userIdentity, int externalProviderId);

        void AddExternalAccount(ExternalAccount externalAccount);

        List<ExternalProvider> GetNonAttachedExternalProviders(int profileId);

        bool IsAttachedExternalAccount(int profileId, int externalProviderId);

        bool IsAttachedExternalAccountToCurrentProfile(string userIdentity, int externalProviderId, int profileId);
    }
}