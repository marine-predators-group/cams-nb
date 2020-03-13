
---
layout: post
title: "Preparing tag data for FaCeT"
author: Camrin Braun
date: '2020-03-12'
tags:
  - facet
---

*** 
### Get raw eTUFF data

```
## load most recent meta file from nip_drake project
meta <- read.table('~/work/RCode/nip_drake/RawData/all_tag_meta.csv', sep=',', header=T, stringsAsFactors = F)

## get only data for two species, owned by CDB for which eTUFF is already created
meta <- filter(meta, etuff == 1 & person_owner == 'Camrin Braun' & (platform == 'Prionace glauca' | platform == 'Xiphias gladius'))

#---------------
## identify eTUFF files from NIP, if available
etuff_files <- list.files('~/work/RCode/nip_drake/data/etuff/', full.names = TRUE)
etuff_ids <- rep(NA, length.out=length(etuff_files))
for (i in 1:length(etuff_files)) etuff_ids[i] <- substr(etuff_files[i], stringr::str_locate(etuff_files[i], '//')[2] + 1, stringr::str_locate(etuff_files[i], '_eTUFF')[1] - 1)

## copy files from NIP to drive
etuff_files <- etuff_files[which(etuff_ids %in% meta$instrument_name)]
for (i in 1:length(etuff_files)) file.copy(etuff_files[i], paste('~/Google Drive File Stream/Shared drives/FaCeT/data/raw/'))


#---------------
## identify etuff files from data_org, if available
etuff_files <- list.files('~/Desktop/data_org/', full.names = FALSE, recursive = TRUE)
etuff_files <- etuff_files[grep('eTUFF_hdr', etuff_files)]
etuff_ids <- rep(NA, length.out=length(etuff_files))
for (i in 1:length(etuff_files)) etuff_ids[i] <- substr(etuff_files[i], stringr::str_locate(etuff_files[i], '/')[2] + 1, stringr::str_locate(etuff_files[i], '_eTUFF')[1] - 1)

## copy files to drive
etuff_files <- list.files('~/Desktop/data_org/', full.names = TRUE, recursive = TRUE)
etuff_files <- etuff_files[grep('eTUFF_hdr', etuff_files)]
etuff_files <- etuff_files[which(etuff_ids %in% meta$instrument_name)]
etuff_ids <- etuff_ids[which(etuff_ids %in% meta$instrument_name)]
#etuff_ids <- rep(NA, length.out=length(etuff_files))
#for (i in 1:length(etuff_files)) etuff_ids[i] <- substr(etuff_files[i], stringr::str_locate(etuff_files[i], '/')[2] + 1, stringr::str_locate(etuff_files[i], '_eTUFF')[1] - 1)
for (i in 1:length(etuff_files)) file.copy(etuff_files[i], paste('~/Google Drive File Stream/Shared drives/FaCeT/data/raw/', etuff_ids[i], '_eTUFF_hdr.txt', sep=''), overwrite = FALSE)

#---------------
## test if it worked
foo <- team_drive_get("FaCeT")
drive_get(c("160424_2013_132346_eTUFF_hdr.txt"), team_drive = foo)

## get the uploaded data from drive
setwd('~/work/RCode/NASA-FaCeT/data/raw/')
drib <- drive_find(pattern='eTUFF', team_drive = foo)
for (i in 1:nrow(drib)) drive_download(drib[i,])


```


*** 
### Get rds outputs from build_move

These are RDS files as output from `analyzePSAT::build_move()` which is a custom (somewhat of a wrapper) function for track filtering, standardization, behavior estimation and simulation. This has already been conducted on the Argos-based tags for another project. Those RDS files are identified and copied to the FaCeT drive here:

```
## load most recent meta file from nip_drake project
meta <- read.table('~/work/RCode/nip_drake/RawData/all_tag_meta.csv', sep=',', header=T, stringsAsFactors = F)

## get only data for two species, owned by CDB for which eTUFF is already created
meta <- filter(meta, etuff == 1 & person_owner == 'Camrin Braun' & (platform == 'Prionace glauca' | platform == 'Xiphias gladius'))

#---------------
## identify eTUFF files from NIP, if available
rds_files <- list.files('~/work/RCode/nip_drake/move_res/', full.names = TRUE)
rds_ids <- rep(NA, length.out=length(rds_files))
for (i in 1:length(rds_files)) rds_ids[i] <- substr(rds_files[i], stringr::str_locate(rds_files[i], '//')[2] + 1, stringr::str_locate(rds_files[i], '_move')[1] - 1)

## copy files from NIP to drive
rds_files <- rds_files[which(rds_ids %in% meta$instrument_name)]
for (i in 1:length(rds_files)) file.copy(rds_files[i], paste('~/Google Drive File Stream/Shared drives/FaCeT/data/processed/'))

## this identifies which meta records still need attention
## obviously these are all the pop-up tags that haven't had the same treatment
meta[which(!(meta$instrument_name %in% rds_ids)),]

```

On second thought, we'll actually need to redo the simulation portion of these RDS to get a higher number of sims (see Queiroz et al 2016 supp for sensitivitiy analysis). Suggests ~75 sims is where things stabilize.

```

rds_files <- list.files('~/Google Drive File Stream/Shared drives/FaCeT/data/processed/', full.names = T)
rds_files <- rds_files[grep('move.rds', rds_files)]

bathy <- raster('~/Google Drive File Stream/Shared drives/FaCeT/data/envdata/global_bathy.grd')
  
for (i in 1:length(rds_files)){
  
  move <- readRDS(rds_files[i])
  
  locs.all <- split(move$pred, move$pred$id)
  
  # parameterize the sims
  reps <- 75
  min_locs <- 10
  
  # binary bathy layer, 1 is water NA is land
  r <- raster::raster(bdf)
  
  tmp_out <- lapply(locs.all, FUN=function(x){
    x$bathy <- raster::extract(r, cbind(x$lon, x$lat))
    
    x <- filter(x, bathy == 1) # get rid of points on land
    
    if (nrow(x) > min_locs){
      
      # build trajectories to base sims on
      tr1 <- adehabitatLT::as.ltraj(cbind(x$lon, x$lat), date=x$date, id=as.factor(x$id),
                                    proj4string = sp::CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"))
      
      
      crw <- adehabitatLT::NMs.randomCRW(na.omit(tr1), rangles=TRUE, rdist=TRUE,
                                         #treatment.func = myfunc,
                                         #treatment.par = map,
                                         constraint.func = consfun,
                                         constraint.par = bdf, nrep = reps)
      # simulate
      tmp <- adehabitatLT::testNM(crw)
      
      for (i in 1:length(tmp)){
        id.i <- names(tmp)[i]
        for (b in 1:length(tmp[[i]])){
          tmp.b <- tmp[[i]][[b]]
          names(tmp.b) <- c('lon','lat','date')
          tmp.b$id <- id.i
          tmp.b$id.iter <- paste(id.i, '.', b, sep='')
          tmp.b$instrument_name <- x$instrument_name[1]
          #tmp.b$date <- as.Date(tmp.b$date)
          #tmp.b$bathy <- raster::extract(bathy, cbind(tmp.b$lon, tmp.b$lat))
          #tmp.b <- tmp.b[which(!is.na(tmp.b$bathy)),]
          
          if (b == 1){
            tmp_out <- tmp.b
          } else {
            tmp_out <- rbind(tmp_out, tmp.b)
          }
        } # end b loop
      } # end i loop
      tmp_out
      
    }
    
    # output from tmp loop is rbind(df) w cols lon, lat, date, id, id.iter
    
  }) %>% do.call(rbind, .)

  tmp_out$bathy <- raster::extract(bathy, cbind(ifelse(tmp_out$lon < 0, tmp_out$lon + 360, tmp_out$lon), tmp_out$lat))
  
  move$sim <- tmp_out
  
  saveRDS(move, file = rds_files[i])
}

```

*** 
### Preparing pop-up data for SDMs

We need:

*  daily track estimates plus x/y error radius or confidence interval

*  daily tag-measured mean SST

*  other vertical info? 

All GPE3 and HMMoce sword locations are in scratch/cdb. Should do the same for blue sharks.

After all this was done, turns out GPE3 is rubbish for swords. Have to use HMMoce outputs so re-running to make that change.

```

meta <- read.table('~/work/RCode/nip_drake/RawData/all_tag_meta.csv', sep=',', header=T, stringsAsFactors = F)

## get only data for two species, owned by CDB for which eTUFF is already created
meta <- filter(meta, etuff == 1 & person_owner == 'Camrin Braun' & platform == 'Xiphias gladius' & instrument_type == 'popup' & meta$ptt != 100978)

## get etuff file list
etuff_files <- list.files('~/Google Drive File Stream/Shared drives/FaCeT/data/raw/', full.names = TRUE, recursive = TRUE)
etuff_files <- etuff_files[grep('eTUFF_hdr', etuff_files)]

#gpe_files <- list.files('~/work/RCode/NASA-FaCeT/scratch/cdb/', full.names = T)
#gpe_files_nc <- gpe_files[grep('GPE3.nc', gpe_files)]
#gpe_files_csv <- gpe_files[grep('GPE3.csv', gpe_files)]

bathy <- raster('~/Google Drive File Stream/Shared drives/FaCeT/data/envdata/global_bathy.grd')

outDir <- "/Users/Cam/Google Drive File Stream/Shared drives/FaCeT/data/processed/"

hmm_locs <- read.table("/Users/Cam/Google Drive File Stream/Shared drives/FaCeT/data/raw/all_sword_hmmoce_locs.csv", sep=',', header=T)
hmm_locs$date <- as.POSIXct(hmm_locs$date, tz='UTC')

for (i in 4:nrow(meta)){
  
  #ncFile <- list.files()[grep('.nc', list.files())]
  #csvFile <- list.files()[grep('GPE3.csv',list.files())]
  
  #out <- getCtr_gpe3(gpe_files_nc[i], gpe_files_csv[i], threshold=50, makePlot=F)
  #df <- lapply(out, FUN=function(x) cbind(x$loc, x$xDist, x$yDist))
  #df <- rlist::list.rbind(df)
  df <- hmm_locs[which(hmm_locs$ptt == meta$ptt[i]),]
  df$id <- meta$instrument_name[i]
  #names(df) <- c('id','date','lat','lon','xDist','yDist')
  #ci[[i]] <- CI2shp(df)
  
  cat("building simulations...\n")
  
  locs.all <- split(df, df$id)
  
  # parameterize the sims
  reps <- 75
  min_locs <- 10
  
  # binary bathy layer, 1 is water NA is land
  r <- raster::raster(bdf)
  
  tmp_out <- lapply(locs.all, FUN=function(x){
    
    if (any(duplicated(x$date))) x <- x[which(!duplicated(x$date)),]
    
    x$bathy <- raster::extract(r, cbind(x$lon, x$lat))
    
    x <- filter(x, bathy == 1) # get rid of points on land
    
    if (nrow(x) > min_locs){
      
      # build trajectories to base sims on
      tr1 <- adehabitatLT::as.ltraj(cbind(x$lon, x$lat), date=x$date, id=as.factor(x$id),
                                    proj4string = sp::CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"))
      
      
      crw <- adehabitatLT::NMs.randomCRW(na.omit(tr1), rangles=TRUE, rdist=TRUE,
                                         #treatment.func = myfunc,
                                         #treatment.par = map,
                                         constraint.func = consfun,
                                         constraint.par = bdf, nrep = reps)
      # simulate
      tmp <- adehabitatLT::testNM(crw)
      
      for (i in 1:length(tmp)){
        id.i <- names(tmp)[i]
        for (b in 1:length(tmp[[i]])){
          tmp.b <- tmp[[i]][[b]]
          names(tmp.b) <- c('lon','lat','date')
          tmp.b$id <- id.i
          tmp.b$id.iter <- paste(id.i, '.', b, sep='')
          tmp.b$instrument_name <- x$instrument_name[1]
          #tmp.b$date <- as.Date(tmp.b$date)
          #tmp.b$bathy <- raster::extract(bathy, cbind(tmp.b$lon, tmp.b$lat))
          #tmp.b <- tmp.b[which(!is.na(tmp.b$bathy)),]
          
          if (b == 1){
            tmp_out <- tmp.b
          } else {
            tmp_out <- rbind(tmp_out, tmp.b)
          }
        } # end b loop
      } # end i loop
      tmp_out
      
    }
    
    # output from tmp loop is rbind(df) w cols lon, lat, date, id, id.iter
    
  }) %>% do.call(rbind, .)
  
  tmp_out$bathy <- raster::extract(bathy, cbind(ifelse(tmp_out$lon < 0, tmp_out$lon + 360, tmp_out$lon), tmp_out$lat))
  

  
  #------------------
  ## make output
  #------------------
  cat("\ngenerating output of class \"move\"...\n")
  
  meta.sub <- meta[grep(df$id[1], meta$instrument_name),]
  if (nrow(meta.sub) > 1) meta.sub <- meta.sub[which(meta.sub$platform == 'Xiphias gladius'),]
  if (nrow(meta.sub) > 1) stop('more than one meta row')
  
  out <- list(
    raw = NULL,
    pred = data.frame(df),
    sim = tmp_out,
    ssm_fit = NULL,
    mpm_fit = NULL,
    vert = NULL,
    platform = 'Xiphias gladius',
    meta = meta.sub
    
  )
  
  out$pred$instrument_name <- meta.sub$instrument_name
  
  
  class(out) <- append("move", class(out))
  
  saveRDS(out, file=paste(outDir, out$meta$instrument_name, '_move.rds', sep=''))
  
}

```

Popup data was converted to a move object with sims but without move$raw (which is really meant for raw argos data). Results look something like:

![Example PSAT prepped for SDMs with simulations.](https://github.com/marine-predators-group/cams-nb/blob/gh-pages/images/example_psat_sim.png?raw=true)

*** 
### Add vertical data to move outputs

```

## load most recent meta file from nip_drake project
meta <- read.table('~/work/RCode/nip_drake/RawData/all_tag_meta.csv', sep=',', header=T, stringsAsFactors = F)

## get only data for two species, owned by CDB for which eTUFF is already created
meta <- filter(meta, etuff == 1 & person_owner == 'Camrin Braun' & (platform == 'Prionace glauca' | platform == 'Xiphias gladius') & instrument_type == 'popup'& meta$ptt != 100978)

rds_files <- list.files('~/Google Drive File Stream/Shared drives/FaCeT/data/processed/', full.names = T)
rds_files <- rds_files[grep('move.rds', rds_files)]
rds_ids <- rep(NA, length.out=length(rds_files))
for (i in 1:length(rds_files)) rds_ids[i] <- substr(rds_files[i], stringr::str_locate(rds_files[i], '//')[2] + 1, stringr::str_locate(rds_files[i], '_move')[1] - 1)

idx <- which(rds_ids %in% meta$instrument_name)

## get etuff file list
etuff_files <- list.files('~/Google Drive File Stream/Shared drives/FaCeT/data/raw/', full.names = TRUE, recursive = TRUE)
etuff_files <- etuff_files[grep('eTUFF_hdr', etuff_files)]

outDir <- "/Users/Cam/Google Drive File Stream/Shared drives/FaCeT/data/processed/"

for (i in idx){
  
  move <- readRDS(rds_files[i])

  if (is.null(move$vert)){
    
    etuff <- etuff_files[grep(move$meta$instrument_name, etuff_files)]
    hdr <- get_etuff_hdr(etuff)

    df <- read.table(etuff, sep = ',', header = T, skip = hdr[which(hdr$varName == 'skip'), 2])
    df <- df %>% dplyr::select(-c(VariableID, VariableUnits)) %>% spread(VariableName, VariableValue)
    df$id <- hdr[grep('instrument_name', hdr$varName), 2]
    if (names(df)[1] == 'X...DateTime') names(df)[1] <- 'DateTime'
    df$DateTime <- as.POSIXct(df$DateTime, tz='UTC')

    move$vert <- df
    
      saveRDS(move, file=paste(outDir, move$meta$instrument_name, '_move.rds', sep=''))

  }
    
  
}

```


*** 
### Pseudo-absences
From Hazen et al 2018: 
"All tracks were standardized using a state spacemodel, generating a dai- ly regular position including uncertainty estimates to match availability of remotely sensed environmental data (30)...Pseudo-absences (hereafter called absences) for tracking data were generated by creating a set of 20 correlated random walks for each in- dividual, which started at the tagging location and matched the total duration of the tag (fig. S2). Each step was determined by sampling a paired step length and turning angle from the distribution of ob- served step lengths and turning angles from the corresponding track [see the study ofHazen et al.(31)]. The correlated random walks thus recreate movement characteristics that are similar to the original track butmove independently ofthe underlying environment to sample space available to, but not used by, focal individuals.We collated tracking data and randomly selected absences into a master data set, combining loca- tions received from all individuals sampled from each population. To account for sampling bias and reduce spatial autocorrelation issues, pres- ences and absences from tracking data were randomly and iteratively sub-sampled 1000 times."

Basically make master data frame of lat/lons that were for a mixture of observations (track positions) and absences (simulated track positions), then just randomly sampled 1000 positions from the larger dataset from which the SDMs were built.

Will be building three separate sets of models:

1. P glauca from arogs-based sat tags

2. P glauca from pop up tags (and compare to sat tag results as almost all fish were double-tagged) -> **validation of pop up tag SDMs!**

3. X gladius from pop up tags (likely larger error bounds than P glauca pop up based models)

Having difficulty with the `lapply` code below due to lack of standardization in the way the SE metrics are reported in the different cases. For example, argos-based tags are output from `foieGras::fit_ssm` as lat/lon with some x/y error metrics that appear to be in kms. However, HMMoce and GPE3 outputs provide lat/lon and xdist/ydist SE in degrees. Added to an existing closed issue on `foieGras` site to see if that was indeed solved.

```

rds_files <- list.files('~/Google Drive File Stream/Shared drives/FaCeT/data/processed/', full.names = T)
rds_files <- rds_files[grep('move.rds', rds_files)]
rds_ids <- rep(NA, length.out=length(rds_files))
for (i in 1:length(rds_files)) rds_ids[i] <- substr(rds_files[i], stringr::str_locate(rds_files[i], '//')[2] + 1, stringr::str_locate(rds_files[i], '_move')[1] - 1)

meta <- make_move_list(rds_files, meta_only = TRUE)
move_list <- make_move_list(rds_files, meta_only = FALSE)

move <- lapply(move_list$move[[1]], FUN=function(x){
  pred_all <- x$pred
  sim_all <- x$sim
  names(pred_all) <- tolower(names(pred_all))
  names(sim_all) <- tolower(names(sim_all))
  pred_all <- pred_all[,c('lon','lat','date','id','bathy','instrument_name', 'xdist', 'ydist')]
  pred_all$type <- 'obs'
  sim_all <- sim_all[,c('lon','lat','date','id.iter','bathy','instrument_name')]
  sim_all$type <- 'sim'
  sim_all$xdist <- 0
  sim_all$ydist <- 0
  names(sim_all)[4] <- 'id'
  all <- rbind(pred_all, sim_all)
  all
}) %>% do.call(rbind, .)


```
