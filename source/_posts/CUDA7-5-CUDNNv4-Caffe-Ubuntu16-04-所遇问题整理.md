---
title: CUDA7.5+CUDNNv4+Caffe+Ubuntu16.04 所遇问题整理
date: 2016-06-11 04:23:45
tags:
- Caffe
- Ubuntu 16.04
- CUDA7.5
- CUDNNv4
- Chinese
categories:
- Machine Learning
---

最近用 `Caffe+CUDA7.5+CUDNNv4+Ubuntu16.04` 遇到太多问题，因此在此整理一下。

首先，应该用 `Python2.7`, 而不是`Python3.5`!!!

<!--more-->

> To fix shared libraries error (通常都是 `symbolic link` 的问题):

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
 - 如果是用 Makefile 编译的，就打开 Makfile 文件，把 `NVCCFLAGS += -ccbin=$(CXX) -Xcompiler -fPIC $(COMMON_FLAGS)` 这一行替换为 `NVCCFLAGS += -D_FORCE_INLINES -ccbin=$(CXX) -Xcompiler -fPIC $(COMMON_FLAGS)`.
	
	
> To fix python2.7 error:

* "python/caffe/_caffe.cpp:11:31: fatal error: numpy/arrayobject.h: No such file or directory"
 - Solution:
 `vim Makefile.config`
 Find: PYTHON_INCLUDE
 Add: change "/usr/lib/python2.7/dist-packages/numpy/core/include" to "/usr/local/python2.7/dist-packages/numpy/core/include"
	

> If matplotlib.pyplt() does not work:

* `sudo apt-get install python-qt4`
 Change backend=PyQt4, and uncomment the backend=backend.pyqt4