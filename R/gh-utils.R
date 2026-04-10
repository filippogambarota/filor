gh_remote_to_pages <- function() {
  stopifnot(is_git_repo())
  username <- gh_get_username()
  repo <- gh_get_repo()
  sprintf("https://%s.github.io/%s", username, repo)
}

gh_get_remote <- function() {
  stopifnot(is_git_repo())
  system("git config --get remote.origin.url", intern = TRUE)
}

is_git_repo <- function() {
  out <- system("git rev-parse --is-inside-work-tree", intern = TRUE)
  out == "true"
}

gh_get_username <- function() {
  stopifnot(is_git_repo())
  sub(".*:([^/]+)/.*", "\\1", gh_get_remote())
}

gh_get_repo <- function() {
  stopifnot(is_git_repo())
  repo <- gh_get_remote()
  basename(xfun::sans_ext(repo))
}

gh_link <- function(file) {
  stopifnot(
    file.exists(file),
    is_git_repo()
  )
  sprintf("%s/%s", gh_remote_to_pages(), file)
}
