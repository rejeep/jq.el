[WIP] jq.el
===========

[![Build Status](https://travis-ci.org/rejeep/jq.el.svg)](https://travis-ci.org/rejeep/jq.el) [![License] (http://img.shields.io/:license-gpl3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0.html)
<!-- reade to insert melpa badge:
[![MELPA](http://melpa.org/packages/jq-badge.svg)](http://melpa.org/#/jq) [![MELPA stable](http://stable.melpa.org/packages/jq-badge.svg)](http://stable.melpa.org/#/jq) -->

Emacs major mode for [jq](http://stedolan.github.io/jq/).

This is a work in progress, please feel free to chip in.

## Usage

You can launch it whether by calling `jq` that will prompting you a file
or by calling `jq-mode` on an existing JSON buffer.

Here are the main command if the mode, which mostly enable you to tweak
different jq modes:

- <kbd>C-c C-s</kbd> : `jq-toggle-slurp`
- <kbd>C-c C-p</kbd> : `jq-toggle-pretty`
- <kbd>C-c C-r</kbd> : `jq-toggle-raw`
- <kbd>C-c C-j</kbd> : `jq-toggle-join`
- <kbd>C-c C-q</kbd> : `jq-quit`
