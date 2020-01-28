Guide to running the source code without first watching the course!
===================================================================

Pre-reqs.   Make sure you have the latest version of dotnet core SDK and at least version 10 of Node installed on your computer.

1.  Copy the section you wish to run into a new empty directory (optional).
2.  Open this folder in a command prompt or terminal window.
3.  At the 'Reactivities' level run the following command:

dotnet restore:

4.  Change directory into the client-app and run:

npm install

5.  Change directory back into the Reactivities folder.

6.  Open the project in VS Code.

7.  We use dotnet user-secrets to store secret information in this course, but if you want to see the project running then add the following to the appsettings.json file in the API project:

{
  "TokenKey": "super secret key",
  "Logging": {
    "LogLevel": {
      "Default": "Warning"
    }
  },
  "AllowedHosts": "*"
}

8.  If you want to see the photo upload working then you will also need a Cloudinary account and you can use the following in the appsettings.json (obviously replace the Cloudinary settings with your details).  The project will work without these but you will not be able to use the photo upload feature.

{
  "TokenKey": "super secret key",
  "Cloudinary": {
    "CloudName": "YourCloudName",
    "ApiKey": "YourAPIKey",
    "ApiSecret": "YourAPISecret"
  },
  "Logging": {
    "LogLevel": {
      "Default": "Warning"
    }
  },
  "AllowedHosts": "*"
}

9.  If you are running the 'final' source code from section 22 then you will need to change the mode the project is running in from Production to Development.  Open the launchSettings.json file (inside the API project in the properties folder).  Inside the 'API' section ensure you change the ASPNETCORE_ENVIRONMENT setting as follows:

    "API": {
      "commandName": "Project",
      "launchBrowser": true,
      "launchUrl": "api/values",
      "applicationUrl": "http://localhost:5000",
      "environmentVariables": {
        "ASPNETCORE_ENVIRONMENT": "Development"
      }
    }

10.  You should now be able to start the API.  This will also create a Sqlite DB file inside the API project and seed some initial data into the database.  Change directory into the API and run the following command:

dotnet run

11. You should now see the API project running on Port 5000.

12. In a separate terminal session inside VS Code start the React application by running the following:

npm start

13.  This should start the React application on Port 3000.   You should now be able to browse to the application on the following URL:

http://localhost:3000

14.  You can login to the application using one of the test user accounts that was seeded when you started the API.   You can use the following test user:

email:  bob@test.com
password:  Pa$$w0rd

You should now be in the app! 