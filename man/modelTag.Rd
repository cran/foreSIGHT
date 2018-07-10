\name{modelTag}
\alias{modelTag}
\docType{data}
\title{
Model Tags
}
\description{
modelTag provides the main function with requested models.
}
\usage{modelTag}
\format{
  modelTag is vector of any of the following supported models:
  \describe{
    \item{\code{"Simple-ann"}}{a simple annual scaling}
    \item{\code{"P-ann-wgen"}}{a four parameter annual rainfall model}
    \item{\code{"P-seas-wgen"}}{a 16 parameter seasonal rainfall model}
    \item{\code{"P-har6-wgen"}}{a harmonic rainfall model with 6 periods}
    \item{\code{"P-har12-wgen"}}{a harmonic rainfall model}
    \item{\code{"P-har12-wgen-FS"}}{a harmonic rainfall model where seasonality is fixed (phase angles must be specified via modelInfoMod=list("P-har12-wgen-FS"=fixedPars=c(x,x,x,x))}
    \item{\code{"P-har26-wgen"}}{a harmonic rainfall model}
    \item{\code{"P-2har26-wgen"}}{a double harmonic rainfall model}
    \item{\code{"Temp-har26-wgen"}}{a harmonic temperature model not conditional on rainfall}
    \item{\code{"Temp-har26-wgen-wd"}}{a harmonic temperature model dependent on wet or dry day}
    \item{\code{"Temp-har26-wgen-wdsd"}}{a harmonic temperature model where standard deviation parameters are dependent on wet or dry day}
    \item{\code{"PET-har12-wgen"}}{a harmonic potential evapotranspiration model}
    \item{\code{"PET-har26-wgen"}}{a harmonic potential evapotranspiration model}
    \item{\code{"PET-har26-wgen-wd"}}{a harmonic potential evapotranspiration model dependent on wet or dry day}
    \item{\code{"Radn-har26-wgen"}}{a harmonic solar radiation model (MJ/m2)}
  }
}
%\details{
%%  ~~ If necessary, more details than the __description__ above ~~
%}
%\source{
%%  ~~ reference to a publication or URL from which the data were obtained ~~
%}
%\references{
%%  ~~ possibly secondary sources and usages ~~
%}
%\examples{
%data(modelTag)
%## maybe str(modelTag) ; plot(modelTag) ...
%}
\keyword{datasets}
