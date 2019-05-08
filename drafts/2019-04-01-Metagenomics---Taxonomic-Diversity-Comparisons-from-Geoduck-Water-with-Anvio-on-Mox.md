---
layout: post
title: Metagenomics - Taxonomic Diversity Comparisons from Geoduck Water with Anvio on Mox
date: '2019-04-01 14:44'
tags:
  - metagenomics
  - water
  - geoduck
  - Panopea generosa
  - anvio
  - mox
categories:
  - Miscellaneous
---


One of the many reasons [Anvi'o](http://merenlab.org/software/anvio/) seems like such a good choice for this are things like this:

![Anvio's screencap showing memory requirement and skull](https://github.com/RobertsLab/sams-notebook/blob/master/images/screencaps/20190404_metagenomics_pgen_anvio-01.png?raw=true)

By checking the SLURM output file, Anvi'o was showing that it was using 28 threads that required 478GB of memory, and since I was using a node in the coenv partition, I had insufficient memory (only 120GB)! Luckily, we have a 500GB node in the srlab partion. So, with some finagling I did the following in order to get this job to run faster (if I had left if running, it would have probably taken months to complete):

- killed Anvi'o job running on coenv node
- killed Maker job running on both srlab nodes
- started Anvi'o job running on srlab 500GB node
- queued Maker job on srlab nodes
  - This has built-in checkpointing so we continue where it left off once Anvi'o job completes!


---

#### RESULTS

Whew! This took quite some time to run (over two weeks!):

![screencap of start/end time of Anvi'o run on Mox](https://github.com/RobertsLab/sams-notebook/blob/master/images/screencaps/20190401_anvio_runtime.png?raw=true)


All the stuff below is to give a simple overview of what Anvi's has generated. More detailed exploration/analysis will happen later.

- Output folder:

- [20190401_metagenomics_pgen_anvio/](http://gannet.fish.washington.edu/Atumefaciens/20190401_metagenomics_pgen_anvio/)

"Important" files. The following files are the three core files needed to run Anvi'o's interactive plotting interface:

- [20190401_metagenomics_pgen_anvio/contigs.db](http://gannet.fish.washington.edu/Atumefaciens/20190401_metagenomics_pgen_anvio/contigs.db) (5.2GB)

- [20190401_metagenomics_pgen_anvio/SAMPLES-MERGED/PROFILE.db](http://gannet.fish.washington.edu/Atumefaciens/20190401_metagenomics_pgen_anvio/SAMPLES-MERGED/PROFILE.db) (2.1GB)

- [20190401_metagenomics_pgen_anvio/SAMPLES-MERGED/AUXILIARY-DATA.db](http://gannet.fish.washington.edu/Atumefaciens/20190401_metagenomics_pgen_anvio/SAMPLES-MERGED/AUXILIARY-DATA.db) (1.6GB)


Command to generate interactive plot:

`anvi-interactive -p PROFILE.db -c contigs.db -C CONCOCT`

Then, in my case, a browser window opens, but doesn't produce anything. So, in that window I need to enter the following URL to see the plotting interface:

`http://0.0.0.0:8080`



Screencaps of interactive plot interfaces:

---

#### Circular phylogram

![Screencap of circular phylogram interactive plot interface](https://github.com/RobertsLab/sams-notebook/blob/master/images/screencaps/20190401_anvio_circle_phylogram-01.png?raw=true)


---

#### Standard phylogram

![Screencap of standard phylogram interactive plot interface](https://github.com/RobertsLab/sams-notebook/blob/master/images/screencaps/20190401_anvio_phylogram-01.png?raw=true)

---

The plot(s) above are showing the results of [CONCOCT](https://github.com/BinPro/CONCOCT) genome binning (this is built-in with Anvi'o) and detection of those genomes across all the samples.

There's a lot going on here that needs further exploration data-wise, as well as just how to understand the Anvi'o plotting interface (e.g. what do all the different views actually mean, how to rename samples, what does the `summarize` command produce, etc.). I'll explore this further later on.
