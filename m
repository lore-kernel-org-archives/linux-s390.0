Return-Path: <linux-kernel-owner+w=401wt.eu-S932076AbZBYPQ7@vger.kernel.org>
Message-Id: <20090225150838.464129126@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:07:03 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 41/46] s390: remove duplicate nul-termination of string
Content-Disposition: inline; filename=140-parm-nul-term.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

strlcpy() does already NUL-terminate the destination string.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/early.c |    1 -
 1 file changed, 1 deletion(-)

Index: quilt-2.6/arch/s390/kernel/early.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/early.c
+++ quilt-2.6/arch/s390/kernel/early.c
@@ -352,7 +352,6 @@ static void __init setup_boot_command_li
 
 	/* copy arch command line */
 	strlcpy(boot_command_line, COMMAND_LINE, ARCH_COMMAND_LINE_SIZE);
-	boot_command_line[ARCH_COMMAND_LINE_SIZE - 1] = 0;
 
 	/* append IPL PARM data to the boot command line */
 	if (MACHINE_IS_VM) {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
