using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
//using Application.Profiles;

namespace API.Controllers
{
    public class ProfilesController : BaseApiController
    {
        [HttpGet("{username}")]
        public async Task<IActionResult> GetProfile(string username)
        {
            return HandleResult(await Mediator.Send(new Application.Profiles.Details.Query { Username = username }));
        }

        [HttpPut]
        public async Task<IActionResult> Edit(Application.Profiles.Edit.Command command)
        {
            return HandleResult(await Mediator.Send(command));
        }

        [HttpGet("{username}/activities")]
        public async Task<IActionResult> GetUserActivities(string username, string predicate)
        {
            return HandleResult(await Mediator.Send(new Application.Profiles.ListActivities.Query
            { Username = username, Predicate = predicate }));
        }


    }
}