using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Grpc.Core;
using Microsoft.Extensions.Logging;

namespace LongRunningService
{
    public class GreeterService : Greeter.GreeterBase
    {
        private readonly ILogger<GreeterService> _logger;
        private static Managed.Executor executor = new Managed.Executor();
        public GreeterService(ILogger<GreeterService> logger)
        {
            _logger = logger;
        }

        public override Task<HelloReply> SayHello(HelloRequest request, ServerCallContext context)
        {
            byte[] frame = request.Frame.ToByteArray();
            bool result = executor.Execute();
            return Task.FromResult(new HelloReply
            {
                Message = "Hello " + request.Name + $" length: {frame?.Length}, result from back-end: {result}"
            });
        }
    }
}
