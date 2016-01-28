Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jeffrey Merkey <jeffmerkey@gmail.com>
Subject: [PATCH 08/31] Add debugger entry points for S390
Date: Thu, 28 Jan 2016 12:46:33 -0700
Message-Id: <1454010393-28719-1-git-send-email-jeffmerkey@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux.mdb@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This patch series adds an export which can be set by system debuggers to
direct the hard lockup and soft lockup detector to trigger a breakpoint
exception and enter a debugger if one is active.  It is assumed that if
someone sets this variable, then an breakpoint handler of some sort will
be actively loaded or registered via the notify die handler chain.

This addition is extremely useful for debugging hard and soft lockups
real time and quickly from a console debugger.

Signed-off-by: Jeffrey Merkey <jeffmerkey@gmail.com>
---
 arch/s390/include/asm/kdebug.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/s390/include/asm/kdebug.h b/arch/s390/include/asm/kdebug.h
index 5c1abd4..8e7d6c3 100644
--- a/arch/s390/include/asm/kdebug.h
+++ b/arch/s390/include/asm/kdebug.h
@@ -24,4 +24,9 @@ enum die_val {
 
 extern void die(struct pt_regs *, const char *);
 
+
+static inline void arch_breakpoint(void)
+{
+}
+
 #endif
-- 
1.8.3.1
