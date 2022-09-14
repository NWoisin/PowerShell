# Restart a remote machine. Singular machine only.
Function Reboot {
        [cmdletbinding()]
        Param(
            [Parameter(Mandatory=$true)
            [string]$ComputerName
            )
        Restart-Computer -ComputerName $ComputerName -confirm
}