using Domain;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using Application.Activities;
using System.Threading;
using System.Threading.Tasks;
using System.Collections.Generic;
using System;

namespace API.Controllers
{
   [Route("api/[controller]")]
   [ApiController]
   public class ActivitiesController : ControllerBase
   {
      private readonly IMediator _mediator;

      public ActivitiesController(IMediator mediator)
      {
         _mediator = mediator;
      }


      [HttpGet]
      public async Task<ActionResult<List<Activity>>> List(CancellationToken ct)
      {
         return await _mediator.Send(new List.Query(), ct);
      }

      [HttpGet("{id}")]
      public async Task<ActionResult<Activity>> Details(Guid id)
      {
         return await _mediator.Send(new Details.Query { Id = id });
      }

      [HttpPost]
      public async Task<ActionResult<Unit>> Create(Create.Command command) //[FromBody]
      {
         return await _mediator.Send(command);
      }

      [HttpPut]
      public async Task<ActionResult<Unit>> Edit(Edit.Command command) //[FromBody]
      {
         return await _mediator.Send(command);
      }

      [HttpDelete("{id}")]
      public async Task<ActionResult<Unit>> Delete(Guid id) //[FromBody]
      {
         return await _mediator.Send(new Delete.Command { Id = id });
      }

   }
}
