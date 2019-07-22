function Show-Custom_Mods{
    #Get-ChildItem -Path .\Documents\WindowsPowerShell\Modules
    [cmdletbinding()]
    [Alias('Custom-Mods')]
    param()

    '
INFORMATION

    help <module name> -full can be used to provide insight and examples of usage for individual Modules.

        EXAMPLE             // help New-ADUser -full
                            // help Get-SysInfo -full

-----------------------------------------------------------------------------------------------------------
DEVICE INFO

    Get-UpTime              // Get-UpTime -PC <PCName>
    Get-MemoryUsage         // Get-MemoryUsage -PC <PCName>
    Get-<ENTER SERVICE>     // Checks service this Module has been edited on input server/computer
    3rdMonitorBandaid       // 3rdMonitorBandaid -PC <PCName>
    Open-PrinterDB          // Opens Printer & Scanner Database in GUI

    Get-SysInfo             // Retreives Several Informational Pieces for input PC(s)
                            // EXAMPLES :
                               Get-SysInfo CompName
                               Get-SysInfo CompName,CompName

                               "CompName","CompName" | Get-SysInfo

                               help Get-SysInfo -full

                               "CompName","CompName" | out-file C:\Temp\Computers.txt
                               Get-Content C:\temp\Computers.txt | Get-SysInfo

                               Get-ADComputer -f * -Searchbase "ou" | select -ExpandProperty Name | Get-SysInfo
                               Get-ADComputer -f * -Searchbase "ou" | select @{l="ComputerName";e={$_.Name}} | Get-SysInfo

                               import-csv .\filename.csv | Get-SysInfo

-----------------------------------------------------------------------------------------------------------
KILL PROCESS

    Stop-CiscoJabber        // Stop-CiscoJabber -PC <PCName>
    Stop-Chrome             // Stop-Chrome -PC <PCName>
    Stop-GoogleFS           // Stop-GoogleFS -PC <PCName>
    Stop-PCSWS              // Stop-PCSWS -PC <PCName>
    Stop-IE                 // Stop-IE -PC <PCName>
    Stop-Adobe              // Stop-Adobe -PC <PCName>
    Stop-Word               // Stop-Word -PC <PCName>
    Stop-Excel              // Stop-Excel -PC <PCName>
    Stop-DocView            // Stop-DocView -PC <PCName>
    Stop-PDFCreator         // Stop-PDFCreator -PC <PCName>

-----------------------------------------------------------------------------------------------------------
LAUNCH

    Open-Pokedex            // Launches Pokedex GUI from \\<NETWORK PATH>\Pokedex.exe
    Open-KeePass            // Launches KeePass from C:\Program Files (x86)\KeePass2x\KeePass.exe
    Open-Custom_Mods        // Launches Custom-Mods Folder from \\<NETWORK PATH>\Custom_Modules\WindowsPowerShell\Modules

-----------------------------------------------------------------------------------------------------------
DESKTOP COPY - PC SWAP

    Copy-Desktop            // (PRE PC SWAP) Copy-Desktop -OldPC <PC> -NewPC <PC> -User <user> 
                                                           *OPTIONAL* -AWS <$false or $true> 
                            // -AWS defaults to $false

    Move-Desktop            // (POST PC SWAP) Move-Desktop -NewPC <PC> -User <user> 
                                                            *OPTIONAL* -AWS <$false or $true> 
                            // -AWS defaults to $false

-----------------------------------------------------------------------------------------------------------
USER TRANSFER, TERM, NEW, SESSIONCREATE

    ADUser-Transfer          // AD Transfer User Script
                             // ADUser-Transfer -UserCopyFrom <user> -UserCopyTo <user> -Dept <department> 
                                                 *OPTIONAL* -KeepPermissions <$false or $true>
                             // -KeepPermissions defaults to $false

    ADUser-Term              // AD Term User Script
                             // ADUser-Term -TermedUser <user>
                             // Advised running this Module from PShell as DA

    ADUser-New               // AD New User Script
                             // ADUser-New -NewUserFN <firstName> -NewUserLN <lastName> 
                                            -SAMAccount <FirstInitialLastName> -TempPWD <tempPassword> 
                                            -CopyFromUser <user> -Dept <department>

                 *Departments : Accounting / Cashiers / Compliance / CustomerService / DefaultDepts
                                ExecAdmin / ExecTeam / Facilities / HECM / HR / Insurance
                                InvestorReporting / Origination / Shipping / Supervisors / TaxesPayoffs
                                Treasury / IT / ServiceAccounts
                                Manual (to manually enter OU when prompted during script run)
                  
                                **ServiceAccounts & Manual not available on ADUser-Transfer**

    ADUser-P8Sessions       // ADUser-P8Sessionss -user -PC

-----------------------------------------------------------------------------------------------------------

    '

}