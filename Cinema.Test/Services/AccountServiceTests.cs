using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using Cinema.DataAccess;
using Cinema.DataAccess.Repositories;
using Cinema.Services;
using Cinema.Services.Helpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;

namespace Cinema.Test.Services
{
    [TestClass]
    public class AccountServiceTests
    {
        private AccountService _accountService;

        private IQueryable<Account> _data;

        [TestInitialize]
        public void Initialize()
        {
            _data = new List<Account>()
            {
                new Account()
                {
                    Profile = new Profile()
                    {
                        Email = "somemail@mail.com"
                    },
                    Password = "somepassword",
                    Login = "somelogin"
                },
                new Account()
                {
                    Profile = new Profile()
                    {
                        Email = "somemail2@mail.com"
                    },
                    Password = "somepassword2",
                    Login = "somelogin2"
                }
            }.AsQueryable();

            var dbSetMock = new Mock<DbSet<Account>>();
            dbSetMock.As<IQueryable<Account>>().Setup(x => x.Provider).Returns(_data.Provider);
            dbSetMock.As<IQueryable<Account>>().Setup(x => x.Expression).Returns(_data.Expression);
            dbSetMock.As<IQueryable<Account>>().Setup(x => x.ElementType).Returns(_data.ElementType);
            dbSetMock.As<IQueryable<Account>>().Setup(x => x.GetEnumerator()).Returns(_data.GetEnumerator);

            var dbContextMock = new Mock<CinemaDatabaseEntities>();
            dbContextMock.Setup(x => x.Accounts).Returns(dbSetMock.Object);

            _accountService = new AccountService(new UnitOfWork(dbContextMock.Object, new AccountRepository(dbContextMock.Object),
                    new GenreRepository(dbContextMock.Object), new MovieRepository(dbContextMock.Object),
                    new PersonRepository(dbContextMock.Object), new SeanceRepository(dbContextMock.Object),
                    new SecurityTokenRepository(dbContextMock.Object)));

            foreach (Account account in _data)
            {
                _accountService.CreatePassword(account);
            }
        }

        [TestMethod]
        public void CreatePasswordSuccess()
        {
            var account = _data.First();
            Assert.AreEqual(account.Password, PasswordManager.GenerateSaltedPassword("somepassword", account.Salt));
        }

        [TestMethod]
        public void CreatePasswordFailed()
        {
            var password = "somepassword";
            var account = new Account()
            {
                Password = password
            };
            _accountService.CreatePassword(account);
            Assert.AreNotEqual(account.Password, PasswordManager.GenerateSaltedPassword(password + "2", account.Salt));
        }

        [TestMethod]
        public void IsValidLoginDataSuccess()
        {
            var account = new Account()
            {
                Login = "somelogin",
                Password = "somepassword"
            };
            Assert.IsTrue(_accountService.IsValidLoginData(account));
        }

        [TestMethod]
        public void IsvalidLoginDataWrongPassword()
        {
            var account = new Account()
            {
                Login = "somelogin",
                Password = "somewrongpassword"
            };
            Assert.IsFalse(_accountService.IsValidLoginData(account));
        }

        [TestMethod]
        public void IsExistUsernameSuccess()
        {
            Assert.IsTrue(_accountService.IsExistUsername("somelogin"));
            Assert.IsFalse(_accountService.IsExistUsername("somewronglogin"));
            Assert.IsTrue(_accountService.IsExistUsername("somelogin2"));
        }

        [TestMethod]
        public void IsExistEmailSuccess()
        {
            Assert.IsTrue(_accountService.IsExistEmail("somemail@mail.com"));
            Assert.IsTrue(_accountService.IsExistEmail("SOMEMAIL@MAIL.COM"));
            Assert.IsTrue(_accountService.IsExistEmail("someMAIL@mail.COM"));
            Assert.IsFalse(_accountService.IsExistEmail("somewrongmail@mail.com"));
        }
    }
}