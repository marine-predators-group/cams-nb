---
author: kubu4
comments: true
date: 2018-02-21 18:39:20+00:00
layout: post
link: http://onsnetwork.org/kubu4/2018/02/21/novaseq-assembly-the-struggle-is-real-real-annoying/
slug: novaseq-assembly-the-struggle-is-real-real-annoying
title: NovaSeq Assembly - The Struggle is Real - Real Annoying!
wordpress_id: 3107
author:
  - kubu4
categories:
  - Geoduck Genome Sequencing
tags:
  - AllPaths-LG
  - assembly
  - geoduck
  - jr-assembler
  - meraculous
  - mox
  - NovaSeq
  - Panopea generosa
  - SOAPdenovo2
---

Well, I continue to struggle to makek progress on assembling the geoduck Illumina NovaSeq data. Granted, there is a _ton_ of data (374GB!!!!), but it's still frustrating that we can't get an assembly anywhere...

Here are some of the struggles so far:

**[Meraculous](http://1ofdmq2n8tc36m6i46scovo2e.wpengine.netdna-cdn.com/wp-content/uploads/2014/12/Manual.pdf)**:





  * Can't run locally because:



    * [Ran out of hard drive space](http://onsnetwork.org/kubu4/2018/02/05/novaseq-assembly-trimmed-geoduck-novaseq-with-meraculous/) - due to hardware limitations of our Apple Xserve


    * [Fixed HDD space issue, but Roadrunner locks up and has to be restarted](http://onsnetwork.org/kubu4/2018/02/05/novaseq-assembly-trimmed-geoduck-novaseq-with-meraculous/); no error message(s) in log files to help troubleshoot




  * Can't run on Mox because:



    * Can't figure out how to install [needed dependencies](http://1ofdmq2n8tc36m6i46scovo2e.wpengine.netdna-cdn.com/wp-content/uploads/2014/12/Manual.pdf) that don't already exist on Mox. More specifically, friggin' Boost libraries! Trying to install these properly has been an issue in the past for non-Mox computers, too. I remember a few times discussing the pain of installing Boost with Sean Bennett.





**[SOAPdenovo2](http://soap.genomics.org.cn/soapdenovo.html)**





  * Our [Mox node can't handle the memory requirements](http://onsnetwork.org/kubu4/2018/02/19/assembly-geoduck-illumina-novaseq-soapdenovo2-on-mox-fail/) needed for assembly.



**[JR-Assembler](http://jr-assembler.iis.sinica.edu.tw/index.htm)**





  * Can't install one of the dependencies ([SOAP error correction](https://sourceforge.net/projects/soapdenovo2/files/ErrorCorrection/))


  * Actually, I need to try the binary version of this, instead of the source version (the source version fails at the `make` step)



So, next up will trying the following two assemblers:



  * [JR-Assembler](http://jr-assembler.iis.sinica.edu.tw/index.htm): Will see if SOAPec binary will work, and then run an assembly.


  * [AllPaths-LG](ftp://ftp.broadinstitute.org/pub/crd/ALLPATHS/Release-LG/AllPaths-LG_Manual.pdf): I was able to install this successfully on Mox.



Additionally, we've ordered some additional hard drives and will be converting the old head/master node on the Apple Xserve cluster to Linux. The old master node is a little better equipped than the other Apple Xserve "birds", so will try to re-run Meraculous on it once we get it converted.
