using System;
using System.Threading.Tasks;
using MediatR;
using Microsoft.AspNetCore.SignalR;
//using Application.Comments;

namespace API.SignalR
{
   public class ChatHub : Hub
   {
      private readonly IMediator _mediator;
      public ChatHub(IMediator mediator)
      {
         _mediator = mediator;
      }

      public async Task SendComment( Application.Comments.Create.Command command)
      {
         var comment = await _mediator.Send(command);

         await Clients.Group(command.ActivityId.ToString())
             .SendAsync("ReceiveComment", comment.Value);
      }

      public override async Task OnConnectedAsync()
      {
         var httpContext = Context.GetHttpContext();
         var activityId = httpContext.Request.Query["activityId"];
         await Groups.AddToGroupAsync(Context.ConnectionId, activityId);
         var result = await _mediator.Send(new  Application.Comments.List.Query { ActivityId = Guid.Parse(activityId) });
         await Clients.Caller.SendAsync("LoadComments", result.Value);
      }
   }
}