Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726918AbfFHLWA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 8 Jun 2019 07:22:00 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x58BLkFL030614
        for <linux-s390@vger.kernel.org>; Sat, 8 Jun 2019 07:21:58 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t075xqquf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 08 Jun 2019 07:21:58 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 8 Jun 2019 12:21:57 +0100
Date: Sat, 8 Jun 2019 13:21:51 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 updates for 5.2-rc4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <20190608112151.GA8766@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull two bug fixes for s390.

Thanks,
Heiko

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.2-4

for you to fetch changes up to 0ab0d7ac2090eae30f1c0b01ae981bb7a368f598:

  s390/unwind: correct stack switching during unwind (2019-06-07 15:20:44 +0200)

----------------------------------------------------------------
s390 updates for 5.2-rc4

 - fix stack unwinder: the stack unwinder rework has on off-by-one bug
   which prevents following stack backchains over more than one
   context (e.g. irq -> process).

 - fix address space detection in exception handler: if user space
   switches to access register mode, which is not supported anymore,
   the exception handler may resolve to the wrong address space.

----------------------------------------------------------------
Gerald Schaefer (1):
      s390/mm: fix address space detection in exception handling

Vasily Gorbik (1):
      s390/unwind: correct stack switching during unwind

 arch/s390/include/asm/stacktrace.h | 2 +-
 arch/s390/mm/fault.c               | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
index 49634bf..0ae4bbf7 100644
--- a/arch/s390/include/asm/stacktrace.h
+++ b/arch/s390/include/asm/stacktrace.h
@@ -30,7 +30,7 @@ static inline bool on_stack(struct stack_info *info,
 		return false;
 	if (addr + len < addr)
 		return false;
-	return addr >= info->begin && addr + len < info->end;
+	return addr >= info->begin && addr + len <= info->end;
 }
 
 static inline unsigned long get_stack_pointer(struct task_struct *task,
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 91ce03f..df75d57 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -83,7 +83,6 @@ static inline int notify_page_fault(struct pt_regs *regs)
 
 /*
  * Find out which address space caused the exception.
- * Access register mode is impossible, ignore space == 3.
  */
 static enum fault_type get_fault_type(struct pt_regs *regs)
 {
@@ -108,6 +107,10 @@ static enum fault_type get_fault_type(struct pt_regs *regs)
 		}
 		return VDSO_FAULT;
 	}
+	if (trans_exc_code == 1) {
+		/* access register mode, not used in the kernel */
+		return USER_FAULT;
+	}
 	/* home space exception -> access via kernel ASCE */
 	return KERNEL_FAULT;
 }
