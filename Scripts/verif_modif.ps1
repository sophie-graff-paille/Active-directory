$date = Get-Date -Hour 00 -Minute 00 -Second 00
$evenements =  Get-WinEvent Security | Where-Object {
    $_.TimeCreated -ge $date -and $_.Id -eq 4663
} 
$fichiers = @{}

foreach ($evenement in $evenements) {
    if ($fichiers.ContainsKey($evenement.Properties[6].Value)) {
        $fichiers[$evenement.Properties[6].Value]++
        if ($fichiers[$evenement.Properties[6].Value] -ge 3) {
            Write-Host "Le fichier $($evenement.Properties[6].Value) a été modifié au moins 3 fois en moins de 24h"
        }
    } else {
        $fichiers.Add($evenement.Properties[6].Value, 1)
    }
}