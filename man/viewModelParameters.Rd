% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/default_parameters.R
\name{viewModelParameters}
\alias{viewModelParameters}
\title{Prints the names and bounds of the parameters of the stochastic models}
\usage{
viewModelParameters(variable, modelType, modelParameterVariation)
}
\arguments{
\item{variable}{A string; the name of the variable. Type \code{viewModels()} to view valid variable names}

\item{modelType}{A string; the model type. Use \code{viewModels} to view the valid values.}

\item{modelParameterVariation}{A string; the parameter variation. Use \code{viewModels} to view the valid values.}
}
\description{
\code{viewModelParameters} prints the names of the parameters of the stochastic model and its default minimum and maximum bounds.
The stochastic model is specified using the function arguments.
}
\details{
The available stochastic models can be viewed using the function \code{viewModels()}.
This function prints the default ranges of the parameters of the stochastic model specified the
stochastic model of interest.
}
\examples{
viewModelParameters("P", "wgen", "annual")
viewModelParameters("P", "wgen", "harmonic")
}
\seealso{
\code{viewModels}, \code{writeControlFile}
}
