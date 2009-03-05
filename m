Return-Path: <linux-kernel-owner+w=401wt.eu-S1756837AbZCEQsW@vger.kernel.org>
From: Dan Smith <danms@us.ibm.com>
Subject: [PATCH] s390: Expose a constant for the number of words representing the CRs
Date: Thu,  5 Mar 2009 11:48:08 -0500
Message-Id: <1236271688-18806-1-git-send-email-danms@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

We need to use this value in the checkpoint/restart code and would like to
have a constant instead of a magic '3'.

Changelog:
    Mar 03:
            . Picked up additional use of magic '3' in ptrace.h

Signed-off-by: Dan Smith <danms@us.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/ptrace.h   |    4 +++-
 arch/s390/kernel/compat_ptrace.h |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index 8920025..f1b0516 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -172,6 +172,8 @@
 #define NUM_CRS		16
 #define NUM_ACRS	16
 
+#define NUM_CR_WORDS	3
+
 #define FPR_SIZE	8
 #define FPC_SIZE	4
 #define FPC_PAD_SIZE	4 /* gcc insists on aligning the fpregs */
@@ -334,7 +336,7 @@ struct pt_regs
  */
 typedef struct
 {
-	unsigned long cr[3];
+	unsigned long cr[NUM_CR_WORDS];
 } per_cr_words;
 
 #define PER_EM_MASK 0xE8000000UL
diff --git a/arch/s390/kernel/compat_ptrace.h b/arch/s390/kernel/compat_ptrace.h
index a2be3a9..123dd66 100644
--- a/arch/s390/kernel/compat_ptrace.h
+++ b/arch/s390/kernel/compat_ptrace.h
@@ -1,10 +1,11 @@
 #ifndef _PTRACE32_H
 #define _PTRACE32_H
 
+#include <asm/ptrace.h>    /* needed for NUM_CR_WORDS */
 #include "compat_linux.h"  /* needed for psw_compat_t */
 
 typedef struct {
-	__u32 cr[3];
+	__u32 cr[NUM_CR_WORDS];
 } per_cr_words32;
 
 typedef struct {
-- 
1.6.1
