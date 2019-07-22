# Get-SysInfo COMPUTERNAME
# Get-SysInfo COMPUTERNAME,COMPUTERNAME
# "COMPUTERNAME","COMPUTERNAME" | Get-SysInfo

# help Get-SysInfo -full

# "PcName","PcName" | out-file C:\Temp\Computers.txt
# Get-Content C:\temp\Computers.txt | Get-SysInfo

# Get-ADComputer -f * -Searchbase "ou" | select -ExpandProperty Name | Get-SysInfo
# Get-ADComputer -f * -Searchbase "ou" | select @{l="ComputerName";e={$_.Name}} | Get-SysInfo

# import-csv .\filename.csv | Get-SysInfo




function Get-SysInfoTest{

    <#
    .Synopsis
       Retreive System Information
    .DESCRIPTION
       Retrieve System Information from
       one or more computers.
    .EXAMPLE
       Get-SysInfo -ComputerName 'PCName'
    .EXAMPLE
       Get-SysInfo PC1,PC2,PC3
    #>

    # [cmdletbinding(SupportShouldProcess=$True,
    #  ConfirmImpact="Medium")]

    [cmdletbinding()]
    param(
        
        # Enter one or more computer names
        [Parameter(
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true
        )]
        [string[]]$ComputerName = ".",
        # Enter the log file name
        [string]$LogFile = "C:\Logs\Test.log"

        )

    begin{}    ##begin and end block can be left out after empty. Code in Begin and end only happens one time. Process block happens for each item coming through the pipe.
    process{
        foreach($computer in $ComputerName){
            Write-Verbose "about to run Get-CIMInstance on: $Computer"
            #***   Test 1
            #Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $Computer | 
            #     Select-Object Name,TotalPhysicalMemory,Model,Manufacturer   #does not take custom formatting and is not a custom object
            #*** End Test 1

            #*** Test 2 - Customer Object Output
            $CS = Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $Computer
            $OS = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $Computer
            
            $MemoryUse = ((($OS.TotalVisibleMemorySize - $OS.FreePhysicalMemory)*100)/ $OS.TotalVisibleMemorySize)
            $MemoryRound = [math]::Round($MemoryUse,2)
            $props = @{'ComputerName' = $Computer;
                        'Build' = $OS.BuildNumber;
                        'Version' = $OS.Version;
                        'OS' = $OS.Caption;
                        'Model' = $CS.Model;
                        'Manu' = $CS.Manufacturer;
                        'Memory' = $CS.TotalPhysicalMemory;
                        'MemoryUsage' = "$MemoryRound %";
                        }
            $SysInfoOBJ = New-Object -TypeName PSObject -Property $props
            Write-Output $SysInfoOBJ
            #*** END Test 2
        }
    }
    end{} 

}