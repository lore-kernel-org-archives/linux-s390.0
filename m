Return-Path: <linux-kernel-owner+w=401wt.eu-S1762580AbXEJN66@vger.kernel.org>
Message-Id: <20070510135644.668728319@de.ibm.com>
References: <20070510135152.178104939@de.ibm.com>
Date: Thu, 10 May 2007 15:52:00 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/15] Avoid compile warning.
Content-Disposition: inline; filename=008-warning.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

arch/s390/mm/fault.c: In function `signal_return': 
arch/s390/mm/fault.c:256: warning: unused variable `compat' 

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/mm/fault.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/mm/fault.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/fault.c
+++ quilt-2.6/arch/s390/mm/fault.c
@@ -253,7 +253,10 @@ static int signal_return(struct mm_struc
 			 unsigned long address, unsigned long error_code)
 {
 	u16 instruction;
-	int rc, compat;
+	int rc;
+#ifdef CONFIG_COMPAT
+	int compat;
+#endif
 
 	pagefault_disable();
 	rc = __get_user(instruction, (u16 __user *) regs->psw.addr);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
