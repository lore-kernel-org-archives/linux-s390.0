Return-Path: <linux-kernel-owner+w=401wt.eu-S1757909AbXFSIrV@vger.kernel.org>
Message-Id: <20070619084643.095486838@de.ibm.com>
References: <20070619084516.457715754@de.ibm.com>
Date: Tue, 19 Jun 2007 10:45:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 6/6] Add oops_enter()/oops_exit() calls to die().
Content-Disposition: inline; filename=006-oops-enter.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

This is mainly to switch off all potentially debugging stuff that
won't report anything useful after an oops happened.
Besided that setting pause_on_oops will work too, but doesn't make
too much sense on s390.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/processor.h |    5 +++++
 include/asm-s390/ptrace.h    |    9 +--------
 2 files changed, 6 insertions(+), 8 deletions(-)

Index: quilt-2.6/include/asm-s390/processor.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/processor.h
+++ quilt-2.6/include/asm-s390/processor.h
@@ -216,6 +216,11 @@ static inline void cpu_relax(void)
 	barrier();
 }
 
+static inline void psw_set_key(unsigned int key)
+{
+	asm volatile("spka 0(%0)" : : "d" (key));
+}
+
 /*
  * Set PSW to specified value.
  */
Index: quilt-2.6/include/asm-s390/ptrace.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/ptrace.h
+++ quilt-2.6/include/asm-s390/ptrace.h
@@ -470,14 +470,7 @@ struct user_regs_struct
 #define regs_return_value(regs)((regs)->gprs[2])
 #define profile_pc(regs) instruction_pointer(regs)
 extern void show_regs(struct pt_regs * regs);
-#endif
-
-static inline void
-psw_set_key(unsigned int key)
-{
-	asm volatile("spka 0(%0)" : : "d" (key));
-}
-
+#endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
 
 #endif /* _S390_PTRACE_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
