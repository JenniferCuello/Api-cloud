FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR webapp

EXPOSE 80
EXPOSE 5000

#COPY PROJECT FILES.

COPY ./*.csproj ./
RUN dotnet restore

#COPY EVERITHING ELSE 

COPY . .
RUN dotnet publish -c Release -o out

#buil docker image 

FROM mcr.microsoft.com/dotnet/sdk:7.0
WORKDIR /webapp
COPY --from=build /webapp/out ./
ENTRYPOINT [ "dotnet", "ejercicios.dll" ]
