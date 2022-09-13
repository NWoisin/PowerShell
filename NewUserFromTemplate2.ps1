Function New-ITUser
{
Param(
        [Parameter(Mandatory=$true)][String]$FirstName,
        [Parameter(Mandatory=$True)][String]$LastName )
      
       
$TemplateITUser = Get-ADUser -Identity TemplateITUser -Properties Department,Company
New-ADUser -Instance $TemplateITUser -Path "OU=IT,DC=Adatum,DC=com" -Name "$FirstName $LastName" -GivenName $FirstName -Surname $LastName -DisplayName "$FirstName $LastName" -SamAccountName "$FirstName $LastName" -UserPrincipalName "$FirstName$LastName@adatum.com" -AccountPassword (ConvertTo-SecureString "Pa55w.rd" -AsPlainText -Force) -ChangePasswordAtLogon $True -Enabled $True
Add-ADGroupMember -Members "$FirstName $LastName" -Identity IT
}