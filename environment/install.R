# Restore exact installed versions captured from the manuscript host.
# Run from the repository root. Optional first argument selects the library.
args <- commandArgs(trailingOnly = TRUE)
lib <- if (length(args)) args[1] else "environment/library"
dir.create(lib, recursive = TRUE, showWarnings = FALSE)
.libPaths(c(normalizePath(lib), .libPaths()))
if (as.character(getRversion()) != "4.5.1") stop("This environment requires R 4.5.1")
lock <- read.delim("environment/r-runtime-lock.tsv", check.names = FALSE,
                   stringsAsFactors = FALSE, na.strings = character())
options(timeout = 1800)
dir.create("environment/cache", recursive = TRUE, showWarnings = FALSE)
complete <- character()
active <- character()
restore <- function(name) {
  if (name %in% complete || name == "R") return(invisible(NULL))
  if (name %in% active) stop("Dependency cycle: ", name)
  row <- lock[lock$Package == name, , drop = FALSE]
  if (nrow(row) != 1) stop("Dependency missing from lock: ", name)
  current <- tryCatch(packageDescription(name)$Version, error=function(e) "")
  if (row$Priority == "base") {
    if (current != row$Version) stop("Base package version mismatch: ", name)
    complete <<- c(complete, name)
    return(invisible(NULL))
  }
  active <<- c(active, name)
  deptext <- paste(row$Depends, row$Imports, row$LinkingTo, sep=",")
  deps <- trimws(gsub("\\s*\\([^)]*\\)", "", unlist(strsplit(deptext, ","))))
  for (dep in unique(deps[nzchar(deps)])) restore(dep)
  if (current != row$Version) {
    dest <- file.path("environment/cache", paste0(name, "_", row$Version, ".tar.gz"))
    downloaded <- FALSE
    for (url in strsplit(row$source_urls, ";", fixed=TRUE)[[1]]) {
      status <- tryCatch(suppressWarnings(download.file(url, dest, mode="wb", quiet=FALSE)),
                         error=function(e) 1)
      if (identical(status, 0L)) { downloaded <- TRUE; break }
    }
    if (!downloaded) stop("Exact source unavailable: ", name, " ", row$Version)
    install.packages(dest, repos=NULL, type="source", lib=lib)
    if (packageDescription(name, lib.loc=lib)$Version != row$Version)
      stop("Installed version mismatch: ", name)
  }
  active <<- setdiff(active, name)
  complete <<- c(complete, name)
}
for (name in lock$Package) restore(name)
cat("Verified", length(complete), "locked R packages.\n")
