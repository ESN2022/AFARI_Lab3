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

Pour contrôler les afficheurs 7 segments, une méthode utilisée est d'utiliser un PIO programmé en sortie de 24 bits, chaque afficheur nécessitant 4 bits. Cette approche permet de contrôler 6 afficheurs au total.

