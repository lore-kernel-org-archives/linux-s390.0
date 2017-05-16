Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 16 May 2017 07:44:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.12-rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170516074429.296be4d9@mschwideX1>
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

 * Convert the debug feature to refcount_t

 * Reduce the copy size for strncpy_from_user

 * 8 bug fixes

Elena Reshetova (1):
      s390: convert debug_info.ref_count from atomic_t to refcount_t

Heiko Carstens (8):
      s390/ftrace: fix compile for !MODULES
      s390/uprobes: fix compile for !KPROBES
      s390/uaccess: use sane length for __strncpy_from_user()
      s390/topology: let topology_mnest_limit() return unsigned char
      s390/ccwgroup: increase string buffer size
      s390/qdio: increase string buffer size
      s390: move _text symbol to address higher than zero
      s390/virtio: change virtio_feature_desc:features type to __le32

Martin Schwidefsky (1):
      s390/cputime: fix incorrect system time

 arch/s390/include/asm/debug.h    |  3 ++-
 arch/s390/include/asm/dis.h      |  2 ++
 arch/s390/include/asm/kprobes.h  | 20 ++++++++++----------
 arch/s390/include/asm/sysinfo.h  |  2 +-
 arch/s390/kernel/debug.c         |  8 ++++----
 arch/s390/kernel/entry.S         | 21 ++++++++++++++++++---
 arch/s390/kernel/ftrace.c        |  4 ++++
 arch/s390/kernel/vmlinux.lds.S   |  8 +++++++-
 arch/s390/lib/probes.c           |  1 +
 arch/s390/lib/uaccess.c          |  4 ++--
 drivers/s390/cio/ccwgroup.c      |  4 ++--
 drivers/s390/cio/qdio_debug.h    |  2 +-
 drivers/s390/virtio/virtio_ccw.c |  2 +-
 13 files changed, 55 insertions(+), 26 deletions(-)

diff --git a/arch/s390/include/asm/debug.h b/arch/s390/include/asm/debug.h
index 0206c80..df7b54e 100644
--- a/arch/s390/include/asm/debug.h
+++ b/arch/s390/include/asm/debug.h
@@ -10,6 +10,7 @@
 #include <linux/spinlock.h>
 #include <linux/kernel.h>
 #include <linux/time.h>
+#include <linux/refcount.h>
 #include <uapi/asm/debug.h>
 
 #define DEBUG_MAX_LEVEL            6  /* debug levels range from 0 to 6 */
@@ -31,7 +32,7 @@ struct debug_view;
 typedef struct debug_info {	
 	struct debug_info* next;
 	struct debug_info* prev;
-	atomic_t ref_count;
+	refcount_t ref_count;
 	spinlock_t lock;			
 	int level;
 	int nr_areas;
diff --git a/arch/s390/include/asm/dis.h b/arch/s390/include/asm/dis.h
index 60323c2..37f617d 100644
--- a/arch/s390/include/asm/dis.h
+++ b/arch/s390/include/asm/dis.h
@@ -40,6 +40,8 @@ static inline int insn_length(unsigned char code)
 	return ((((int) code + 64) >> 7) + 1) << 1;
 }
 
+struct pt_regs;
+
 void show_code(struct pt_regs *regs);
 void print_fn_code(unsigned char *code, unsigned long len);
 int insn_to_mnemonic(unsigned char *instruction, char *buf, unsigned int len);
diff --git a/arch/s390/include/asm/kprobes.h b/arch/s390/include/asm/kprobes.h
index 1293c40..28792ef 100644
--- a/arch/s390/include/asm/kprobes.h
+++ b/arch/s390/include/asm/kprobes.h
@@ -27,12 +27,21 @@
  * 2005-Dec	Used as a template for s390 by Mike Grundy
  *		<grundym@us.ibm.com>
  */
+#include <linux/types.h>
 #include <asm-generic/kprobes.h>
 
 #define BREAKPOINT_INSTRUCTION	0x0002
 
+#define FIXUP_PSW_NORMAL	0x08
+#define FIXUP_BRANCH_NOT_TAKEN	0x04
+#define FIXUP_RETURN_REGISTER	0x02
+#define FIXUP_NOT_REQUIRED	0x01
+
+int probe_is_prohibited_opcode(u16 *insn);
+int probe_get_fixup_type(u16 *insn);
+int probe_is_insn_relative_long(u16 *insn);
+
 #ifdef CONFIG_KPROBES
-#include <linux/types.h>
 #include <linux/ptrace.h>
 #include <linux/percpu.h>
 #include <linux/sched/task_stack.h>
@@ -56,11 +65,6 @@ typedef u16 kprobe_opcode_t;
 
 #define KPROBE_SWAP_INST	0x10
 
-#define FIXUP_PSW_NORMAL	0x08
-#define FIXUP_BRANCH_NOT_TAKEN	0x04
-#define FIXUP_RETURN_REGISTER	0x02
-#define FIXUP_NOT_REQUIRED	0x01
-
 /* Architecture specific copy of original instruction */
 struct arch_specific_insn {
 	/* copy of original instruction */
@@ -90,10 +94,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 int kprobe_exceptions_notify(struct notifier_block *self,
 	unsigned long val, void *data);
 
-int probe_is_prohibited_opcode(u16 *insn);
-int probe_get_fixup_type(u16 *insn);
-int probe_is_insn_relative_long(u16 *insn);
-
 #define flush_insn_slot(p)	do { } while (0)
 
 #endif /* CONFIG_KPROBES */
diff --git a/arch/s390/include/asm/sysinfo.h b/arch/s390/include/asm/sysinfo.h
index 73bff45..e784bed 100644
--- a/arch/s390/include/asm/sysinfo.h
+++ b/arch/s390/include/asm/sysinfo.h
@@ -146,7 +146,7 @@ extern int topology_max_mnest;
  * Returns the maximum nesting level supported by the cpu topology code.
  * The current maximum level is 4 which is the drawer level.
  */
-static inline int topology_mnest_limit(void)
+static inline unsigned char topology_mnest_limit(void)
 {
 	return min(topology_max_mnest, 4);
 }
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 530226b..86b3e74 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -277,7 +277,7 @@ debug_info_alloc(const char *name, int pages_per_area, int nr_areas,
 	memset(rc->views, 0, DEBUG_MAX_VIEWS * sizeof(struct debug_view *));
 	memset(rc->debugfs_entries, 0 ,DEBUG_MAX_VIEWS *
 		sizeof(struct dentry*));
-	atomic_set(&(rc->ref_count), 0);
+	refcount_set(&(rc->ref_count), 0);
 
 	return rc;
 
@@ -361,7 +361,7 @@ debug_info_create(const char *name, int pages_per_area, int nr_areas,
         debug_area_last = rc;
         rc->next = NULL;
 
-	debug_info_get(rc);
+	refcount_set(&rc->ref_count, 1);
 out:
 	return rc;
 }
@@ -416,7 +416,7 @@ static void
 debug_info_get(debug_info_t * db_info)
 {
 	if (db_info)
-		atomic_inc(&db_info->ref_count);
+		refcount_inc(&db_info->ref_count);
 }
 
 /*
@@ -431,7 +431,7 @@ debug_info_put(debug_info_t *db_info)
 
 	if (!db_info)
 		return;
-	if (atomic_dec_and_test(&db_info->ref_count)) {
+	if (refcount_dec_and_test(&db_info->ref_count)) {
 		for (i = 0; i < DEBUG_MAX_VIEWS; i++) {
 			if (!db_info->views[i])
 				continue;
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index a5f5d3b..e408d9c 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -312,6 +312,7 @@ ENTRY(system_call)
 	lg	%r14,__LC_VDSO_PER_CPU
 	lmg	%r0,%r10,__PT_R0(%r11)
 	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r11)
+.Lsysc_exit_timer:
 	stpt	__LC_EXIT_TIMER
 	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
 	lmg	%r11,%r15,__PT_R11(%r11)
@@ -623,6 +624,7 @@ ENTRY(io_int_handler)
 	lg	%r14,__LC_VDSO_PER_CPU
 	lmg	%r0,%r10,__PT_R0(%r11)
 	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r11)
+.Lio_exit_timer:
 	stpt	__LC_EXIT_TIMER
 	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
 	lmg	%r11,%r15,__PT_R11(%r11)
@@ -1174,15 +1176,23 @@ cleanup_critical:
 	br	%r14
 
 .Lcleanup_sysc_restore:
+	# check if stpt has been executed
 	clg	%r9,BASED(.Lcleanup_sysc_restore_insn)
+	jh	0f
+	mvc	__LC_EXIT_TIMER(8),__LC_ASYNC_ENTER_TIMER
+	cghi	%r11,__LC_SAVE_AREA_ASYNC
 	je	0f
+	mvc	__LC_EXIT_TIMER(8),__LC_MCCK_ENTER_TIMER
+0:	clg	%r9,BASED(.Lcleanup_sysc_restore_insn+8)
+	je	1f
 	lg	%r9,24(%r11)		# get saved pointer to pt_regs
 	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r9)
 	mvc	0(64,%r11),__PT_R8(%r9)
 	lmg	%r0,%r7,__PT_R0(%r9)
-0:	lmg	%r8,%r9,__LC_RETURN_PSW
+1:	lmg	%r8,%r9,__LC_RETURN_PSW
 	br	%r14
 .Lcleanup_sysc_restore_insn:
+	.quad	.Lsysc_exit_timer
 	.quad	.Lsysc_done - 4
 
 .Lcleanup_io_tif:
@@ -1190,15 +1200,20 @@ cleanup_critical:
 	br	%r14
 
 .Lcleanup_io_restore:
+	# check if stpt has been executed
 	clg	%r9,BASED(.Lcleanup_io_restore_insn)
-	je	0f
+	jh	0f
+	mvc	__LC_EXIT_TIMER(8),__LC_MCCK_ENTER_TIMER
+0:	clg	%r9,BASED(.Lcleanup_io_restore_insn+8)
+	je	1f
 	lg	%r9,24(%r11)		# get saved r11 pointer to pt_regs
 	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r9)
 	mvc	0(64,%r11),__PT_R8(%r9)
 	lmg	%r0,%r7,__PT_R0(%r9)
-0:	lmg	%r8,%r9,__LC_RETURN_PSW
+1:	lmg	%r8,%r9,__LC_RETURN_PSW
 	br	%r14
 .Lcleanup_io_restore_insn:
+	.quad	.Lio_exit_timer
 	.quad	.Lio_done - 4
 
 .Lcleanup_idle:
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index 60a8a4e..68f2b8a 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -172,6 +172,8 @@ int __init ftrace_dyn_arch_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_MODULES
+
 static int __init ftrace_plt_init(void)
 {
 	unsigned int *ip;
@@ -190,6 +192,8 @@ static int __init ftrace_plt_init(void)
 }
 device_initcall(ftrace_plt_init);
 
+#endif /* CONFIG_MODULES */
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 /*
  * Hook the return address and push it in the stack of return addresses
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 72307f1..6e2c42b 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -31,8 +31,14 @@ SECTIONS
 {
 	. = 0x00000000;
 	.text : {
-	_text = .;		/* Text and read-only data */
+		/* Text and read-only data */
 		HEAD_TEXT
+		/*
+		 * E.g. perf doesn't like symbols starting at address zero,
+		 * therefore skip the initial PSW and channel program located
+		 * at address zero and let _text start at 0x200.
+		 */
+	_text = 0x200;
 		TEXT_TEXT
 		SCHED_TEXT
 		CPUIDLE_TEXT
diff --git a/arch/s390/lib/probes.c b/arch/s390/lib/probes.c
index ae90e1a..1963ddb 100644
--- a/arch/s390/lib/probes.c
+++ b/arch/s390/lib/probes.c
@@ -4,6 +4,7 @@
  *    Copyright IBM Corp. 2014
  */
 
+#include <linux/errno.h>
 #include <asm/kprobes.h>
 #include <asm/dis.h>
 
diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
index 1e5bb2b..b3bd3f2 100644
--- a/arch/s390/lib/uaccess.c
+++ b/arch/s390/lib/uaccess.c
@@ -337,8 +337,8 @@ long __strncpy_from_user(char *dst, const char __user *src, long size)
 		return 0;
 	done = 0;
 	do {
-		offset = (size_t)src & ~PAGE_MASK;
-		len = min(size - done, PAGE_SIZE - offset);
+		offset = (size_t)src & (L1_CACHE_BYTES - 1);
+		len = min(size - done, L1_CACHE_BYTES - offset);
 		if (copy_from_user(dst, src, len))
 			return -EFAULT;
 		len_str = strnlen(dst, len);
diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index e443b0d..34b9ad6 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -35,7 +35,7 @@ static struct bus_type ccwgroup_bus_type;
 static void __ccwgroup_remove_symlinks(struct ccwgroup_device *gdev)
 {
 	int i;
-	char str[8];
+	char str[16];
 
 	for (i = 0; i < gdev->count; i++) {
 		sprintf(str, "cdev%d", i);
@@ -238,7 +238,7 @@ static void ccwgroup_release(struct device *dev)
 
 static int __ccwgroup_create_symlinks(struct ccwgroup_device *gdev)
 {
-	char str[8];
+	char str[16];
 	int i, rc;
 
 	for (i = 0; i < gdev->count; i++) {
diff --git a/drivers/s390/cio/qdio_debug.h b/drivers/s390/cio/qdio_debug.h
index f33ce85..1d595d1 100644
--- a/drivers/s390/cio/qdio_debug.h
+++ b/drivers/s390/cio/qdio_debug.h
@@ -11,7 +11,7 @@
 #include "qdio.h"
 
 /* that gives us 15 characters in the text event views */
-#define QDIO_DBF_LEN	16
+#define QDIO_DBF_LEN	32
 
 extern debug_info_t *qdio_dbf_setup;
 extern debug_info_t *qdio_dbf_error;
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 0ed209f..c7d4ef7 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -87,7 +87,7 @@ struct vq_info_block {
 } __packed;
 
 struct virtio_feature_desc {
-	__u32 features;
+	__le32 features;
 	__u8 index;
 } __packed;
 
