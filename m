Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41602 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728015AbgH2Kv2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 29 Aug 2020 06:51:28 -0400
Date: Sat, 29 Aug 2020 12:51:15 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.9-rc3
Message-ID: <your-ad-here.call-01598698275-ext-0854@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.9-rc3.

Thank you,
Vasily

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-4

for you to fetch changes up to bffc2f7aa96343f91931272d7a8a2d8d925e1ab2:

  s390/vmem: fix vmem_add_range for 4-level paging (2020-08-26 18:07:05 +0200)

----------------------------------------------------------------
s390 fixes for 5.9-rc3

- Disable preemption trace in percpu macros since the lockdep code itself
  uses percpu variables now and it causes recursions.

- Fix kernel space 4-level paging broken by recent vmem rework.

----------------------------------------------------------------
Sven Schnelle (1):
      s390: don't trace preemption in percpu macros

Vasily Gorbik (1):
      s390/vmem: fix vmem_add_range for 4-level paging

 arch/s390/include/asm/percpu.h | 28 ++++++++++++++--------------
 arch/s390/mm/vmem.c            |  1 +
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 50b4ce8cddfd..918f0ba4f4d2 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -29,7 +29,7 @@
 	typedef typeof(pcp) pcp_op_T__;					\
 	pcp_op_T__ old__, new__, prev__;				\
 	pcp_op_T__ *ptr__;						\
-	preempt_disable();						\
+	preempt_disable_notrace();					\
 	ptr__ = raw_cpu_ptr(&(pcp));					\
 	prev__ = *ptr__;						\
 	do {								\
@@ -37,7 +37,7 @@
 		new__ = old__ op (val);					\
 		prev__ = cmpxchg(ptr__, old__, new__);			\
 	} while (prev__ != old__);					\
-	preempt_enable();						\
+	preempt_enable_notrace();					\
 	new__;								\
 })
 
@@ -68,7 +68,7 @@
 	typedef typeof(pcp) pcp_op_T__; 				\
 	pcp_op_T__ val__ = (val);					\
 	pcp_op_T__ old__, *ptr__;					\
-	preempt_disable();						\
+	preempt_disable_notrace();					\
 	ptr__ = raw_cpu_ptr(&(pcp)); 				\
 	if (__builtin_constant_p(val__) &&				\
 	    ((szcast)val__ > -129) && ((szcast)val__ < 128)) {		\
@@ -84,7 +84,7 @@
 			: [val__] "d" (val__)				\
 			: "cc");					\
 	}								\
-	preempt_enable();						\
+	preempt_enable_notrace();					\
 }
 
 #define this_cpu_add_4(pcp, val) arch_this_cpu_add(pcp, val, "laa", "asi", int)
@@ -95,14 +95,14 @@
 	typedef typeof(pcp) pcp_op_T__; 				\
 	pcp_op_T__ val__ = (val);					\
 	pcp_op_T__ old__, *ptr__;					\
-	preempt_disable();						\
+	preempt_disable_notrace();					\
 	ptr__ = raw_cpu_ptr(&(pcp));	 				\
 	asm volatile(							\
 		op "    %[old__],%[val__],%[ptr__]\n"			\
 		: [old__] "=d" (old__), [ptr__] "+Q" (*ptr__)		\
 		: [val__] "d" (val__)					\
 		: "cc");						\
-	preempt_enable();						\
+	preempt_enable_notrace();						\
 	old__ + val__;							\
 })
 
@@ -114,14 +114,14 @@
 	typedef typeof(pcp) pcp_op_T__; 				\
 	pcp_op_T__ val__ = (val);					\
 	pcp_op_T__ old__, *ptr__;					\
-	preempt_disable();						\
+	preempt_disable_notrace();					\
 	ptr__ = raw_cpu_ptr(&(pcp));	 				\
 	asm volatile(							\
 		op "    %[old__],%[val__],%[ptr__]\n"			\
 		: [old__] "=d" (old__), [ptr__] "+Q" (*ptr__)		\
 		: [val__] "d" (val__)					\
 		: "cc");						\
-	preempt_enable();						\
+	preempt_enable_notrace();					\
 }
 
 #define this_cpu_and_4(pcp, val)	arch_this_cpu_to_op(pcp, val, "lan")
@@ -136,10 +136,10 @@
 	typedef typeof(pcp) pcp_op_T__;					\
 	pcp_op_T__ ret__;						\
 	pcp_op_T__ *ptr__;						\
-	preempt_disable();						\
+	preempt_disable_notrace();					\
 	ptr__ = raw_cpu_ptr(&(pcp));					\
 	ret__ = cmpxchg(ptr__, oval, nval);				\
-	preempt_enable();						\
+	preempt_enable_notrace();					\
 	ret__;								\
 })
 
@@ -152,10 +152,10 @@
 ({									\
 	typeof(pcp) *ptr__;						\
 	typeof(pcp) ret__;						\
-	preempt_disable();						\
+	preempt_disable_notrace();					\
 	ptr__ = raw_cpu_ptr(&(pcp));					\
 	ret__ = xchg(ptr__, nval);					\
-	preempt_enable();						\
+	preempt_enable_notrace();					\
 	ret__;								\
 })
 
@@ -171,11 +171,11 @@
 	typeof(pcp1) *p1__;						\
 	typeof(pcp2) *p2__;						\
 	int ret__;							\
-	preempt_disable();						\
+	preempt_disable_notrace();					\
 	p1__ = raw_cpu_ptr(&(pcp1));					\
 	p2__ = raw_cpu_ptr(&(pcp2));					\
 	ret__ = __cmpxchg_double(p1__, p2__, o1__, o2__, n1__, n2__);	\
-	preempt_enable();						\
+	preempt_enable_notrace();					\
 	ret__;								\
 })
 
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 1aed1a4dfc2d..eddf71c22875 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -402,6 +402,7 @@ static int modify_p4d_table(pgd_t *pgd, unsigned long addr, unsigned long end,
 			pud = vmem_crst_alloc(_REGION3_ENTRY_EMPTY);
 			if (!pud)
 				goto out;
+			p4d_populate(&init_mm, p4d, pud);
 		}
 		ret = modify_pud_table(p4d, addr, next, add, direct);
 		if (ret)
