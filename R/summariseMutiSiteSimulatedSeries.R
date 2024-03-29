###############################
#' Creates summary plots of the biases in the multi-site scenarios
#'
#' \code{plotMultiSiteScenarios} uses a multi-site simulation performed using the function \code{generateScenarios} as input, 
#' and creates heatmaps that show biases in simulated attributes and spatial correlation. 
#' The function creates heatmaps (for each replicate and target) that show:
#' \itemize{
#' \item{magnitude of biases in single site attributes}
#' \item{magnitude of biases in catchment total attributes}
#' \item{biases in spatial correlation}
#' }
#' @param reference list; contains reference daily climate data, with elements named \emph{year}, \emph{month}, \emph{day}, \emph{*variable_name1*}, \emph{*variable_name2*}. List format is suitable for both single and multi-site data. 
#'            Climate variables are specified as matrices, with columns for each site. \cr   
#'            Please refer to data provided with the package that may be loaded using \code{data(barossaDat)} for examples of the expected format of multi-site \code{reference}.
#' @param sim a list; contains a multi-site stochastic simulation created using the function \code{generateScenarios}
#' @param attSel a vector; contains names of selected attributes to be evaluated 
#' @param targets a vector; contains set of targets in exposure space to be evaluated 
#' @param reps a vector; contains replicates of stochastic simulation to be evaluated 
#' @param stages a vector; contains names of approaches used to generate multi-site stochastic simulations ('Stage3' is recommended approach, while 'Stage1' and 'Stage2' show intermediate results)    
#' @return The function returns three R plots for each target and replicate showing the biases in single site attributes, catchment average attributes, and spatial correlations. 
#' @seealso \code{generateScenarios}
#' @examples
#' # load data from multi-site simulation
#' data(egMultiSiteSim)
#' # plot performance of simulated time series in terms of single site 
#' # and catchment attributes, and correlation between sites
#' \dontrun{
#' plotMultiSiteScenarios(reference=barossa_obs,sim=egMultiSiteSim)
#' }
#' @export
plotMultiSiteScenarios = function(reference,sim,attSel=NULL,targets=1,reps=1,stages=c('Stage1','Stage2','Stage3')){
  
  if(is.null(attSel)){
    attSel=c(sim$expSpace$attPerturb,sim$expSpace$attHold)
  }
  
  # calculate summary of performance of simulated time series
  multiSiteSummary = calcMultiSiteSummary(clim_ref=reference,sim=sim,attSel=attSel,targets=targets,reps=reps)
  
  col=grDevices::colorRampPalette(c("green","yellow", "red"))( 120 )
  
  diffSites = multiSiteSummary$diffSites
  diffTotal = multiSiteSummary$diffTotal
  diffCor = multiSiteSummary$diffCor
  
  targetNames = names(diffSites)
  repNames = names(diffSites[[1]])
  sites = colnames(diffSites[[1]][[1]][[1]])

  # plot biases in single site attributes
  for (target in targetNames){
    for (rep in repNames){
      for (scen in stages){
        print(lattice::levelplot(t(abs(diffSites[[target]][[rep]][[scen]])),xlab='',ylab='',col.regions=col,
                                 scales=list(x=list(at=seq(1,length(sites)),labels=sites),
                                             y=list(at=seq(1,length(attSel)),labels=attSel)),
                                 at=c(seq(0,30,length.out=100),Inf),panel=myPanel,
                                 main=paste0(scen,', ',target,', ',rep,': Bias in site attributes relative to target (%)')))
      }
    } 
  }
  
  # plot biases in catchment average attributes
  for (target in targetNames){
    for (rep in repNames){
      print(lattice::levelplot(t(abs(diffTotal[[target]][[rep]])),xlab='',ylab='',col.regions=col,
                               scales=list(x=list(at=seq(1,length(sites)),labels=stages),
                                           y=list(at=seq(1,length(attSel)),labels=attSel)),
                               at=c(seq(0,30,length.out=100),Inf),panel=myPanel,
                               main=paste0(scen,', ',target,', ',rep,': Bias in total attributes relative to target (%)')))
    }
  }
  
  # plot biases in correlation  
  for (target in targetNames){
    for (rep in repNames){
      for (scen in stages){
        print(lattice::levelplot(diffCor[[target]][[rep]][[scen]][,length(sites):1],xlab='',ylab='',
                                 at=seq(-1,1,length.out=100),panel=myPanel,
                                 scales=list(x=list(rot=90)),
                                 main=paste0(scen,', ',target,', ',rep,': Bias in spatial correlation')))
      }
    }
  }
  
}

###############################

calcMultiSiteSummary = function(clim_ref,sim,attSel,targets=1,reps=1,stages=c('Stage1','Stage2','Stage3')){
  
  diffSites = diffTotal = diffCor = list()
  
  for (target in targets){
    targetName = paste0('Target',target)
    diffSites[[targetName]] = diffTotal[[targetName]] = diffCor[[targetName]] = list()
    for (rep in reps){
      repName = paste0('Rep',rep)
      diffTotal[[targetName]][[repName]] = c()
      diffSites[[targetName]][[repName]] = diffCor[[targetName]][[repName]] = list()
      for (scen in stages){
        # calculate biases in single site and catchment average attributes
        diff = calc_diff(clim_ref=clim_ref,sim=sim,scen=scen,label=scen,attSel=attSel,target=target)
        diffSites[[targetName]][[repName]][[scen]] = diff$sites
        diffTotal[[targetName]][[repName]] = cbind(diffTotal[[targetName]][[repName]],diff$total)
        # calculate biases in correlation
        diffCor[[targetName]][[repName]][[scen]] = calc_cor(clim_ref=clim_ref,sim=sim,scen=scen,target=target)$cor_diff
      }
    }
  }
  
  multiSiteSummary = list(diffSites=diffSites,diffTotal=diffTotal,diffCor=diffCor)
  
  return(multiSiteSummary)
  
}

###############################
# calculate differences between simulated and observed attributes, based on single site and catchment average time series

calc_diff = function(clim_ref,sim,scen,label,attSel,target=1,rep=1){
  
  targetFac = as.vector(as.matrix(sim$expSpace$targetMat)[target,])
  
  sites = colnames(clim_ref$P)
  
  diff = list()
  diff$sites = matrix(nrow=length(attSel),ncol=length(sites))
  colnames(diff$sites) = sites
  rownames(diff$sites) = attSel
  for (s in 1:length(sites)){
    site = sites[s]
    clim_ref_site = clim_ref
    if (is.matrix(clim_ref$P)){
      clim_ref_site$P = clim_ref$P[,site]
    } else {
      clim_ref_site$P = clim_ref$P
    }
    obsAtts <- calculateAttributes(clim_ref_site, attSel)
    targetAtts = obsAtts*targetFac
    
    P <- sim[[paste0("Rep",rep)]][[paste0("Target",target)]][[scen]][["P"]][["sim"]][,s]
    simData <- sim[["simDates"]]
    simData[['P']]=P
    simAtts <- calculateAttributes(simData, attSel)
    
    percDiff <- (simAtts - targetAtts)/targetAtts*100
    percDiff
    diff$sites[,s] = percDiff
  }
  
  diff$total = matrix(nrow=length(attSel),ncol=2)
  
  clim_ref_mean = clim_ref
  clim_ref_mean$P = apply(clim_ref$P,1,mean)
  obsAtts <- calculateAttributes(clim_ref_mean, attSel)
  targetAtts = obsAtts*targetFac
  
  P <- apply(sim[[paste0("Rep",rep)]][[paste0("Target",target)]][[scen]][["P"]][["sim"]],1,mean)
  simData <- sim[["simDates"]]
  simData[['P']]=P
  simAtts <- calculateAttributes(simData, attSel)
  percDiff <- (simAtts - targetAtts)/targetAtts*100
  diff$total = percDiff
  
  return(diff)
}

###############################
# calculate correlation between sites

calc_cor = function(clim_ref,sim,scen,target=1,rep=1){
  
  cor_obs = stats::cor(clim_ref$P)
  cor_sim = stats::cor(sim[[paste0('Rep',rep)]][[paste0('Target',target)]][[scen]]$P$sim)
  cor_diff = cor_obs-cor_sim
  
  return(list(cor_obs=cor_obs,cor_sim=cor_sim,cor_diff=cor_diff))
  
}

#############################

myPanel <- function(x,y,z, ...){
  lattice::panel.levelplot(x,y,z,...) 
  lattice::panel.text(x,y, sprintf("%.2f", z))
}

#############################

