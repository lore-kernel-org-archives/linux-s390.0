Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13892 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403976AbgKXSFE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Nov 2020 13:05:04 -0500
Date: Tue, 24 Nov 2020 19:04:55 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.10-rc6
Message-ID: <20201124180455.GA4250@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

please pull one important s390 fix for 5.10-rc6.

Thanks,
Heiko

The following changes since commit 78d732e1f326f74f240d416af9484928303d9951:

  s390/cpum_sf.c: fix file permission for cpum_sfb_size (2020-11-12 12:10:36 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-5

for you to fetch changes up to 1179f170b6f0af7bb0b3b7628136eaac450ddf31:

  s390: fix fpu restore in entry.S (2020-11-23 11:52:13 +0100)

----------------------------------------------------------------
- disable interrupts when restoring fpu and vector registers,
  otherwise KVM guests might see corrupted register contents

----------------------------------------------------------------
Sven Schnelle (1):
      s390: fix fpu restore in entry.S

 arch/s390/kernel/asm-offsets.c | 10 +++++-----
 arch/s390/kernel/entry.S       |  2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index 2012c1cf0853..483051e10db3 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -53,11 +53,11 @@ int main(void)
 	/* stack_frame offsets */
 	OFFSET(__SF_BACKCHAIN, stack_frame, back_chain);
 	OFFSET(__SF_GPRS, stack_frame, gprs);
-	OFFSET(__SF_EMPTY, stack_frame, empty1);
-	OFFSET(__SF_SIE_CONTROL, stack_frame, empty1[0]);
-	OFFSET(__SF_SIE_SAVEAREA, stack_frame, empty1[1]);
-	OFFSET(__SF_SIE_REASON, stack_frame, empty1[2]);
-	OFFSET(__SF_SIE_FLAGS, stack_frame, empty1[3]);
+	OFFSET(__SF_EMPTY, stack_frame, empty1[0]);
+	OFFSET(__SF_SIE_CONTROL, stack_frame, empty1[1]);
+	OFFSET(__SF_SIE_SAVEAREA, stack_frame, empty1[2]);
+	OFFSET(__SF_SIE_REASON, stack_frame, empty1[3]);
+	OFFSET(__SF_SIE_FLAGS, stack_frame, empty1[4]);
 	BLANK();
 	OFFSET(__VDSO_GETCPU_VAL, vdso_per_cpu_data, getcpu_val);
 	BLANK();
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 5346545b9860..26bb0603c5a1 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -1068,6 +1068,7 @@ EXPORT_SYMBOL(save_fpu_regs)
  *	%r4
  */
 load_fpu_regs:
+	stnsm	__SF_EMPTY(%r15),0xfc
 	lg	%r4,__LC_CURRENT
 	aghi	%r4,__TASK_thread
 	TSTMSK	__LC_CPU_FLAGS,_CIF_FPU
@@ -1099,6 +1100,7 @@ load_fpu_regs:
 .Lload_fpu_regs_done:
 	ni	__LC_CPU_FLAGS+7,255-_CIF_FPU
 .Lload_fpu_regs_exit:
+	ssm	__SF_EMPTY(%r15)
 	BR_EX	%r14
 .Lload_fpu_regs_end:
 ENDPROC(load_fpu_regs)
