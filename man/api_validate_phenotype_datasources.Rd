% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api_validation.R
\name{api_validate_phenotype_datasources}
\alias{api_validate_phenotype_datasources}
\title{api_validate_phenotype_datasources}
\usage{
api_validate_phenotype_datasources(data, api_client, is.valid)
}
\arguments{
\item{data}{Phenotype and concept data read from yaml file}

\item{api_client}{The HttpClient returned by the \code{\link{connect_to_API}} function.}

\item{is.valid}{Bool, used to pass on whether previous checks were invalid or not}
}
\value{
TRUE if valid, FALSE otherwise
}
\description{
Validates datasources stored in the phenotype's data
}
