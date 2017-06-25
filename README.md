# GCC-ARM [![Build Status](https://travis-ci.org/EpicEric/gcc-arm.svg?branch=master)](https://travis-ci.org/EpicEric/gcc-arm) [![Docker Stars](https://img.shields.io/docker/stars/epiceric/gcc-arm.svg)](https://hub.docker.com/r/epiceric/gcc-arm/) [![Docker Pulls](https://img.shields.io/docker/pulls/epiceric/gcc-arm.svg)](https://hub.docker.com/r/epiceric/gcc-arm/)

Docker container for "PCS3732 - Laboratory of Processors" course in Poli-USP with Ubuntu 16.04 image, able to run a 32-bit GCC version for the ARM architecture. Includes basic text editors and aliases.

# Usage

## Installation

There are two alternative origins:

* Pulling from Docker Hub:
	* `docker pull epiceric/gcc-arm`

* Building from GitHub source: 
	* `git clone https://github.com/EpicEric/gcc-arm.git ; cd gcc-arm ; docker build -t epiceric/gcc-arm docker`
	* Alternatively, you can clone the repo and run `./build_docker.sh` from this directory.


## Running

* Starting an interactive Bash shell:
	* `docker run -ti -v "$PWD/src":/home/student/src epiceric/gcc-arm`
	* Alternatively, you can run `./run_docker.sh` from this directory.
* You can place files in `src/` to mount them to the default directory (`/home/student/src/`).
	* Or you can specify a custom source directory location with `./run_docker.sh ~/path/to/custom_src` or `docker run -ti -v "$HOME/path/to/custom_src":/home/student/src epiceric/gcc-arm`.
* Quit with `Ctrl-D`.

## Commands

* Text editing:
	* `less`
	* `vim`
		* You can replace the installed text editor from `vim` to any `apt-get` package(s) of your choice by adding build args to `build_docker.sh` or `docker build`. Examples:
			* `emacs`: `./build_docker.sh emacs` or `docker build -t epiceric/gcc-arm --build-arg EDITORPKG=emacs docker`
			* `nano` and `vim`: `./build_docker.sh nano vim` or `docker build -t epiceric/gcc-arm --build-arg EDITORPKG="nano vim" docker`
* Compiling and debugging:
	* `arm main.c`: Compile from C program `main.c` to ARM-Assembly `main.s`.
		* Alias for `arm-elf-gcc -S main.c`.
	* `gcc -o main main.s`: Assemble an executable file `main` from `main.s`.
		* Alias for `arm-elf-gcc -Wall -g -o main main.s`.
	* `gdb main`: Run `main` on GDB in Text User Interface.
		* Alias for `arm-elf-gdb -tui --command=/home/student/.gdb main`. The `.gdb` file loads setup commands for GDB (`layout regs ; target sim ; load`).

To test the example file `item-2-2.s`, assemble with `gcc` and run the compiled program on `gdb` with the following commands:
* `b main` (`break main`): Set a breakpoint on the `main` label.
* `r` (`run`): Begin execution.
* `s` (`step`): Execute every command step-by-step.
* `q` (`quit`): Exit GDB before running the `SWI` instruction, to prevent it from freezing.

Please view the [GDB Manual](https://sourceware.org/gdb/onlinedocs/gdb/index.html) for more information. 

# Advanced

## Running on Windows

First, avoid running Docker on Windows. Second, avoid developing on Windows at all. If you cannot avoid it, proceed anyway.

Obviously, the shell scripts intended for Bash won't work. But instead, if you have the Docker Toolchain up and running, you can still build the container with the full command.

Running the container however is trickier. It has been reported to work with the extra `-e TERM` argument and Linux-based syntax for mounted directories (with `C:\` drive replaced with `/c/`). Here is an example:

```docker run -ti -v "/c/Users/yourname/path/to/custom_src":/home/student/src -e TERM epiceric/gcc-arm```

