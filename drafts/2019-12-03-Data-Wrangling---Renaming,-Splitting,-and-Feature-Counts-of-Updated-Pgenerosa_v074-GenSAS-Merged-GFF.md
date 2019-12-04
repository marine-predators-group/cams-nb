---
layout: post
title: Data Wrangling - Renaming, Splitting, and Feature Counts of Updated Pgenerosa_v074 GenSAS Merged GFF
date: '2019-12-03 15:34'
tags:
  - GFF
  - parsing
  - Panopea generosa
  - geoduck
  - genome
  - GenSAS
categories:
  - Geoduck Genome Sequencing
---
In the final GFF from our [GenSAS Pgenerosa_v074.a4 annotation ](https://robertslab.github.io/sams-notebook/2019/09/28/Genome-Annotation-Pgenerosa_v074-a4-Using-GenSAS.html), we noticed that there were no repeat motifs/sequences identified on Scaffold 01. The remaining scaffolds all had repeat motifs present on them, so something seemed amiss (see this [GitHub Issue for more info](https://github.com/RobertsLab/resources/issues/788)).

I ended up contacting GenSAS and it turned out there was a bug on their end that led to this:


>Taein Lee
>Nov 26, 2019, 7:27 PM (8 days ago)
>to me, jhumann
>
>Hi Sam,
>
>Thank you so much for your report. There was a bug and it has been fixed.
>Your gff3 files has been re-generated.
>
>-Taein
>From: gensas-admin on behalf of sam white
>Sent: Tuesday, November 26, 2019 3:45 PM
>To: gensas-admin; jhumann; taein_lee
>Subject: [Website feedback] Merged GFF missing repeats on only one chromosome
>
>Sam (https://www.gensas.org/user/1671) sent a message using the contact form
>at https://www.gensas.org/gensas-contact.
>
>Hi,
>
>I generated a merged GFF after I "published" my annotation. I included
>RepeatModeler features in the merged GFF.
>
>My genome has 18 chromosomes. All of them except one chromosome (name:
>PGA_scaffold1__77_contigs__length_89643857) has the expected repeats
>annotations present.
>
>I looked at the individual RepeatMasker and RepeatModeler jobs, and both of
>those GFFs identified repeats on PGA_scaffold1__77_contigs__length_89643857.
>
>Would you happen to have any ideas on why
>PGA_scaffold1__77_contigs__length_89643857 isn't showing any repeat features
>in the merged GFF?>
>
>This is for my project Pgenerosa_v074.
>
>Thanks for any insight!
>
>Sam


---

#### RESULTS

Output folder:

- [20191203_pgen_v074.a4_genome_feature_counts/](https://gannet.fish.washington.edu/Atumefaciens/20191203_pgen_v074.a4_genome_feature_counts/)
