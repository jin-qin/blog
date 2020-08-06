#!/bin/bash
wiki_path="$(pwd -P)/wiki"
cd "$wiki_path"
hexo generate
cd ..