TOC
===

About

Dependencies

Installing and running

--

About
=====

This small project is just an example (very simple) how to calculate code coverage for bash scripts with **assert.sh** framework and **kcov** tool.


Dependencies
============

All required dependencies:

1. linux box (obviously)
2. bash
3. kcov (either installed widely in your system or placed inside tests/kcov/ dir)

Optional dependencies:

1. assert.sh v1.1 framework (scripts can fetch it from github directly)


Installing and running
======================

If you have **kcov** already installed in your system it's enough to launch run_tests.sh and count_coverage.sh scripts to see how tests are being executed and how code coverage is measured. If not availanle bash test framework **assert.sh** will be downloaded automatically into tests/ dir.


--

travis-ci status for bash_covr_example:

[![Build Status](https://travis-ci.org/brand0m/bash_covr_example.png?branch=master)](https://travis-ci.org/brand0m/bash_covr_example)

