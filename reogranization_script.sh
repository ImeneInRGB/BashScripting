#!bin/bash

#Complexité : O(n)
#Je crée une pattern pour pouvoir faire le tri des fichiers plus tard.

regex=".*/([^_]+)_([0-9]{4})-([0-9]{2})-([0-9]{2})-([0-9]{2})-([0-9]{2})-([0-9]{2})-([0-9]{3})\.txt$"
#Je crée un répertoire Root pour pouvoir y déplacer les fichiers après les avoir triés.

mkdir -p Root
for FILE in Repo/*/*; 
do  
   
        #Je sauvegarde le nom du chemin d'origine, et l'ancien nom du fichier (seul)

        chemin_du_fichier=$FILE
        nom_seul=$(basename "$FILE")
        #echo $FILE; 
        #Je regarde si le nom du fichier correspond à la pattern que j'ai créée plus tôt,
        #et si c'est le cas, je peux extraire les différentes parties du nom du fichier pour pouvoir les utiliser plus tard

        if [[ $FILE =~ $regex ]]; then
            
            echo "Le nom du fichier est bien formé"
            #Extraire les différentes parties du nom de fichier à l'aide des groupes de parenthèses dans la regex
            #le BASH_REMATCH est un tableau qui contient
            #les différentes parties du nom de fichier qui ont été extraites à l'aide de la regex

            prefix=${BASH_REMATCH[1]}
            annee=${BASH_REMATCH[2]}
            mois=${BASH_REMATCH[3]}
            jour=${BASH_REMATCH[4]}
            heure=${BASH_REMATCH[5]}
            minute=${BASH_REMATCH[6]}
            seconde=${BASH_REMATCH[7]}
            milli=${BASH_REMATCH[8]}
            #echo $prefix
            #Je crée les répertoires demandés, et je déplace le fichier dans l'endroit adéquat.

            mkdir -p Root/$prefix/$annee/$mois/$jour/$heure/
            mv $FILE Root/$prefix/$annee/$mois/$jour/$heure/$minute$seconde$milli.txt

            #On ajoute le nom du fichier, le chemin d'origine, et le nom du script dans le fichier de destination
            echo $nom_seul >> Root/$prefix/$annee/$mois/$jour/$heure/$minute$seconde$milli.txt
            echo ${BASH_REMATCH[0]} >> Root/$prefix/$annee/$mois/$jour/$heure/$minute$seconde$milli.txt
            echo "creation_script.sh" >> Root/$prefix/$annee/$mois/$jour/$heure/$minute$seconde$milli.txt

            echo "Le fichier $nom_seul a été déplacé et son contenu a été ajouté à $minute$seconde$milli.txt"   
            #rwx
            #100------ (Qui signifierait : seul l'utilisateur owner à tous les droits sur le fichier, et pas les autres)
            chmod 400 Root/$prefix/$annee/$mois/$jour/$heure/$minute$seconde$milli.txt
        else
            echo "Le nom du fichier n'est pas bien formé"
        fi
   

    
done
