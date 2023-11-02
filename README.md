# hmpps-tools-installer
Simple BASH script to install homebrew and a few selected packages for developers within HMPPS. 

### Running the script
#### One-liner

To run the script, use the simple following one-liner in your terminal:

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ministryofjustice/hmpps-tools-installer/main/setup.sh)"`

#### Classic
- Git clone this repository - `git clone https://github.com/ministryofjustice/hmpps-tools-installer.git`
- Enter repository - `cd hmpps-tools-installer`
- Make script executable - `chmod +x setup.sh`
- Run the script - `./setup.sh`
 
As the script runs it will prompt several times for your admin password to proceed with installs. 
The admin password is the one you use to login to the MacBook, not your Apple ID password.
 
### Installed software:
You can select between installing just recommended packages, optional packages, or all packages. 
This list is compiled from our [onboarding confluence for developers](https://dsdmoj.atlassian.net/wiki/spaces/NDSS/pages/1476755613/Recommended+software).
Note: homebrew is installed eith either option.


#### Recommended packages:
- homebrew
- node@180
- java
- git
- jq
- helm
- kubernetes-cli
- docker-compose
- docker
- adoptopenjdk
- intellij-idea
- slack
- postman

#### Optional packages:
- homebrew
- aws-elasticbeanstalk
- make
- awscli
- terraform
