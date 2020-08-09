#!/bin/bash
hexo generate
bash "$(pwd -P)/gen-wiki.sh"