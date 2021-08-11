#!/usr/bin/env bash

# This script generates needed bootswatch theme files from given theme names
# NB: You need to install jq

# These values came from this Bootswatch API response : https://bootswatch.com/api/4.json
# against this JSONPath (https://jsonpath.com/) : $.themes[*].name
THEMES=$(cat <<'EOF'
[
  "Cerulean",
  "Cosmo",
  "Cyborg",
  "Darkly",
  "Flatly",
  "Journal",
  "Litera",
  "Lumen",
  "Lux",
  "Materia",
  "Minty",
  "Morph",
  "Pulse",
  "Quartz",
  "Sandstone",
  "Simplex",
  "Sketchy",
  "Slate",
  "Solar",
  "Spacelab",
  "Superhero",
  "United",
  "Vapor",
  "Yeti",
  "Zephyr"
]
EOF
)




#         __  __     _     ____  ___  ____ 
#        |  \/  |   / \   / ___||_ _|/ ___|
#        | |\/| |  / _ \ | |  _  | || |    
#        | |  | | / ___ \| |_| | | || |___ 
#        |_|  |_|/_/   \_\\____||___|\____|
                                   
echo "###################################################################################################"
echo "Generating Bootswatch theme files :"
echo "---------------------------------------------------------------------------------------------------"
for theme in $(echo "${THEMES}" | jq -r '.[]'); do

name=$(echo $theme | tr '[:upper:]' '[:lower:]')
filename="./theme-${name}.scss"
echo "- ${theme} theme file into ${filename} ..."

cat <<EOT > $filename
// For this specific ${theme} theme, your variable overrides go here

@import "common-variables";
@import "~bootswatch/dist/${name}/variables";
@import "~bootstrap/scss/bootstrap";
@import "~bootswatch/dist/${name}/bootswatch";
EOT

done
echo "###################################################################################################"






echo "###################################################################################################"
echo "Almost done ... do not forget to update \"angular.json\" with theses following values"
echo "---------------------------------------------------------------------------------------------------"
for theme in $(echo "${THEMES}" | jq -r '.[]'); do

name=$(echo $theme | tr '[:upper:]' '[:lower:]')
filename="theme-${name}"

cat <<EOT
{
    "input": "src/styles/bootswatch/${filename}.scss",
    "bundleName": "${filename}",
    "inject": false
},
EOT

done
echo "###################################################################################################"





echo "###################################################################################################"
echo "Usage samples of how to load available themes"
echo "---------------------------------------------------------------------------------------------------"

cat <<EOT
<div class="btn-group" role="group" aria-label="Theme selector">
EOT

for theme in $(echo "${THEMES}" | jq -r '.[]'); do

name=$(echo $theme | tr '[:upper:]' '[:lower:]')
filename="theme-${name}"

cat <<EOT
  <input type="radio" class="btn-check" name="btnradio" id="btnradio-${theme}" autocomplete="off" checked="" (click)="loadTheme('${filename}.css')">
  <label class="btn btn-outline-primary" for="btnradio-${theme}">${theme}"</label>
EOT

done


cat <<EOT
</div>
EOT

echo "###################################################################################################"