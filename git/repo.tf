data "gitlab_projects" "group_projects" {
  owned             = true
  include_subgroups = false
  archived          = false
  visibility        = "public"
}

locals {
  mirror_excludes = [
    "Lens0021", # Because they link each other
  ]

  mirrors = {
    for project
    in data.gitlab_projects.group_projects.projects
    : project["name"] => project
    if !contains(local.mirror_excludes, project["name"])
  }
}

# Possible in opentofu 1.7 https://github.com/opentofu/opentofu/issues/1033
# import {
#   for_each = local.mirrors
#   id       = replace(each.value.name, " ", "_")
#   to       = github_repository.gitlab_mirrors[each.key]
# }
resource "github_repository" "gitlab_mirrors" {
  for_each = local.mirrors

  name            = replace(each.value.name, " ", "_")
  description     = "Mirror"
  homepage_url    = each.value.web_url
  has_issues      = false
  has_discussions = false
  has_projects    = false
  has_wiki        = false
  has_downloads   = false
}

resource "gitlab_project_mirror" "github_mirrors" {
  for_each = local.mirrors

  project             = each.value.id
  url                 = "https://lens0021:${var.github_token_mirror}@github.com/lens0021/${replace(each.value.name, " ", "_")}.git"
  keep_divergent_refs = false
}
