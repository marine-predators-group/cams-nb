---
layout: post
title: add drifters
date: '2020-03-05'
tags:
  - nip
categories:
---

Got a subset of the drifter data from AOML and made sure to only get those that are drogued, for 2002-2019 (matching tag data), and global (for now).

Your submitted request was: request_gld.20200306_013522
Drogue=1
fromDate=2002/02/15
toDate=2019/06/30
northernEdge=90
southernEdge=-78
westernEdge=-180
easternEdge=180

```
setwd('~/ebs/Data/drifters/')
download.file('ftp://ftp.aoml.noaa.gov/od/pub/envids/metadata_gld.20200306_013522.zip', 'metadata_gld.20200306_013522.zip')
download.file('ftp://ftp.aoml.noaa.gov/od/pub/envids/interpolated_gld.20200306_013522.zip', 'interpolated_gld.20200306_013522.zip')

unzip('metadata_gld.20200306_013522.zip')
unzip('interpolated_gld.20200306_013522.zip')

dr <- data.table::fread('interpolated_gld.20200306_013522')
meta <- data.table::fread('metadata_gld.20200306_013522', fill=T)

```

