# configurizer
This script synchronizes configuration files across my OSX/Linux machines.

The go.py script can be potentially dangerous (NO WARRANTY). Run it in dry-run mode first for safety. The dry-run mode is default, unless `--run` option is given.

## syncing repo -> machine
1. `git clone` or `git pull` (make it up-to-date)
2. `./go.py --run deploy`

## syncing machine -> repo
1. `git clone` or `git pull` (make it up-to-date)
2. `./go.py --run collect`
3. `git commit -a` then `git push`
