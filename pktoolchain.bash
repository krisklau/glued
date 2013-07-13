#! /bin/bash
#############################################################################
# Copyright (C) 2007-2012 Laboratório de Sistemas e Tecnologia Subaquática  #
# Departamento de Engenharia Electrotécnica e de Computadores               #
# Rua Dr. Roberto Frias, 4200-465 Porto, Portugal                           #
#############################################################################
# Author: Ricardo Martins                                                   #
#############################################################################
# $Id::                                                                   $:#
#############################################################################

# Check shell type.
if [ -z "$BASH_VERSION" ]; then
    echo "ERROR: you must use bash to run this script."
    exit 1
fi

if [ $# -ne 1 ]; then
    echo "Usage: $0 <config>"
    exit 1
fi

if ! [ -f "$1" ]; then
    echo "ERROR: configuration file '$1' does not exist."
    exit 1
fi

source "$1"

tar \
    -v \
    -j \
    -c \
    -C "$cfg_dir_toolchain" \
    -f "$cfg_toolchain_tar" \
    .