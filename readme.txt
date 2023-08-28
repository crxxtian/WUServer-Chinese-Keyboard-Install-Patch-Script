Software Update Services server on Windows 11 is blocking downloads for things like Windows Store and Language Pack downloads.

Main issue: Users not able to install Chinese keyboard features such as "Basic typing" for assignments. 

This powershell script will do the following if ran as administrator:
1. Set the UseWUServer registry value to 0 
(Default is set to 1, to configure Automatic Updates to use a server that is running Software Update Services instead of Windows Update)
2. Stop Windows Update service
3. Wait for the service to stop
4. Delete cache from SoftwareDistribution folder
5. Start Windows Update service
6. Wait for the service to start

User should now have proper functionality. 
 
