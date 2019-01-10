From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 10 Jan 2019 15:41:40 +0000
Subject: [kvm-unit-tests PATCH v5 00/11] s390x: Add cross hypervisor and disk boot
Message-Id: <20190110154151.24233-1-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

With these patches kvm unit tests are now bootable under LPAR and
z/VM, as well as from KVM disks.

For this to work we added:
    * Initial PSW in lowcore
    * Switch to 64 bit and z/Arch
    * SCLP linemode console
    * Binary generation in Makefile

v5:
	* Cleaned up linemode
	* Minor fixups and squash of sclp int and lock patches
	* Removed time patches, added phys alloc setup

v4:
	* Added sigp header file
	* Moved clearing to xgr instead of lm
	* Minor renames, comment additions

v3:
	* Rebased on David's SCLP fixes
	* Added binary generation make command
	* Split up cleanup and sclp common movement
	* Fixed whitespace problems
	* Added more comments
	* Added linemode buffer to get rid of line splits

v2:
	* Moved cleanup to the front and broadened patch
	* Split up SCLP patch into interrupt and linemode
	* Removed unneeded instructions
	* Improved comments and commit messages

Janosch Frank (11):
  s390x: Add Sigp header file
  s390x: Rename and cleanup sclp-ascii.c
  s390x: Make tests bootable from disk
  s390x: Switch to z/Arch and enable 64 bit addressing mode
  s390x: Add BSS clearing for non ELF boot
  s390x: Move common sclp data and functions to sclp.c
  s390x: Use interrupts in SCLP and add locking
  s390x: Add linemode console
  s390x: Add binary generation to makefile
  s390x: Add linemode buffer to fix newline on every print
  s390x: Initialize the physical allocator on mem init

 lib/s390x/asm/arch_def.h  |   1 +
 lib/s390x/asm/interrupt.h |   2 +
 lib/s390x/asm/sigp.h      |  60 +++++++++++++
 lib/s390x/interrupt.c     |  12 ++-
 lib/s390x/io.c            |  13 +--
 lib/s390x/sclp-ascii.c    |  68 --------------
 lib/s390x/sclp-console.c  | 225 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/s390x/sclp.c          |  83 ++++++++++++++++-
 lib/s390x/sclp.h          |  62 ++++++++++++-
 s390x/Makefile            |  11 ++-
 s390x/cstart64.S          |  41 ++++++++-
 s390x/flat.lds            |  15 +++-
 12 files changed, 500 insertions(+), 93 deletions(-)
 create mode 100644 lib/s390x/asm/sigp.h
 delete mode 100644 lib/s390x/sclp-ascii.c
 create mode 100644 lib/s390x/sclp-console.c

-- 
2.14.3
