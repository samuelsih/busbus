FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS build-env
WORKDIR /app

COPY BusBookingProject/*.csproj ./
RUN dotnet restore

COPY . .
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/framework/runtime:4.8
WORKDIR /app
COPY --from=build-env /app/out .

ENTRYPOINT [ "dotnet", "BusBooking.dll" ]