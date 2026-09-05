if (dir.exists("environment/library")) .libPaths(c(normalizePath("environment/library"), .libPaths()))
stopifnot(as.character(getRversion()) == "4.5.1")
lock <- read.delim("environment/r-runtime-lock.tsv", stringsAsFactors=FALSE)
actual <- vapply(lock$Package, function(p) tryCatch(packageDescription(p)$Version,
                 error=function(e) "missing"), character(1))
bad <- actual != lock$Version
if (any(bad)) {
  print(data.frame(package=lock$Package[bad], expected=lock$Version[bad], actual=actual[bad]))
  stop("R environment differs from recorded versions")
}
cat("All", nrow(lock), "R package versions match.\n")
