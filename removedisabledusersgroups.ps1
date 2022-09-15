#Remove disbaled users from groups except for Domain Users
#developed in MSSA Lab environment, changes will need to be made in order to use in production
#for each group, define a variable as $<groupname>
#may need to change the Disabled Accounts OU
#Remove disbaled users from groups
#for each group, define a variable as $<groupname>
$IT = "IT"
$market = "Marketing"
$manager = "Managers"
$sales = "Sales"
$dev = "Development"
$res = "Research"
$disabled = "OU=DisabledAccounts,DC=Adatum,DC=Com"

Start-Transcript C:\moveandremove.log
Search-ADAccount -AccountDisabled -UsersOnly | Where-Object DistinguishedName -NotLike "$DisabledAccounts" | Move-ADObject -TargetPath $disabled


$itMember = (Get-ADGroup $it -Properties members).members
  foreach ($member in $itMember) {
   Write-Verbose "Checking on '$member' ... " -Verbose
  $userstatus = Get-ADuser $member
   if (-not($userstatus.enabled -eq "False")){
  Remove-ADGroupMember $it -Members $member -Confirm:$false -verbose
     }
  }

    $markMember = (Get-ADGroup $market -Properties members).members
foreach ($member in $markMember) {
    Write-Verbose "Checking on '$member' ... " -Verbose
    $userstatus = Get-ADuser $member
    if (-not($userstatus.enabled -eq "false")){
        Remove-ADGroupMember $market -Members $member -Confirm:$false -verbose
        }
}

$mgtMember = (Get-ADGroup $manager -Properties members).members
foreach ($member in $mgtmember) {
    Write-Verbose "Checking on '$member' ... " -Verbose
    $userstatus = Get-ADuser $member
    if (-not($userstatus.enabled -eq "false")){
        Remove-ADGroupMember $manager -Members $member -Confirm:$false -verbose
        }
}

$saleMember = (Get-ADGroup $sales -Properties members).members
foreach ($member in $saleMember) {
    Write-Verbose "Checking on '$member' ... " -Verbose
    $userstatus = Get-ADuser $member
if (-not($userstatus.enabled -eq "false")){
        Remove-ADGroupMember $sales -Members $member -Confirm:$false -verbose
        }
}

$devMember = (Get-ADGroup $dev -Properties members).members
foreach ($member in $devMember) {
    Write-Verbose "Checking on '$member' ... " -Verbose
    $userstatus = Get-ADuser $member
if (-not($userstatus.enabled -eq "false")){
        Remove-ADGroupMember $dev -Members $member -Confirm:$false -verbose
        }
}

$resMember = (Get-ADGroup $res -Properties members).members
foreach ($member in $resMember) {
    Write-Verbose "Checking on '$member' ... " -Verbose
    $userstatus = Get-ADuser $member
if (-not($userstatus.enabled -eq "false")){
        Remove-ADGroupMember $res -Members $member -Confirm:$false -verbose
        }
}
Stop-Transcript