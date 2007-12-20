Return-Path: <linux-kernel-owner+w=401wt.eu-S933981AbXLTPV7@vger.kernel.org>
Message-Id: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:25 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/47] s390 2.6.25 patch queue.
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is my set of patches in the queue for the next upstream merge
window. Most of them are bug fixes and small changes. The last three
patches are big and introduce an interesting new feature: hyper PAV.
Similar to the existing PAV support in the dasd driver the new
hyper PAV support allows to start multiple channel programs on a
single dasd device. The major difference is that the old style PAV
support uses static alias devices while the hyper PAV code uses
dynamic alias devices. The shortlog:

Christian Borntraeger (2):
      [S390] Change vmalloc defintions
      [S390] vmemmap: allocate struct pages before 1:1 mapping

Cornelia Huck (9):
      [S390] cio: Use helpers instead of container_of().
      [S390] cio: css_driver: Use consistent parameters.
      [S390] cio: Reset sch->driver.
      [S390] cio: Add css_driver_{register,unregister}.
      [S390] cio: Cleanup debug feature usage.
      [S390] cio: Introduce subchannel->private.
      [S390] cio: I/O subchannel specific fields.
      [S390] cio: Use dev_{g,s}et_drvdata().
      [S390] cio: Set driver->owner on css, ccw and ccwgroup busses.

Denis Cheng (1):
      [S390] use LIST_HEAD instead of LIST_HEAD_INIT

Heiko Carstens (10):
      [S390] Standby cpu activation/deactivation.
      [S390] sclp: convert channel path configure code to use sync interface.
      [S390] Print kernel version in dump_stack() and show_regs().
      [S390] Get rid of HOLES_IN_ZONE requirement.
      [S390] DEBUG_PAGEALLOC support for s390.
      [S390] Remove owner_pc member from raw_spinlock_t.
      [S390] Use new style spinlock initializer in __RWSEM_INITIALIZER.
      [S390] Get rid of additional_cpus kernel parameter.
      [S390] Remove appldata include from sysctl_check.c
      [S390] Allocate and free cpu lowcores and stacks when needed/possible.

Jan Glauber (1):
      [S390] crypto: move s390 Kconfig options.

Joe Perches (5):
      [S390] arch/s390: Add missing "space"
      [S390] drivers/s390: Add missing "space"
      [S390] arch/s390/: Spelling fixes
      [S390] include/asm-s390/: Spelling fixes
      [S390] drivers/s390/: Spelling fixes

Martin Schwidefsky (3):
      [S390] Optimize reference bit handling.
      [S390] Fix tlb flushing with idte.
      [S390] Move NOTES and BUG_TABLE.

Michael Ernst (1):
      [S390] sclp: sysfs interface for SCLP cpi

Michael Holzheu (4):
      [S390] kernel: Shutdown Actions Interface
      [S390] Load disabled wait psw instead of stopping cpu on halt.
      [S390] Initialize sclp_ipl_info
      [S390] Use diag308 subcodes 3 and 6 for reboot and dump when possible.

Peter Oberparleiter (2):
      [S390] cio: Extend adapter interrupt interface.
      [S390] cio: reduce cpu utilization during device scan

Roland McGrath (1):
      [S390] single-step cleanup

Sebastian Ott (3):
      [S390] Cleanup in Documentation/kernel-parameters.txt.
      [S390] cio: Dump ccw device information in case of timeout.
      [S390] qdio: Remove double checked value.

Stefan Haberland (1):
      [S390] dasd: fix return value of dasd_generic_probe()

Stefan Weinhuber (3):
      [S390] dasd: add hyper PAV support to DASD device driver, part 1
      [S390] dasd: add hyper PAV support to DASD device driver, part 2
      [S390] dasd: add hyper PAV support to DASD device driver, part 3

Ursula Braun (1):
      [S390] qdio: set QDIO_ACTIVATE_TIMEOUT to 5s

Have fun and merry xmas.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
