# Exercise

Develop the Salt scripts

```sh
init_nginx.sls
init_tomcat1.sls
init_tomcat2.sls
```

The scripts will be treated as state init scripts and
will be invoked by user 'root' using the following procedure

```sh
cd feature166
salt node2.local state.apply tomcat1
salt node3.local state.apply tomcat2
salt node1.local state.apply nginx
```

The scripts should fulfill the tasks described below (cp. 'Task').

(Git) stage, commit, and push your changes (the Salt script file) to feature
branch 'feature166'. Check, if the green check-mark appears in the
Gitea Web application at feature branch 'feature166'. If it appears,
submit a pull request via the Gitea Web application. If not, check your code.
It did not pass the tests.

  
#### Timetable - success points and due dates

Finish the exercise *before* the below given due date. If the exercise is
successfully finished and checked, you will be rewarded with the respective
amount of success points.

|Exercise    |points (obtainable)                   |due date (finish before)|
|:--------:  |:--------:                            |:--------:              |
|166|6|18.01.2024|


#### Hints

- The Salt version will be 3005.
- Config and data files that may eventually be needed will be copied from
  the feature branch folder `feature166/*` to the Salt master's root
  folder. To access them from within Salt scripts use `salt://` as path.
- For Salt cp.
  - https://docs.saltproject.io/en/latest/
- For information about Nginx's load balancer mode see
  - https://www.nginx.com/
- Information about Tomcat are available at
  - http://tomcat.apache.org/
- Read the docs!

#### Task

Develop the Salt scripts 'init_nginx.sls', 'init_tomcat1.sls' and
'init_tomcat2.sls'. They should set up nginx as a load balancer that routes
requests to two Tomcat nodes that act as Web servers.

Do **not** use the 'service.running' module of Salt. It is not supported
in the current execution setup.

The requests should be routed according to the following weights:

- Tomcat node one: 2
- Tomcat node two: 1

And nginx should use one worker process only.

The Salt scripts will run on 'salt', who act as Salt master. All
minion nodes are already connected to the Salt master, and public/private keys
are properly setup. The minion nodes run Ubuntu 22.04.

Install nginx on minion node 'node1.local' using 'init_nginx.sls'.

Install Tomcat **one** on minion node 'node2.local' using
'init_tomcat1.sls'. There, setup version 9.0.33 of Tomcat.
Install it underneath `/usr/local`. As we are using it as a Web server, set up
a valid HTML homepage for it that contains the string 'cpetapvnldgv'.

Install Tomcat **two** on minion node 'node3.local' using
'init_tomcat2.sls'. There, setup version 9.0.36 of Tomcat.
Install it underneath `/usr/local`. As we are using it as a Web server, set up
a valid HTML homepage for it that contains the string 'yzohpwsoorzw'.