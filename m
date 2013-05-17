From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/8] s390/kvm: Mark if a cpu is in SIE
Date: Fri, 17 May 2013 14:41:34 +0200
Message-ID: <1368794498-2051-5-git-send-email-borntraeger@de.ibm.com>
References: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Lets track in a private bit if the sie control block is active.
We want to track this as closely as possible, so we also have to
instrument the interrupt and program check handler. Lets use the
existing HANDLE_SIE_INTERCEPT macro.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  5 ++++-
 arch/s390/kernel/asm-offsets.c   |  2 ++
 arch/s390/kernel/entry64.S       | 10 +++++++---
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 16bd5d1..962b92e 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -68,7 +68,10 @@ struct sca_block {
 struct kvm_s390_sie_block {
 	atomic_t cpuflags;		/* 0x0000 */
 	__u32	prefix;			/* 0x0004 */
-	__u8	reserved8[32];		/* 0x0008 */
+	__u8	reserved08[4];		/* 0x0008 */
+#define PROG_IN_SIE (1<<0)
+	__u32	prog0c;			/* 0x000c */
+	__u8	reserved10[24];		/* 0x0010 */
 	__u64	cputm;			/* 0x0028 */
 	__u64	ckc;			/* 0x0030 */
 	__u64	epoch;			/* 0x0038 */
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index 7a82f9f..6456bbe 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -7,6 +7,7 @@
 #define ASM_OFFSETS_C
 
 #include <linux/kbuild.h>
+#include <linux/kvm_host.h>
 #include <linux/sched.h>
 #include <asm/cputime.h>
 #include <asm/vdso.h>
@@ -161,6 +162,7 @@ int main(void)
 	DEFINE(__LC_PGM_TDB, offsetof(struct _lowcore, pgm_tdb));
 	DEFINE(__THREAD_trap_tdb, offsetof(struct task_struct, thread.trap_tdb));
 	DEFINE(__GMAP_ASCE, offsetof(struct gmap, asce));
+	DEFINE(__SIE_PROG0C, offsetof(struct kvm_s390_sie_block, prog0c));
 #endif /* CONFIG_32BIT */
 	return 0;
 }
diff --git a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
index 4c17eec..c2e81b4 100644
--- a/arch/s390/kernel/entry64.S
+++ b/arch/s390/kernel/entry64.S
@@ -84,7 +84,7 @@ _TIF_EXIT_SIE = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_MCCK_PENDING)
 	.macro	HANDLE_SIE_INTERCEPT scratch,pgmcheck
 #if defined(CONFIG_KVM) || defined(CONFIG_KVM_MODULE)
 	tmhh	%r8,0x0001		# interrupting from user ?
-	jnz	.+42
+	jnz	.+52
 	lgr	\scratch,%r9
 	slg	\scratch,BASED(.Lsie_loop)
 	clg	\scratch,BASED(.Lsie_length)
@@ -92,12 +92,14 @@ _TIF_EXIT_SIE = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_MCCK_PENDING)
 	# Some program interrupts are suppressing (e.g. protection).
 	# We must also check the instruction after SIE in that case.
 	# do_protection_exception will rewind to rewind_pad
-	jh	.+22
+	jh	.+32
 	.else
-	jhe	.+22
+	jhe	.+32
 	.endif
 	lg	%r9,BASED(.Lsie_loop)
 	LPP	BASED(.Lhost_id)	# set host id
+	lg	%r14,__SF_EMPTY(%r15)	# get control block pointer
+	ni	__SIE_PROG0C+3(%r14),0xfe	# no longer in SIE
 #endif
 	.endm
 
@@ -956,10 +958,12 @@ sie_loop:
 	lctlg	%c1,%c1,__GMAP_ASCE(%r14)	# load primary asce
 sie_gmap:
 	lg	%r14,__SF_EMPTY(%r15)		# get control block pointer
+	oi	__SIE_PROG0C+3(%r14),1		# we are in SIE now
 	LPP	__SF_EMPTY(%r15)		# set guest id
 	sie	0(%r14)
 sie_done:
 	LPP	__SF_EMPTY+16(%r15)		# set host id
+	ni	__SIE_PROG0C+3(%r14),0xfe	# no longer in SIE
 	lg	%r14,__LC_THREAD_INFO		# pointer thread_info struct
 sie_exit:
 	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
-- 
1.8.1.4
