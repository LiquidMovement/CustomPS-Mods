function Get-UpTime{

    [cmdletbinding()]
    param(
        #[Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        [ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$PC = "."
        )

    $lastBoot = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $PC | select LastBootUpTime

    $now = Get-Date
    $bootTime = $lastBoot.LastBootUpTime

    $UpTime = $now.Subtract($bootTime)
    $days = $UpTime.Days
    $hours = $UpTime.Hours
    $minutes = $UpTime.Minutes

    "`nDays : $days `nHours : $hours `nMinutes : $minutes`n"
}



function Get-MemoryUsage{
    [cmdletbinding()]
    param(
        #[Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        [ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$PC = "."
        )

    $ComputerMemory =  Get-WmiObject -Class WIN32_OperatingSystem -ComputerName $PC
    $Memory = ((($ComputerMemory.TotalVisibleMemorySize - $ComputerMemory.FreePhysicalMemory)*100)/ $ComputerMemory.TotalVisibleMemorySize)
    $MemoryRound = [math]::Round($Memory,2)

    "`n $MemoryRound %`n"
}



function Get-<EnterService>{
    get-service -ComputerName <COMPUTER> -name <ENTER SERVICE(S)> | ft -AutoSize
}


function Invoke-3rdMonitorBandaid{
    [cmdletbinding()]
    [Alias('3rdMonitorBandaid')]
    param(
        [Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        [ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$PC
        )

    $session = New-PSSession -ComputerName $PC
    $correct = $true
    $count = 1

        Invoke-Command -Session $session -ScriptBlock {Get-PnpDevice | Where-Object {$_.FriendlyName -match "MCT USB3.0 External Graphics Device"} | Where-Object {$_.Status -ne "ERROR"} | Disable-PnpDevice -confirm:$false}
        sleep 5
        $off = Invoke-Command -Session $session -ScriptBlock {Get-PnpDevice | Where-Object {$_.FriendlyName -match "MCT USB3.0 External Graphics Device"} | Format-Table status,FriendlyName }
        $off
        Write-Host "`n"
        Write-Host "Verify device has entered 'ERROR' status."
        Write-Host "`n"
        pause
        Write-Host "`n"
        Invoke-Command -Session $session -ScriptBlock {Get-PnpDevice | Where-Object {$_.FriendlyName -match "MCT USB3.0 External Graphics Device"} | Where-Object {$_.Status -eq "ERROR"} | Enable-PnpDevice -confirm:$false}
        $on = Invoke-Command -Session $session -ScriptBlock {Get-PnpDevice | Where-Object {$_.FriendlyName -match "MCT USB3.0 External Graphics Device"} | Format-Table status,FriendlyName}
        $on

        while($correct -eq $true){
            $answer = Read-Host "Is the monitor functioning? (Y/N)"
            $count++
            if($answer -like "N"){
                Write-Host "`nYou answered $answer, running attempt $count."
                Write-Host "`n"
                $correct = $true
                sleep 3

                Invoke-Command -Session $session -ScriptBlock {Get-PnpDevice | Where-Object {$_.FriendlyName -match "MCT USB3.0 External Graphics Device"} | Where-Object {$_.Status -ne "ERROR"} | Disable-PnpDevice -confirm:$false}
                sleep 5
                $off = Invoke-Command -Session $session -ScriptBlock {Get-PnpDevice | Where-Object {$_.FriendlyName -match "MCT USB3.0 External Graphics Device"} | Format-Table status,FriendlyName }
                $off
                Write-Host "`n"
                Write-Host "Verify device has entered 'ERROR' status."
                Write-Host "`n"
                pause
                Write-Host "`n"
                Invoke-Command -Session $session -ScriptBlock {Get-PnpDevice | Where-Object {$_.FriendlyName -match "MCT USB3.0 External Graphics Device"} | Where-Object {$_.Status -eq "ERROR"} | Enable-PnpDevice -confirm:$false}
                $on = Invoke-Command -Session $session -ScriptBlock {Get-PnpDevice | Where-Object {$_.FriendlyName -match "MCT USB3.0 External Graphics Device"} | Format-Table status,FriendlyName}
                $on
            }
            else{
               $correct = $false 
            }
        }

    Remove-PSSession -Session $session
    Write-Host "`nComplete, session removed."
}



function Open-PrinterDB{
    Start-Process powershell.exe \\<NETWORK PATH>\PrinterScanner_Assets_WRKnPROGRESS_V1.1.ps1
}



function Get-SysInfo{

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
            #$Disk = Get-Disk 
            
            $MemoryUse = ((($OS.TotalVisibleMemorySize - $OS.FreePhysicalMemory)*100)/ $OS.TotalVisibleMemorySize)
            $MemoryRound = [math]::Round($MemoryUse,2)
            #$DiskMath = ($Disk.Size / 1000000000)
            #$DiskGB = [math]::Round($DiskMath,0)
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