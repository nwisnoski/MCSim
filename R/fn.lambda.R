#' fn.lambda
#' 
#' @title Calculate recruitment bias based on environmental filtering
#' 
#' @description Used by \link{fn.metaSIM}.  Uses niche breadth and an 
#' environmental gradient to determine how to bias species selection 
#' weights based on environmental filtering dynamics.  See Gravel et al. 2006.
#' 
#' @usage fn.lambda(trait.optimum, niche.breadth, Ef, Ef.specificity)
#' 
#' @param trait.optimum Optimum value for a given species along an environmental 
#' gradient.  Gradients in \link{fn.metaSIM} are restricted to the range [0,1], so 
#' this value must be in the range [0,1].
#' @param niche.breadth Niche breadth around a species' trait optimum.  The value of sigma 
#' in Fig 1 in Gravel et al. (2006).
#' @param Ef Value of the environmental filter at the site for which lambda is being 
#' calculated.
#' @param Ef.specificity The selection specificity of the environmental filter.
#' 
#' @references 
#' Gravel, D., C. D. Canham, M. Beaudet, and C. Messier. 2006. Reconciling niche and 
#' neutrality: the continuum hypothesis. Ecology Letters 9:399--409.
#' 
#' @export
#' 
fn.lambda <- function(
  trait.optimum,
  niche.breadth,
  Ef,
  Ef.specificity){
  if(Ef.specificity!=0){
    integrate(f=function(e,t,niche)exp(-1 * ((e -  t)^2) / (2 * niche^2) ),
              lower=Ef-(Ef.specificity/2),
              upper=Ef+(Ef.specificity/2),
              t=trait.optimum,
              niche=niche.breadth)$value
  }else{
    exp(-1 * ((Ef -  trait.optimum)^2) / (2 * niche.breadth^2) )
  }
}
