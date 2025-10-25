#!/bin/bash
# Script d'installation / update de Factorio headless
# Sauvegarde maintenant dans le home (~)

# 1. Définir les chemins
TMP_FILE="/tmp/factorio_headless.tar.xz"
INSTALL_DIR="/opt/factorio"
BACKUP_DIR="$HOME/factorio_backup/saves"

# 2. Sauvegarde des saves existantes
if [ -d "$INSTALL_DIR/saves" ]; then
    echo "📂 Sauvegarde des mondes existants dans $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
    cp -r "$INSTALL_DIR/saves" "$BACKUP_DIR/"
else
    echo "⚠️ Aucun monde trouvé à sauvegarder."
fi

# 3. Télécharger la version demandée
while [[ "$choix" != "1" && "$choix" != "2" ]]; do
    echo "Que souhaitez-vous faire ?"
    echo "1) Mettre à jour sur la dernière version"
    echo "2) Mettre à jour sur une version souhaitée"
    read -p "Votre choix : " choix

    if [ "$choix" = "1" ]; then
        echo "Mise à jour vers la dernière version..."
	version="latest"
    elif [ "$choix" = "2" ]; then
	regex="0"
	while [ "$regex" == "0" ]; do
	    read -p "Entrez la version souhaitée : " version

	    if [[ "$version" =~ ^([0-2])\.([0-9]|[1-9][0-9])\.([1-9][0-9]*)$ ]]; then
	        echo "Version $version valide"
		regex="1"
	    else
		echo "Veuillez rentrer un numéro de version valide."
		regex="0"
	    fi
	done
        echo "Version choisie : $version"
    else
        echo "Choix invalide, veuillez taper 1 ou 2."
    fi
done

echo "⬇️ Téléchargement de Factorio v$ersion $version.."
wget "https://www.factorio.com/get-download/$version/headless/linux64" -O "$TMP_FILE"

# 4. Extraire dans /opt
echo "📦 Extraction dans $INSTALL_DIR..."
sudo rm -rf "$INSTALL_DIR"
sudo mkdir -p "$INSTALL_DIR"
sudo tar -xJf "$TMP_FILE" -C /opt

# 5. Créer l’utilisateur factorio si inexistant
if ! id "factorio" &>/dev/null; then
    echo "👤 Création de l'utilisateur factorio..."
    sudo useradd -r -m -d /opt/factorio factorio
fi

# 6. Attribution des droits
sudo chown -R factorio:factorio "$INSTALL_DIR"

echo -e "👉 Tes saves ont été sauvegardés ici : $BACKUP_DIR"
echo -e "Création du dossier saves"
sudo mkdir /opt/factorio/saves
echo -e "Copie des mondes sauvegardés"
cp -r "$BACKUP_DIR"/saves/* /opt/factorio/saves

# 7. Désactivation des mods SpaceAge
(/opt/factorio/bin/x64/factorio --start-server inexistantprsur.zip)
echo -e "Désactivation des mods de SpaceAge"
cp /root/update_sys/mod-list.json /opt/factorio/mods/mod-list.json
