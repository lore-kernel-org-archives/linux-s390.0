From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 18/23] arm64: ilp32: add sys_ilp32.c and a separate table (in entry.S) to use it
Date: Tue, 24 May 2016 03:04:47 +0300
Message-ID: <1464048292-30136-19-git-send-email-ynorov@caviumnetworks.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, Andrew Pinski <apinski@cavium.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
List-ID: <linux-s390.vger.kernel.org>

From: Andrew Pinski <apinski@cavium.com>

Add a separate syscall-table for ILP32, which dispatches either to native
LP64 system call implementation or to compat-syscalls, as appropriate.

Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/unistd.h | 11 +++++-
 arch/arm64/kernel/Makefile      |  2 +-
 arch/arm64/kernel/entry.S       | 10 ++++-
 arch/arm64/kernel/sys_ilp32.c   | 83 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/kernel/sys_ilp32.c

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 2971dea..5ea18ef 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -13,9 +13,18 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+
+#ifdef CONFIG_COMPAT
+#define __ARCH_WANT_COMPAT_STAT64
+#endif
+
+#ifdef CONFIG_ARM64_ILP32
+#define __ARCH_WANT_COMPAT_SYS_PREADV64
+#define __ARCH_WANT_COMPAT_SYS_PWRITEV64
+#endif
+
 #ifdef CONFIG_AARCH32_EL0
 #define __ARCH_WANT_COMPAT_SYS_GETDENTS64
-#define __ARCH_WANT_COMPAT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_GETPGRP
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 9dfdf86..7aa65ea 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -28,7 +28,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o		\
 					   ../../arm/kernel/opcodes.o binfmt_elf32.o
-arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o
+arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o sys_ilp32.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 21a0624..acea2cb 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -501,6 +501,7 @@ el0_svc_compat:
 	 * AArch32 syscall handling
 	 */
 	adrp	stbl, compat_sys_call_table	// load compat syscall table pointer
+	ldr     x16, [tsk, #TI_FLAGS]
 	uxtw	scno, w7			// syscall number in w7 (r7)
 	mov     sc_nr, #__NR_compat_syscalls
 	b	el0_svc_naked
@@ -717,15 +718,20 @@ ENDPROC(ret_from_fork)
 	.align	6
 el0_svc:
 	adrp	stbl, sys_call_table		// load syscall table pointer
+	ldr	x16, [tsk, #TI_FLAGS]
 	uxtw	scno, w8			// syscall number in w8
 	mov	sc_nr, #__NR_syscalls
+#ifdef CONFIG_ARM64_ILP32
+	adrp	x17, sys_call_ilp32_table	// load ilp32 syscall table pointer
+	tst	x16, #_TIF_32BIT_AARCH64
+	csel    stbl, stbl, x17, eq		// We are using ILP32
+#endif
 el0_svc_naked:					// compat entry point
 	stp	x0, scno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
 	enable_dbg_and_irq
 	ct_user_exit 1
 
-	ldr	x16, [tsk, #TI_FLAGS]		// check for syscall hooks
-	tst	x16, #_TIF_SYSCALL_WORK
+	tst	x16, #_TIF_SYSCALL_WORK		// check for syscall hooks
 	b.ne	__sys_trace
 	cmp     scno, sc_nr                     // check upper syscall limit
 	b.hs	ni_sys
diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
new file mode 100644
index 0000000..d4cd2a9
--- /dev/null
+++ b/arch/arm64/kernel/sys_ilp32.c
@@ -0,0 +1,83 @@
+/*
+ * AArch64- ILP32 specific system calls implementation
+ *
+ * Copyright (C) 2016 Cavium Inc.
+ * Author: Andrew Pinski <apinski@cavium.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define __SYSCALL_COMPAT
+
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/msg.h>
+#include <linux/export.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/compat.h>
+#include <asm-generic/syscalls.h>
+
+/* Using non-compat syscalls where necessary */
+#define compat_sys_fadvise64_64		sys_fadvise64_64
+#define compat_sys_fallocate		sys_fallocate
+#define compat_sys_ftruncate64		sys_ftruncate
+#define compat_sys_lookup_dcookie	sys_lookup_dcookie
+#define compat_sys_readahead		sys_readahead
+#define compat_sys_shmat		sys_shmat
+#define compat_sys_sync_file_range	sys_sync_file_range
+#define compat_sys_truncate64		sys_truncate
+#define sys_llseek			sys_lseek
+#define sys_mmap2			compat_sys_mmap2
+
+static unsigned long compat_sys_mmap2(compat_uptr_t addr, compat_size_t len,
+       int prot, int flags, int fd, off_t pgoff)
+{
+       if (pgoff & (~PAGE_MASK >> 12))
+               return -EINVAL;
+
+       return sys_mmap_pgoff(addr, len, prot, flags, fd,
+		       pgoff >> (PAGE_SHIFT - 12));
+}
+
+static unsigned long compat_sys_pread64(unsigned int fd,
+		compat_uptr_t __user *ubuf, compat_size_t count, off_t offset)
+{
+	return sys_pread64(fd, (char *) ubuf, count, offset);
+}
+
+static unsigned long compat_sys_pwrite64(unsigned int fd,
+		compat_uptr_t __user *ubuf, compat_size_t count, off_t offset)
+{
+	return sys_pwrite64(fd, (char *) ubuf, count, offset);
+}
+
+#include <asm/syscall.h>
+
+#undef __SYSCALL
+#undef __SC_WRAP
+
+#define __SYSCALL(nr, sym)	[nr] = sym,
+#define __SC_WRAP(nr, sym)	[nr] = compat_##sym,
+
+/*
+ * The sys_call_ilp32_table array must be 4K aligned to be accessible from
+ * kernel/entry.S.
+ */
+void *sys_call_ilp32_table[__NR_syscalls] __aligned(4096) = {
+	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+#include <asm/unistd.h>
+};
-- 
2.5.0
