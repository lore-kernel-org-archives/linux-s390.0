From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 05 Dec 2018 15:39:12 +0000
Subject: [kvm-unit-tests PATCH v2 0/6] 390x: Add cross hypervisor and disk boot
Message-Id: <20181205153918.29480-1-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

With these patches kvm unit tests are now bootable under LPAR and
z/VM, as well as from KVM disks. Don't forget to convert the ELF files
to binary via:

objcopy -O binary s390x/test.elf test.bin

For this to work we added:
    * Initial PSW in lowcore
    * Switch to 64 bit and z/Arch
    * SCLP linemode console

This is an early version, linemode currently splits lines a bit too
often and I still need to polish comments and cleanup code.


v2:
	* Moved cleanup to the front and broadened patch
	* Split up SCLP patch into interrupt and linemode
	* Removed unneeded instructions
	* Improved comments and commit messages

Janosch Frank (6):
  s390x: Cleanup sclp-ascii.c and add sigp order definitions
  s390x: Make tests bootable from disk
  s390x: Switch to z/Arch if needed
  s390x: Add BSS clearing for non ELF boot
  s390x: Use interrupts in SCLP
  s390x: Add linemode console

 lib/s390x/asm/arch_def.h  |  19 ++++
 lib/s390x/asm/interrupt.h |   2 +
 lib/s390x/interrupt.c     |  12 ++-
 lib/s390x/io.c            |   5 +-
 lib/s390x/sclp-ascii.c    |  68 ---------------
 lib/s390x/sclp-console.c  | 214 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/s390x/sclp.c          |  42 +++++++++
 lib/s390x/sclp.h          |  73 +++++++++++++++-
 s390x/Makefile            |   2 +-
 s390x/cstart64.S          |  40 ++++++++-
 s390x/flat.lds            |  10 ++-
 11 files changed, 409 insertions(+), 78 deletions(-)
 delete mode 100644 lib/s390x/sclp-ascii.c
 create mode 100644 lib/s390x/sclp-console.c

-- 
2.14.3
