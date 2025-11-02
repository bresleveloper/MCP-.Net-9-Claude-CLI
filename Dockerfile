FROM codercom/code-server:latest

# Switch to root for installations
USER root

# Install prerequisites (including .NET dependencies)
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    nano \
    vim \
    unzip \
    libc6 \
    libgcc1 \
    libgssapi-krb5-2 \
    libicu-dev \
    libssl-dev \
    libstdc++6 \
    zlib1g \
    && rm -rf /var/lib/apt/lists/*

# Set .NET environment variables BEFORE installation
ENV DOTNET_ROOT=/usr/share/dotnet
ENV PATH="${PATH}:/usr/share/dotnet"

# Install .NET 8 SDK
RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh && \
    chmod +x dotnet-install.sh && \
    ./dotnet-install.sh --channel 8.0 --install-dir /usr/share/dotnet && \
    rm dotnet-install.sh && \
    ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# Verify .NET installation
RUN dotnet --version

# Pre-cache MCP NuGet packages (so they don't download each time)
RUN mkdir -p /tmp/warmup && \
    cd /tmp/warmup && \
    dotnet new console && \
    # dotnet add package Microsoft.Extensions.AI.ModelContextProtocol && \
    dotnet add package ModelContextProtocol --prerelease && \
    dotnet add package Microsoft.Extensions.Hosting && \
    dotnet restore && \
    cd / && \
    rm -rf /tmp/warmup

# Install Node.js (required for Claude Code CLI)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install Claude Code CLI globally
RUN npm install -g @anthropic-ai/claude-code

# Verify installations
RUN dotnet --version && \
    node --version && \
    npm --version && \
    claude --version

# Switch back to coder user
USER coder

WORKDIR /home/coder/workspace

# Expose code-server port
EXPOSE 8080

CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "password", "/home/coder/workspace"]