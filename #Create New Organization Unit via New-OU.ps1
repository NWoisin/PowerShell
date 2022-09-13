#Create New Organization Unit via New-OU
function New-Ou
{
    Param(
        [Parameter(Mandatory=$true)][string]$OUname)

        
  New-ADOrganizationalUnit -name $OUName -path "dc=adatum,dc=com"
  }