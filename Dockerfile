FROM ://node:18-alpine
WORKDIR /src

# Copy all source files
COPY . .

# Restore dependencies and build the application
RUN dotnet restore "digos-ambassador.sln"
RUN dotnet publish "DIGOS.Ambassador/DIGOS.Ambassador.csproj" -c Release -o /app/publish

# Use the runtime image to run the bot
FROM ://microsoft.com AS final
WORKDIR /app
COPY --from=build /app/publish .

# Command to run the bot executable
ENTRYPOINT ["dotnet", "DIGOS.Ambassador.dll"]
