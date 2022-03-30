#.....repo/main.tf.........
/* data "github_organization" "communication" {
  name = var.org_name
} */
data "github_user" "admin_user" {
  username = "muykol"
}

#data "github_repository" "repo" {
 # name = var.repository_name
#}

resource "github_repository" "repo" {
    name = join("-", [var.repo_prefix, var.repository_name])
    description = "${var.description}"
    visibility = "${var.visibility}"
    #has_projects = "${var.has_projects}"
    allow_squash_merge = "${var.allow_squash_merge}"
    auto_init = "${var.auto_init}"
    archive_on_destroy = "${var.archive_on_destroy}"
    vulnerability_alerts = "${var.vulnerability_alerts}" 
}

resource "github_branch_protection_v3" "main" {
  repository     = github_repository.repo.name
  branch         = var.branch_pattern
  enforce_admins = var.enforce_admins
  require_conversation_resolution = var.require_comment_resolution

  required_pull_request_reviews {
    dismiss_stale_reviews = var.dismiss_stale_reviews
    #TODO
    #dismissal_users       = ["foo-user"] to do later upon agreement who is the user to have this power
    #dismissal_teams       = [github_team.example.slug]
    #minimum required approve count (2) default value variable will be 1
  }
  restrictions {
    users = var.push_main_users
  }
}


resource "github_membership" "org_members" {
  username = var.org_members
  role     = var.org_member_role
}
/*
 resource "github_repository_project" "project" {
  name       = var.project_name
  repository = "${github_repository.main.name}"
}resource "github_branch_protection" "main" {
  #repository_id = data.github_repository.repo.name
  repository_id = github_repository.repo.node_id
 
  pattern          = var.branch_pattern
  enforce_admins   = var.enforce_admins
  allows_deletions = var.allows_deletions

  required_pull_request_reviews {
    dismiss_stale_reviews  = var.dismiss_stale_reviews
    restrict_dismissals    = var.restrict_dismissals
    #dismissal_restrictions = [data.github_user.admin_user.name,]
  }

  push_restrictions = [
    data.github_user.admin_user.name,
    # limited to a list of one type of restriction (user, team, app)
    # github_team.dev.name
  ]

}
/*resource "github_branch" "main" {
  repository = github_repository.repo.name
  branch     = var.branch_name
}
resource "github_branch_default" "main"{
  repository = github_repository.repo.name
  branch     = github_branch.main.branch
}*/






