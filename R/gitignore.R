#' Create a .gitignore file tailored that meets usual Sandpiper requirements
#'
#' This function generates a .gitignore file that is commonly used for sandpiper analytics projects.
#' It initially ignores all files but then selectively un-ignores specific file
#' types essential for R development, such as R scripts, R Markdown files,
#' R project files, and others. It also allows all subdirectories.
#'
#' @param filepath Character string specifying the path and name of the
#'   .gitignore file to be created. Defaults to ".gitignore" (in the current
#'   working directory).
#'
#' @return This function does not return any value. It creates a file in the
#'   file system as a side effect.
#'
#' @examples
#' # Create .gitignore in the current working directory
#' create_gitignore()
#'
#' # Create .gitignore in a specific directory
#' create_gitignore("path/to/your/project/.gitignore")
#'
#' @export
.create.gitignore <- function(filepath = "./.gitignore") {
  # Define the content of the .gitignore file
  gitignore_content <- c(
    "# Ignore everything",
    "*",
    "",
    "# Except gitignore",
    "!.gitignore",
    "",
    "# Except R files",
    "!*.R",
    "!*.md",
    "!*.Rmd",
    "!*.Rproj",
    "!*.Rprofile",
    "!*DESCRIPTION",
    "!*NAMESPACE",
    "!*.Rbuildignore",
    "!*renv.lock",
    "!*.txt",
    "!*.css",
    "",
    "# Even if they are in sub-directories",
    "!*/",
    ".Rproj.user"
  )

  # Write the content to the .gitignore file
  writeLines(gitignore_content, con = filepath)

  # Print a message indicating successful creation
  message(paste("Successfully created .gitignore file at:", filepath))
}

.init.project <- function(){

  usethis::use_description()
  .create.gitignore("./.gitignore")

}


#' Create a .renvignore to aid with dependency detection
#'
#' This function generates a .renvignore that makes sure dependencies not
#' already declared in DESCRIPTION can be detected.
#'
#' @param filepath Character string specifying the path and name of the
#'   .renvignore file to be created. Defaults to ".renvignore" (in the current
#'   working directory).
#'
#' @return This function does not return any value. It creates a file in the
#'   file system as a side effect.
#'
#' @examples
#' # Create .gitignore in the current working directory
#' .create.renvignore()
#'
#' # Create .gitignore in a specific directory
#' .create.renvignore("path/to/your/project/.gitignore")
#'
#' @export
.create.renvignore <- function(filepath = "./.renvignore"){
  renvignore_content <- c(
    "DESCRIPTION"
  )

  # Write the content to the .gitignore file
  writeLines(renvignore_content, con = filepath)

  # Print a message indicating successful creation
  message(paste("Successfully created .renvignore file at:", filepath))
}

.add.deps <- function(){

  if(file.exists("DESCRIPTION")){

    if(!file.exists(".renvignore")){
      cat(crayon::yellow("DESCRIPTION detected but no .renvignore. Adding .renvignore to ensure all packages are detected"))
      .create.renvignore()
    }

  }

  deps <- renv::dependencies() |>
    dplyr::filter(Package != "tidyverse") |>
    dplyr::distinct(Package) |>
    dplyr::pull(Package)

  sapply(deps, function(x) usethis::use_package(x))
}
