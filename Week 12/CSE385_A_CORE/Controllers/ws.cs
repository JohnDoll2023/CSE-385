using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CSE385_A_CORE.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class ws : ControllerBase {

        // https://localhost:????/ws/GetEmployees
        [Route("getEmployees/{count?}")]                // ? means the parameter is optional
        public IActionResult getEmployees(int count) {
            List<Object> lst = new List<Object>();
            string[] fns = { "John", "Peter", "Sally", "Mike", "Tom", "Cindy", "Nina", "Paula", "Sandy", "Brian", "Scott" };
            string[] lns = { "Letherman", "Kline", "Hall", "Dickerson", "Anderson", "Smith", "Stahr", "Thompson", "Gates", "Jackson", "Peterson" };

            for (int i = 0; i < (count == 0 ? 10 : count); i++)
            {
                string fn = fns[(new Random()).Next(fns.Length - 1)];
                string ln = lns[(new Random()).Next(lns.Length - 1)];
                lst.Add(new { empId = i, firstName = fn, lastName = ln, age = (new Random()).Next(19, 27), avatar = "https://robohash.org/"+ fn+ln });
            }
            return Ok(lst.ToList());
        }


    }
}
