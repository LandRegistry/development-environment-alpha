Land Registry Development Environment
=================

### Overview

This repository contains the setup scripts for developers to quickly get up and running with the Land Registry codebase. By bootstrapping their developer environment from these scripts developers will be able to get all of the code repositories, run the unit tests and start the various applications that make up the land registry systems.

These scripts are very new and may contain a few rough edges. Please let the team know if you find anything and we'll work to fix it.

### Supported environments

Currently most of our developers are running MacOS 10.9, so this is the primary environment supported by these scripts. Linux is not currently supported, but can be made to work. See below.

These scripts currently require a little work to run on linux systems, and it's assumed that if you're developing on Linux you "Know What You Are Doing (tm)" and are able to configure your environment.

More information is provided for Linux users below.

Please note these scripts are still very new and will likely need a little modification as our development environment evolves.

### Prerequisites

You will need a Mac running Mac OS 10.9 or above with a user account with sudo access. (This does not need to be an administrator, you just need to add yourself into /etc/sudoers)

You will also need python version >= 2.7.5 and git version >= 1.8.0

For external tools such as elasticsearch you will need java >= 1.7

The various python libraries may require a C compiler to build, so you'll need the XCode command line tools, available from https://developer.apple.com/xcode/downloads/

### Bootstrapping

To obtain a development environment simply check out this repository and run

```
./bootstrap
```

This will check out all of the applications defined into the apps directory within this repository. (Note: This is ignored by git, so you can safely work there.)

### Starting all of the applications

In order to start all of the applications run

```
./start-all
```

from this repository. This will start all of the configured applications.

### Running all of the unit tests

To run all of the unit tests configured in the applications simply run 

```
./run-all-unit-tests.sh
```

### Working with individual applications

These scripts will check out all of the configured applications into the apps directory of this repository.

Along with this, into each application it will check out a "dev" directory containing useful scripts for developers.

An overview of this repository layout is described below:

<pre>
development-environment
+-- script (Root directory for all scripts and utilities. You shouldn't need to wory about these unless you are editng the deployment scripts)
|		dev (developer scripts that are copied into the dev directory of each application)
|       script
| 			+-- apps (Script defining which apps to checkout from the repository)
|           +-- configure (This script sets up the environment for each project and any global exports)
|   bootstrap (Script to create the development environment. This can be re-run as new repositories are added)
|   start-all (Script to start all configured applications with foreman)
</pre>

### Adding new repositories to the development environment

New repositories can be added by editing the file 

```
script/utils/apps
```

Simply add the repository name that you wish to add into this script and re-run bootstrap. The new repository will be checked out and the application added to the start script.

The format of this script is <pre>application-name:http-port</pre> and the startup scripts will configure Flask apps to run on this port for you.

#### Developer tools in individual applications

When a sub-project is added to the "scripts/utils/apps" file it will be checked out when the environment is bootstrapped, or start-all is called. As part of this process the environment will create a directory called "dev" in each application.

This "dev" directory currently contains the following executable scripts:

```
run-app			(Run the application in its own python virtual-env)
run-unit-tests  (Run the unit tests using py.test, described below in the unit-testing section)
clean           (Remove any .pyc files that are present in the application directory, useful for debugging)
```

So, to start a sub application simply execute the following, assuming you are in the development-environment directory

```
cd apps/<app-name>
dev/run-app
```

When executing run-app the script will look for a run.sh in your application directory and execute it, first creating & configuring a python virutal environment. It is probably a good idea to ensure that your run.sh script is NOT executable, as this will stop you running it by mistake. You must ALWAYS use run-app to start yoour application.

If you want to execute another script instead of run.sh you can do the following:

```
dev/run-app myscript
```

And to run the tests for an application simply execute the following

```
dev/run-unit-tests
```

### Requirement for layout of the application repositories
The expected layout for application repositories is defined in the (Flask Examples)[https://github.com/LandRegistry/flask-examples] repository.

### Configuring ports
All applications HTTP ports are managed in the /script/apps file. Look there for examples.

### Unit tests
The development environment automatically installs (py.test)[http://pytest.org/latest/]

This is a simple test framework that automatically discovers unit tests that are provided in a "tests" directory. 

Note:

  * The /tests directory must have an __init__.py file present in it. It can be empty. If this is not present your tests will not be found.
  * The test filenames must begin with test_
  * You can create subdirectories in this directory, provided that you create an __init__.py

### Technical overview

The bootstrap script first looks to see whether you have the required dependencies (that are not installed by default on a Mac with the developer tools present from Xcode command line tools). If these tools are not found it will automatically install them.

It will automatically install and startup a Postgres database.

It then finds all repositories that are listed in scripts/utils/apps. It will check out each repository into the /apps directory.

Then each repository in the apps directory is examined, if the script does not find a "dev" directory it will copy in the /script/dev directory from the root of the development environmnet. This provides the run-app and run-unit-tests script.

Each time these run-* scripts are executed they will use virutalenvwrapper to create a python virtual environment in ~/.land-registry-python-venvs for this application. This means that each application runs in its own virtual environment, with its own dependencies. 

The start-all script scans all of the applications for Procfiles and merges them into a Procfile in the root of the development environment and starts this.

### TODO
The scripts are still a little rough, and we'll try them out and evolve them over time. Extra features that may be required are:

* Ability to get a shell with the virtual environment settings (this may be simple with workon, I haven't tested it yet)

* Do we need a seperation for integration tests & unit tests?

* Ability to generate Docker files / upstart scripts from the Procfiles

* Application configuration: Currently the mint & system-of-record apps are not fully integrated.

* Linux support.

### Linux

These scripts won't work out of the box on linux, but should be fairly straightforward to enable.

In order to run on linux you will need the following pre-requisites

```
ruby-1.9.3 
rubygems (1.9.3)
git >= 1.8
easy_install
python 2.7.x
pip
virtualenv
virtualenvwrapper
postgress 9.3.4
```

My suggestion for getting Linux suport is to add 2 new scripts into the "/scripts" directory

```
resolve-dependencies-ubunut-12
resolve-dependencies-ubuntu-14
```

These scripts would then execute the apt-get required to configure linux, and the rest of the scripts could be executed unedited.

### Modifying the development scripts

If you want to modify these development scripts it's no worry. If you need to test them simply remove the apps directory and re-run the scripts. There is also a script/remove-app-dev-directories.sh which will remove the dev directory in checked out apps which can be useful.

The primary development environment is currently a Mac, so I'd ask that if you modify these scripts on a linux machine you don't check into master but provide a pull request so that a developer with a Mac can check that they still work on the Mac.








