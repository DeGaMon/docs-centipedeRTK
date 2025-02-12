---
layout: default
title: Activation du port serie
parent: Installation logiciel
grand_parent: Fabriquer une base RTK
nav_order: 1
---

## Activation du port serie

Pour activer les ports série RaspberryPi et avoir le point de montage ```/dev/ttyAMA0``` :

* Avoir flashé la carte SD avec l'image rtkbase.
* Enlever puis remettre la carte SD dans le PC pour monter et afficher les partitions dans un explorateur de fichier.

* Editez 2 fichiers dans la partition ```/boot```.
  * Editez ```/boot/cmdline.txt``` et supprimez ```console=serial0, 115200```
  * Éditez ```/boot/config.txt``` et ajoutez à la fin :

```
enable_uart=1
dtoverlay=pi3-miniuart-bt
```

* Démonter la carte SD > l'insérer dans le RaspberryPi > et mettre sous tension
* Connectez-vous aux paramètres de Rtkbase et ajoutez ```ttyAMA0``` dans **Rtcm server port**.

voici un exemple de branchement sur le port serie du raspberry Pi.

   ![serial](/assets/images/basegnss/radio_serial.jpg)

