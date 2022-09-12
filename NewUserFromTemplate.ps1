#Change the Identity in the template account to a user account in your org
#ensure you change the -path in the New-ADUser 
$template_account = Get-ADUser -Identity Abbie -Properties State,Department,Country,City
$template_account.UserPrincipalName = $null
$fname = Read-Host "First Name"
$lname = Read-Host  "Last Name"
New-AdUser -Instance $template_account -Name "$fname $lname" -SamAccountName "$fname" -AccountPassword (Read-Host -AsSecureString "Input User Password") -Enabled $true -UserPrincipalName "$fname" -path "OU=Sales,DC=Adatum,dc=com" -GivenName $fname -Surname $lname -DisplayName "$fname $lname"
Set-ADUser -Identity $fname -ChangePasswordAtLogon:$true
Add-ADGroupMember -Members $fname -Identity Sales
