#!/bin/bash

if [[ ! -d .virtualenv ]]
	then
		echo "Creating python virtualenv"
		virtualenv .virtualenv
	fi