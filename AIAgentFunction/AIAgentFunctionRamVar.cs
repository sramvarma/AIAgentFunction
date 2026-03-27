using Microsoft.Agents.AI;
using Microsoft.Agents.AI.DurableTask;
using Microsoft.Azure.Functions.Worker;
using Microsoft.DurableTask;

namespace AIAgentFunction
{
    public static class AIAgentFunctionRamVar
    {
        [Function(nameof(MyOrchestration))]
        public static async Task<string> MyOrchestration(
            [OrchestrationTrigger] TaskOrchestrationContext context)
        {
            // 1. Get the durable agent instance
            DurableAIAgent agent = context.GetAgent("AIAgentRamVarName");

            // 2. Create a session (thread) for the conversation
            AgentSession session = await agent.CreateSessionAsync();

            // 3. Run the agent; state is saved to the Durable Task Scheduler
            AgentResponse response = await agent.RunAsync(
                message: "Tell me a joke about robots.",
                session: session);

            return response.Text;
        }
    }

}


    //using Microsoft.AspNetCore.Http;
    //using Microsoft.AspNetCore.Mvc;
    //using Microsoft.Azure.Functions.Worker;
    //using Microsoft.Extensions.Logging;

    //namespace AIAgentFunction;

    //public class AIAgentFunction
    //{
    //    private readonly ILogger<AIAgentFunction> _logger;

    //    public AIAgentFunction(ILogger<AIAgentFunction> logger)
    //    {
    //        _logger = logger;
    //    }

    //    [Function("AIAgentTestFunction")]
    //    public IActionResult Run([HttpTrigger(AuthorizationLevel.Function, "get", "post")] HttpRequest req)
    //    {
    //        _logger.LogInformation("C# HTTP trigger function processed a request.");
    //        return new OkObjectResult("Welcome to Azure Functions!");
    //    }
    //}