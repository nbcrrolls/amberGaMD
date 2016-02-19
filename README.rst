.. hightlight:: rst

AMBER Roll
================
AMBER Molecular Dynamics

.. contents::

Introduction
--------------
This roll installs AMBER tools. 
There are 4 flavors compiled for each compiler (gnu, intel): ::

    serial,
    mpi
    cuda
    cuda mpi

Downloads
-----------
Amber is a licensed software. Get licensed files for AMBAER and AmberTools from 
amber roll and  put source files in ``src/amber``.
Download GaMD patches (provided by developer Yinglong Miao): :: 

     amber14_GaMD_patch_confidential.txt  
     amber14-gamd-updates-20160104.tgz  
 
Building the roll
------------------
**Dependencies**

- The ``mpi`` roll must be installed on the build/install host. 
  depends on mpi libraries. 
- The ``cuda`` roll must be installed on build/install host . In the absence of cuda, edit 
  ``src/amber/Makefile``  targets to remove cuda-specific compilation.
- The roll sources assumes that modulefiles provided by ``intel``, ``cuda`` and ``mpi``
  rolls are available.

The roll uses ``openmpi`` compiled with ``gnu`` compiler for ``eth`` fabric. 
To make a roll use the following command: ::

    # make ROLLCOMPILER='gnu' ROLLMPI='openmpi'  ROLLNETWORK='eth' 2>&1 | tee build.log

or simply ::

    # make  2>&1 | tee build.log

A successful build will create the file ``amberGaMD-*.disk1.iso``.  

Installing
-------------

To install, execute these instructions on a Rocks frontend: ::

    # rocks add roll amberGaMD*.iso
    # rocks enable roll amberGaMD
    # (cd /export/rocks/install; rocks create distro)
    # rocks run roll amberGaMD > add-amberGaMD.sh
    # bash add-amberGaMD.sh
    
Rebuild the compute nodes or :: 

    # rocks run host compute "yum clean all; yum install amberGaMD-gnu-eth amberGaMD-module-gnu-eth"


What is installed
-------------------

The roll installs GaMD patched amber14 (AmberTools15)  and environment module files in: ::

    /opt/amberGaMD/gnu - compiled with GNU
    /opt/modulefiles/applications/amberGaMD<VERSION> - environment modules


Building GaMD version of roll
-----------------------------

For Sep 2015 workshop  buid `amberGaMD` roll based on a received patch for amber14 source 
Create the following changes to the amber roll source: ::

       modified:   src/amber-modules/amber.module.in
       modified:   src/amber-modules/version.mk
       modified:   src/amber/Makefile
       modified:   src/amber/version.mk
       modified:   version.mk

       replace in graphs/default: amber.xml with amberGaMD.xml
       replace in nodes: amber-common.xml.in with amberGaMD-common.xml.in

       add a GaMD patch/distro to src/amber/ (patch received via email from author, source )

