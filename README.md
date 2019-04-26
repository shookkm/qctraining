#Java Template
## After-fork Checklist
* Update ./changelog.mustache
    * Title to project name
    * Repository url to reflect project's repository url - this is likely only a word change
* Update ./gradle.properties
    * Name to reflect project
    * Version
* Check if bitbucket-pipelines.yml has sufficient automations and checks
* Enable BitBucket Pipeline for repository in BitBucket, if needed
* Check branch permissions
* Add default reviewers
* Lock master branch so no one can push anymore but select persons

