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
