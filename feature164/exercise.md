# Exercise

Develop the Terraform configuration files

```sh
main.tf
variables.tf
```

These files will be applied according to the following procedure

```sh
terraform init
terraform plan
terraform apply -auto-approve
```

They are intended to change the state of the Docker containers
'salt', 'node1.local', 'node2.local', and
'node3.local' to fulfill the tasks described below (cp. 'Task').

Each of those Docker containers uses a minimal Ubuntu 22.04 as base image
and runs a ssh server as main process, which allows for password-based login
for user 'root' with password 'ubuntu'. In
addition to `openssh-server`, the packages `curl` and `sudo` are pre-installed,
the locale is set to 'en-US', and the timezone is set to 'Europe/Berlin'.
The container 'salt' exposes ports 4505 and 4506.

(Git) stage, commit, and push your changes to feature branch
'feature164'. Check, if the green check-mark appears in the Gitea Web
application at feature branch 'feature164'. If it appears, submit a pull
request via the Gitea Web application. If not, check your code. It did not pass
the tests.

  
#### Timetable - success points and due dates

Finish the exercise *before* the below given due date. If the exercise is
successfully finished and checked, you will be rewarded with the respective
amount of success points.

|Exercise    |points (obtainable)                   |due date (finish before)|
|:--------:  |:--------:                            |:--------:              |
|164|8|11.01.2024|


#### Hints

- The Terraform version will be the lastest one available as a Docker image.
  - Consider using the Null provider
- For Terraform cp.
  - https://registry.terraform.io
  - https://developer.hashicorp.com/terraform/language
- Use Salt version 3005.
- For Salt cp.
  - https://docs.saltproject.io/en/latest/
- Read the docs!

#### Task

Setup 'salt' as Salt master. Setup 'node1.local',
'node2.local' and 'node3.local' as Salt minions that are
connected to 'salt'. Set the log file log level of the Salt master
to 'critical'.

- Setup 'lsxvax' as Salt ID for 'node1.local' and set the
  log file log level of the corresponding log file to 'critical'.

- Setup 'gcevyt' as Salt ID for 'node2.local' and set the
  log file log level of the corresponding log file to 'error'.

- Setup 'foawji' as Salt ID for 'node3.local' and set the
  log file log level of the corresponding log file to 'warning'.