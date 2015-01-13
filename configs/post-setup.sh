#!/bin/bash
cd ~/nit
echo "compiling srt.nit..."
nitc srt.nit && sudo mv srt /usr/local/bin
rm -rf .nit_compile
cd ~/git/configs/torrents
echo "compiling wg.nit..."
nitc wg.nit && sudo mv wg /usr/local/bin
rm -rf .nit_compile
echo "nit utilities installed ok"
cd
