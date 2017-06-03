[![Docker Stars](https://img.shields.io/docker/stars/epiceric/gcc-arm.svg)](https://hub.docker.com/r/epiceric/gcc-arm/)
[![Docker Pulls](https://img.shields.io/docker/pulls/epiceric/gcc-arm.svg)](https://hub.docker.com/r/epiceric/gcc-arm/)
[![Docker Automated build](https://img.shields.io/docker/automated/epiceric/gcc-arm.svg)](https://hub.docker.com/r/epiceric/gcc-arm/)

# GCC-ARM

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
* You can place files in `src/` to mount them in the default directory (`/home/student/src/`).
* Quit with `Ctrl-D`.

## Commands

* Text editing:
	* `less`
	* `vim`. You can replace the installed text editor from `vim` to any `apt-get` package(s) of your choice by adding build args to `build_docker.sh` or `docker build`. Examples:
		* `emacs`: `./build_docker.sh emacs` or `docker build -t epiceric/gcc-arm --build-arg EDITORPKG=emacs docker`
		* `nano` and `vim`: `./build_docker.sh nano vim` or `docker build -t epiceric/gcc-arm --build-arg EDITORPKG="nano vim" docker`
* Utils:
	* `git`
* Compiling and debugging:
	* `arm main.c` to compile from C program `main.c` to ARM-Assembly `main.s`.
		* Alias for `arm-elf-gcc -S main.c`.
	* `gcc -o main main.s` to assemble an executable file `main` from `main.s`.
		* Alias for `arm-elf-gcc -Wall -g -o main main.s`.
	* `gdb main` to run `main` on GDB in Text User Interface.
		* Alias for `arm-elf-gdb -tui main`.

