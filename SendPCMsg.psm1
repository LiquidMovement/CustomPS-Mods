function Send-MessagePC{
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        #[ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]
        $Message,

        [Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        [ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]
        $Computer

        )

        #Start-Sleep -Seconds 500
        Write-Host "Sending now!"

        Invoke-WmiMethod -Class Win32_Process -ComputerName $Computer -Name Create -ArgumentList "C:\Windows\System32\msg.exe * $Message"

}