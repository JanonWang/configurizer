#!/usr/bin/env python2.7

import sys
import subprocess
import getopt

dry_run = True

# DB format: list of <local file>, or 2-tuple of (<local file>, <target file>)
#   If only local file is specified, we use it as its target file.
#
# NOTE: absolute paths are not well tested
#
# If local file ends:
#     '/': this is a directory (copy recursively, except hidden files)
# If local file starts with:
#     '+': create an empty file or directory.
#          (beware that existing files are deleted)
#     '!': remove the target file, if exists.
common = [
    '+.vim/',
    '.vim/after/',
    '+.vim/bundle/',
    '.vim/bundle/Vundle.vim/',
    '+.vim/backups/',
    '+.vim/swaps/',
    '.vimrc',
    '.terminfo/',
    '.bash_env',
    '.bash_prompt',
    '.bash_profile',
    '.bashrc',
    '.dircolors',
    '.tmux.conf',
    '.gitconfig',
    '+.ssh/',
    '.ssh/authorized_keys',
    '.ssh/config',
    '+.config/',
    '+.config/htop/',
    '.config/htop/htoprc',
    '.ackrc',
    '.inputrc',
    ]

linux = [
    '.bash_aliases',
    ]

osx = [
    '.bash_aliases',
    '.iterm2/',
    '.iterm2-bitmap/',
    ]

def run_cmd(cmd):
    global dry_run

    print '\t\tcmd: %s' % cmd
    if not dry_run:
        subprocess.check_call(cmd, shell=True)

def parse_entry(entry, local_prefix):
    flag_dir = False
    flag_add = False
    flag_del = False    # flag_add and flag_del cannot be set at the same time

    target = None

    if isinstance(entry, tuple):
        local, target = entry
    else:
        local = entry

    if local[-1] == '/':
        flag_dir = True
        local = local[:-1]

    if local[0] == '+':
        local = local[1:]
        flag_add = True
    elif local[0] == '!':
        local = local[1:]
        flag_del = True

    if local[0] == '/':
        local_path = local
    else:
        local_path = '%s/%s' % (local_prefix, local)

    if target == None:
        target = local

    if target[0] == '/':
        target_path = target
    else:
        target_path = '%s/%s' % ('~', target)

    return local_path, target_path, flag_dir, flag_add, flag_del

def deploy(db, local_prefix):
    print 'Processing %s' % local_prefix

    for entry in db:
        local_path, target_path, flag_dir, flag_add, flag_del = \
                parse_entry(entry, local_prefix)

        print '\tFile %s' % local_path

        if flag_del:
            run_cmd('rm -rf %s' % target_path)
        elif flag_add:
            if flag_dir:
                run_cmd('mkdir -p %s' % target_path)
            else:
                run_cmd('touch %s' % target_path)
        else:
            run_cmd('rm -rf %s' % target_path)
            if flag_dir:
                run_cmd('cp -r %s %s' % (local_path, target_path))
            else:
                run_cmd('cp %s %s' % (local_path, target_path))
                

def collect(db, local_prefix):
    print 'Processing %s' % local_prefix

    run_cmd('rm -rf %s' % local_prefix)
    run_cmd('mkdir %s' % local_prefix)

    for entry in db:
        local_path, target_path, flag_dir, flag_add, flag_del = \
                parse_entry(entry, local_prefix)

        print '\tFile %s' % local_path

        if flag_del:
            continue

        if flag_add:
            run_cmd('rm -rf %s' % local_path)
            if flag_dir:
                run_cmd('mkdir -p %s' % local_path)
            else:
                run_cmd('rm -f %s' % local_path)
                run_cmd('touch %s' % local_path)
        else:
            if flag_dir:
                run_cmd('cp -r %s %s' % (target_path, local_path))
            else:
                run_cmd('cp %s %s' % (target_path, local_path))

def print_usage():
    print >> sys.stderr, 'Usage: %s [--run] <deploy | collect>' % sys.argv[0]
    sys.exit(2)

def main():
    global dry_run

    opts, args = getopt.gnu_getopt(sys.argv[1:], '', ['run'])

    if len(args) != 1 or args[0] not in ['deploy', 'collect']:
        print_usage()

    for opt, optarg in opts:
        if opt == '--run':
            dry_run = False
        else:
            print_usage()

    if dry_run:
        print 'Running in dry-run mode. Use --run to actually run it'

    uname = subprocess.check_output('uname', shell=True).strip()
    assert(uname in ['Linux', 'Darwin'])

    if args[0] == 'deploy':
        func = deploy
    elif args[0] == 'collect':
        func = collect
    else:
        assert False

    func(common, 'common')
    if uname == 'Linux':
        func(linux, 'linux')
    elif uname == 'Darwin':
        func(osx, 'osx')

if __name__ == '__main__':
    main()
