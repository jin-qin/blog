---
title: CUDA7.5+CUDNNv4+Caffe+Ubuntu16.04 Issues Collection
date: 2016-06-11 04:23:45
tags:
- Caffe
- Ubuntu 16.04
- CUDA7.5
- CUDNNv4
categories:
- Machine Learning
---

There are so many issues when I tried `Caffe+CUDA7.5+CUDNNv4+Ubuntu16.04`, put them here in case of need.

First, should use `Python2.7` rather than `Python3.5`!!!

<!--more-->

> To fix shared libraries error (normally it is `symbolic link` issue):

* "while loading shared libraries: libcudart.so.7.5: cannot open shared object"
 - `sudo ldconfig /usr/local/cuda/lib64`

> To fix libhdf5 error:

* `sudo apt-get install --reinstall libhdf5-10`
* `sudo apt-get install –reinstall libhdf5-dev`
* `sudo apt-get install –reinstall libhdf5-serial-dev`
* Add /usr/lib/x86_64-linux-gnu/hdf5/serial/ to INCLUDE_LIBRARIES

> To fix opencv, liblzma etc errors:

* Check LD_LIBRARY_PATH, if it contains anaconda3/lib then do:
* Set LD_LIBRARY_PATH="/usr/lib/x86_65-linux-gnu/"
	
	

> To fix g++ compile bugs:

* "/usr/include/string.h: In function ‘void* __mempcpy_inline(void*, const void*, size_t)’": 
 - If compile with Makefile，then open Makfile，change `NVCCFLAGS += -ccbin=$(CXX) -Xcompiler -fPIC $(COMMON_FLAGS)` to `NVCCFLAGS += -D_FORCE_INLINES -ccbin=$(CXX) -Xcompiler -fPIC $(COMMON_FLAGS)`.
	
	
> To fix python2.7 error:

* "python/caffe/_caffe.cpp:11:31: fatal error: numpy/arrayobject.h: No such file or directory"
 - Solution:
 `vim Makefile.config`
 Find: PYTHON_INCLUDE
 Add: change "/usr/lib/python2.7/dist-packages/numpy/core/include" to "/usr/local/python2.7/dist-packages/numpy/core/include"
	

> If matplotlib.pyplt() does not work:

* `sudo apt-get install python-qt4`
 Change backend=PyQt4, and uncomment the backend=backend.pyqt4