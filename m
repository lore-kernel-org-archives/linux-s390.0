Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 12 Mar 2017 08:27:09 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.11-rc2/rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170312082709.3ac98bf1@mschwideX1>
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

* Four patches to get the new cputime code in shape for s390

* Add the new statx system call

* A few bug fixes

Heiko Carstens (2):
      s390/ipl: always use load normal for CCW-type re-IPL
      s390: wire up statx system call

Janosch Frank (1):
      KVM: s390: Fix guest migration for huge guests resulting in panic

Martin Schwidefsky (6):
      s390/crypt: fix missing unlock in ctr_paes_crypt on error path
      s390: fix in-kernel program checks
      s390/cputime: remove last traces of cputime_t
      s390/cputime: reset all accounting fields on fork
      s390/cputime: provide archicture specific cputime_to_nsecs
      s390/timex: micro optimization for tod_to_ns

 arch/s390/crypto/paes_s390.c        |  5 ++++-
 arch/s390/include/asm/cputime.h     | 20 ++++++++------------
 arch/s390/include/asm/timex.h       | 12 ++++--------
 arch/s390/include/uapi/asm/unistd.h |  4 +++-
 arch/s390/kernel/compat_wrapper.c   |  1 +
 arch/s390/kernel/entry.S            | 10 +++++-----
 arch/s390/kernel/ipl.c              |  2 ++
 arch/s390/kernel/process.c          |  3 +++
 arch/s390/kernel/syscalls.S         |  2 ++
 arch/s390/kernel/vtime.c            |  2 +-
 arch/s390/mm/pgtable.c              | 19 ++++++++++++++++++-
 11 files changed, 51 insertions(+), 29 deletions(-)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index d69ea49..716b172 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -474,8 +474,11 @@ static int ctr_paes_crypt(struct blkcipher_desc *desc, unsigned long modifier,
 			ret = blkcipher_walk_done(desc, walk, nbytes - n);
 		}
 		if (k < n) {
-			if (__ctr_paes_set_key(ctx) != 0)
+			if (__ctr_paes_set_key(ctx) != 0) {
+				if (locked)
+					spin_unlock(&ctrblk_lock);
 				return blkcipher_walk_done(desc, walk, -EIO);
+			}
 		}
 	}
 	if (locked)
diff --git a/arch/s390/include/asm/cputime.h b/arch/s390/include/asm/cputime.h
index d1c407d..9072bf6 100644
--- a/arch/s390/include/asm/cputime.h
+++ b/arch/s390/include/asm/cputime.h
@@ -8,31 +8,27 @@
 #define _S390_CPUTIME_H
 
 #include <linux/types.h>
-#include <asm/div64.h>
+#include <asm/timex.h>
 
 #define CPUTIME_PER_USEC 4096ULL
 #define CPUTIME_PER_SEC (CPUTIME_PER_USEC * USEC_PER_SEC)
 
 /* We want to use full resolution of the CPU timer: 2**-12 micro-seconds. */
 
-typedef unsigned long long __nocast cputime_t;
-typedef unsigned long long __nocast cputime64_t;
-
 #define cmpxchg_cputime(ptr, old, new) cmpxchg64(ptr, old, new)
 
-static inline unsigned long __div(unsigned long long n, unsigned long base)
-{
-	return n / base;
-}
-
 /*
- * Convert cputime to microseconds and back.
+ * Convert cputime to microseconds.
  */
-static inline unsigned int cputime_to_usecs(const cputime_t cputime)
+static inline u64 cputime_to_usecs(const u64 cputime)
 {
-	return (__force unsigned long long) cputime >> 12;
+	return cputime >> 12;
 }
 
+/*
+ * Convert cputime to nanoseconds.
+ */
+#define cputime_to_nsecs(cputime) tod_to_ns(cputime)
 
 u64 arch_cpu_idle_time(int cpu);
 
diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index 354344d..1185351 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -206,20 +206,16 @@ static inline unsigned long long get_tod_clock_monotonic(void)
  *    ns = (todval * 125) >> 9;
  *
  * In order to avoid an overflow with the multiplication we can rewrite this.
- * With a split todval == 2^32 * th + tl (th upper 32 bits, tl lower 32 bits)
+ * With a split todval == 2^9 * th + tl (th upper 55 bits, tl lower 9 bits)
  * we end up with
  *
- *    ns = ((2^32 * th + tl) * 125 ) >> 9;
- * -> ns = (2^23 * th * 125) + ((tl * 125) >> 9);
+ *    ns = ((2^9 * th + tl) * 125 ) >> 9;
+ * -> ns = (th * 125) + ((tl * 125) >> 9);
  *
  */
 static inline unsigned long long tod_to_ns(unsigned long long todval)
 {
-	unsigned long long ns;
-
-	ns = ((todval >> 32) << 23) * 125;
-	ns += ((todval & 0xffffffff) * 125) >> 9;
-	return ns;
+	return ((todval >> 9) * 125) + (((todval & 0x1ff) * 125) >> 9);
 }
 
 #endif
diff --git a/arch/s390/include/uapi/asm/unistd.h b/arch/s390/include/uapi/asm/unistd.h
index 4384bc7..152de9b 100644
--- a/arch/s390/include/uapi/asm/unistd.h
+++ b/arch/s390/include/uapi/asm/unistd.h
@@ -313,7 +313,9 @@
 #define __NR_copy_file_range	375
 #define __NR_preadv2		376
 #define __NR_pwritev2		377
-#define NR_syscalls 378
+/* Number 378 is reserved for guarded storage */
+#define __NR_statx		379
+#define NR_syscalls 380
 
 /* 
  * There are some system calls that are not present on 64 bit, some
diff --git a/arch/s390/kernel/compat_wrapper.c b/arch/s390/kernel/compat_wrapper.c
index ae2cda5..e89cc2e 100644
--- a/arch/s390/kernel/compat_wrapper.c
+++ b/arch/s390/kernel/compat_wrapper.c
@@ -178,3 +178,4 @@ COMPAT_SYSCALL_WRAP3(getpeername, int, fd, struct sockaddr __user *, usockaddr,
 COMPAT_SYSCALL_WRAP6(sendto, int, fd, void __user *, buff, size_t, len, unsigned int, flags, struct sockaddr __user *, addr, int, addr_len);
 COMPAT_SYSCALL_WRAP3(mlock2, unsigned long, start, size_t, len, int, flags);
 COMPAT_SYSCALL_WRAP6(copy_file_range, int, fd_in, loff_t __user *, off_in, int, fd_out, loff_t __user *, off_out, size_t, len, unsigned int, flags);
+COMPAT_SYSCALL_WRAP5(statx, int, dfd, const char __user *, path, unsigned, flags, unsigned, mask, struct statx __user *, buffer);
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index dff2152..6a7d737 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -490,7 +490,7 @@ ENTRY(pgm_check_handler)
 	jnz	.Lpgm_svcper		# -> single stepped svc
 1:	CHECK_STACK STACK_SIZE,__LC_SAVE_AREA_SYNC
 	aghi	%r15,-(STACK_FRAME_OVERHEAD + __PT_SIZE)
-	j	3f
+	j	4f
 2:	UPDATE_VTIME %r14,%r15,__LC_SYNC_ENTER_TIMER
 	lg	%r15,__LC_KERNEL_STACK
 	lgr	%r14,%r12
@@ -499,8 +499,8 @@ ENTRY(pgm_check_handler)
 	tm	__LC_PGM_ILC+2,0x02	# check for transaction abort
 	jz	3f
 	mvc	__THREAD_trap_tdb(256,%r14),0(%r13)
-3:	la	%r11,STACK_FRAME_OVERHEAD(%r15)
-	stg	%r10,__THREAD_last_break(%r14)
+3:	stg	%r10,__THREAD_last_break(%r14)
+4:	la	%r11,STACK_FRAME_OVERHEAD(%r15)
 	stmg	%r0,%r7,__PT_R0(%r11)
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_SYNC
 	stmg	%r8,%r9,__PT_PSW(%r11)
@@ -509,14 +509,14 @@ ENTRY(pgm_check_handler)
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
 	stg	%r10,__PT_ARGS(%r11)
 	tm	__LC_PGM_ILC+3,0x80	# check for per exception
-	jz	4f
+	jz	5f
 	tmhh	%r8,0x0001		# kernel per event ?
 	jz	.Lpgm_kprobe
 	oi	__PT_FLAGS+7(%r11),_PIF_PER_TRAP
 	mvc	__THREAD_per_address(8,%r14),__LC_PER_ADDRESS
 	mvc	__THREAD_per_cause(2,%r14),__LC_PER_CODE
 	mvc	__THREAD_per_paid(1,%r14),__LC_PER_ACCESS_ID
-4:	REENABLE_IRQS
+5:	REENABLE_IRQS
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	larl	%r1,pgm_check_table
 	llgh	%r10,__PT_INT_CODE+2(%r11)
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index b67dafb..e545ffe 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -564,6 +564,8 @@ static struct kset *ipl_kset;
 
 static void __ipl_run(void *unused)
 {
+	if (MACHINE_IS_LPAR && ipl_info.type == IPL_TYPE_CCW)
+		diag308(DIAG308_LOAD_NORMAL_DUMP, NULL);
 	diag308(DIAG308_LOAD_CLEAR, NULL);
 	if (MACHINE_IS_VM)
 		__cpcmd("IPL", NULL, 0, NULL);
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 5428166..249deaf 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -121,7 +121,10 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long new_stackp,
 	clear_tsk_thread_flag(p, TIF_SINGLE_STEP);
 	/* Initialize per thread user and system timer values */
 	p->thread.user_timer = 0;
+	p->thread.guest_timer = 0;
 	p->thread.system_timer = 0;
+	p->thread.hardirq_timer = 0;
+	p->thread.softirq_timer = 0;
 
 	frame->sf.back_chain = 0;
 	/* new return point is ret_from_fork */
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index 9b59e62..2659b5c 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -386,3 +386,5 @@ SYSCALL(sys_mlock2,compat_sys_mlock2)
 SYSCALL(sys_copy_file_range,compat_sys_copy_file_range) /* 375 */
 SYSCALL(sys_preadv2,compat_sys_preadv2)
 SYSCALL(sys_pwritev2,compat_sys_pwritev2)
+NI_SYSCALL
+SYSCALL(sys_statx,compat_sys_statx)
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 31bd96e..8f5f59a 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -111,7 +111,7 @@ static inline u64 scale_vtime(u64 vtime)
 }
 
 static void account_system_index_scaled(struct task_struct *p,
-					cputime_t cputime, cputime_t scaled,
+					u64 cputime, u64 scaled,
 					enum cpu_usage_stat index)
 {
 	p->stimescaled += cputime_to_nsecs(scaled);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index b48dc5f..463e5ef 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -608,12 +608,29 @@ void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 bool test_and_clear_guest_dirty(struct mm_struct *mm, unsigned long addr)
 {
 	spinlock_t *ptl;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
 	pgste_t pgste;
 	pte_t *ptep;
 	pte_t pte;
 	bool dirty;
 
-	ptep = get_locked_pte(mm, addr, &ptl);
+	pgd = pgd_offset(mm, addr);
+	pud = pud_alloc(mm, pgd, addr);
+	if (!pud)
+		return false;
+	pmd = pmd_alloc(mm, pud, addr);
+	if (!pmd)
+		return false;
+	/* We can't run guests backed by huge pages, but userspace can
+	 * still set them up and then try to migrate them without any
+	 * migration support.
+	 */
+	if (pmd_large(*pmd))
+		return true;
+
+	ptep = pte_alloc_map_lock(mm, pmd, addr, &ptl);
 	if (unlikely(!ptep))
 		return false;
 
