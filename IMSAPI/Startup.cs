using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(IMSAPI.Startup))]
namespace IMSAPI
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
