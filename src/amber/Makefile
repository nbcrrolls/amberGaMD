#
# Makefile
#
# @Copyright@
# @Copyright@

ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
ifndef ROLLNETWORK
  ROLLNETWORK = eth
endif
ifndef ROLLMPI
  ROLLMPI = openmpi
endif

PKGROOT = /opt/amber
REDHAT.ROOT = $(PWD)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include $(NBCRDEVEL)/NBCR.mk

COMPILERSETUP = echo $(ROLLCOMPILER)

ifeq ("$(ROLLCOMPILER)", "intel")
COMPILERSETUP = \
  if test -e /etc/profile.d/modules.sh; then \
    . /etc/profile.d/modules.sh; \
    module load $(ROLLCOMPILER); \
    module load mkl; \
  fi 
endif

MPIMODULE = $(ROLLMPI)-$(ROLLCOMPILER)-$(ROLLNETWORK)

build-from-patch:
	bzip2 -dc $(SOURCE_PKG) | tar xf -
	bzip2 -dc $(TOOLS_PKG) | tar xf -
	( \
	  $(MODULE_LOAD_CC); \
	  $(MODULE_LOAD_MPI); \
	  export AMBERHOME=`pwd`/$(SOURCE_DIR); \
	  cd $${AMBERHOME}; pwd ; \
	  ./update_amber --update ; \
	  patch -p0 < ../amber14_GaMD_patch_confidential.txt ; \
	  ./configure $(ROLLCOMPILER); \
	  make -j8 install;  make clean; \
	  ./configure -mpi $(ROLLCOMPILER); \
	  make -j8 install; make clean; \
	  if test -e $(CUDAHOME); then \
	    module load cuda; \
	    export CUDA_HOME=/opt/cuda; \
	    echo "Using CUDA from $(CUDAHOME)"; \
	    ./configure -cuda $(ROLLCOMPILER); \
	    make -j8 install; make clean; \
	    ./configure -cuda -mpi $(ROLLCOMPILER); \
	    make -j8 install; make clean; \
	  fi \
	)
	
build:
	bzip2 -dc $(SOURCE_PKG) | tar xf -
	bzip2 -dc $(TOOLS_PKG) | tar xf -
	tar xzf $(GAMDUPDATES).$(TARBALL_POSTFIX)
	( \
	  $(MODULE_LOAD_CC); \
	  $(MODULE_LOAD_OPENMPI); \
	  export AMBERHOME=`pwd`/$(SOURCE_DIR); \
	  cd $${AMBERHOME}; pwd ; \
	  ./update_amber --update ; \
	  /bin/cp -rv ../$(GAMDUPDATES)/pmemd/* src/pmemd; pwd ; \
	  ./configure $(ROLLCOMPILER); \
	  make -j8 install;  make clean; \
	  ./configure -mpi $(ROLLCOMPILER); \
	  make -j8 install; make clean; \
	  if test -e $(CUDAHOME); then \
	    module load cuda; \
	    export CUDA_HOME=/opt/cuda; \
	    echo "Using CUDA from $(CUDAHOME)"; \
	    ./configure -cuda $(ROLLCOMPILER); \
	    make -j8 install; make clean; \
	    ./configure -cuda -mpi $(ROLLCOMPILER); \
	    make -j8 install; make clean; \
	  fi \
	)

install::
	mkdir -p -m 754 $(ROOT)/$(PKGROOT)/src
	cp $(SOURCE_DIR)/src/config.h $(ROOT)/$(PKGROOT)/src/
	cp -r $(SOURCE_DIR)/bin $(SOURCE_DIR)/dat $(SOURCE_DIR)/include $(ROOT)/$(PKGROOT)
	rm -rf $(ROOT)/$(PKGROOT)/bin/FEW.pl
	cp $(SOURCE_DIR)/$(TOOLS_NAME)/src/FEW/FEW.pl  $(ROOT)/$(PKGROOT)/bin
	cp -r $(SOURCE_DIR)/share $(SOURCE_DIR)/lib  $(ROOT)/$(PKGROOT)
	(cd $(ROOT)/$(PKGROOT); ln -s lib lib64)

clean::
	rm -rf $(SOURCE_DIR)
	rm -rf $(GAMDUPDATES)
