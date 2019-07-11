. ~/.bashrc

export QSYS_ROOTDIR="/home/soulthym/.cache/yay/quartus-free/pkg/quartus-free/opt/altera/18.1/quartus/sopc_builder/bin"
export PATH="$(du $HOME/.local/bin/ | cut -f2 | tr '\n' ':')$PATH"
