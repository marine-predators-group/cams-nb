---
layout: post
title: Genome Assessment - BUSCO Metazoa on P.generosa v071 on Mox
date: '2019-03-02 07:46'
tags:
  - busco
  - metzoa
  - Panopea generosa
  - geoduck
  - mox
  - augustus
categories:
  - Miscellaneous
---




---

#### RESULTS

Human output folder:

- [20190228_pgen_busco_metazoa_augustus/](http://gannet.fish.washington.edu/Atumefaciens/20190228_pgen_busco_metazoa_augustus/)

Fly output folder:

- [20190301_pgen_busco_metazoa_fly_augustus/](http://gannet.fish.washington.edu/Atumefaciens/20190301_pgen_busco_metazoa_fly_augustus/)

---

Human short summary:

- [20190228_pgen_busco_metazoa_augustus/run_Pgenerosa_v071_genome_snap02.all.maker/short_summary_Pgenerosa_v071_genome_snap02.all.maker.txt](http://gannet.fish.washington.edu/Atumefaciens/20190228_pgen_busco_metazoa_augustus/run_Pgenerosa_v071_genome_snap02.all.maker/short_summary_Pgenerosa_v071_genome_snap02.all.maker.txt)

<pre><code>
# BUSCO version is: 3.0.2
# The lineage dataset is: metazoa_odb9 (Creation date: 2016-02-13, number of species: 65, number of BUSCOs: 978)
# To reproduce this run: python /gscratch/srlab/programs/busco-v3/scripts/run_BUSCO.py -i /gscratch/srlab/sam/data/P_generosa/genomes/Pgenerosa_v071_genome_snap02.all.renamed.fasta -o Pgenerosa_v071_genome_snap02.all.maker -l /gscratch/srlab/sam/data/databases/BUSCO/metazoa_odb9/ -m genome -c 28 --long -z -sp human --augustus_parameters '--progress=true'
#
# Summarized benchmarking in BUSCO notation for file /gscratch/srlab/sam/data/P_generosa/genomes/Pgenerosa_v071_genome_snap02.all.renamed.fasta
# BUSCO was run in mode: genome

	C:76.3%[S:73.3%,D:3.0%],F:5.2%,M:18.5%,n:978

	746	Complete BUSCOs (C)
	717	Complete and single-copy BUSCOs (S)
	29	Complete and duplicated BUSCOs (D)
	51	Fragmented BUSCOs (F)
	181	Missing BUSCOs (M)
	978	Total BUSCO groups searched
</code></pre>

---

Fly short summary:

- [20190301_pgen_busco_metazoa_fly_augustus/run_Pgenerosa_v071_genome_snap02.all.maker/short_summary_Pgenerosa_v071_genome_snap02.all.maker.txt](http://gannet.fish.washington.edu/Atumefaciens/20190301_pgen_busco_metazoa_fly_augustus/run_Pgenerosa_v071_genome_snap02.all.maker/short_summary_Pgenerosa_v071_genome_snap02.all.maker.txt)

<pre><code>
# BUSCO version is: 3.0.2
# The lineage dataset is: metazoa_odb9 (Creation date: 2016-02-13, number of species: 65, number of BUSCOs: 978)
# To reproduce this run: python /gscratch/srlab/programs/busco-v3/scripts/run_BUSCO.py -i /gscratch/srlab/sam/data/P_generosa/genomes/Pgenerosa_v071_genome_snap02.all.renamed.fasta -o Pgenerosa_v071_genome_snap02.all.maker -l /gscratch/srlab/sam/data/databases/BUSCO/metazoa_odb9/ -m genome -c 28 --long -z -sp fly --augustus_parameters '--progress=true'
#
# Summarized benchmarking in BUSCO notation for file /gscratch/srlab/sam/data/P_generosa/genomes/Pgenerosa_v071_genome_snap02.all.renamed.fasta
# BUSCO was run in mode: genome

	C:76.6%[S:73.3%,D:3.3%],F:5.2%,M:18.2%,n:978

	749	Complete BUSCOs (C)
	717	Complete and single-copy BUSCOs (S)
	32	Complete and duplicated BUSCOs (D)
	51	Fragmented BUSCOs (F)
	178	Missing BUSCOs (M)
	978	Total BUSCO groups searched
</code></pre>
