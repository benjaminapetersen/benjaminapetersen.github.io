---
layout: post
date:   2017-11-24
title:  "A Short grep Cheatsheet"
tags: grep bash unix gnu cheatsheet
---

# A Short Grep Cheatsheet

I've been working on improving my bash-fu since I started at RedHat. I was introduced to tools like [ack](https://beyondgrep.com/) and [ag](https://github.com/ggreer/the_silver_searcher) along the way, but never actually took the time to learn good ol' `grep`.  The problem is that you inevitably have to `ssh` into a machine that doesn't have all of your favorite tools installed.  In this case, its good to have an understanding of the basics to fall back on.  So, for the short term at least, I'll be `grep`ping all the things.

As an aside, I've definitely come to appreciate the [GNU](https://en.wikipedia.org/wiki/GNU) versions of commands which brought us long form flags.  MacOS includes the BSD versions, for some horrible reason.  Long form
flags are actually memorable and far less cryptic.  Go team user experience!

By the way, `grep` stands for `g/re/p`, or "globally search a
regular expression and print".  Like many [Unix](https://en.wikipedia.org/wiki/Unix-like) tools, it is
line based.  This is important to know as it won't match
multiple occurrences of search terms in one line unless you
explicitly ask with a flag.

`grep`'s basic job is to print lines matching some pattern.



```bash
# search for a string in a single file
grep "some string" file.txt
# search for a string in all files in the current directory  
grep "some string" *
# recursive
grep --recursive "some string" .
grep -r "some string" ./
# search for a string & show lines before & after the context
# of your search. The possible flags are: --before-context,
# --after-context & --context
grep --after-context 3 "some string" file.txt
grep --before-context 2 "some string" file.txt
grep -A 3 -B 2 "some string" file.txt
# if you want the same # of lines before and after, just use `-C`:
grep --context 3 "some string" file.txt
grep -C 3 "some string" file.txt
# if you really want to be terse, you can just -<num>
grep -3 "some string" file.txt
# search for a string within a certain set of files in the directory
grep "some string" ./foo_*
# case insensitive search
grep --ignore-case "SoMe StRInG" *
grep -i "SoMe StRInG" *
# search for a regex in a file, a handful of examples:
grep "REGEX" file.txt
grep "^line starts with" file.txt
grep "line ends with$" file.txt
grep "^line contains only these words$"file.txt
grep "starts with this.*and ends with that" file.txt  # .* and has an arbitrary gap in the middle
grep '[Tt]ext' file.txt # Text or text
grep 'T[eE][xX]t' file.txt # Text or TExt or TEXt or... (however, just consider -i unless reason to be picky)
grep '^$' file.txt # blank lines
grep '[0-9][0-9]' file.txt # pairs of digits
# multiple regex
grep --regexp="[Ss]ome" --regexp="[Tt]ext" file.txt
grep -e "[Ss]ome" -e "[Tt]ext" file.txt
# invert multiple regex (non matches)
grep --invert-match -e "[Ss]ome" -e "[Tt]ext" file.txt # -v is short for --invert-match
# search for exact word match.
grep --word-regexp 'is' file.txt  # this, his, etc will not match, only 'is'
grep --w 'is' file.txt
# custom highlight output before doing next search
export GREP_OPTIONS='--color=auto' GREP_COLOR='100;8'
# invert the match (search for non matches)
grep --invert-match "some string" file.txt
grep -v "some string" file.txt
# count lines that match
grep --count "some string" file.txt  # <num>
grep -c "some string" file.txt
# count lines that do not match
grep -v -c "some string" file.txt
# print only matching filenames
grep --files-with-matches "some string" ./
grep -l "some string" ./
```

[This article](http://www.thegeekstuff.com/2009/03/15-practical-unix-grep-command-examples/) from The Geek Stuff was a helpful reference for this post.
