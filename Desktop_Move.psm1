function Copy-Desktop{

    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        [ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$OldPC,

        [Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        [ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$NewPC,

        [Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        #[ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$User,

        #[Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        #[ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$oldPCPath = "\\$OldPC\C$\Users\$User",

        #[Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        #[ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$AWS = $false
        
        )    

        if($AWS -eq $false){
            $newTempPath = "\\$NewPC\C$\temp"
        }
        else{
            $newTempPath = "\\$NewPC\D$\temp"
        }

        if(Test-Path $newTempPath){

            if(Test-Path $oldPCPath){
                $Desktop = "$oldPCPath\Desktop"
                $Documents = "$oldPCPath\Documents"
                $Favorites = "$oldPCPath\Favorites"
                $Downloads = "$oldPCPath\Downloads"

                Copy-Item $Desktop -Destination "$newTempPath\Desktop" -Recurse 
                Copy-Item $Documents -Destination "$newTempPath\Documents" -recurse
                Copy-Item $Favorites -Destination "$newTempPath\Favorites" -recurse
                Copy-Item $Downloads -Destination "$newTempPath\Downloads" -Recurse

                Write-Host "Copy from $oldPC to $newPC complete."
            }
            else{
                Write-Host "$oldPCPath has failed to connect. Please ensure the PC is powered on and reachable over the Network."
            }

        }
        else{
            Write-Host "$newTempPath has failed to connect. Please ensure the PC is powered on and reachable over the Network."
        }

}



function Move-Desktop{

    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        [ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$NewPC,

        [Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        #[ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$User,

        #[Parameter(Mandatory=$true)]
        #[ValidateCount(0,1)]
        #[ValidateSet()]
        #[ValidatePattern("(IT|D)\d{1,5}$")]
        #[ValidateCount(0,1)]
        #[ValidateLength(0,15)]
        [string]$AWS = $false
        
        )    

        if($AWS -eq $false){
            $newTempPath = "\\$NewPC\C$\temp"
            $newPCPath = "\\$NewPC\C$\Users\$User"
        }
        else{
            $newTempPath = "\\$NewPC\D$\temp"
            $newPCPath = "\\$NewPC\D$\Users\$User"
        }

        if(Test-Path $newTempPath){

            if(Test-Path $newPCPath){
                Get-ChildItem "$newTempPath\Desktop" -Recurse | Move-Item -Destination "$newPCPath\Desktop" -Force -ErrorAction SilentlyContinue
                Get-ChildItem "$newTempPath\Documents" -Recurse | Move-Item -Destination "$newPCPath\Documents" -Force -ErrorAction SilentlyContinue
                Get-ChildItem "$newTempPath\Favorites" -Recurse | Move-Item -Destination "$newPCPath\Favorites" -Force -ErrorAction SilentlyContinue
                Get-ChildItem "$newTempPath\Downloads" -Recurse | Move-Item -Destination "$newPCPath\Downloads" -Force -ErrorAction SilentlyContinue

                Write-Host "Copy from $newTempPath to $newPCPath complete."

                Remove-Item "$newTempPath\Desktop" -Force -Recurse -ErrorAction SilentlyContinue
                Remove-Item "$newTempPath\Documents" -Force -Recurse -ErrorAction SilentlyContinue
                Remove-Item "$newTempPath\Favorites" -Force -Recurse -ErrorAction SilentlyContinue
                Remove-Item "$newTempPath\Downloads" -Force -Recurse -ErrorAction SilentlyContinue
            }
            else{
                Write-Host "$newPCPath has failed to connect. Please ensure the PC is powered on and reachable over the Network."
            }

        }
        else{
            Write-Host "$newTempPath has failed to connect. Please ensure the PC is powered on and reachable over the Network."
        }

}