#!/bin/bash
ARCH=$(awk '/^def/{print NR + 1;exit;0}' $0)

tail -n+$ARCH $0 | sudo tee

exit
def
