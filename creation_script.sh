#!/bin/bash

Creer_repertoire() {
    list_prefixes=()
    prefix="defaut"
    i=0
    index=0
    N=$1
    M=$2
    echo "Le nom du repertoire que vous voulez creer ? "
    read nom_repertoire
    mkdir $nom_repertoire

    while [ $prefix != "stop" ];
    do
       echo "Entrez les préfixes des fichiers, tapez stop quand vous avez fini"
       read prefix
       list_prefix[i]=$prefix

       ((i++))

    done
    compteur=1
      for ((index=0; index<${#list_prefix[@]}; index++));
      do
        while [ $compteur != $((N+1)) ] && [ ${list_prefix[index]} != "stop" ]
        do

          file_name=$(date +%Y-%T-%3N)
          touch /${nom_repertoire}/${list_prefix[index]}_${file_name}.txt
          echo "wow fichier disponible"
          ((compteur++))
          sleep ${M}s
        done

        compteur=1
      done

     }



answer="yes"

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
