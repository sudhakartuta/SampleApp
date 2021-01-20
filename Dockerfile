FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2

WORKDIR /app


RUN apt-get update

COPY --from=build-env /app/out .

EXPOSE 80

ENTRYPOINT ["dotnet","SampleApp.dll"]


