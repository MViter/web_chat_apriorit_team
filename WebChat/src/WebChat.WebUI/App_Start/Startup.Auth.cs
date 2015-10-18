using System;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.Google;
using Owin;
using WebChat.WebUI.Models;
using WebChat.DataAccess.Concrete.DataBase;
using WebChat.BusinessLogic.Managers;
using WebChat.DataAccess.Concrete.Entities.Identity;
using Microsoft.Owin.Security;
using WebChat.DataAccess.Abstract;
using WebChat.DataAccess.Concrete;

namespace WebChat.WebUI
{
    public partial class Startup
    {
        // Дополнительные сведения о настройке проверки подлинности см. по адресу: http://go.microsoft.com/fwlink/?LinkId=301864
        public void ConfigureAuth(IAppBuilder app)
        {
            // Настройка контекста базы данных, диспетчера пользователей и диспетчера входа для использования одного экземпляра на запрос
            app.CreatePerOwinContext(WebChatDbContext.GetInstance);
            app.CreatePerOwinContext<AppUserManager>(AppUserManager.Create);
            app.CreatePerOwinContext<AppSignInManager>(AppSignInManager.Create);

            app.CreatePerOwinContext<IUnitOfWork>(EfUnitOfWork.GetInstance);

            app.SetDefaultSignInAsAuthenticationType(DefaultAuthenticationTypes.ApplicationCookie);
            app.UseCookieAuthentication(new CookieAuthenticationOptions
            {
                AuthenticationType = DefaultAuthenticationTypes.ApplicationCookie,
                LoginPath = new PathString("/Account/Login"),
                Provider = new CookieAuthenticationProvider
                {
                    // Позволяет приложению проверять метку безопасности при входе пользователя.
                    // Эта функция безопасности используется, когда вы меняете пароль или добавляете внешнее имя входа в свою учетную запись.  
                    OnValidateIdentity = SecurityStampValidator.OnValidateIdentity<AppUserManager, AppUser, int>(
                        validateInterval: TimeSpan.FromMinutes(30),
                        regenerateIdentityCallback: (manager, user) => user.GenerateUserIdentityAsync(manager),
                        getUserIdCallback: (id) => (id.GetUserId<int>()))
                }
            });            
                       
            app.UseTwitterAuthentication(
               consumerKey: "hpZUrEInHVdFmVJJmfBswuS7G",
               consumerSecret: "iFapdkAi2k3OwKS9gq3eyPSsY2UVUSEAygF5WndsSQIxOfFT4s"
            );

            app.UseFacebookAuthentication(
               appId: "1594773760771878",
               appSecret: "5175b70906e8e324236195b11db5a04e"
            );
        }
    }
}