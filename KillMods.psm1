##Invoke-Command -PC servername -ScriptBlock {Stop-Process -ID 4436}


function Stop-CiscoJabber{
    [cmdletbinding()]
    [Alias('Kill-CiscoJabber')]
    param(
        [Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        [ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$PC
        )

        Invoke-Command -ComputerName $PC -ScriptBlock {Stop-Process -Name CiscoJabber -Force}
}


function Stop-Chrome{
    [cmdletbinding()]
    [Alias('Kill-Chrome')]
    param(
        [Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        [ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$PC
        )

    Invoke-Command -ComputerName $PC -ScriptBlock {Stop-Process -Name Chrome -Force}
}


function Stop-GoogleFS{
    [cmdletbinding()]
    [Alias('Kill-GoogleFS')]
    param(
        [Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        [ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$PC
        )

    Invoke-Command -ComputerName $PC -ScriptBlock {Stop-Process -Name GoogleDriveFS -Force}
}


function Stop-PCSWS{
    [cmdletbinding()]
    [Alias('Kill-PCSWS')]
    param(
        [Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        [ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$PC
        )

    Invoke-Command -ComputerName $PC -ScriptBlock {Stop-Process -Name pcsws -Force}
}


function Stop-IE{
    [cmdletbinding()]
    [Alias('Kill-IE')]
    param(
        [Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        [ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$PC
        )

    Invoke-Command -ComputerName $PC -ScriptBlock {Stop-Process -Name iexplore -Force}
}


function Stop-Adobe{
    [cmdletbinding()]
    [Alias('Kill-Adobe')]
    param(
        [Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        [ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$PC
        )

    Invoke-Command -ComputerName $PC -ScriptBlock {Stop-Process -Name AcroRd32 -Force}
}


function Stop-Word{
    [cmdletbinding()]
    [Alias('Kill-Word')]
    param(
        [Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        [ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$PC
        )

    Invoke-Command -ComputerName $PC -ScriptBlock {Stop-Process -Name WINWORD -Force}
}


function Stop-Excel{
    [cmdletbinding()]
    [Alias('Kill-Excel')]
    param(
        [Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        [ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$PC
        )

    Invoke-Command -ComputerName $PC -ScriptBlock {Stop-Process -Name Excel -Force}
}


function Stop-DocView{
    [cmdletbinding()]
    [Alias('Kill-DocView')]
    param(
        [Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        [ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$PC
        )

    Invoke-Command -ComputerName $PC -ScriptBlock {Stop-Process -Name spy32 -Force}
}


function Stop-PDFCreator{
    [cmdletbinding()]
    [Alias('Kill-PDFCreator')]
    param(
        [Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        [ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$PC
        )

    Invoke-Command -ComputerName $PC -ScriptBlock {Stop-Process -Name PDFCreator -Force}
}