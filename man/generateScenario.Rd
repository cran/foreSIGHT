% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/control.R
\name{generateScenario}
\alias{generateScenario}
\title{Produces time series of hydroclimatic variables for an exposure target.}
\usage{
generateScenario(
  reference,
  expTarg,
  simLengthNyrs = NULL,
  seedID = NULL,
  controlFile = NULL
)
}
\arguments{
\item{reference}{data.frame; contains reference daily climate data in a data frame with columns named \emph{year} \emph{month} \emph{day} \emph{*variable_name1*} \emph{*variable_name2*}. 
Use \code{viewModels()} to view the valid variable names. Note that the first three columns of the data.frame contain the year, month, and day of the reference. The columns have to be named as specified.
Please refer data provided with the package that may be loaded using \code{data(tankDat)} for an example of the expected format of \code{reference}.}

\item{expTarg}{a named vector; the attributes at the target location in the exposure space
\code{generateScenario} is intended to be used to adapt the functionality of \code{generateScenarios} for use in a parallel computing environment.}

\item{simLengthNyrs}{a number; a scalar that specifies the length in years of each generated scenario. This argument is used only with stochastic generation.
If \code{NULL} (the default), the generated simulation will be as long as \code{reference}.}

\item{seedID}{a number; a scalar that specifies the seed to be used for the first replicate. Subsequent replicates will use seeds incremented by one. 
If \code{seedID} is \code{NULL} (which is the default), the function will use a random seed for stochastic time series generation. 
The seed used will be specified in the output. This argument is intended for use in cases that aim to reproduce an existing simulation.}

\item{controlFile}{a string; to specify the model/optimisation options used for simulating time series data. The valid values are:
\itemize{
\item {\code{NULL}} {: the simulation uses the foreSIGHT default stochastic model settings.}
\item {\code{"scaling"}} {: the simulation uses simple scaling instead of a stochastic model.}
\item {\code{path to a JSON file}} {: the JSON file contains advanced options specify the stochastic model and optimisation inputs. 
                  These options can be used to change stochastic model types, overwrite default model parameter bounds, change default optimisation arguments, and set penalty attributes to be used in optimisation. 
                  Please refer to the function \code{writeControlFile} in order to create an \code{controlFile} JSON file.
                  }
                  }}
}
\description{
\code{generateScenario} is the base function used by \code{generateScenarios}.
The function produces time series of hydroclimatic variables using requested climate attributes that correspond to a single target in the exposure space.
The function argument definitions are detailed in the documentation of \code{generateScenarios}; please refer to that documentation using \code{?generateScenarios}.
}
\seealso{
\code{generateScenarios}
}
