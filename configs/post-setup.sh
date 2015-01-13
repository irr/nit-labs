#!/bin/bash
cd ~/nit
nitc srt.nit && sudo mv srt /usr/local/bin
nitc wg.nit && sudo mv wg /usr/local/bin
rm -rf .nit_compile
echo "nit utilities installed ok"
cd
