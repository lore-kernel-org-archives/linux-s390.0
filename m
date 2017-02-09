Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 1/3] s390: kernel: Audit and remove any unnecessary uses of module.h
Date: Thu, 9 Feb 2017 15:20:23 -0500
Message-ID: <20170209202025.8713-2-paul.gortmaker@windriver.com>
In-Reply-To: <20170209202025.8713-1-paul.gortmaker@windriver.com>
References: <20170209202025.8713-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Historically a lot of these existed because we did not have
a distinction between what was modular code and what was providing
support to modules via EXPORT_SYMBOL and friends.  That changed
when we forked out support for the latter into the export.h file.

This means we should be able to reduce the usage of module.h
in code that is obj-y Makefile or bool Kconfig.  The advantage
in doing so is that module.h itself sources about 15 other headers;
adding significantly to what we feed cpp, and it can obscure what
headers we are effectively using.

Since module.h was the source for init.h (for __init) and for
export.h (for EXPORT_SYMBOL) we consider each change instance
for the presence of either and replace as needed.  Build testing
revealed some implicit header usage that was fixed up accordingly.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/s390/kernel/compat_linux.c | 1 -
 arch/s390/kernel/cpcmd.c        | 2 +-
 arch/s390/kernel/crash_dump.c   | 3 ++-
 arch/s390/kernel/debug.c        | 2 +-
 arch/s390/kernel/diag.c         | 3 ++-
 arch/s390/kernel/dis.c          | 2 +-
 arch/s390/kernel/ebcdic.c       | 4 ++--
 arch/s390/kernel/ipl.c          | 3 ++-
 arch/s390/kernel/irq.c          | 3 ++-
 arch/s390/kernel/jump_label.c   | 1 -
 arch/s390/kernel/nmi.c          | 2 +-
 arch/s390/kernel/process.c      | 2 +-
 arch/s390/kernel/smp.c          | 2 +-
 arch/s390/kernel/stacktrace.c   | 2 +-
 arch/s390/kernel/sysinfo.c      | 2 +-
 arch/s390/kernel/time.c         | 2 +-
 arch/s390/kernel/vdso.c         | 2 +-
 17 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 96df4547377a..a3d14161abcb 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -28,7 +28,6 @@
 #include <linux/shm.h>
 #include <linux/uio.h>
 #include <linux/quota.h>
-#include <linux/module.h>
 #include <linux/poll.h>
 #include <linux/personality.h>
 #include <linux/stat.h>
diff --git a/arch/s390/kernel/cpcmd.c b/arch/s390/kernel/cpcmd.c
index 7f48e568ac64..9f0e4a2785f7 100644
--- a/arch/s390/kernel/cpcmd.c
+++ b/arch/s390/kernel/cpcmd.c
@@ -9,7 +9,7 @@
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 9c9440dc253a..d49715398e47 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -8,7 +8,8 @@
 #include <linux/crash_dump.h>
 #include <asm/lowcore.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/mm.h>
 #include <linux/gfp.h>
 #include <linux/slab.h>
 #include <linux/bootmem.h>
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 20a5a4286368..530226b6cb19 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -20,7 +20,7 @@
 #include <linux/string.h>
 #include <linux/sysctl.h>
 #include <linux/uaccess.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/debugfs.h>
diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
index a97354c8c667..ac6abcd3fe6a 100644
--- a/arch/s390/kernel/diag.c
+++ b/arch/s390/kernel/diag.c
@@ -5,7 +5,8 @@
  * Author(s): Michael Holzheu <holzheu@de.ibm.com>
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
+#include <linux/init.h>
 #include <linux/cpu.h>
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
index 9f017cf417f6..f7e82302a71e 100644
--- a/arch/s390/kernel/dis.c
+++ b/arch/s390/kernel/dis.c
@@ -16,7 +16,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/kallsyms.h>
 #include <linux/reboot.h>
 #include <linux/kprobes.h>
diff --git a/arch/s390/kernel/ebcdic.c b/arch/s390/kernel/ebcdic.c
index b971c6be6298..1d5392b36ad8 100644
--- a/arch/s390/kernel/ebcdic.c
+++ b/arch/s390/kernel/ebcdic.c
@@ -8,8 +8,8 @@
  *               Martin Peschke <peschke@fh-brandenburg.de>
  */
 
-#include <linux/module.h>
-#include <asm/types.h>
+#include <linux/types.h>
+#include <linux/export.h>
 #include <asm/ebcdic.h>
 
 /*
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 5b91308f6117..b67dafb7b7cf 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -8,7 +8,8 @@
  */
 
 #include <linux/types.h>
-#include <linux/module.h>
+#include <linux/export.h>
+#include <linux/init.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index ef60f4177331..6dca93b29bed 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -12,11 +12,12 @@
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 #include <linux/profile.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/ftrace.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
+#include <linux/init.h>
 #include <linux/cpu.h>
 #include <linux/irq.h>
 #include <asm/irq_regs.h>
diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
index 083b05f5f5ab..6aa630a8d24f 100644
--- a/arch/s390/kernel/jump_label.c
+++ b/arch/s390/kernel/jump_label.c
@@ -4,7 +4,6 @@
  * Copyright IBM Corp. 2011
  * Author(s): Jan Glauber <jang@linux.vnet.ibm.com>
  */
-#include <linux/module.h>
 #include <linux/uaccess.h>
 #include <linux/stop_machine.h>
 #include <linux/jump_label.h>
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index 9862196b4b89..56e14d073167 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -13,7 +13,7 @@
 #include <linux/errno.h>
 #include <linux/hardirq.h>
 #include <linux/time.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <asm/lowcore.h>
 #include <asm/smp.h>
 #include <asm/stp.h>
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 400d14f0b9f5..c5b86b4a1a8b 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -23,7 +23,7 @@
 #include <linux/compat.h>
 #include <linux/kprobes.h>
 #include <linux/random.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/init_task.h>
 #include <asm/io.h>
 #include <asm/processor.h>
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index e49f61aadaf9..d0a74d7ce433 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -20,7 +20,7 @@
 
 #include <linux/workqueue.h>
 #include <linux/bootmem.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/err.h>
diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
index 355db9db8210..0085b2d8ed7d 100644
--- a/arch/s390/kernel/stacktrace.c
+++ b/arch/s390/kernel/stacktrace.c
@@ -8,7 +8,7 @@
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
 #include <linux/kallsyms.h>
-#include <linux/module.h>
+#include <linux/export.h>
 
 static int __save_address(void *data, unsigned long address, int nosched)
 {
diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
index 24021c1e3ecb..12b6b138e354 100644
--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -10,7 +10,7 @@
 #include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <asm/ebcdic.h>
 #include <asm/sysinfo.h>
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 546e513a0271..de66abb479c9 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -16,7 +16,7 @@
 
 #include <linux/kernel_stat.h>
 #include <linux/errno.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/param.h>
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 5904abf6b1ae..10516ae3b55e 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -9,7 +9,7 @@
  * as published by the Free Software Foundation.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
-- 
2.11.0
