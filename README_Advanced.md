## Land Registry development environment advanced concepts

### Layout of the development environment

The development environment will install itself in the */vagrant* directory of your virtual machine.
In this directory there are a few key sub-directories:

#### /vagrant/apps 
This directory is the workspace that developers can use to work on apps. All of the applications are checked out here in their own directory.

#### /vagrant/config

The config directory contains two files: the *apps* file describes which apps to check out in the development environment, and the *virtual-env-global-requirements.txt* is a pip requirements file containing global requirements required in all virutual environments to make the development environment work. Application dependencies should not be checked into this file.

#### /vagrant/logs

This directory contains the individual log files for each application, and the log files of the virtual environment setup used during unit testing.

#### /vagrant/script

This directory contains the core scripts for the development environment. Anything put in */vagrant/script/bin* will be on the path for the VM user.

### Adding new applications to the development environment.

In order to work on a new application in the development environment you can follow this simple process.

First, create a git repository for the application and push it to github. In your application you will need to create the following files:

#### If you want your application to be startable by scripts like *lr-run-app* 

You should add a *run.sh* in the root of the application. This does not need to be executable and must issue the startup command for the application. It should not set any environment variables, the mechanism for this is described below.

#### If your application needs environment specific configuration

Adding an *environment.sh* into the root of the application directory which declares the environment as shell variables is all you need to do.
*NOTE*: You do *NOT* need to set SETTINGS='config.DevelopmentConfig' here, many of the scripts currently do and this reduces our flexibility.

If you add an *environment_test.sh* into the root of the application directory you can add specific requirements for tests here. 

Note that the development environment will import *environment.sh* when starting the application, and will import *environment.sh* and then *environment_test.sh* when running test, so you don't need to duplicate properties in *environment_test.sh* if they don't need to change when testing. Also note, you do *not* need to add SETTINGS='config.TestConfig' here, the development system will do this for you.

#### If your application needs to create a database

Currently the best place for this is in the *environment.sh*. Do not do this in the *run.sh*.




### Starting multiple applications

The environment scripts support two ways of starting applications, either a *multi start* which starts a group of applications, or a *single start* which starts an individual application. All of these mechanisms are supported by the same start scripts.

It is possible to run multiple single starts at the same time, but only one multi start.

The workflow that is envisioned is that a number of background applications will be started as a multi-start, with the application that developers are working on started individually in another window. This allows developers to quickly stop / start the application they are working on without restarting all of the applications. 


All of the applicatications can be started with 

```
lr-start-all
```

A selection of applications can be started with 

```
lr-run-app [app-names]
```

For example, to run the system-of-record and casework frontend you can run

```
lr-run-app system-of-record casework-frontend
```

#### Starting individual applications

To start an individual application simply go into the application directory and run *lr-run-app*. So, for example, to start the casework-frontend do:

```
cd /vagrant/apps/casework-frontend
lr-run-app
```

### Running unit tests for individual applications

To run all of the *unit-tests* for an individual application you can run the following:

```
cd /vagrant/apps/[app-name]
lr-run-unit-tests
```

### Running acceptance tests

The acceptance tests are stored in /vagrant/apps/acceptance-tests, and they feature documentation at https://github.com/LandRegistry/acceptance-tests. Follow these instructions to run the acceptance tests locally.

