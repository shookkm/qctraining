#Java Template
## After-fork Checklist
* Update ./changelog.mustache
    * Title to project name (first line, not the variable)
    * Repository url to reflect project's repository url - this is likely only a word change
* Update ./gradle.properties
    * Name to reflect project
    * Version (this may not be necessary as the start is usually 0.0.0)
* Update System/Config/Log4j contents
    * Update projectName property in log4j2-properties.xml
    * Create a copy of default.log4j2.xml with the appropriate name per mgr/interface that needs specific logging
* Check if bitbucket-pipelines.yml has sufficient automations and checks
    * Only does build checks at the moment
    * Will later on include tests
* Enable BitBucket Pipeline for repository in BitBucket, if needed
* Check branch permissions
    * Enable all desired checks
    * Ensure that the premium features are all enabled
* Add default reviewers - this is usually the dev lead and senior devs
* Enable JIRA Ticket check under Settings -> Links
* Lock master branch
    * Only allow select people to directly change master
    * (Temporary) Ensure Phillipe Briones is one of the users that can write directly to master as the credentials for automation are under his account

