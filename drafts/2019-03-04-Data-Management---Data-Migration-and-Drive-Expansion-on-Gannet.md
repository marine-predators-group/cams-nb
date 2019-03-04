---
layout: post
title: Data Management - Data Migration and Drive Expansion on Gannet
date: '2019-03-04 07:04'
tags:
  - gannet
categories:
  - Miscellaneous
---
A little while ago, we installed some additional hard drives in Gannet (Synology RS3618XS) with the intention of expanding the total storage space. However, the original set of HDDs were set up as RAID10. As it turns out, RAID10 configurations cannot be expanded! So, the new set of HDDs were configured as a separate volume (Volume 2) in a RAID5 configuration. After backing up the ```/volume1/web``` directory (via ```rsync```) to our UW Google Drive, I begane the data migration.

Synology provides a simple interface for this:

1. Select Shared Folders

2. Select the folder you want to move.

3. Edit

  - Change "Location" from Volume1 to Volume2.

The Synology will take care of the rest, but it's going to take awhile (Synology estimates it taking >24hrs!).



After the data migration, then I should be able to use the Synology Storage Manager to expand Volume2 to include Volume1 and become a singlular, large storage volume.


In theory, this change of volume will not be noticeable for most of our regular usage. However, for ```rsync/ssh```, a user will now have to specify ```/volume2/web``` instead of ```/volume1/web``` like we previously did. There does not appear to be a way to change the name of the volume.
