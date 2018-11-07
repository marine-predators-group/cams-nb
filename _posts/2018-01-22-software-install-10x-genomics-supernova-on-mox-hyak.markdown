---
author: kubu4
comments: true
date: 2018-01-22 23:46:35+00:00
layout: post
link: http://onsnetwork.org/kubu4/2018/01/22/software-install-10x-genomics-supernova-on-mox-hyak/
slug: software-install-10x-genomics-supernova-on-mox-hyak
title: Software Install - 10x Genomics Supernova on Mox (Hyak)
wordpress_id: 3054
author:
  - kubu4
categories:
  - Miscellaneous
tags:
  - 10x genomics
  - bcl2fastq2
  - hyak
  - mox
  - supernova
---

[Steven asked me to install Supernova (by 10x Genomics on our Mox node](https://github.com/RobertsLab/resources/issues/159).

First, need to install a dependency: [bcl2fastq2](https://support.illumina.com/sequencing/sequencing_software/bcl2fastq-conversion-software.html)
Followed [Illumina bcl2fastq2 manual (PDF)](https://support.illumina.com/content/dam/illumina-support/documents/documentation/software_documentation/bcl2fastq/bcl2fastq2_guide_15051736_v2.pdf)

Logged into Mox and initiated a [Build node](https://github.com/RobertsLab/hyak_mox/wiki/Node-Types#build-node):


    
    <code>srun -p build --time=1:00:00 --pty /bin/bash</code>





### Install bclsfastq2 dependency



[Illumina bcl2fastq2 manual (PDF)](https://support.illumina.com/content/dam/illumina-support/documents/documentation/software_documentation/bcl2fastq/bcl2fastq2_guide_15051736_v2.pdf)


    
    <code>cd /gscratch/srlab/tmp</code>




    
    <code>wget ftp://webdata2:webdata2@ussd-ftp.illumina.com/downloads/software/bcl2fastq/bcl2fastq2-v2-20-0-tar.zip</code>




    
    <code>export TMP=/gscratch/srlab/tmp/</code>




    
    <code>export SOURCE=${TMP}/bcl2fastq</code>




    
    <code>export BUILD=${TMP}/bcl2fastq2.20-build</code>




    
    <code>export INSTALL_DIR=/gscratch/srlab/programs/bcl2fastq-v2.20</code>




    
    <code>cd ${TMP}</code>




    
    <code>unzip bcl2fastq2-v2-20-0-tar.zip</code>




    
    <code>tar -xvzf bcl2fastq2-v2.20.0.422-Source.tar.gz</code>




    
    <code>cd ${BUILD}</code>




    
    <code>chmod ugo+x ${SOURCE}/src/configure</code>




    
    <code>chmod ugo+x ${SOURCE}/src/cmake/bootstrap/installCmake.sh</code>




    
    <code>${SOURCE}/src/configure --prefix=${INSTALL_DIR}</code>




    
    <code>cd ${BUILD}</code>




    
    <code>make</code>




    
    <code>make install</code>





### Install Supernova 2.0.0



[Supernova install directions](https://support.10xgenomics.com/de-novo-assembly/software/pipelines/latest/installation)


    
    <code>cd /gscratch/srlab/programs</code>




    
    <code>wget -O supernova-2.0.0.tar.gz "http://cf.10xgenomics.com/releases/assembly/supernova-2.0.0.tar.gz?Expires=1516707075&Policy;=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cDovL2NmLjEweGdlbm9taWNzLmNvbS9yZWxlYXNlcy9hc3NlbWJseS9zdXBlcm5vdmEtMi4wLjAudGFyLmd6IiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNTE2NzA3MDc1fX19XX0_&Signature;=XJR7c9UlSkueydP304nKJrqomLXBH9~DWsenwlvBrplFMojbO-DPMghO09Sk6Wi5ApZSPwKB3sl1Wrnjy3qBLwr7dCoT~9oStyBpqlF~Xl2nBY6odnTzUaq3IpLyu8icIkt7DJM0GMXQTTp6rYu1PlLG31hMM5b5HZI3Tjzrhk8URbSrsG~7mm6m5-28afYHX00kT2Xfor7xr-ZSjjLe2jr99SEIARfzZjt6kUEnDMbl~3FXCHsSxXzKrkYXobGmfQhYBrey0iRyCAc9yNF7eSuBHAsqRGsP2yURVcYf3BB5nB1ZuEUo0qLgc5GlZJDQdsqDNC69HkyLCJamkJSnVg__&Key-Pair-Id;=APKAI7S6A5RYOXBWRPDA"</code>




    
    <code>tar -xzvf supernova-2.0.0.tar.gz</code>




    
    <code>rm supernova-2.0.0.tar.gz</code>




    
    <code>cd supernova-2.0.0</code>




    
    <code>supernova-cs/2.0.0/bin/supernova sitecheck > sitecheck.txt</code>




    
    <code>supernova-cs/2.0.0/bin/supernova upload samwhite@uw.edu sitecheck.txt</code>




    
    <code>srun -p srlab -A srlab --time=2:00:00 --pty /bin/bash</code>




    
    <code>/gscratch/srlab/programs/supernova-2.0.0/supernova testrun --id=tiny</code>



![](http://owl.fish.washington.edu/Athaliana/20180122_mox_supernova_install.png)

OK, looks like the test run finished successfully.
