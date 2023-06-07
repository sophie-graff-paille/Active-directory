# Veuillez indiquer l'heure de début et l'heure de fin de la plage non permise (format 24h) : HH:mm:ss. Par exemple, $heure_début = 08:00:00
$heure_début = 
$heure_fin = 

$utilisateurs = Get-ADUser -Filter * | Select-Object -ExpandProperty SamAccountName

if ($heure_début -lt $heure_fin){
    $date_début = Get-Date -Hour $heure_début.Split(":")[0] -Minute $heure_début.Split(":")[1] -Second $heure_début.Split(":")[2]
    $date_fin = Get-Date -Hour $heure_fin.Split(":")[0] -Minute $heure_fin.Split(":")[1] -Second $heure_fin.Split(":")[2] 
    $evenements =  Get-WinEvent Security | Where-Object {
        $_.TimeCreated -ge $date_début -and $_.TimeCreated -le $date_fin
    } 
    
    foreach ($evenement in $evenements) {
        if ($evenement.Id -eq  4624 -and $evenement.Properties[5].Value -ne $null -and $utilisateurs -contains $evenement.Properties[5].Value) {
            Write-Host "L'utilisateur $($evenement.Properties[5].Value) s'est connecté pendant la plage non permise à $($evenement.TimeCreated)"
        }
        if ($evenement.Id -eq  4634 -and $evenement.Properties[5].Value -ne $null -and $utilisateurs -contains $evenement.Properties[5].Value) {
            Write-Host "L'utilisateur $($evenement.Properties[5].Value) s'est déconnecté pendant la plage non permise à $($evenement.TimeCreated)"
        }
    }
}

if ($heure_début -gt $heure_fin -or $heure_début -eq $heure_fin){
    $date_actu = Get-Date -Format "HH:mm:ss"

    if($heure_début -le $date_actu){
        $date_début = Get-Date -Hour $heure_début.Split(":")[0] -Minute $heure_début.Split(":")[1] -Second $heure_début.Split(":")[2]
        $evenements =  Get-WinEvent Security | Where-Object { $_.TimeCreated -ge $date_début } 
        
        foreach ($evenement in $evenements) {
            if ($evenement.Id -eq  4624 -and $evenement.Properties[5].Value -ne $null -and $utilisateurs -contains $evenement.Properties[5].Value) {
                Write-Host "L'utilisateur $($evenement.Properties[5].Value) s'est connecté pendant la plage non permise à $($evenement.TimeCreated)"
            }
            if ($evenement.Id -eq  4634 -and $evenement.Properties[5].Value -ne $null -and $utilisateurs -contains $evenement.Properties[5].Value) {
                Write-Host "L'utilisateur $($evenement.Properties[5].Value) s'est déconnecté pendant la plage non permise à $($evenement.TimeCreated)"
            }
        }
    }
    if($heure_fin -ge $date_actu){
        $date_début = (Get-Date -Hour $heure_début.Split(":")[0] -Minute $heure_début.Split(":")[1] -Second $heure_début.Split(":")[2]).AddDays(-1)
        $date_fin = Get-Date -Hour $heure_fin.Split(":")[0] -Minute $heure_fin.Split(":")[1] -Second $heure_fin.Split(":")[2]
        $evenements =  Get-WinEvent Security | Where-Object {
            $_.TimeCreated -ge $date_début -and $_.TimeCreated -le $date_fin
        } 
        
        foreach ($evenement in $evenements) {
            if ($evenement.Id -eq  4624 -and $evenement.Properties[5].Value -ne $null -and $utilisateurs -contains $evenement.Properties[5].Value) {
                Write-Host "L'utilisateur $($evenement.Properties[5].Value) s'est connecté pendant la plage non permise à $($evenement.TimeCreated)"
            }
            if ($evenement.Id -eq  4634 -and $evenement.Properties[5].Value -ne $null -and $utilisateurs -contains $evenement.Properties[5].Value) {
                Write-Host "L'utilisateur $($evenement.Properties[5].Value) s'est déconnecté pendant la plage non permise à $($evenement.TimeCreated)"
            }
        }
    }
}