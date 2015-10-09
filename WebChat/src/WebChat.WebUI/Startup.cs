using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(WebChat.WebUI.Startup))]
namespace WebChat.WebUI
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
