# Exercise

Develop an Ansible playbook

```sh
playbook
```

The playbook will be invoked by user 'root' using the
following procedure

```sh
cd feature162
ansible-playbook -i inventory playbook
```

The playbook should fulfill the task described below (cp. 'Task').

(Git) stage, commit, and push your changes (the playbook file) to feature
branch 'feature162'. Check, if the green check-mark appears in the
Gitea Web application at feature branch 'feature162'. If it appears,
submit a pull request via the Gitea Web application. If not, check your code.
It did not pass the tests.

  
#### Timetable - success points and due dates

Finish the exercise *before* the below given due date. If the exercise is
successfully finished and checked, you will be rewarded with the respective
amount of success points.

|Exercise    |points (obtainable)                   |due date (finish before)|
|:--------:  |:--------:                            |:--------:              |
|162|6|07.12.2023|


#### Hints

- The Ansible version will be the one that comes with Ubuntu 20.04.
- For Ansible cp.
  - https://www.ansible.com/
- For information about Nginx's load balancer mode see
  - https://www.nginx.com/
- Information about Apache2 are available at
  - https://httpd.apache.org/
- Information about Tomcat are available at
  - http://tomcat.apache.org/
- In case of Nginx doesn't restart with `service nginx restart`, consider
  using alternative methods as `/etc/init.d/nginx restart`, or
  `nginx -g 'daemon off;'` instead.
- Read the docs!

#### Task

Write an Ansible playbook 'playbook'. It should set up nginx as a
load balancer that routes requests to a Tomcat and an Apache 2 node
that act as Web servers.

The requests should be routed according to the following weights:

- Apache 2 node: 5
- Tomcat node: 1

And nginx should use one worker process only.

The playbook will run on 'master.local'. All nodes are already
declared in an Ansible inventory file 'inventory', and public/private keys
are properly setup. The nodes run Ubuntu 20.04. 

Install nginx on node 'node1.local'.

Install Apache 2 on node 'node2.local'. There, setup version
'2.4.41-4ubuntu3.14' of Apache 2. As we are using it as a Web server,
set up a valid HTML homepage for it that contains the string
'qrumnruowvkv'.

Install Tomcat  on node 'node3.local'. There, setup version
'9.0.37' of Tomcat. Install it underneath `/usr/local`.
As we are using it as a Web server, set up a valid HTML homepage for it
that contains the string 'qhrykxeislbu'.