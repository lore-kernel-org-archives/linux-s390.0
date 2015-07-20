Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 20 Jul 2015 17:02:14 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.2-rc4
Message-ID: <20150720170214.603b0de1@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Fast path fix for the thread_struct breakage.

Martin Schwidefsky (1):
      s390: adapt entry.S to the move of thread_struct

 arch/s390/kernel/asm-offsets.c | 15 +++++++--------
 arch/s390/kernel/entry.S       | 13 +++++++++----
 arch/s390/kernel/traps.c       |  4 ++--
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index c7d1b9d..a2da259 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -23,15 +23,15 @@
 
 int main(void)
 {
-	DEFINE(__THREAD_info, offsetof(struct task_struct, stack));
-	DEFINE(__THREAD_ksp, offsetof(struct task_struct, thread.ksp));
-	DEFINE(__THREAD_mm_segment, offsetof(struct task_struct, thread.mm_segment));
-	BLANK();
+	DEFINE(__TASK_thread_info, offsetof(struct task_struct, stack));
+	DEFINE(__TASK_thread, offsetof(struct task_struct, thread));
 	DEFINE(__TASK_pid, offsetof(struct task_struct, pid));
 	BLANK();
-	DEFINE(__THREAD_per_cause, offsetof(struct task_struct, thread.per_event.cause));
-	DEFINE(__THREAD_per_address, offsetof(struct task_struct, thread.per_event.address));
-	DEFINE(__THREAD_per_paid, offsetof(struct task_struct, thread.per_event.paid));
+	DEFINE(__THREAD_ksp, offsetof(struct thread_struct, ksp));
+	DEFINE(__THREAD_per_cause, offsetof(struct thread_struct, per_event.cause));
+	DEFINE(__THREAD_per_address, offsetof(struct thread_struct, per_event.address));
+	DEFINE(__THREAD_per_paid, offsetof(struct thread_struct, per_event.paid));
+	DEFINE(__THREAD_trap_tdb, offsetof(struct thread_struct, trap_tdb));
 	BLANK();
 	DEFINE(__TI_task, offsetof(struct thread_info, task));
 	DEFINE(__TI_flags, offsetof(struct thread_info, flags));
@@ -176,7 +176,6 @@ int main(void)
 	DEFINE(__LC_VDSO_PER_CPU, offsetof(struct _lowcore, vdso_per_cpu_data));
 	DEFINE(__LC_GMAP, offsetof(struct _lowcore, gmap));
 	DEFINE(__LC_PGM_TDB, offsetof(struct _lowcore, pgm_tdb));
-	DEFINE(__THREAD_trap_tdb, offsetof(struct task_struct, thread.trap_tdb));
 	DEFINE(__GMAP_ASCE, offsetof(struct gmap, asce));
 	DEFINE(__SIE_PROG0C, offsetof(struct kvm_s390_sie_block, prog0c));
 	DEFINE(__SIE_PROG20, offsetof(struct kvm_s390_sie_block, prog20));
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 3238893..84062e7 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -178,17 +178,21 @@ _PIF_WORK	= (_PIF_PER_TRAP)
  */
 ENTRY(__switch_to)
 	stmg	%r6,%r15,__SF_GPRS(%r15)	# store gprs of prev task
-	stg	%r15,__THREAD_ksp(%r2)		# store kernel stack of prev
-	lg	%r4,__THREAD_info(%r2)		# get thread_info of prev
-	lg	%r5,__THREAD_info(%r3)		# get thread_info of next
+	lgr	%r1,%r2
+	aghi	%r1,__TASK_thread		# thread_struct of prev task
+	lg	%r4,__TASK_thread_info(%r2)	# get thread_info of prev
+	lg	%r5,__TASK_thread_info(%r3)	# get thread_info of next
+	stg	%r15,__THREAD_ksp(%r1)		# store kernel stack of prev
+	lgr	%r1,%r3
+	aghi	%r1,__TASK_thread		# thread_struct of next task
 	lgr	%r15,%r5
 	aghi	%r15,STACK_INIT			# end of kernel stack of next
 	stg	%r3,__LC_CURRENT		# store task struct of next
 	stg	%r5,__LC_THREAD_INFO		# store thread info of next
 	stg	%r15,__LC_KERNEL_STACK		# store end of kernel stack
+	lg	%r15,__THREAD_ksp(%r1)		# load kernel stack of next
 	lctl	%c4,%c4,__TASK_pid(%r3)		# load pid to control reg. 4
 	mvc	__LC_CURRENT_PID+4(4,%r0),__TASK_pid(%r3) # store pid of next
-	lg	%r15,__THREAD_ksp(%r3)		# load kernel stack of next
 	lmg	%r6,%r15,__SF_GPRS(%r15)	# load gprs of next task
 	br	%r14
 
@@ -417,6 +421,7 @@ ENTRY(pgm_check_handler)
 	LAST_BREAK %r14
 	lg	%r15,__LC_KERNEL_STACK
 	lg	%r14,__TI_task(%r12)
+	aghi	%r14,__TASK_thread	# pointer to thread_struct
 	lghi	%r13,__LC_PGM_TDB
 	tm	__LC_PGM_ILC+2,0x02	# check for transaction abort
 	jz	2f
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 4d96c9f..7bea81d 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -259,7 +259,7 @@ void vector_exception(struct pt_regs *regs)
 	}
 
 	/* get vector interrupt code from fpc */
-	asm volatile("stfpc %0" : "=m" (current->thread.fp_regs.fpc));
+	asm volatile("stfpc %0" : "=Q" (current->thread.fp_regs.fpc));
 	vic = (current->thread.fp_regs.fpc & 0xf00) >> 8;
 	switch (vic) {
 	case 1: /* invalid vector operation */
@@ -297,7 +297,7 @@ void data_exception(struct pt_regs *regs)
 
 	location = get_trap_ip(regs);
 
-	asm volatile("stfpc %0" : "=m" (current->thread.fp_regs.fpc));
+	asm volatile("stfpc %0" : "=Q" (current->thread.fp_regs.fpc));
 	/* Check for vector register enablement */
 	if (MACHINE_HAS_VX && !current->thread.vxrs &&
 	    (current->thread.fp_regs.fpc & FPC_DXC_MASK) == 0xfe00) {
