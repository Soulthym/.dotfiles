. ~/.bashrc

export QSYS_ROOTDIR="/home/soulthym/intelFPGA_lite/17.0/quartus/sopc_builder/bin"
export PATH="$(du $HOME/.local/bin/ | cut -f2 | tr '\n' ':')$PATH"
