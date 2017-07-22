# GCC-ARM [![Build Status](https://travis-ci.org/EpicEric/gcc-arm.svg?branch=master)](https://travis-ci.org/EpicEric/gcc-arm) [![Docker Stars](https://img.shields.io/docker/stars/epiceric/gcc-arm.svg)](https://hub.docker.com/r/epiceric/gcc-arm/) [![Docker Pulls](https://img.shields.io/docker/pulls/epiceric/gcc-arm.svg)](https://hub.docker.com/r/epiceric/gcc-arm/)

Docker container for "PCS3732 - Laboratory of Processors" course in Poli-USP with Ubuntu 16.04 image, able to run a 32-bit GCC version for the ARM architecture. Includes basic text editor, command aliases, and Evaluator-7T board support.

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
	* `docker run --rm -ti -v "$PWD/src":/home/student/src epiceric/gcc-arm`
	* Alternatively, you can run `./run_docker.sh` from this directory.
* You can place files in `src/` to mount them to the default directory (`/home/student/src/`).
	* Or you can specify a custom source directory location with `./run_docker.sh ~/path/to/custom_src` or `docker run --rm -ti -v "$HOME/path/to/custom_src":/home/student/src epiceric/gcc-arm`.
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
	* `gcc -o main main.s`: Assemble an executable file `main` from `main.s`. Receives one or more C or Assembly files as input.
		* Alias for `arm-elf-gcc -Wall -g -o main main.s`.
	* `gdb main`: Run `main` on GDB in Text User Interface.
		* Alias for `arm-elf-gdb -tui --command=/home/student/.gdbinit/default main`. The `.gdbinit/default` file loads setup commands for GDB (`layout regs ; target sim ; load`).
	* For more toolchain commands, list all executables in `/gnuarm-3.4.3/bin`.

To test the example file `item-2-2.s`, assemble with `gcc` and run the compiled program on `gdb` with the following commands:
* `b main` (`break main`): Set a breakpoint on the `main` label.
* `r` (`run`): Begin execution.
* `s` (`step`): Execute every command step-by-step.
* `q` (`quit`): Exit GDB once the program is finished.

For documentation on the ARM Assembly language, please refer to the [ARM Laboratory Exercises](http://courses.cs.tamu.edu/rabi/cpsc617/resources/ARM%20Lab%20Mannual.pdf).

Please view the [GDB Manual](https://sourceware.org/gdb/onlinedocs/gdb/index.html) for more information on running GDB.

# Advanced

## Running on Windows

**Note:** This solution only appears to work in the regular command line, but not in PowerShell.

Obviously, the shell scripts intended for Bash won't work. But instead, if you have the Docker Toolchain up and running, you can still build the container with the full command.

Running the container however is trickier. It has been reported to work with the extra `-e TERM` argument and Linux-based syntax for mounted directories (i.e. `C:\` drive replaced by `/c/`). Here is an example:

`docker run --rm -ti -v "/c/Users/yourname/path/to/custom_src":/home/student/src -e TERM epiceric/gcc-arm`

## Connecting to the ARM Evaluator-7T Board

The ARM Evaluator-7T board must be connected to your computer through an USB port. Identify the appropriate interface in the host (for example, `/dev/ttyUSB0`) and run the container with a second argument:
* `./run_docker.sh ~/path/to/custom/src /dev/ttyUSB0`
* (Shorthand for `docker run --rm -ti -v "$HOME/path/to/custom_src":/home/student/src --device=/dev/ttyUSB0:/dev/ttyS0 epiceric/gcc-arm`).

Then, you must use `e7t main` instead of `gdb main`. The only difference is `.gdbinit/default` being replaced by `.gdbinit/evaluator7t`, with separate setup commands (`layout regs ; set remotebaud 57600 ; target rdi /dev/ttyS0 ; load`). Once you're in GDB, set your breakpoints and begin execution with `c` (`continue`) instead of the default run command.

For detailed information on the board, please refer to the [Evaluator-7T User Guide](http://infocenter.arm.com/help/topic/com.arm.doc.dui0134a/DUI0134A_evaluator7t_ug.pdf).

### Other operating systems

Due to how Docker Toolchain exposes devices to the Linux virtual machine, there is no simple workaround for OS X or Windows. If you are a more experienced user, you may try to set up a Oracle VirtualBox machine and run this container from there. **All of the following commands are run at your own risk, and I hold no liability.**

#### OS X

1. Create a Docker Machine in VirtualBox (in this case, named `vbox-test`).
	* `docker-machine create -d virtualbox vbox-test`
2. Download and install the [VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads) with the VirtualBox GUI.
3. Connect the Evaluator-7T board on an USB port.
4. Turn off the virtual machine.
	* `docker-machine stop vbox-test`
5. In the VirtualBox GUI configurations, right-click your VM and enable/add the appropriate device in "Settings -> Ports -> USB".
6. Turn on the virtual machine.
	* `docker-machine start vbox-test && eval $(docker-machine env vbox-test)`
7. Build or pull the container inside the VM. The file structure is identical to the host's.
	* `docker-machine ssh vbox-test docker build -t epiceric/gcc-arm $PWD/docker`
8. Identify the relevant USB device.
	* `docker-machine ssh vbox-test ls /dev | grep -i USB`
9. Run the container as usual, setting the appropriate device as `/dev/ttyS0` (in this case, `/dev/usb`).
	* `docker run --rm -ti -v "$HOME/path/to/custom_src":/home/student/src --device=/dev/usb:/dev/ttyS0 epiceric/gcc-arm`

#### Windows

No guide yet. :^)

Following similar steps to OS X might work. However, Windows may require Hyper-V to be disabled before using Oracle VirtualBox. Please tell me if you manage to make it work.

## Bare metal with arm-none-eabi

Another toolchain that comes with this installation is the [Sourcery CodeBench Lite for ARM EABI](https://sourcery.mentor.com/GNUToolchain/release2032). It facilitates building bare metal programs with a C user program, an Assembly interrupt vector and a linker script. Furthermore, the compiled executable can be run and tested on GDB. Here is a useful set of commands:

Useful resources from Balau: [a basic example](https://balau82.wordpress.com/2010/02/14/simplest-bare-metal-program-for-arm/), ['Hello World'](https://balau82.wordpress.com/2010/02/28/hello-world-for-bare-metal-arm-using-qemu/).

### Regular program

```
eabi-gcc c_entry.c -o c_entry.o
eabi-as startup.s -o startup.o
eabi-ld -T vector_table.ld c_entry.o startup.o -o program.elf
eabi-gdb program.elf
```

### Code on emulated board with QEMU

```
eabi-gcc c_entry.c -o c_entry.o
eabi-as startup.s -o startup.o
eabi-ld -T vector_table.ld c_entry.o startup.o -o program.elf
eabi-bin program.elf program.bin
qemu program.bin
```

In another terminal, open the same container with `./run_docker.sh` (without parameters).

```
eabi-qemu -se program.elf
[gdb] break c_entry
[gdb] continue
[gdb] ...
[gdb] quit
pkill qemu
```

