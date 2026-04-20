#!/bin/bash

#Complexité: O(N*M) où N est le nombre de fichiers à créer pour chaque préfixe et M est le nombre de préfixes. 

#Cette fonction va créer les fichiers dans un répertoire tout deux spécifiés par l'utilisateur
mkdir -p Repo
Creer_repertoire() {

    #je sauvgarde les préfixes dans une liste pour pouvoir les réutiliser plus tard.
    list_prefixes=()
    prefix="defaut"
    i=0
    index=0

    #N et M sont les arguments de la fonction, ils sont passés par l'utilisateur lors de l'appel de la fonction
    N=$1
    M=$2
    echo "Le nom du repertoire que vous voulez creer ? "
    read nom_repertoire
    mkdir /Repo/$nom_repertoire
     
    #j'utilise des boucles pour permettre à l'utilisateur de créer plusieurs fichiers avec différents préfixes
    #La boucle s'arrêtera lorsque l'utilisateur tapera "stop" pour les préfixes

    while [ $prefix != "stop" ];
    do
       echo "Entrez les préfixes des fichiers, tapez stop quand vous avez fini"
       read prefix
       list_prefix[i]=$prefix

       ((i++))

    done
    
    #une fois que l'utilisateur a rentré tout les préfixes, on peut commencer à créer les fichiers

    compteur=1
      for ((index=0; index<${#list_prefix[@]}; index++));
      do
        while [ $compteur != $((N+1)) ] && [ ${list_prefix[index]} != "stop" ]
        do
          # Je sauvgarde la date et l'heure de création du fichier pour pouvoir les ajouter au nom du fichier plus tard.
          file_name=$(date +%Y-%T-%3N)
          touch /Repo/${nom_repertoire}/${list_prefix[index]}_${file_name}.txt
          echo fichier ${compteur} disponible

          ((compteur++))
          sleep ${M}s
        done

        compteur=1
      done

     }



answer="yes"

#le processus se répétera jusqu'à ce que l'utilisateur décide d'arrêter en tapant "non"

echo "Bonjour, ce script va créer des fichers. Introduisez le nombre de fichier N, et l'intervale de création"
while [ "$answer" != "non" ];
do

  echo "Entrez le nombre de fichier N souhaité"
  read N
  echo "Entrez l'intervale de création M"
  read M
  Creer_repertoire $N $M
  echo "Encore un autre repertoire ? "
  read answer

done
