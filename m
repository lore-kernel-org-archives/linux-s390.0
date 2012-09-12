From: Fengguang Wu <fengguang.wu@intel.com>
Date: Wed, 12 Sep 2012 11:03:47 +0000
Subject: arch/s390/kernel/ptrace.c:63:4: warning: left shift count >= width of type
Message-Id: <20120912110347.GB6170@localhost>
To: linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

FYI, a new compile warning in linux-next:

arch/s390/kernel/ptrace.c:63:4: warning: left shift count >= width of type [enabled by default]

vim +63 arch/s390/kernel/ptrace.c
    56		/* Take care of the enable/disable of transactional execution. */
    57		if (MACHINE_HAS_TE) {
    58			unsigned long cr0, cr0_new;
    59	
    60			__ctl_store(cr0, 0, 0);
    61			/* set or clear transaction execution bits 8 and 9. */
    62			if (task->thread.per_flags & PER_FLAG_NO_TE)
  > 63				cr0_new = cr0 & ~(3UL << 54);
    64			else
    65				cr0_new = cr0 | (3UL << 54);
    66			/* Only load control register 0 if necessary. */
    67			if (cr0 != cr0_new)
    68				__ctl_load(cr0_new, 0, 0);
    69		}

---
0-DAY kernel build testing backend         Open Source Technology Centre
Fengguang Wu <wfg@linux.intel.com>                     Intel Corporation
