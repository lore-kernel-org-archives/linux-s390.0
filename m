Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 6 Jul 2018 08:58:40 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.18-rc4
Message-Id: <20180706085840.70f54926@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
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

A few more changes for v4.18:

 - Wire up the two new system calls io_pgetevents and rseq

 - Fix a register corruption in the expolines code for machines without EXRL

 - Drastically reduce the memory utilization of the dasd driver

 - Fix reference counting for KVM page table pages


Christian Borntraeger (1):
      s390: Correct register corruption in critical section cleanup

Eric Farman (1):
      s390/mm: fix refcount usage for 4K pgste

Heiko Carstens (2):
      s390: wire up io_pgetevents system call
      s390: wire up rseq system call

Stefan Haberland (1):
      s390/dasd: reduce the default queue depth and nr of hardware queues

 arch/s390/Kconfig                     |  1 +
 arch/s390/kernel/compat_wrapper.c     |  1 +
 arch/s390/kernel/entry.S              |  8 ++++++--
 arch/s390/kernel/signal.c             |  3 ++-
 arch/s390/kernel/syscalls/syscall.tbl |  2 ++
 arch/s390/mm/pgalloc.c                |  4 ++++
 drivers/s390/block/dasd.c             | 13 +++++++++++--
 drivers/s390/block/dasd_int.h         |  8 --------
 8 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index baed397..e44bb2b 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -160,6 +160,7 @@ config S390
 	select HAVE_OPROFILE
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select MODULES_USE_ELF_RELA
diff --git a/arch/s390/kernel/compat_wrapper.c b/arch/s390/kernel/compat_wrapper.c
index 607c5e9..2ce28bf 100644
--- a/arch/s390/kernel/compat_wrapper.c
+++ b/arch/s390/kernel/compat_wrapper.c
@@ -183,3 +183,4 @@ COMPAT_SYSCALL_WRAP2(s390_guarded_storage, int, command, struct gs_cb *, gs_cb);
 COMPAT_SYSCALL_WRAP5(statx, int, dfd, const char __user *, path, unsigned, flags, unsigned, mask, struct statx __user *, buffer);
 COMPAT_SYSCALL_WRAP4(s390_sthyi, unsigned long, code, void __user *, info, u64 __user *, rc, unsigned long, flags);
 COMPAT_SYSCALL_WRAP5(kexec_file_load, int, kernel_fd, int, initrd_fd, unsigned long, cmdline_len, const char __user *, cmdline_ptr, unsigned long, flags)
+COMPAT_SYSCALL_WRAP4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32, sig)
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index f03402e..150130c 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -357,6 +357,10 @@ ENTRY(system_call)
 	stg	%r2,__PT_R2(%r11)		# store return value
 
 .Lsysc_return:
+#ifdef CONFIG_DEBUG_RSEQ
+	lgr	%r2,%r11
+	brasl	%r14,rseq_syscall
+#endif
 	LOCKDEP_SYS_EXIT
 .Lsysc_tif:
 	TSTMSK	__PT_FLAGS(%r11),_PIF_WORK
@@ -1265,7 +1269,7 @@ cleanup_critical:
 	jl	0f
 	clg	%r9,BASED(.Lcleanup_table+104)	# .Lload_fpu_regs_end
 	jl	.Lcleanup_load_fpu_regs
-0:	BR_EX	%r14
+0:	BR_EX	%r14,%r11
 
 	.align	8
 .Lcleanup_table:
@@ -1301,7 +1305,7 @@ cleanup_critical:
 	ni	__SIE_PROG0C+3(%r9),0xfe	# no longer in SIE
 	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
 	larl	%r9,sie_exit			# skip forward to sie_exit
-	BR_EX	%r14
+	BR_EX	%r14,%r11
 #endif
 
 .Lcleanup_system_call:
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 2d2960a..22f0824 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -498,7 +498,7 @@ void do_signal(struct pt_regs *regs)
 		}
 		/* No longer in a system call */
 		clear_pt_regs_flag(regs, PIF_SYSCALL);
-
+		rseq_signal_deliver(&ksig, regs);
 		if (is_compat_task())
 			handle_signal32(&ksig, oldset, regs);
 		else
@@ -537,4 +537,5 @@ void do_notify_resume(struct pt_regs *regs)
 {
 	clear_thread_flag(TIF_NOTIFY_RESUME);
 	tracehook_notify_resume(regs);
+	rseq_handle_notify_resume(NULL, regs);
 }
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 8b210ea..022fc09 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -389,3 +389,5 @@
 379  common	statx			sys_statx			compat_sys_statx
 380  common	s390_sthyi		sys_s390_sthyi			compat_sys_s390_sthyi
 381  common	kexec_file_load		sys_kexec_file_load		compat_sys_kexec_file_load
+382  common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
+383  common	rseq			sys_rseq			compat_sys_rseq
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 84bd632..e3bd562 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -252,6 +252,8 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 		spin_unlock_bh(&mm->context.lock);
 		if (mask != 0)
 			return;
+	} else {
+		atomic_xor_bits(&page->_refcount, 3U << 24);
 	}
 
 	pgtable_page_dtor(page);
@@ -304,6 +306,8 @@ static void __tlb_remove_table(void *_table)
 			break;
 		/* fallthrough */
 	case 3:		/* 4K page table with pgstes */
+		if (mask & 3)
+			atomic_xor_bits(&page->_refcount, 3 << 24);
 		pgtable_page_dtor(page);
 		__free_page(page);
 		break;
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index d3a38c4..a9f60d0 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -41,6 +41,15 @@
 
 #define DASD_DIAG_MOD		"dasd_diag_mod"
 
+static unsigned int queue_depth = 32;
+static unsigned int nr_hw_queues = 4;
+
+module_param(queue_depth, uint, 0444);
+MODULE_PARM_DESC(queue_depth, "Default queue depth for new DASD devices");
+
+module_param(nr_hw_queues, uint, 0444);
+MODULE_PARM_DESC(nr_hw_queues, "Default number of hardware queues for new DASD devices");
+
 /*
  * SECTION: exported variables of dasd.c
  */
@@ -3115,8 +3124,8 @@ static int dasd_alloc_queue(struct dasd_block *block)
 
 	block->tag_set.ops = &dasd_mq_ops;
 	block->tag_set.cmd_size = sizeof(struct dasd_ccw_req);
-	block->tag_set.nr_hw_queues = DASD_NR_HW_QUEUES;
-	block->tag_set.queue_depth = DASD_MAX_LCU_DEV * DASD_REQ_PER_DEV;
+	block->tag_set.nr_hw_queues = nr_hw_queues;
+	block->tag_set.queue_depth = queue_depth;
 	block->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 
 	rc = blk_mq_alloc_tag_set(&block->tag_set);
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 976b6bd..de6b960 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -228,14 +228,6 @@ struct dasd_ccw_req {
 #define DASD_CQR_SUPPRESS_IL	6	/* Suppress 'Incorrect Length' error */
 #define DASD_CQR_SUPPRESS_CR	7	/* Suppress 'Command Reject' error */
 
-/*
- * There is no reliable way to determine the number of available CPUs on
- * LPAR but there is no big performance difference between 1 and the
- * maximum CPU number.
- * 64 is a good trade off performance wise.
- */
-#define DASD_NR_HW_QUEUES 64
-#define DASD_MAX_LCU_DEV 256
 #define DASD_REQ_PER_DEV 4
 
 /* Signature for error recovery functions. */
