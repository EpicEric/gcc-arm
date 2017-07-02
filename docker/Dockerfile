FROM ubuntu:16.04
LABEL maintainer "Eric Pires <ericpires9@gmail.com>"

# Build arg: Preferred text editor (default = vim)
ARG	EDITORPKG=vim

# Install ARM-GCC
ADD	files/bu-2.15_gcc-3.4.3-c-c++-java_nl-1.12.0_gi-6.1.tar.bz2	/

# Install additional packages
RUN	dpkg --add-architecture i386 && \
	apt-get update && \
	apt-get install --no-install-recommends -y \
		# Multi-arch libraries
		libc6:i386 libncurses5:i386 libstdc++6:i386 libx11-6:i386 \
		# Text editors
		less $EDITORPKG && \
	rm -rf /var/lib/apt/lists/*

# Create non-root "student" user
RUN	useradd -mG sudo student && mkdir -p /etc/sudoers.d && \
	echo "%sudo   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/sudo_nopasswd && \
	mkdir -p /home/student/src

# Login as "student" user on startup
COPY	entrypoint.sh	/
ENTRYPOINT	["/entrypoint.sh"]

# Run commands when starting GDB
ADD	files/.gdbinit	/home/student/.gdbinit/

# Fix ARM highlight syntax for VIM
ADD	files/asm.vim	/home/student/.vim/syntax/

# Configure user Bash
ADD	files/.bashrc	/home/student/.bashrc_tmp
RUN	cat < /home/student/.bashrc_tmp >> /home/student/.bashrc && \
	rm /home/student/.bashrc_tmp
