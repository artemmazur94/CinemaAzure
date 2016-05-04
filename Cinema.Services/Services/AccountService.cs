using System;
using System.Collections.Generic;
using System.Linq;
using Cinema.DataAccess;
using Cinema.Services.Contracts;
using Cinema.Services.Helpers;

namespace Cinema.Services
{
    public class AccountService : IAccountService
    {
        private readonly IUnitOfWork _unitOfWork;

        private const string PROTOCOL_TYPE_URL = "https://";
        private const string UPDATE_PASSWORD_ACTION_URL = "/Account/UpdatePassword?token=";

        public AccountService(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public void Commit()
        {
            _unitOfWork.Commit();
        }

        public void CreatePassword(Account account)
        {
            CreatePassword(account, account.Password);
        }

        private void CreatePassword(Account account, string password)
        {
            account.Salt = PasswordManager.GenerateSalt(16);
            account.Password = PasswordManager.GenerateSaltedPassword(password, account.Salt);
        }

        public bool IsValidLoginData(Account account)
        {
            string salt = _unitOfWork.AccountRepository.GetAccountByUsername(account.Login).Salt;
            account.Password = PasswordManager.GenerateSaltedPassword(account.Password, salt);
            return _unitOfWork.AccountRepository.IsValidLoginData(account);
        }

        public bool IsExistUsername(string username)
        {
            return _unitOfWork.AccountRepository.IsExistUsername(username);
        }

        public bool IsExistEmail(string email)
        {
            return _unitOfWork.AccountRepository.IsExistEmail(email);
        }

        public void RestorePassword(string email, string restoreDomain)
        {
            var account = _unitOfWork.AccountRepository.Find(x => x.Profile.Email == email).First();
            var guid = Guid.NewGuid();
            _unitOfWork.SecurityTokenRepository.Add(new SecurityToken()
            {
                AccountId = account.Id,
                Id = guid,
                ResetRequestDateTime = DateTime.UtcNow
            });
            var restoreUrl = CombineRestoreUrl(restoreDomain, guid.ToString());
            EmailManager.RestorePasswordEmail(restoreUrl, email,$"{account.Profile.Name} {account.Profile.Surname}");
        }

        private string CombineRestoreUrl(string domain, string token)
        {
            return PROTOCOL_TYPE_URL + domain + UPDATE_PASSWORD_ACTION_URL + token;
        }

        public string GetUsernameByToken(Guid token)
        {
            return _unitOfWork.SecurityTokenRepository.GetUsernameByToken(token);
        }

        public void UpdatePassword(string username, string password)
        {
            var account = _unitOfWork.AccountRepository.Find(x => x.Login == username).First();
            account.Password = PasswordManager.GenerateSaltedPassword(password, account.Salt);
            _unitOfWork.AccountRepository.Update(account);
        }

        public void UseSecurityToken(Guid token)
        {
            var securityToken = _unitOfWork.SecurityTokenRepository.Find(x => x.Id == token).First();
            securityToken.IsUsed = true;
            _unitOfWork.SecurityTokenRepository.Update(securityToken);
        }

        public void ChangePassword(string login, string newPassword)
        {
            Account account = _unitOfWork.AccountRepository.GetAccountByUsername(login);
            CreatePassword(account, newPassword);
        }

        public Profile GetProfileByUsername(string username)
        {
            return _unitOfWork.AccountRepository.GetAccountByUsername(username).Profile;
        }
        
        public void AddAccount(Account account)
        {
            _unitOfWork.AccountRepository.Add(account);
        }

        public Profile GetProfile(int id)
        {
            return _unitOfWork.AccountRepository.GetProfile(id);
        }

        public Profile GetProfileByEmail(string email)
        {
            return _unitOfWork.AccountRepository.GetProfileByEmail(email);
        }

        public bool IsExistExternalAccount(string userIdentity, int externalProviderId)
        {
            return _unitOfWork.AccountRepository.IsExistExternalAccount(userIdentity, externalProviderId);
        }

        public void AddExternalAccount(ExternalAccount externalAccount)
        {
            _unitOfWork.AccountRepository.AddExternalAccount(externalAccount);
        }

        public List<ExternalProvider> GetNonAttachedExternalProviders(int profileId)
        {
            return _unitOfWork.AccountRepository.GetNonAttachedExternalProviders(profileId);
        }

        public bool IsAttachedExternalAccount(int profileId, int externalProviderId)
        {
            return _unitOfWork.AccountRepository.IsAttachedExternalAccount(profileId, externalProviderId);
        }

        public bool IsAttachedExternalAccountToCurrentProfile(string userIdentity, int externalProviderId, int profileId)
        {
            return _unitOfWork.AccountRepository.IsAttachedExternalAccountToCurrentProfile(
                userIdentity, externalProviderId, profileId);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (disposing)
            {
                _unitOfWork.Dispose();
            }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}