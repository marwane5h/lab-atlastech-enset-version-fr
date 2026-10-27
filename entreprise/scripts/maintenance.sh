echo "=== DEBUT DU SCRIPT DE MAINTENANCE ATLASTECH ==="
DATE=$(date +%Y-%m-%d_%H-%M)
grep "ERROR" entreprise/rapports/systeme.log > entreprise/rapports/erreurs_${DATE}.txt
echo "[+] Extraits d'erreurs générés : entreprise/rapports/erreurs_${DATE}.txt"
tar -czf "sauvegarde_atlastech_${DATE}.tar.gz" entreprise
echo "[+] Sauvegarde créée : sauvegarde_atlastech_${DATE}.tar.gz"

echo "=== MAINTENANCE TERMINEE AVEC SUCCES ==="
