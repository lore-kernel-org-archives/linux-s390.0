From: Philipp Rudo <prudo@linux.ibm.com>
Date: Wed, 25 Jul 2018 11:36:10 +0000
Subject: [PATCH 0/5] s390-tools: Add install script for zfcpdump
Message-Id: <20180725113615.93755-1-prudo@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi everybody

currently every distro handles the zfcpdump kernel differently. However,
with systemd (>= 203) there is a general script (kernel-install) available
for kernel installs. This script allows the execution of drop-in scripts to
deal with specific aspects of the kernel installation.  Add such a drop-in
script to s390-tools to allow unifying zfcpdump kernel handling among the
distros and simplifying the interaction between zipl and zfcpdump.

At the moment the script is only generated but not installed to allow
distros to decide if/where they want to install it.

Before the script is added some minor cleanups are made regarding zfcpdump
related macros. The goal here is to reduce unnecessary macro definitions and
to unify the naming in zfcpdump and zipl.

Thanks
Philipp


Philipp Rudo (5):
  zfcpdump: Remove unused macros
  zipl: Rename FSDUMP_PART_* macros
  Makefile: Rename ZFCPDUMP_PART_* macros
  zipl: Move macro definition to Makefile
  zfcpdump: Add install script for zfcpdump

 .gitignore                      |   3 +-
 common.mak                      |   7 +--
 zfcpdump/10-zfcpdump.install.in | 114 ++++++++++++++++++++++++++++++++++++++++
 zfcpdump/Makefile               |  22 +++++---
 zipl/include/zipl.h             |   7 ---
 zipl/src/Makefile               |   7 +--
 zipl/src/job.c                  |  10 ++--
 7 files changed, 143 insertions(+), 27 deletions(-)
 create mode 100755 zfcpdump/10-zfcpdump.install.in

-- 
2.16.4
