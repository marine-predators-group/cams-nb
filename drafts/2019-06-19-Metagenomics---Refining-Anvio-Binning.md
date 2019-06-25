---
layout: post
title: Metagenomics - Refining Anvio Binning
date: '2019-06-19 08:25'
tags:
  - metagenomics
  - Panopea generosa
  - geoduck
  - anvio
categories:
  - Miscellaneous
---


Check the initial data binning:

```shell
anvi-interactive \
--profile-db PROFILE.db \
--contigs-db contigs.db \
--collection-name CONCOCT
```

That generates this:

![initial anvio dendrogram screencap]()



Table representation of initial data binning:

```shell
anvi-summarize \
--pan-or-profile-db PROFILE.db \
--contigs-db contigs.db \
--collection-name CONCOCT \
--output-dir MERGED_SUMMARY
```

This command generates an `index.html` file (see Results section below for link) and takes ~10 minutes to complete. Here's the portion showing the binning completion/redundancy info (there's much, much more data present in that file):

![initial anvio binning table showing completion/redundancy]()



Refine the bins:

```shell
anvi-refine \
--profile-db PROFILE.db \
--contigs-db contigs.db \
--collection-name CONCOCT \
--bin-id Bin_75
```

In the screencap below, the region of the dendrogram marked as "Bin_75_1" shows a drastic difference in coverage in the MG7 track at this particular split. Additionally, looking at the quick stats shown for this newly identified bin in the window pane to the left, one can see that Completion is now 99% and Redundancy is only 1.4%; a marked improvement on the automatic binning.




There does appear to be a problem with the binning data, though. It appears that many bins exhibit Completion/Redundancy data of 0.00%, however clicking on that data in the summary table reveals that is incorrect:



Ah, as it turns out, this has been fixed in the "master" commit in Anvi'o (thanks to the Anvi'o devs for their fast responses to my questions on their [Slack channel](https://anvio.slack.com/archives/C8SFMGYF3/p1561043792054900)!!).

Here's how the upgrade process went:



After upgrading, here's how things look:

![Screencap of dendgrogram after update now shows Completion/Redundancy info for all bins]()


![Screencap of Summarize table after update]()


Clearly, there's a _lot_ of manual binning that needs to take place in order to refine the bins with excessive Completion/Redundancy info...

---

#### RESULTS

Output folder:
