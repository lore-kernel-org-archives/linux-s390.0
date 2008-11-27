Return-Path: <linux-kernel-owner+w=401wt.eu-S1756429AbYK0Kld@vger.kernel.org>
Message-Id: <20081127103135.074281261@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:46 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 26/60] mark disabled_wait as noreturn function
Content-Disposition: inline; filename=125-dw-warning.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

disabled_wait() won't return, so add an __attribute__((noreturn)).
This will remove a false positive finding which our internal code
checker reports.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/processor.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/include/asm/processor.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/processor.h
+++ quilt-2.6/arch/s390/include/asm/processor.h
@@ -13,6 +13,7 @@
 #ifndef __ASM_S390_PROCESSOR_H
 #define __ASM_S390_PROCESSOR_H
 
+#include <linux/linkage.h>
 #include <asm/ptrace.h>
 
 #ifdef __KERNEL__
@@ -258,7 +259,7 @@ static inline void enabled_wait(void)
  * Function to drop a processor into disabled wait state
  */
 
-static inline void disabled_wait(unsigned long code)
+static inline void ATTRIB_NORET disabled_wait(unsigned long code)
 {
         unsigned long ctl_buf;
         psw_t dw_psw;
@@ -322,6 +323,7 @@ static inline void disabled_wait(unsigne
 		: "=m" (ctl_buf)
 		: "a" (&dw_psw), "a" (&ctl_buf), "m" (dw_psw) : "cc", "0");
 #endif /* __s390x__ */
+	while (1);
 }
 
 /*

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
