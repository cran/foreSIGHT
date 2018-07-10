\name{modSimulator}
\alias{modSimulator}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
modSimulator
}
\description{
Simulates using weather generator models specified using modelTag.
}
\usage{
modSimulator(datStart=NULL,
             datFinish=NULL,
             modelTag=NULL,      
             parS=NULL,
             seed=NULL,
             file=NULL,
             IOmode="suppress"
             )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{datStart}{A date string in an accepted date format e.g. \emph{"01-10-1990"}.}
  \item{datFinish}{A date string in an accepted date format e.g. \emph{"01-10-1990"}. Must occur after datStart.}
  \item{modelTag}{A character vector of which stochastic models to use to create each climate variable. Supported tags are shown in \code{\link{modelTag}}}
  \item{parS}{A list (names must match supplied modelTags) containing numeric vectors of model parameters.} 
  \item{seed}{Numeric. Seed value supplied to weather generator.}
  \item{file}{Character. Specifies filename for simulation output.}
  \item{IOmode}{A string that specifies the input-output mode for the time series = "verbose", "dev" or "suppress".} 
}
%\details{
%%  ~~ If necessary, more details than the description above ~~
%}
%\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
%}
%\references{
%% ~put references to the literature/web site here ~
%}
%\author{
%%  ~~who you are~~
%}
%\note{
%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
\dontrun{
data(tankDat); obs=tank_obs                     #Get observed data
modelTag=c("P-har12-wgen","Temp-har26-wgen")    #Select models
pars=modCalibrator(obs=obs,modelTag=modelTag)   #Calibrate models
sim=modSimulator(datStart="1970-01-01",         #Simulate!
                 datFinish="1999-12-31",
                 modelTag=modelTag,
                 parS=pars,
                 seed=123,
                 file=paste0("tester.csv"),
                 IOmode="verbose")
plot(sim$P[1:365])                             #Plot first year of rainfall
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{functions}% use one of  RShowDoc("KEYWORDS")
%\keyword{  }% __ONLY ONE__ keyword per line
