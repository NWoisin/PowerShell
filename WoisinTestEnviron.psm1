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

#