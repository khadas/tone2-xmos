Debug printing library
======================

Overview
--------

This library provides a lightweight printf function that can be enabled
or disabled via configuration defines. Code can be declared to be
within a "debug unit" (usually a library or application source base)
and prints can be enabled/disabled per debug unit.

Features
........

  * Low memory usage
  * Ability to enable or disable printing via compile options
  * Ability to enable or disable printing for sets of source files

Software version and dependencies
.................................

.. libdeps::
