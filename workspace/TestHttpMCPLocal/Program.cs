var builder = WebApplication.CreateBuilder(args);

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Run on port 8094
builder.WebHost.UseUrls("http://0.0.0.0:8094");

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// Comment out HTTPS redirect for HTTP-only testing
// app.UseHttpsRedirection();

// Health check
app.MapGet("/health", () => new { status = "healthy", timestamp = DateTime.UtcNow });

// MCP Tool 1: How is Ari
app.MapGet("/mcp/how-is-ari", () => 
{
    return new { result = "ari is super holy zus he is with rabbi nachman" };
})
.WithName("HowIsAri")
.WithOpenApi();

// MCP Tool 2: What Ari Thinks About
app.MapPost("/mcp/what-ari-thinks", (ThinkRequest request) => 
{
    var query = request.Query.ToLower();
    
    string response;
    
    if (query.Contains("openai") || query.Contains("open ai") || 
        query.Contains("gpt") || query.Contains("gp"))
    {
        response = "EVIL!";
    }
    else if (query.Contains("claude"))
    {
        response = "chatty buddy!";
    }
    else
    {
        response = "ari still thinking about it";
    }
    
    return new { result = response };
})
.WithName("WhatAriThinks")
.WithOpenApi();

app.Run();

// Request model
record ThinkRequest(string Query);