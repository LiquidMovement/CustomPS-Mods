function Move-ADUser{
    <#
    .Synopsis
       Transfer AD User to new job, Department, etc.
       Calls Script located at \\<NETWORK PATH>\Transfer.ps1 with params (args) entered
    .DESCRIPTION
       Transfer AD User to new job, Department, etc.
       Copies AD information such as MemberOf, Manager, Dept, etc. from the user enter for parameter -UserCopyFrom

       Will prompt running user (you) to verify the user you've entered before running
          through the main body of the script that performs the steps above.
       
       Parameter -KeepPermissions is not mandatory and defaults to $false automatically. 
       If the user needs to keep their current permissions, set -KeepPermissions to $true

       *Departments : Accounting / Cashiers / Compliance / CustomerService / DefaultDepts
                                ExecAdmin / ExecTeam / Facilities / HECM / HR / Insurance
                                InvestorReporting / Origination / Shipping / Supervisors / TaxesPayoffs
                                Treasury / IT
    .EXAMPLE
       ADUser-Transfer -UserCopyFrom JSmith -UserCopyTo -ACatchem -Dept DefaultDepts
    .EXAMPLE
       Move-ADUser -UserCopyFrom JSmith -UserCopyTo -ACatchem -Dept DefaultDepts -KeepPermissions $true
    #>


    [cmdletbinding()]
    [Alias('ADUser-Transfer')]
    param(
        #Enter user to copy AD information from
        [Parameter(Mandatory=$true)]
        [string]$UserCopyFrom,

        #Enter user that is being transferred
        [Parameter(Mandatory=$true)]
        [string]$UserCopyTo,

        #Enter the Department the user is transferring to
        [Parameter(Mandatory=$true)]
        [ValidateSet("Accounting", "Cashiers", "Compliance", "CustomerService", "DefaultDepts", "ExecAdmin", "ExecTeam", "Facilities", "HECM", "HR", "Insurance", "InvestorReporting", "Origination", "Shipping", "Supervisors", "TaxesPayoffs", "Treasury", "IT")]
        [string]$Dept,

        #Optional parameter in the event the user needs to retain their current AD permissions and MemberOf Groups.
        [string]$KeepPermissions = $false

        )

    Start-Process powershell.exe -WorkingDirectory C:\temp -ArgumentList "-noprofile -command &{powershell.exe \\<NETWORK PATH>\4_Modules\Transfer_4_Mods.ps1 -UserCopyFrom $UserCopyFrom -UserCopyTo $UserCopyTo -Dept $Dept -KeepPermissions $KeepPermissions}"


}




function Clear-ADUser{
    <#
    .Synopsis
       Term AD User
       Module will require Termed User param
       After Termed User param is defined, script will prompt for DA Creds.
       New Powershell Window will open as DA to run script located at : 
          \\<NETWORK PATH>\TermADUser_4_Mods.ps1 
          with Termed User param (arg)
    .DESCRIPTION
       Term AD User
       Module will require Termed User param
       After Termed User param is defined, script will prompt for DA Creds.
       New Powershell Window will open as DA to run script located at : 
          \\<NETWORK PATH>\TermADUser_4_Mods.ps1
          with Termed User param (arg)

       1. Adds Termed_Users Group & sets as Primary Group
       2. Removes all Group Memberships, Telephone, ipPhone
       3. Adds Termed + Date in Description & sets Department to TERMED
       4. Scrambles their Password
       5. Moves user to Google Termed OU
       
       Will prompt running user (you) to verify the user you've entered before running
          through the main body of the script that performs the steps above.
       
    .EXAMPLE
       ADUser-Term -TermedUser JSmith
    .EXAMPLE
       Clear-ADUser -TermedUser ACatchem
    #>

    [cmdletbinding()]
    [Alias('ADUser-Term')]
    param(
        #Enter termed User's username
        [Parameter(Mandatory=$true)]
        [string]$TermedUser

        ) 

    function Get-Creds{
        $script:pp = Get-Credential
    }

    Get-Creds

    Start-Process powershell.exe -Credential $script:pp -WorkingDirectory C:\temp -ArgumentList "-noprofile -command &{powershell.exe \\<NETWORK PATH>\4_Modules\TermADUser_4_Mods.ps1 -TermedUser $TermedUser}"


}




function Publish-NewP8Sessions{


    [cmdletbinding()]
    [Alias('ADUser-P8Sessions')]
    param(
        [Parameter(Mandatory=$true)]
        [string]$User,

        [Parameter(Mandatory=$true)]
        [ValidatePattern("(IT|D)\d{1,5}$")]
        [string]$PC

        )

    Start-Process powershell.exe -WorkingDirectory C:\temp -ArgumentList "-noprofile -command &{powershell.exe \\<NETWORK PATH>\4_Modules\Create_New_P8Sessions_4Mods.ps1 -User $User -PC $PC}"

}




function New-ADUser{
    <#
    .Synopsis
       Create New AD User
    .DESCRIPTION
       Create New AD User
       Creates new AD User based on the parameter input from the running user (you)
       Copies AD information such as Description, MemberOf, Manage, etc. from the entered user for parameter -CopyFromUser
       
       1. After entering parameter, you will be prompted for you DA credentials.
       2. After entering your DA credentials, a new Powershell Window will open using these credentials & run the script located
           at \\<NETWORK PATH>\4_Modules\NewADUser_CopyMemberOf_4Mods.ps1 with the parameters (arguments) entered for the
           New User
       3. The script checks DisplayName attribute against current AD users.
       4. If the DisplayName already exists (Last name, First name) the script will prompt the running user and terminate.
       5. Script will prompt running user if the SAMAccount, UniversalPrincipalName, and/or Email exists in AD
              *Prompts for a new value if any of the above already exist in AD.
       6. Script will prompt user to verify the entered information before creating the new user.
       7. Script will prompt user again to verify the information post creating the new user before continuing.
       8. Script will copy AD info from -CopyFromUser

       *Departments : Accounting / Cashiers / Compliance / CustomerService / DefaultDepts
                                ExecAdmin / ExecTeam / Facilities / HECM / HR / Insurance
                                InvestorReporting / Origination / Shipping / Supervisors / TaxesPayoffs
                                Treasury / IT / ServiceAccounts
                                Manual (to manually enter OU when prompted during script run)

                                *When prompted for Manual OU entry -- example : OU=Staff,DC=corp,DC=YOURDOMAIN,DC=com
    .EXAMPLE
       ADUser-New -NewUserFN Ash -NewUserLN Catchem -SAMAccount ACatchem -TempPWD Abc123! -CopyFromUser JSmith -Dept DefaultDepts
    .EXAMPLE
       New-ADUser -NewUserFN Ash -NewUserLN Catchem -SAMAccount ACatchem -TempPWD Abc123! -CopyFromUser JSmith -Dept Manual
    #>
    [cmdletbinding()]
    [Alias('ADUser-New')]
    param(
        #Enter Users First Name
        [Parameter(Mandatory=$true)]
        [string]$NewUserFN,

        #Enter Users Last Name
        [Parameter(Mandatory=$true)]
        [string]$NewUserLN,

        #Enter Users SAMAccount (typically first initial & last name)
        [Parameter(Mandatory=$true)]
        [string]$SAMAccount,

        #Enter Users Temporary Password
        [Parameter(Mandatory=$true)]
        [string]$TempPWD,

        #Enter User to copy from
        [Parameter(Mandatory=$true)]
        [string]$CopyFromUser,

        #Enter User's department
        [Parameter(Mandatory=$true)]
        [ValidateSet("Accounting", "Cashiers", "Compliance", "CustomerService", "DefaultDepts", "ExecAdmin", "ExecTeam", "Facilities", "HECM", "HR", "Insurance", "InvestorReporting", "Origination", "Shipping", "Supervisors", "TaxesPayoffs", "Treasury", "IT", "ServiceAccounts", "Manual")]
        [string]$Dept

        )
    
    function Get-Creds{
        $script:pp = Get-Credential
    }

    Get-Creds

    Start-Process powershell.exe -Credential $script:pp -WorkingDirectory C:\temp -ArgumentList "-noprofile -command &{powershell.exe \\<NETWORK PATH>\4_Modules\NewADUser_CopyMemberOf_4Mods.ps1 -NewUserFN $NewUserFN -NewUserLN $NewUserLN -SAMAccount $SAMAccount -TempPWD $TempPWD -CopyFromUser $CopyFromUser -Dept $Dept}"
    
}