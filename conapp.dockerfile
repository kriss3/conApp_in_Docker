FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /AppCounter
LABEL author="Kriss3"

# Copy everything
COPY . ./

# Restore layers
RUN dotnet restore Dotnet.Docker.csproj

# Build and publish Release version
RUN dotnet publish Dotnet.Docker.csproj -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /AppCounter
COPY --from=build-env /AppCounter/out .
ENTRYPOINT ["dotnet", "DotNet.Docker.dll"]



