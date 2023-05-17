#Imagen de Producion
#############################################################
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base  
WORKDIR /app
EXPOSE 80
EXPOSE 443

#Imagen Build
###########################################################
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build  
WORKDIR /src
COPY ["ejercicios.csproj", "."]
RUN dotnet restore "./ejercicios.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "ejercicios.csproj" -c Release -o /app/build

#Imagen Publish
############################################################
FROM build AS publish
RUN dotnet publish "ejercicios.csproj" -c Release -o /app/publish

#Mover Publish a Final
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ejercicios.csproj.dll"]
