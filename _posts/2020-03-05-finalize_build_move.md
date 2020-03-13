---
layout: post
title: finalize build_move
date: '2020-03-05'
tags:
  - nip
categories:
---

Hopefully this wraps up all the `build_move` runs.

run build_move w sims, save rds

Two remaining issues:
*  meta[133,] "159903_2012_118864" sims are freezing. Built in a catch but that means the sims for that traj are skipped. Thus resulting in an observed traj with no associated sims.
*  172 ("160189_2015_141155") & 258 ("159924_2018_159824") look like 2 individual datasets are combined into one etuff file - somehow this was magically fixed...

```
source('~/ebs/RCode/nip_drake/R/functions.R')
source('~/ebs/RCode/nip_drake/R/packages.R')

# first build_move for all indiv of interest
meta <- read.table('./RawData/all_tag_meta.csv', sep=',', header=T, stringsAsFactors = F)
meta <- meta[which(meta$etuff == 1 & meta$instrument_type == 'satellite' & meta$person_owner != 'TOPP'),]

files = list.files(path='/home/rstudio/ebs/Data/eddies/etuff/', pattern="*.txt", full.names=TRUE, recursive=FALSE)

res_files <- list.files('~/ebs/RCode/nip_drake/move_res/', pattern = "*.rds", full.names=T)

idList <- sapply(res_files, FUN=function(x) id <- substr(x, 
               stringr::str_locate(x, '//')[2] + 1,
               stringr::str_locate(x, '_move')[1] - 1))

#dir.create('~/ebs/RCode/nip_drake/temp_res/')

# go through the build_move process then pull move$raw
idx <- which(!meta$instrument_name %in% idList)
idx <- idx[-which(idx %in% c(133))] # sims are freezing
idx <- idx[-which(idx %in% c(311, 315, 349, 473, 529, 600, 629))] # build_move fails, no convergence for good reason (usually little data)
idx <- idx[-which(idx %in% nullVec)]
failVec <- NA; nullVec <- NA
for (i in idx){
#for (i in failVec){
 
  fName <- files[grep(paste(meta$instrument_name[i], '_', sep=''), files)]
  fName <- fName[grep('hdr', fName)]
  
  id <- substr(fName, 
               stringr::str_locate(fName, '//')[2] + 1,
               stringr::str_locate(fName, '_eTUFF')[1] - 1)
  
  if (
    file.exists(paste('~/ebs/RCode/nip_drake/move_res/', id, '_move.rds', sep=''))
    ) next

  t1 <- Sys.time()
  # build_move
  move = try(build_move(fName, ssm = 'foieGras', behav = TRUE,
                        sim = TRUE, reps = 20, time_step = 6, gap_days = 10,
                        min_locs = 20, res_out = 6, cut_days = 5, bathy = raster('~/ebs/EnvData/bathy/global_bathy.grd')), TRUE)
  
  if (class(move)[1] == 'try-error'){
    failVec[length(failVec) + 1] <- i
    #stop(paste('build_move failed for ', id, '...', sep = ''))
  } else if(is.null(move)){
    
    nullVec[length(nullVec) + 1] <- i
  
  } else{
    
    saveRDS(move, file=paste('~/ebs/RCode/nip_drake/move_res/', id, '_move.rds', sep=''))

  }
  
  #t2 <- Sys.time()
  
}

failVec <- failVec[!is.na(failVec)]
nullVec <- nullVec[!is.na(nullVec)]
failVec.save <- failVec
# plus 133 freezing in sim 2
# 258 freezing sim 1
# 172 sim 2

# the rds files written out are already controlling for the failures
rds_files <- list.files('~/ebs/RCode/nip_drake/move_res/', full.names = F)

```



```

source('~/ebs/RCode/nip_drake/R/functions.R')
source('~/ebs/RCode/nip_drake/R/packages.R')

# first build_move for all indiv of interest
meta <- read.table('./RawData/all_tag_meta.csv', sep=',', header=T, stringsAsFactors = F)
meta <- meta[which(meta$etuff == 1 & meta$instrument_type == 'satellite'),]
files = list.files(path='/home/rstudio/ebs/Data/eddies/etuff2/', pattern="*.txt", full.names=TRUE, recursive=FALSE)


#dir.create('~/ebs/RCode/nip_drake/temp_res/')

# go through the build_move process then pull move$raw
failVec <- NA
#for (i in 1:nrow(meta)){
 i=34
  fName <- files[grep(meta$instrument_name[i], files)]
  fName <- fName[grep('hdr', fName)]

  id <- substr(fName,
               stringr::str_locate(fName, '//')[2] + 1,
               stringr::str_locate(fName, '_eTUFF')[1] - 1)

  t1 <- Sys.time()
  # build_move
  move = try(build_move(fName, ssm = 'foieGras', behav = TRUE,
                        sim = FALSE, reps = 20, time_step = 6, gap_days = 10,
                        min_locs = 20, res_out = 6, cut_days = 5, bathy = raster('~/ebs/EnvData/bathy/global_bathy.grd')), TRUE)


```

Need to copy over some old etuff files that didn't make the most recent batch of converted files and thus aren't in the right directory.

```

meta <- read.table('./RawData/all_tag_meta.csv', sep=',', header=T, stringsAsFactors = F)
meta <- meta[which(meta$etuff == 1 & meta$instrument_type == 'satellite'),]
files = list.files(path='/home/rstudio/ebs/Data/eddies/etuff2/', pattern="*.txt", full.names=TRUE, recursive=FALSE)

meta$etuff_file <- NA
for (i in 1:nrow(meta)){
  if (length(grep(meta$instrument_name[i], files)) == 1){
    meta$etuff_file[i] <- 1
  } else if (length(grep(meta$instrument_name[i], files)) == 0){
    meta$etuff_file[i] <- 0
  } else {}

}

meta.sub <- meta[which(meta$etuff_file == 0),]
meta.sub %>% group_by(person_owner, platform, end_type) %>% dplyr::summarise(n=n())

static_owners <- c('Alison Kock', 'Bradley Wetherbee')
for (i in 1:nrow(meta)){

  if (length(grep(meta$instrument_name[i], files)) == 0){
    from_file <- paste('~/ebs/Data/move/', meta$instrument_name[i], '/', meta$instrument_name[i], '_eTUFF_hdr.txt', sep='')
    to_file <- paste('~/ebs/Data/eddies/etuff2/', meta$instrument_name[i], '_eTUFF_hdr.txt', sep='')
    file.copy(from_file, to_file)
  }

}

```
