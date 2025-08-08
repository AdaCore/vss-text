# VSS-Text

[![Build](https://github.com/AdaCore/vss-text/actions/workflows/main.yml/badge.svg)](https://github.com/AdaCore/vss-text/actions/workflows/main.yml)
[![alire](https://img.shields.io/endpoint?url=https://alire.ada.dev/badges/vss-text.json)](https://alire.ada.dev/crates/vss-text.html)

A high level Unicode text processing library.

## Warning - Work in Progress

This project is based on [`VSS`](https://github.com/AdaCore/VSS) (Virtual
String System). VSS has been split into two projects:

* [`vss-text`](https://github.com/AdaCore/vss-text) (this project): a library for Unicode text
  processing.
* [`vss-extra`](https://github.com/AdaCore/vss-extra): libraries for handling
  JSON, Regexp, XML and other features based on `vss-text`.

Significant changes are planned in `vss-text` with the goal to make it a
high-quality, high-performance library suitable for a wide range of
applications.

The changes include the following (non-exhaustive list):

* API Changes
  * Introduce an immutable string type.
  * Repurpose the mutable `Virtual_String` type to a string builder type.
  * Possibly rename the root package `VSS` to a new more appropriate name. GPR project and repository names might change accordingly.
* (done) Drop the support of multiple internal encodings in favor of a single internal
  encoding (likely UTF-8) for improved performance.

## The objectives

The objectives of this project are

* To introduce a definite type that represents a string of Unicode characters
  and provides a handy set of operations.
* The API should be encoding independent and allows efficient implementations.
* Besides separating string API from in-memory data representation, it should
  separate string API from input/output stream representation.
* To provide a clear, well-defined semantic for iteration over string
  elements, such as unicode unit, grapheme cluster, etc.
* To avoid string element integer indexes, because this isn't necessarily
  constant time and could mislead about indexed element kind.
* To prefer safe results over raising exceptions where possible.

Warning: This is experimental work in progress, everything is subject to
change.

Note: Some Ada 2022 features are used in source code. This requires compiler
that supports them.

## Install

### Build from sources

Prefered way to install is to download sources and run

    make all install PREFIX=/path/to/install

### Using `Alire`

Or you can use [Alire](https://alire.ada.dev/) library manager:

    alr get --build vss_text

Then you can use it as dependency in the project file:

    with "vss_text.gpr";

## Documentation

* [API Reference](https://adacore.github.io/VSS/)
* [Tips & Tricks](docs/Tips_and_Tricks.md)

## Maintainers

[@AdaCore](https://adacore.com/).

## Contribute

Feel free to dive in!
[Open an issue](https://github.com/AdaCore/vss-text/issues/new)
or submit PRs.

## License

[Apache License v2.0 with LLVM Exceptions](LICENSE.txt).
