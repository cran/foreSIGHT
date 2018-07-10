\name{modCalibrator}
\alias{modCalibrator}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
modCalibrator
}
\description{
Calibrates weather generator models specified using modelTag.
}
\usage{
modCalibrator(obs = NULL,
              modelTag = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{obs}{A dataframe of observed climate data in the form \emph{Year Month Day P Temp}.}
  \item{modelTag}{A character vector of which stochastic models to use to create each climate variable. Supported tags are shown in \code{\link{modelTag}}}
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
data(tankDat)                               #Load tank data (tank_obs)
modelTag=c("P-ann-wgen","Temp-har26-wgen")  #Select a rainfall and a temperature generator
out<- modCalibrator(obs = tank_obs,         #Calibrate models
                    modelTag = modelTag)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{functions}% use one of  RShowDoc("KEYWORDS")
%\keyword{  }% __ONLY ONE__ keyword per line
