ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLNETWORK
  ROLLNETWORK = eth
endif

ifndef ROLLMPI
  ROLLMPI = openmpi
endif

# define dependent modules that will need to be loaded  with amber module
ADDCOMP = 
ifeq ("$(ROLLCOMPILER)", "intel")
  ADDCOMP = intel mkl
endif
PREREQMODULES = "$(ROLLMPI)-$(COMPILERNAME)-$(ROLLNETWORK) $(CUDA) $(ADDCOMP)"

VERSION.MK.MASTER = version.mk
VERSION.MK.MASTER.DIR = ../amber
VERSION.MK.INCLUDE = amber.version.mk
include $(VERSION.MK.INCLUDE) 

PACKAGE     = amberGaMD
CATEGORY    = applications
NAME        = amberGaMD-module-$(COMPILERNAME)-$(ROLLNETWORK)
RELEASE     = 0
PKGROOT     = /opt/modulefiles/$(CATEGORY)/$(PACKAGE)$(VERSION)

RPM.REQUIRES    = environment-modules

