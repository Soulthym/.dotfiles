# Remove orphaned packages.
# Needs single quotes, otherwise the newlines that "pacman -Qqdt" outputs
# cause trouble.
# The parentheses create a subshell meaning the verbose output caused by
# "set -x" is unset when the subshell exits at the end of the command.
# Arguments to "pacman -Q":
#    -d restrict output to packages installed as dependencies
#    -t list packages that are no longer required by any installed package
#    -q suppress version numbers of packages (this would confuse pacman -R)
# alias cleanup_packages='(set -x; sudo pacman -R $(pacman -Qdtq))'
pacman -Qdtq
