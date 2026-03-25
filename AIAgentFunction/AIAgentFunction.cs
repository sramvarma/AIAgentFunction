using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;

namespace AIAgentFunction;

public class AIAgentFunction
{
    private readonly ILogger<AIAgentFunction> _logger;

    public AIAgentFunction(ILogger<AIAgentFunction> logger)
    {
        _logger = logger;
    }

    [Function("AIAgentTestFunction")]
    public IActionResult Run([HttpTrigger(AuthorizationLevel.Function, "get", "post")] HttpRequest req)
    {
        _logger.LogInformation("C# HTTP trigger function processed a request.");
        return new OkObjectResult("Welcome to Azure Functions!");
    }
}