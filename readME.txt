TO CREATE A WINDOWSPOWERSHELL PROFILE THAT WILL AUTOMATICALLY IMPORT THE CUSTOM JBN MODULES

Browse to "\\<NETWORK PATH>\powershell\Custom_Modules\WindowsPowerShell" -- there's a script w/ the name CreateProfile_AutoImportMods.ps1 -- run that guy & it will create a WindowsPowershell profile for you.

This profile is created in C:\Users\<you>\Documents\WindowsPowerShell\Microsoft.Powershell_profile.ps1. 

Each time you launch a Powershell window, this profile says hey go look in \\<NETWORK PATH>\Custom_Modules\WindowsPowerShell\Modules\ & import all the Modules we've created in there. 

Once the profile is created, you can open a new Powershell Window & run the cmd JBN-Mods and it will show you everything we've created so far & semi-how to use them.

To review how to use each Module in it's entirely enter the cmd help <module> -full in a Powershell Window
Example : help ADUser-New -full