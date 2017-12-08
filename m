Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 8 Dec 2017 17:27:06 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.15-rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20171208172706.180620c1@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

* Three more patches in regard to the SPDX license tags. The missing tags
  for the files in arch/s390/kvm will be merged via the KVM tree. With
  that all s390 related files should have their SPDX tags.

* A patch to get rid of 'struct timespec' in the DASD driver.

* Bug fixes.

Arnd Bergmann (1):
      s390/dasd: remove 'struct timespec' usage

Heiko Carstens (3):
      s390: always save and restore all registers on context switch
      s390/mm: fix off-by-one bug in 5-level page table handling
      s390: fix compat system call table

Julian Wiedmann (2):
      s390/qdio: consider ERROR buffers for inbound-full condition
      s390/qdio: restrict target-full handling to IQDIO

Martin Schwidefsky (2):
      s390: add a few more SPDX identifiers
      s390: Remove redudant license text

Michael S. Tsirkin (1):
      s390/virtio: add BSD license to virtio-ccw

Stefan Haberland (1):
      s390/dasd: prevent prefix I/O error

 arch/s390/Kbuild                        |  1 +
 arch/s390/appldata/Makefile             |  1 +
 arch/s390/boot/compressed/vmlinux.scr   |  1 +
 arch/s390/crypto/sha1_s390.c            |  7 +------
 arch/s390/hypfs/Makefile                |  1 +
 arch/s390/include/asm/Kbuild            |  1 +
 arch/s390/include/asm/alternative.h     |  1 +
 arch/s390/include/asm/ap.h              |  5 +----
 arch/s390/include/asm/bugs.h            |  1 +
 arch/s390/include/asm/segment.h         |  1 +
 arch/s390/include/asm/switch_to.h       | 27 +++++++++++++--------------
 arch/s390/include/asm/vga.h             |  1 +
 arch/s390/include/uapi/asm/Kbuild       |  1 +
 arch/s390/include/uapi/asm/perf_regs.h  |  1 +
 arch/s390/include/uapi/asm/sthyi.h      |  1 +
 arch/s390/include/uapi/asm/virtio-ccw.h |  2 +-
 arch/s390/include/uapi/asm/vmcp.h       |  1 +
 arch/s390/kernel/alternative.c          |  1 +
 arch/s390/kernel/perf_regs.c            |  1 +
 arch/s390/kernel/syscalls.S             |  6 +++---
 arch/s390/kernel/vdso64/note.S          |  1 +
 arch/s390/mm/pgalloc.c                  |  2 --
 arch/s390/net/Makefile                  |  1 +
 arch/s390/numa/Makefile                 |  1 +
 arch/s390/pci/Makefile                  |  1 +
 arch/s390/tools/gen_opcode_table.c      |  1 +
 drivers/s390/Makefile                   |  1 +
 drivers/s390/block/Kconfig              |  1 +
 drivers/s390/block/dasd.c               | 10 +++++-----
 drivers/s390/block/dasd_eckd.c          | 16 ++++++++++------
 drivers/s390/block/dasd_int.h           |  2 +-
 drivers/s390/char/Kconfig               |  1 +
 drivers/s390/char/defkeymap.map         |  1 +
 drivers/s390/cio/blacklist.h            |  1 +
 drivers/s390/cio/qdio_main.c            |  7 ++++---
 drivers/s390/net/Kconfig                |  1 +
 drivers/s390/scsi/Makefile              |  1 +
 37 files changed, 66 insertions(+), 45 deletions(-)

diff --git a/arch/s390/Kbuild b/arch/s390/Kbuild
index eae2c64..9fdff3f 100644
--- a/arch/s390/Kbuild
+++ b/arch/s390/Kbuild
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-y				+= kernel/
 obj-y				+= mm/
 obj-$(CONFIG_KVM)		+= kvm/
diff --git a/arch/s390/appldata/Makefile b/arch/s390/appldata/Makefile
index 99f1cf0..b06def4 100644
--- a/arch/s390/appldata/Makefile
+++ b/arch/s390/appldata/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the Linux - z/VM Monitor Stream.
 #
diff --git a/arch/s390/boot/compressed/vmlinux.scr b/arch/s390/boot/compressed/vmlinux.scr
index f02382a..42a2425 100644
--- a/arch/s390/boot/compressed/vmlinux.scr
+++ b/arch/s390/boot/compressed/vmlinux.scr
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 SECTIONS
 {
   .rodata.compressed : {
diff --git a/arch/s390/crypto/sha1_s390.c b/arch/s390/crypto/sha1_s390.c
index c7de53d..a00c17f 100644
--- a/arch/s390/crypto/sha1_s390.c
+++ b/arch/s390/crypto/sha1_s390.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Cryptographic API.
  *
@@ -16,12 +17,6 @@
  *   Copyright (c) Alan Smithee.
  *   Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>
  *   Copyright (c) Jean-Francois Dive <jef@linuxbe.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
  */
 #include <crypto/internal/hash.h>
 #include <linux/init.h>
diff --git a/arch/s390/hypfs/Makefile b/arch/s390/hypfs/Makefile
index 2ee25ba..06f6015 100644
--- a/arch/s390/hypfs/Makefile
+++ b/arch/s390/hypfs/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the linux hypfs filesystem routines.
 #
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 41c211a..0484508 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 generic-y += asm-offsets.h
 generic-y += cacheflush.h
 generic-y += clkdev.h
diff --git a/arch/s390/include/asm/alternative.h b/arch/s390/include/asm/alternative.h
index a720020..c2cf7bc 100644
--- a/arch/s390/include/asm/alternative.h
+++ b/arch/s390/include/asm/alternative.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_S390_ALTERNATIVE_H
 #define _ASM_S390_ALTERNATIVE_H
 
diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
index c02f4ab..cfce683 100644
--- a/arch/s390/include/asm/ap.h
+++ b/arch/s390/include/asm/ap.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Adjunct processor (AP) interfaces
  *
  * Copyright IBM Corp. 2017
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
  *	      Martin Schwidefsky <schwidefsky@de.ibm.com>
  *	      Harald Freudenberger <freude@de.ibm.com>
diff --git a/arch/s390/include/asm/bugs.h b/arch/s390/include/asm/bugs.h
index 0f5bd89..aa42a17 100644
--- a/arch/s390/include/asm/bugs.h
+++ b/arch/s390/include/asm/bugs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  S390 version
  *    Copyright IBM Corp. 1999
diff --git a/arch/s390/include/asm/segment.h b/arch/s390/include/asm/segment.h
index 8bfce34..97a0582b 100644
--- a/arch/s390/include/asm/segment.h
+++ b/arch/s390/include/asm/segment.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_SEGMENT_H
 #define _ASM_SEGMENT_H
 
diff --git a/arch/s390/include/asm/switch_to.h b/arch/s390/include/asm/switch_to.h
index ec7b476..c61b2cc 100644
--- a/arch/s390/include/asm/switch_to.h
+++ b/arch/s390/include/asm/switch_to.h
@@ -30,21 +30,20 @@ static inline void restore_access_regs(unsigned int *acrs)
 	asm volatile("lam 0,15,%0" : : "Q" (*(acrstype *)acrs));
 }
 
-#define switch_to(prev,next,last) do {					\
-	if (prev->mm) {							\
-		save_fpu_regs();					\
-		save_access_regs(&prev->thread.acrs[0]);		\
-		save_ri_cb(prev->thread.ri_cb);				\
-		save_gs_cb(prev->thread.gs_cb);				\
-	}								\
+#define switch_to(prev, next, last) do {				\
+	/* save_fpu_regs() sets the CIF_FPU flag, which enforces	\
+	 * a restore of the floating point / vector registers as	\
+	 * soon as the next task returns to user space			\
+	 */								\
+	save_fpu_regs();						\
+	save_access_regs(&prev->thread.acrs[0]);			\
+	save_ri_cb(prev->thread.ri_cb);					\
+	save_gs_cb(prev->thread.gs_cb);					\
 	update_cr_regs(next);						\
-	if (next->mm) {							\
-		set_cpu_flag(CIF_FPU);					\
-		restore_access_regs(&next->thread.acrs[0]);		\
-		restore_ri_cb(next->thread.ri_cb, prev->thread.ri_cb);	\
-		restore_gs_cb(next->thread.gs_cb);			\
-	}								\
-	prev = __switch_to(prev,next);					\
+	restore_access_regs(&next->thread.acrs[0]);			\
+	restore_ri_cb(next->thread.ri_cb, prev->thread.ri_cb);		\
+	restore_gs_cb(next->thread.gs_cb);				\
+	prev = __switch_to(prev, next);					\
 } while (0)
 
 #endif /* __ASM_SWITCH_TO_H */
diff --git a/arch/s390/include/asm/vga.h b/arch/s390/include/asm/vga.h
index d375526..605dc46 100644
--- a/arch/s390/include/asm/vga.h
+++ b/arch/s390/include/asm/vga.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_S390_VGA_H
 #define _ASM_S390_VGA_H
 
diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
index 098f287..92b7c9b 100644
--- a/arch/s390/include/uapi/asm/Kbuild
+++ b/arch/s390/include/uapi/asm/Kbuild
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
diff --git a/arch/s390/include/uapi/asm/perf_regs.h b/arch/s390/include/uapi/asm/perf_regs.h
index 7c8564f..d17dd9e 100644
--- a/arch/s390/include/uapi/asm/perf_regs.h
+++ b/arch/s390/include/uapi/asm/perf_regs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef _ASM_S390_PERF_REGS_H
 #define _ASM_S390_PERF_REGS_H
 
diff --git a/arch/s390/include/uapi/asm/sthyi.h b/arch/s390/include/uapi/asm/sthyi.h
index ec113db..b1b0223 100644
--- a/arch/s390/include/uapi/asm/sthyi.h
+++ b/arch/s390/include/uapi/asm/sthyi.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef _UAPI_ASM_STHYI_H
 #define _UAPI_ASM_STHYI_H
 
diff --git a/arch/s390/include/uapi/asm/virtio-ccw.h b/arch/s390/include/uapi/asm/virtio-ccw.h
index 3a77833c..2b605f7 100644
--- a/arch/s390/include/uapi/asm/virtio-ccw.h
+++ b/arch/s390/include/uapi/asm/virtio-ccw.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
  * Definitions for virtio-ccw devices.
  *
diff --git a/arch/s390/include/uapi/asm/vmcp.h b/arch/s390/include/uapi/asm/vmcp.h
index 4caf717..aeaaa03 100644
--- a/arch/s390/include/uapi/asm/vmcp.h
+++ b/arch/s390/include/uapi/asm/vmcp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * Copyright IBM Corp. 2004, 2005
  * Interface implementation for communication with the z/VM control program
diff --git a/arch/s390/kernel/alternative.c b/arch/s390/kernel/alternative.c
index 315986a..574e776 100644
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/module.h>
 #include <asm/alternative.h>
 #include <asm/facility.h>
diff --git a/arch/s390/kernel/perf_regs.c b/arch/s390/kernel/perf_regs.c
index f8603eb..54e2d63 100644
--- a/arch/s390/kernel/perf_regs.c
+++ b/arch/s390/kernel/perf_regs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/perf_event.h>
 #include <linux/perf_regs.h>
 #include <linux/kernel.h>
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index 308a7b6..f7fc633 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -370,10 +370,10 @@ SYSCALL(sys_recvmmsg,compat_sys_recvmmsg)
 SYSCALL(sys_sendmmsg,compat_sys_sendmmsg)
 SYSCALL(sys_socket,sys_socket)
 SYSCALL(sys_socketpair,compat_sys_socketpair)		/* 360 */
-SYSCALL(sys_bind,sys_bind)
-SYSCALL(sys_connect,sys_connect)
+SYSCALL(sys_bind,compat_sys_bind)
+SYSCALL(sys_connect,compat_sys_connect)
 SYSCALL(sys_listen,sys_listen)
-SYSCALL(sys_accept4,sys_accept4)
+SYSCALL(sys_accept4,compat_sys_accept4)
 SYSCALL(sys_getsockopt,compat_sys_getsockopt)		/* 365 */
 SYSCALL(sys_setsockopt,compat_sys_setsockopt)
 SYSCALL(sys_getsockname,compat_sys_getsockname)
diff --git a/arch/s390/kernel/vdso64/note.S b/arch/s390/kernel/vdso64/note.S
index 79a071e..db19d06 100644
--- a/arch/s390/kernel/vdso64/note.S
+++ b/arch/s390/kernel/vdso64/note.S
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * This supplies .note.* sections to go into the PT_NOTE inside the vDSO text.
  * Here we can supply some information useful to userland.
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 434a956..cb36415 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -83,8 +83,6 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 
 	/* upgrade should only happen from 3 to 4, 3 to 5, or 4 to 5 levels */
 	VM_BUG_ON(mm->context.asce_limit < _REGION2_SIZE);
-	if (end >= TASK_SIZE_MAX)
-		return -ENOMEM;
 	rc = 0;
 	notify = 0;
 	while (mm->context.asce_limit < end) {
diff --git a/arch/s390/net/Makefile b/arch/s390/net/Makefile
index 90568c3..e0d5f24 100644
--- a/arch/s390/net/Makefile
+++ b/arch/s390/net/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Arch-specific network modules
 #
diff --git a/arch/s390/numa/Makefile b/arch/s390/numa/Makefile
index f94ecaf..66c2dff 100644
--- a/arch/s390/numa/Makefile
+++ b/arch/s390/numa/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-y			+= numa.o
 obj-y			+= toptree.o
 obj-$(CONFIG_NUMA_EMU)	+= mode_emu.o
diff --git a/arch/s390/pci/Makefile b/arch/s390/pci/Makefile
index 805d8b2..22d0871 100644
--- a/arch/s390/pci/Makefile
+++ b/arch/s390/pci/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the s390 PCI subsystem.
 #
diff --git a/arch/s390/tools/gen_opcode_table.c b/arch/s390/tools/gen_opcode_table.c
index 01d4c5a..357d426 100644
--- a/arch/s390/tools/gen_opcode_table.c
+++ b/arch/s390/tools/gen_opcode_table.c
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Generate opcode table initializers for the in-kernel disassembler.
  *
diff --git a/drivers/s390/Makefile b/drivers/s390/Makefile
index e5225ad..2fdab40 100644
--- a/drivers/s390/Makefile
+++ b/drivers/s390/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the S/390 specific device drivers
 #
diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
index 31f014b..bc27d71 100644
--- a/drivers/s390/block/Kconfig
+++ b/drivers/s390/block/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 comment "S/390 block device drivers"
 	depends on S390 && BLOCK
 
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 66e008f..d4e8dff 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -759,7 +759,7 @@ static void dasd_profile_end_add_data(struct dasd_profile_info *data,
 	/* in case of an overflow, reset the whole profile */
 	if (data->dasd_io_reqs == UINT_MAX) {
 			memset(data, 0, sizeof(*data));
-			getnstimeofday(&data->starttod);
+			ktime_get_real_ts64(&data->starttod);
 	}
 	data->dasd_io_reqs++;
 	data->dasd_io_sects += sectors;
@@ -894,7 +894,7 @@ void dasd_profile_reset(struct dasd_profile *profile)
 		return;
 	}
 	memset(data, 0, sizeof(*data));
-	getnstimeofday(&data->starttod);
+	ktime_get_real_ts64(&data->starttod);
 	spin_unlock_bh(&profile->lock);
 }
 
@@ -911,7 +911,7 @@ int dasd_profile_on(struct dasd_profile *profile)
 		kfree(data);
 		return 0;
 	}
-	getnstimeofday(&data->starttod);
+	ktime_get_real_ts64(&data->starttod);
 	profile->data = data;
 	spin_unlock_bh(&profile->lock);
 	return 0;
@@ -995,8 +995,8 @@ static void dasd_stats_array(struct seq_file *m, unsigned int *array)
 static void dasd_stats_seq_print(struct seq_file *m,
 				 struct dasd_profile_info *data)
 {
-	seq_printf(m, "start_time %ld.%09ld\n",
-		   data->starttod.tv_sec, data->starttod.tv_nsec);
+	seq_printf(m, "start_time %lld.%09ld\n",
+		   (s64)data->starttod.tv_sec, data->starttod.tv_nsec);
 	seq_printf(m, "total_requests %u\n", data->dasd_io_reqs);
 	seq_printf(m, "total_sectors %u\n", data->dasd_io_sects);
 	seq_printf(m, "total_pav %u\n", data->dasd_io_alias);
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 1a41ef4..a2edf2a 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -531,10 +531,12 @@ static int prefix_LRE(struct ccw1 *ccw, struct PFX_eckd_data *pfxdata,
 	pfxdata->validity.define_extent = 1;
 
 	/* private uid is kept up to date, conf_data may be outdated */
-	if (startpriv->uid.type != UA_BASE_DEVICE) {
+	if (startpriv->uid.type == UA_BASE_PAV_ALIAS)
 		pfxdata->validity.verify_base = 1;
-		if (startpriv->uid.type == UA_HYPER_PAV_ALIAS)
-			pfxdata->validity.hyper_pav = 1;
+
+	if (startpriv->uid.type == UA_HYPER_PAV_ALIAS) {
+		pfxdata->validity.verify_base = 1;
+		pfxdata->validity.hyper_pav = 1;
 	}
 
 	rc = define_extent(NULL, dedata, trk, totrk, cmd, basedev, blksize);
@@ -3415,10 +3417,12 @@ static int prepare_itcw(struct itcw *itcw,
 	pfxdata.validity.define_extent = 1;
 
 	/* private uid is kept up to date, conf_data may be outdated */
-	if (startpriv->uid.type != UA_BASE_DEVICE) {
+	if (startpriv->uid.type == UA_BASE_PAV_ALIAS)
+		pfxdata.validity.verify_base = 1;
+
+	if (startpriv->uid.type == UA_HYPER_PAV_ALIAS) {
 		pfxdata.validity.verify_base = 1;
-		if (startpriv->uid.type == UA_HYPER_PAV_ALIAS)
-			pfxdata.validity.hyper_pav = 1;
+		pfxdata.validity.hyper_pav = 1;
 	}
 
 	switch (cmd) {
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index b095a23bc..96709b1 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -441,7 +441,7 @@ struct dasd_profile_info {
 	unsigned int dasd_io_nr_req[32]; /* hist. of # of requests in chanq */
 
 	/* new data */
-	struct timespec starttod;	   /* time of start or last reset */
+	struct timespec64 starttod;	   /* time of start or last reset */
 	unsigned int dasd_io_alias;	   /* requests using an alias */
 	unsigned int dasd_io_tpm;	   /* requests using transport mode */
 	unsigned int dasd_read_reqs;	   /* total number of read  requests */
diff --git a/drivers/s390/char/Kconfig b/drivers/s390/char/Kconfig
index 97c4c9f..ab0b243 100644
--- a/drivers/s390/char/Kconfig
+++ b/drivers/s390/char/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 comment "S/390 character device drivers"
 	depends on S390
 
diff --git a/drivers/s390/char/defkeymap.map b/drivers/s390/char/defkeymap.map
index 353b3f2..f4c0956 100644
--- a/drivers/s390/char/defkeymap.map
+++ b/drivers/s390/char/defkeymap.map
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 # Default keymap for 3270 (ebcdic codepage 037).
 keymaps 0-1,4-5
 
diff --git a/drivers/s390/cio/blacklist.h b/drivers/s390/cio/blacklist.h
index 95e25c1..140e3e4 100644
--- a/drivers/s390/cio/blacklist.h
+++ b/drivers/s390/cio/blacklist.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef S390_BLACKLIST_H
 #define S390_BLACKLIST_H
 
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 59b4a33..95b0efe 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -431,8 +431,8 @@ static void process_buffer_error(struct qdio_q *q, int count)
 	q->qdio_error = QDIO_ERROR_SLSB_STATE;
 
 	/* special handling for no target buffer empty */
-	if ((!q->is_input_q &&
-	    (q->sbal[q->first_to_check]->element[15].sflags) == 0x10)) {
+	if (queue_type(q) == QDIO_IQDIO_QFMT && !q->is_input_q &&
+	    q->sbal[q->first_to_check]->element[15].sflags == 0x10) {
 		qperf_inc(q, target_full);
 		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "OUTFULL FTC:%02x",
 			      q->first_to_check);
@@ -536,7 +536,8 @@ static int get_inbound_buffer_frontier(struct qdio_q *q)
 	case SLSB_P_INPUT_ERROR:
 		process_buffer_error(q, count);
 		q->first_to_check = add_buf(q->first_to_check, count);
-		atomic_sub(count, &q->nr_buf_used);
+		if (atomic_sub_return(count, &q->nr_buf_used) == 0)
+			qperf_inc(q, inbound_queue_full);
 		if (q->irq_ptr->perf_stat_enabled)
 			account_sbals_error(q, count);
 		break;
diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index b2837b1..a782a20 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 menu "S/390 network device drivers"
 	depends on NETDEVICES && S390
 
diff --git a/drivers/s390/scsi/Makefile b/drivers/s390/scsi/Makefile
index 9259039..9dda431 100644
--- a/drivers/s390/scsi/Makefile
+++ b/drivers/s390/scsi/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the S/390 specific device drivers
 #
