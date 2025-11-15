# Factorio Server Management System (Linux)
## Description
This project aims to simplify the management of Factorio servers on a Linux machine.  
It allows you to administer multiple servers at once, whether they are using the latest version of the game or a custom version.  
The system offers various features:
- Update the server to the latest version or a custom version
- Launch a custom map or generate a new one
- List available servers
- Easily create or delete servers
- Start or stop a server via simple scripts

This manager aims to automate common tasks as much as possible.


## Upcoming features
- Creation of a web interface for servers (involves shell management for different servers, load balancing, ability to use the hypervisor API, etc.) Still a long way to go!
- Make it so when the system is installed, the .sh files be copied in /usr/local/bin (handle the os locations !!!)
- Be able to handle a different installation of factorio in the future ?
- Update all file in once. (Update and install.sh).
## Need to be modified
- The update script assumes that the user is root; take into account a regular user **update : no need -> cause executing it with sudo is sufficient** 
- Ensure that it is a specific user who can write to the log file; write permission for the log file is only granted to its owner to ensure it cannot be modified. In the future, the objective is to setup a Linux cron or whatever else that makes statistics, that will be available through an API, etc... (you see where i'm coming hehe?)
- Make an install.sh which puts scripts in the use/local/bin, tells the user what to do to install factorio, also sets environnement variables (location of log file,...)
