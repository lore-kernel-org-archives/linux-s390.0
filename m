Return-Path: <linux-kernel-owner+w=401wt.eu-S1758486AbYD2OQO@vger.kernel.org>
Message-Id: <20080429140117.631962807@de.ibm.com>
Date: Tue, 29 Apr 2008 16:01:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/15] 2nd batch of s390 patches for 2.6.26
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The usual fixes and one new feature. After Andrew has forwarded
Gerald's hugetlbfs cleanup patches we can now add support for large
pages. The second interesting patch (well at least for us :-) is
Heiko's vmemmap sparsemem patch.

The shortlog:

Cornelia Huck (2):
      [S390] cio: Use strict_strtoul() for attributes.
      [S390] cio: Make isc handling more robust.

Gerald Schaefer (1):
      [S390] System z large page support.

Heiko Carstens (11):
      [S390] Move show_regs to traps.c.
      [S390] Add missing ifndef/define to include/asm-s390/sysinfo.h.
      [S390] smp: Fix locking order.
      [S390] Automatically detect added cpus.
      [S390] Add topology_core_siblings to topology.h
      [S390] cpu topology: Fix possible deadlock.
      [S390] uaccess_mvcos: #ifdef config dependent code.
      [S390] Move stfl to system.h and delete duplicated version.
      [S390] vmemmap: use clear_table to initialise page tables.
      [S390] Convert machine feature detection code to C.
      [S390] Convert to SPARSEMEM & SPARSEMEM_VMEMMAP

Mathieu Desnoyers (1):
      [S390] remove -traditional

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
