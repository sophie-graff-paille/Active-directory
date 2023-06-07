$comptes_inactif_30 = Search-ADaccount -AccountInactive -Timespan 30 | Where-Object{ ($_.DistinguishedName -notmatch "CN=Users") -and ($_.Enabled -eq $true) }
$comptes_inactif_60 = Search-ADaccount -AccountInactive -Timespan 60 | Where-Object{ ($_.DistinguishedName -notmatch "CN=Users") -and ($_.Enabled -eq $true) }
$comptes_inactif_90 = Search-ADaccount -AccountInactive -Timespan 90 | Where-Object{ ($_.DistinguishedName -notmatch "CN=Users") -and ($_.Enabled -eq $true) }

Foreach($compte in $comptes_inactif_90){

  $SamAccountName = $compte.SamAccountName

  Write-Output "L'utilisateur ayant comme SamAccountName $SamAccountName est inactif depuis au moins 90j !"

}

Foreach($compte in $comptes_inactif_60){

    if ($comptes_inactif_90 -notcontains $compte) {
        $SamAccountName = $compte.SamAccountName
  
        Write-Output "L'utilisateur ayant comme SamAccountName $SamAccountName est inactif depuis au moins 60j !"
    }  
}

Foreach($compte in $comptes_inactif_30){

    if ($comptes_inactif_90 -notcontains $compte -and $comptes_inactif_60 -notcontains $compte) {
        $SamAccountName = $compte.SamAccountName
  
        Write-Output "L'utilisateur ayant comme SamAccountName $SamAccountName est inactif depuis au moins 30j !"
    }  
}