# Ruby-Dev Box Builder

## Copyright and Licensing

### Copyright Notice

The copyright for the software, documentation, and associated files are
held by the author.

> Copyright 2012 Todd A. Jacobs  
> All rights reserved.

The AUTHORS file is also included in the source tree.

### Software License

![GPLv3 Logo](http://www.gnu.org/graphics/gplv3-88x31.png)

The software is licensed under the
[GPLv3](http://www.gnu.org/copyleft/gpl.html). The LICENSE is also
included in the source tree.

### README License

![Creative Commons BY-NC-SA
Logo](http://i.creativecommons.org/l/by-nc-sa/3.0/us/88x31.png)

This README is licensed under the [Creative Commons
Attribution-NonCommercial-ShareAlike 3.0 United States
License](http://creativecommons.org/licenses/by-nc-sa/3.0/us/).

## Purpose

The goal of this project is to automate builds of a fully-functional
[Ruby on Rails][5] development environment for managing multiple clients
and projects simultaneously. This is a very opinionated piece of
software, and has the following design objectives:

- The build should be as automated as possible.
- The build should limit user interaction as much as possible. It should
  "just work."
- A full build-and-provisioning cycle should take less than 30 minutes
  on a modest Internet connection with commodity hardware.
- The Vagrant base box should be light and fast. It currently weighs in
  at only 278 MB.
- The full development environment should be fast and light. The virtual
  drive is currently using ~4.7 GB when fully provisioned, with ~5 GB of
  free space available for source code, binary assets, or additional
  software packages.
- The development tools should always favor simplicity and power.

## Contributions Welcome

This is an open-source project. Contributors are highly encouraged to
add any *optional* Puppet modules, provisioning scripts, or tool-chains
that appeal to a wide audience, but which are  not required to build the
box or run a basic Rails environment.

This project particularly welcomes:

1. Improvements to the existing Puppet modules and provisioning logic.
2. Addition of *optional* Puppet modules that do not impact the base
   build.
3. Addition of user-selectable provisioning scripts.
4. Ruby or Rails tool-chains that fit the design philosophy of the
   project.
5. Speed or size optimizations for the basic build and provisioning
   process.
6. RSpec and Cucumber tests for anything and everything. QA is
   important!
7. Contributions to the wiki. Information is power!

## Standing on the Shoulders of Giants

This is a small project that leverages the excellent work of some other
projects, including [Vagrant][1], [veewee][2], [VirtualBox][3], and
[RVM][4]. The author is grateful to everyone who has made contributions
to those projects, as well as to all the countless other projects that
*those* projects rely upon in turn.

Thank you all.

## Supported Software Versions

The software was tested against Ruby 1.9.3-p194 and Bash 4.2.10. See the
project's *Gemfile.lock* for gem version information.

## Getting Started with Ruby-Dev

    # Download and install VirtualBox for your platform. See
    # https://www.virtualbox.org/wiki/Downloads for details.

    # Clone the project. The clone's directory name will be the name of
    # your Vagrant instance. By default, this will be "ruby-dev" unless
    # you pass a destination directory to git-clone.
    git clone https://github.com/CodeGnome/ruby-dev.git railsbox

    # Change to your new clone.
    cd railsbox

    # Run the (mostly) automated installer.
    bin/runme.sh

    # In some rare cases, you may need to shut down the virtual box and
    # manually run `bundle exec vagrant up` to fully complete the Puppet
    # provisioning.
    bundle exec vagrant halt && bundle exec vagrant up

    # Open a terminal in your new virtual machine and run the
    # provisioning scripts if you need the additional features.
    install_vim_plugins.sh
    install_rvm.sh
    install_mikogo.sh

    # Create a project launcher.
    make_launcher.sh

    # Launch your project environment with the new launcher you just
    # made. For example, if you used the default values:
    launch-sample_project

## Caveats

- Many, many rubies and gems fail to compile properly with Apple's new
  LLVM compilers. In particular, OS X 10.8 (Mountain Lion) brings no joy
  at the moment. Patches, contributions, and wiki entries are most
  welcome.
- RVM and rbenv are unpleasant to provision through Puppet, especially
  when attempting to provision them solely for the *vagrant* user rather
  than as system-wide tools. This makes the post-Puppet provisioning
  scripts necessary, and is a pain point that might go away if enough
  talented people look at the problem.

----
[Project Home Page](https://github.com/CodeGnome/ruby-dev)

[1]: http://vagrantup.com/
[2]: https://github.com/jedi4ever/veewee/
[3]: https://www.virtualbox.org/
[4]: https://rvm.io/
[5]: http://rubyonrails.org/
