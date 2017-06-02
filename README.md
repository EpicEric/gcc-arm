# GCC-ARM

Docker container for PCS3732 - Laboratory of Processors course in Poli-USP with Ubuntu 16.04 image, able to run a 32-bit GCC version for the ARM architecture. Includes basic text editors and aliases.

# Usage

## Installation

There are two alternative origins:

* Pulling from Docker Hub:
    * `docker pull epiceric/gcc-arm`

* Building from GitHub source: 
    * `git clone https://github.com/EpicEric/gcc-arm.git ; docker build -t epiceric/gcc-arm gcc-arm/docker`
    * Alternatively, you can clone the repo and run `build_docker.sh` from this directory.

## Running

* Starting an interactive Bash shell:
    * `docker run -ti -v "$PWD/src":/home/student/src epiceric/gcc-arm`
    * Alternatively, you can run `run_docker.sh` from this directory.
* You can place files in `src/` to mount them in the default directory (`/home/student/src/`).
* Quit with `Ctrl-D`.

## Commands

* Text editing:
    * `vim`, `less`
* Versioning:
    * `git`
* Compiling and debugging:
    * `arm main.c` or `arm -o main.s main.c` to compile from C to ARM-Assembly.
    * `gcc -o main main.c` or `gcc -o main main.s` to compile an executable file `main`.
    * `gdb main` to run GDB-ARM in Text User Interface.

