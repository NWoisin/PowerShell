# Module Built for Adatum.com Lab Environment during MSSA PSCA-7.  All code is adatped to a lab enviornment
# and is not currently suitable for a production environment, however, like all PowerShell, it can
# be adapted.

#Function to shortcut "Get-ADUser"
Function Get-User {
        [cmdletbinding()]
        Param(
            [Parameter(Mandatory=$true)]
            [string]$identity
                      )
        Get-ADUser -Indentity $identity
    }

# This will allow you to simply use, for example, Get-User Logan to retrieve an account

# Create a New Organizational Unit via New-OU
function New-OU
{
    Param(
        [Parameter(Mandatory=$true)][string]$OUname
            )
    New-ADOrganizationalUnit -name $OUname -path "dc=Adatum,dc=com"
}
# Allows for the creation of an OU with much less time.

##Locate disabled AD Accounts,  Move to disabled OU. .

$DisabledAccounts = "OU=DisabledAccounts,DC=Adatum,DC=com"
Search-ADAccount -AccountDisabled -UsersOnly | Where-Object DistinguishedName -notlike "*$DisabledAccounts" | Move-ADObject -TargetPath $DisabledAccounts

##Creates New security group in Specialized OU
Function New-SGroup
{[cmdletbinding()]
    Param(
        [Parameter(Mandatory=$true)][string]$Gname)

        
  New-ADGroup -name $Gname -GroupScope Global -GroupCategory Security -path 'OU="SecurityGroups",DC="Adatum",DC="Com"'
 
  
  }

  #Creates new Distribution Group in a specialized OU
Function New-DGroup
{[cmdletbinding()]
    Param(
        [Parameter(Mandatory=$true)][string]$Gname)

        
  New-ADGroup -name $Gname -GroupScope Global -GroupCategory Distribution -path 'OU="DistributionGroups",DC="Adatum",DC="Com"'
 
  
  }
  ##Locate disabled AD Accounts,  Move to disabled OU.  Build in test environment;may need to adjust to use outside.

$DisabledAccounts = "OU=DisabledAccounts,DC=Adatum,DC=com"
Search-ADAccount -AccountDisabled -UsersOnly | Where-Object DistinguishedName -notlike "*$DisabledAccounts" | Move-ADObject -TargetPath $DisabledAccounts

Function PrinterList
{
    Param(
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true
                  )][string]$ComputerName )

Get-Printer -ComputerName $ComputerName
}

# Restart a remote machine. Singular machine only.
Function Reboot {
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory=$true)
        [string]$ComputerName
        )
    Restart-Computer -ComputerName $ComputerName -confirm
}