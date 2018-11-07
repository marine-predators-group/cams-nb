---
author: kubu4
comments: true
date: 2017-11-21 00:07:50+00:00
layout: post
link: http://onsnetwork.org/kubu4/2017/11/20/troubleshooting-pb-jelly-install-on-emu/
slug: troubleshooting-pb-jelly-install-on-emu
title: Troubleshooting - PB Jelly Install on Emu
wordpress_id: 2936
author:
  - kubu4
categories:
  - Miscellaneous
tags:
  - $PATH
  - blasr
  - emu
  - PB Jelly
---

I previously [installed](http://onsnetwork.org/kubu4/2017/10/30/software-installation-pb-jelly-suite-and-blasr-on-emu/) and [ran PB Jelly](http://onsnetwork.org/kubu4/2017/11/14/genome-assembly-olympia-oyster-illumina-pacbio-using-pb-jelly-wbgi-scaffold-assembly/). Despite no error messages being output, I noticed something odd during my quick post-assembly stats check: [The PB Jelly numbers were identical to the input reference file](http://onsnetwork.org/kubu4/2017/11/14/assembly-comparison-oly-assemblies-using-quast/). This seemed very strange and made me decide to look a bit deeper in the PB Jelly output files.

As it turns out, PB Jelly did not complete successfully! Here's a look at one of the output files (notice the error messages!):

[![](http://owl.fish.washington.edu/Athaliana/20171120_pbjellly_error.png)](http://owl.fish.washington.edu/Athaliana/20171120_pbjellly_error.png)

Looking around the internet seemed to suggest that the issue could be that the `blasr` program wasn't in my system PATH (`blasr` is located in: `/home/shared/bin`). So, I updated that, since `/home/shared/bin` wasn't in the system PATH!:

[![](http://owl.fish.washington.edu/Athaliana/20171120_update_etc_environment.png)](http://owl.fish.washington.edu/Athaliana/20171120_update_etc_environment.png)

[![](http://owl.fish.washington.edu/Athaliana/20171120_updated_PATH.png)](http://owl.fish.washington.edu/Athaliana/20171120_updated_PATH.png)

After doing this, I noticed that the PATH assignment in the `/etc/environment` file is incorrect - it has the $PATH variable appended to the front of the list. This results in the system PATH appending itself to itself over and over again, resulting in a ridiculously long list (like in the screen cap directly above this text). So, I removed that portion and re-sourced the `/etc/environment` file to tidy things up.

Fingers crossed this will resolve the issue...
