#!/usr/bin/env bash
# ------------------------------------------------------------------
# Fichier : globals.sh
# Description : Contient les variables globales utilisées dans tout
#               le projet. À inclure via `source globals.sh`.
# ------------------------------------------------------------------

# Répertoire racine du projet

current_dir=$(pwd)
PROJECT_ROOT="$current_dir"

# Fichier de logs JSON

LOG_FILE="${PROJECT_ROOT}/factorio_logs.json" # Envisager de déplacer ce fichier dans un répertoire de logs dédié autre que le répertoire du projet, histoire que ce soit pas perdu lors d'un git pull, d'une suppresion du projet ou autre.