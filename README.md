# Hubmaster

Hubmaster is a rubygem that allows GitHub API interaction in Terminal. The current version only permits repository interactions, but feel free to fork and contribute!

## Table of Contents

* [Installation](#install)
* [Overview](#overview)
* [Repository Documentation](#repos)
    * [List](#reposList)

<a name="install"/>
## Installation

To use as a library, add this line to your application's Gemfile:
  
    gem 'hubmaster'

And then execute:
  
    bundle install

To use as a command line tool, run:

    sudo gem install hubmaster

<a name="overview"/>
## Overview

Hubmaster is a library written in ruby that makes interfacing with github a snap! In adition to being a library, hubmaster also includes an executable 
command line tool that allows github web operations to be carried out in terminal. The rest of the document details how hubmaster should be used, but there are a few things to note beforehand.

1. The general form for executing commands is `hub repos --modifier [params]`. All parameters that include spaces must be encased in quotes.

2. **BEWARE:** For the purposes of this document, when words are surrounded by brackets, the indicated value should be placed there **without brackets**.

***

To list all repositories under your account:

    hub repos --list

***

To list all repositories under someone elses account:

    hub repos --list [username]

***

To create a new repository:

    hub repos --create [name] "[description]"
  *Additionaly this command can be run with no parameters and you will be prompted for them later.*

***

To delete an existing repository:

    hub repos --delete [name]
  *Andy you will be asked to confirm by typing the name of the repository specified.*

***

To edit an existing repository:

    hub repos --edit [name] -option [option dependent variable]

  *The edit command takes several parameters and can be kind of confusing. First you specify
  the name of the repository you would like to edit, followed by the part you would like to edit.
  Currently all that can be edited is the the description, so the '-option' would look like '-description'.
  Finally, you can either specify the change now or be prompted for it later.*

**REMEMBER: IF ANY PARAMETERS INCLUDE SPACES, THEY MUST BE ENCASED IN QUOTES**
