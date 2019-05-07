#Java Template
## After-fork Checklist
* Update ./changelog.mustache
    * Title to project name
    * Repository url to reflect project's repository url - this is likely only a word change
* Update ./gradle.properties
    * Name to reflect project
    * Version
* Check if bitbucket-pipelines.yml has sufficient automations and checks
    * Only does build checks at the moment
    * Will later on include tests
* Enable BitBucket Pipeline for repository in BitBucket, if needed
* Check branch permissions
    * Enable all desired checks
    * Ensure that the premium features are all enabled
* Add default reviewers - this is usually the dev lead and senior devs
* Lock master branch
    * Only allow select people to directly change master
    * (Temporary) Ensure Phillipe Briones is one of the users that can write directly to master as the credentials for automation are under his account

