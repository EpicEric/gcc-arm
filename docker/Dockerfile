FROM ubuntu:16.04
LABEL maintainer "Eric Pires <ericpires9@gmail.com>"

# Build arg: Preferred text editor (default = vim)
ARG	EDITORPKG=vim

# ARM-GCC
ADD	bu-2.15_gcc-3.4.3-c-c++-java_nl-1.12.0_gi-6.1.tar.bz2 /

# Packages
RUN	dpkg --add-architecture i386 && \
	apt-get update && \
	apt-get install --no-install-recommends -y \
		# Multi-arch libraries
		libc6:i386 libncurses5:i386 libstdc++6:i386 libx11-6:i386 \
		# Text editors
		less $EDITORPKG \
		# Misc programs
		git && \
	rm -rf /var/lib/apt/lists/*

# Non-root "student" user
RUN	useradd -mG sudo student && mkdir -p /etc/sudoers.d && \
	echo "%sudo   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/sudo_nopasswd && \
	mkdir -p /home/student/src && \
	echo "\n\
export PATH=\$PATH\n\
PATH=\"\$PATH:/gnuarm-3.4.3/bin\"\n\
alias arm=\"arm-elf-gcc -S\"\n\
alias gcc=\"arm-elf-gcc -Wall -g\"\n\
alias gdb=\"arm-elf-gdb -tui\"\n\
cd /home/student/src" >> /home/student/.bashrc

COPY	entrypoint.sh /
ENTRYPOINT	["/entrypoint.sh"]
