#PrinterList Function to retrieve installed printers on a device
Function PrinterList
{
    Param(
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true
                  )][string]$ComputerName )

Get-Printer -ComputerName $ComputerName
}