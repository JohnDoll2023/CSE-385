using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(SQLInjection.Startup))]
namespace SQLInjection
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
