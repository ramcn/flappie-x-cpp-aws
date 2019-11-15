#  Copyright 2018 Oxford Nanopore Technologies, Ltd

#  This Source Code Form is subject to the terms of the Oxford Nanopore
#  Technologies, Ltd. Public License, v. 1.0. If a copy of the License 
#  was not  distributed with this file, You can obtain one at
#  http://nanoporetech.com

buildDir ?= build
hdf5Root ?= ''
releaseType ?= Debug 

.PHONY: all
all: flappie
flappie: ${buildDir}/flappie
	cp ${buildDir}/flappie flappie

${buildDir}:
	mkdir ${buildDir}

.PHONY: test
test: ${buildDir}/flappie
	cd ${buildDir} && \
	make test

.PHONY: clean
clean:
	rm -rf ${buildDir} flappie

${buildDir}/flappie: ${buildDir}
	cd ${buildDir} && \
        cmake .. -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DCMAKE_CXX_LINK_FLAGS="-L/usr/lib64" -DCMAKE_CXX_FLAGS="-L/usr/lib64 -pg -std=c++11 -Wno-sign-compare  -Wno-format  -g  -fpermissive   -DUSE_SSE2  -D__USE_MISC -D_POSIX_SOURCE -DNDEBUG" -DCMAKE_BUILD_TYPE=${releaseType} -DOPENBLAS_ROOT=/usr -DHDF5_ROOT=${hdf5Root} && \
	make flappie
    
