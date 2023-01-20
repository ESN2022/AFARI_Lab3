# AFARI_Lab3

# A-Introduction :

Le but de cette séance de laboratoire est de récupérer les valeurs de l'accéléromètre ADXL345 qui mesure les accélérations sur les axes X, Y et Z dans l'espace. Ces valeurs seront affichées sur l'afficheur 7-segment de la carte DE10-Lite. Lorsque le bouton poussoir est appuyé, les valeurs affichées sur l'afficheur 7-segments seront respectivement l'accélération sur l'axe X, l'accélération sur l'axe Y et l'accélération sur l'axe Z.

![image](https://user-images.githubusercontent.com/121948245/213670538-dca6e627-c7ad-40e1-aa34-d5a9ee76c351.png)

# B-Architechture :

L'architecture du système comprend les composants suivants :

- Microcontrôleur Altera Cyclone IV
- Accéléromètre ADXL345
- Afficheur 7 segments
- Interfaces I2C et PIO pour la communication et l'affichage

L'architecture du système est représentée par le schéma ci-dessous :

![image](https://user-images.githubusercontent.com/121948245/213670611-3511e8fd-874e-4072-91b2-124336ad57b7.png)

Dans ce système, la communication entre le microcontrôleur et l'accéléromètre se fait à travers l'interface I2C. Le microcontrôleur envoie des commandes de lecture et d'écriture pour configurer l'accéléromètre et récupérer les données d'accélération. Les données récupérées sont ensuite utilisées pour mettre à jour les affichages sur l'afficheur 7 segments via l'interface PIO.

![image](https://user-images.githubusercontent.com/121948245/213673064-764ef6c2-6264-4014-930e-96c581a78694.png)

Pour contrôler les afficheurs 7 segments, une méthode utilisée est d'utiliser un PIO programmé en sortie de 24 bits, chaque afficheur nécessitant 4 bits. Cette approche permet de contrôler 6 afficheurs au total.

Dans cette implémentation, nous allons d'abord concevoir l'architecture matérielle du système en utilisant Platform Designer. Nous allons ensuite éditer le code VHDL pour appliquer les signaux appropriés sur les broches de la carte afin d'afficher les valeurs souhaitées sur le 7-segments. Sur QUARTUS, nous allons créer un composant appelé "bin_to_7seg" qui se chargera de convertir les valeurs binaires en les valeurs souhaitées à afficher sur le 7-segments (en utilisant la convertion BCD). Ce composant prend en entrée la valeur à convertir en binaire et génère en sortie la combinaison équivalente pour allumer les LEDS du 7-segments afin d'afficher le nombre souhaité. Ensuite, dans le fichier "lab3.vhd", nous allons connecter les digits du 7-segments au composant "bin_to_7seg", permettant ainsi d'afficher les nombres souhaités sur chaque digit du 7-segments configuré. 

Concernant la partie software, dans le fichier "main.c", on a les fonctions suivantes :

lecture_I2C : qui permet d'aller lire les données sur le capteur ADXL345. L'adresse du capteur est (0x1D)

![image](https://user-images.githubusercontent.com/121948245/213673720-8a657793-ccfb-43ef-97dc-7c83627caffe.png)

ecritureI2C : qui permet d'aller écrire les adresses et/ou les données sur le capteur ADXL345

![image](https://user-images.githubusercontent.com/121948245/213673771-9343993a-b882-4145-a034-7767e022ab34.png)

Avant de pouvoir accéder aux données de l'accéléromètre, il est nécessaire de configurer certains paramètres de l'ADXL345 en écrivant dans les régistres suivants:

#define ACT_INACT_CTL 0x27 pour activer l'ADXL345 (0x27 étant son adresse accessible via le bus I²C)

#define POWER_CTL 0x2D pour configurer les paramètres d'alimentation (0x2D étant son adresse accessible via le bus I²C)

#define DATA_FORMAT 0x31 pour formater l'affichage des données (0x31 étant son adresse accessible via le bus I²C)

Afin de récupérer des valeurs exactes des accélérations sur les axes X, Y et Z, il est nécessaire d'ajouter des valeurs d'offset aux valeurs des accélérations. En effet, les valeurs correctes devraient être exprimées en .mg. Pour cela, en se référant à la documentation du capteur, nous devrons:

récupérer d'abord les valeurs brutes des accélérations sur les 3 axes
Appliquer l'équation suivante: offset = data_axe_brute*3.9 / 15.6
faire plusieurs essais et calculer la moyenne
considérer la valeur d'offset calculée en moyenne comme étant l'offset de référence (différent pour chaque axe)
écrire ensuite ces valeurs dans les régistres d'offset correspondants :
#define offset_X_addr 0x1E (addresse offset axe X)
#define offset_Y_addr 0x1F (addresse offset axe Y)
#define offset_Z_addr 0x20 (addresse offset axe Z)
Ces étapes permettent d'obtenir des valeurs d'accélération plus précises et plus fiables.

