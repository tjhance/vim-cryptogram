#!/usr/bin/python

import gflags
import sys

FLAGS = gflags.FLAGS

def matches(word, inject, include, codeword):
    if len(word) != len(codeword):
        return False
    mapping = {}
    values = set()
    for c, d in zip(word, codeword):
        if d == ".":
            pass
        elif d.isupper():
            if c != d:
                return False
        else:
            if c not in include:
                return False
            if d in mapping:
                if mapping[d] != c:
                    return False
            else:
                mapping[d] = c
                if inject:
                    if c in values:
                        return False
                    values.add(c)
    return True

def search_file(f, inject, include, codeword):
    for line in f:
        word = line.strip()
        if matches(word.upper(), inject, include, codeword):
            print word

def main():
    gflags.DEFINE_bool("inject", True, "Require an injective mapping")
    gflags.DEFINE_string("include", "", "String of characters allowed in range. If not given, defaults to entire alphabet if inject is False, otherwise defaults to alphabet minus characters that already exist.")
    gflags.DEFINE_string("dict", "", "filename of the dictionary")

    try:
        argv = FLAGS(sys.argv)
        if len(argv) != 2:
            raise Exception("Bad format.")
        codeword = argv[1]
        if (not codeword) or any(c not in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ." for c in codeword):
            raise Exception("Bad codeword.")
    except Exception as e:
        print '%s\nUsage: %s [options] codeword\n%s' % (e, sys.argv[0], FLAGS)
        sys.exit(1)

    inject = FLAGS.inject
    if FLAGS.include:
        include = FLAGS.include.upper()
    elif inject:
        include = [c for c in "ABCDEFGHIJKLMNOPQRSTUVWXYZ" if c not in codeword]
    else:
        include = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    if FLAGS.dict:
        with open(FLAGS.dict, "r") as f:
            search_file(f, inject, include, codeword)
    else:
        search_file(sys.stdin, inject, include, codeword)

if __name__ == '__main__':
    main()
