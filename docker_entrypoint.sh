#!/bin/bash

# pipe the output of the `uname -a` command (prints info about the OS and kernel version)
# to the cowsay command, which prints text in the speech bubble of an ASCII cow
uname -a | cowsay
