## Land Registry Development Environment

This repository contains the setup scripts for developers to quickly get up and running with the Land Registry codebase. By bootstrapping their developer environment from these scripts developers will be able to get all of the code repositories, run the unit tests and start the various applications that make up the land registry systems.


## Prerequisites

In order to run the development environment locally you will need 

* VirtualBox 4.3.14 or above (https://www.virtualbox.org/wiki/Downloads)
* Vagrant (http://www.vagrantup.com/downloads.html)
* git must be installed locally

## Creating the environment

From the directory containing this repository run

```
vagrant up
```

This will create the virtual machine. Next, log into the virtual machine using the command:

```
vagrant ssh
```

This will log into the machine and check out all of the applications in the */vagrant/apps* directory

## Running all of the unit tests

To run all of the unit tests configured in the applications simply log into the VM and run 

```
lr-run-all-unit-tests
```

## Starting up all of the applications

To start up all of the applications run

```
lr-start-all
```

## If your environment becomes corrupted

To clean out the environment and python virtual environments for all applications you can run

```
lr-clean
```

To clean out the whole environment and begin again from scratch you can run the following commands from the host machine, not inside the VM.

```
vagrant halt
vagrant destroy
vagrant up
```

