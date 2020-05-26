#! /usr/bin/env python
# -*-coding:utf8-*-

from __future__ import print_function

import datetime
import os
import time
import argparse
import subprocess


class Fetcher(object):

    def __init__(self, repository, branch, out_path, interval):
        self.repository = repository
        self.branch = branch
        self.out_path = out_path
        self.interval = interval

        # https://github.com/raomuyang/raomuyang.github.io.git
        if repository.endswith(".git"):
            self._poj_name = repository.split('/')[-1][:-4]
        else:
            self._poj_name = repository.split('/')[-1]

    @property
    def local_path(self):
        return os.path.join(self.out_path, self._poj_name)

    def fetch(self):
        if os.path.exists(os.path.join(self.local_path, ".git")):
            os.chdir(self.local_path)
            print("[{}] ---------------- Force update and fetch branch '{}' --------------".format(datetime.datetime.now(), self.branch))
            os.system(
                "git fetch --all; git reset --hard origin/%s; git pull" % self.branch)
            print(
                "[{}] ---------------- Update successfully --------------".format(datetime.datetime.now()))
        else:
            print(
                "[{}] ---------------- Clone {} --------------".format(datetime.datetime.now(), self.repository))
            cmd = [
                "git",
                "clone",
                "-b",
                self.branch,
                self.repository,
                self.local_path
            ]
            p = subprocess.Popen(cmd)
            p.wait()
            print("[{}] ---------------- Cloned successfully --------------".format(
                datetime.datetime.now(), self.repository))

    def interval_fetch(self):
        print("Start the interval worker for %s, branch: %s" % (self.repository, self.branch))
        cycle = self.interval * 60

        while True:
            try:
                self.fetch()
            except Exception as e:
                print("WARN: ", e)
            time.sleep(cycle)


def main():

    parser = argparse.ArgumentParser()
    parser.add_argument("-r", "--repository", help="git repository address")
    parser.add_argument("-b", "--branch", default='master',
                        help="git branch name")
    parser.add_argument("-o", "--out", help="local path to fetch")
    parser.add_argument("-i", "--interval", type=int,
                        default=30, help="fetch interval (miniutes)")
    args = parser.parse_args()

    fetcher = Fetcher(
        repository=args.repository,
        branch=args.branch,
        out_path=args.out,
        interval=args.interval
    )
    fetcher.interval_fetch()


if __name__ == "__main__":
    main()
