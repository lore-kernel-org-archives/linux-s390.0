Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084448.844782557@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:39 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/32] [PATCH] smp: rename and add lowcore defines
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=108-smp-lowcore-defs.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Rename __LC_RESTART_PSW to __LC_RST_NEW_PSW, add a define for the
missing 32 bit variant and the missing old PSWs.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/lowcore.h |    5 ++++-
 arch/s390/kernel/swsusp_asm64.S |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/lowcore.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/lowcore.h	2010-02-24 09:44:24.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/lowcore.h	2010-02-24 09:44:24.000000000 +0100
@@ -36,6 +36,8 @@
 #define __LC_DUMP_REIPL			0x0e00
 
 #ifndef __s390x__
+#define __LC_RST_NEW_PSW		0x0000
+#define __LC_RST_OLD_PSW		0x0008
 #define __LC_EXT_OLD_PSW		0x0018
 #define __LC_SVC_OLD_PSW		0x0020
 #define __LC_PGM_OLD_PSW		0x0028
@@ -81,12 +83,13 @@
 #define __LC_CREGS_SAVE_AREA		0x01c0
 #else /* __s390x__ */
 #define __LC_LAST_BREAK			0x0110
+#define __LC_RST_OLD_PSW		0x0120
 #define __LC_EXT_OLD_PSW		0x0130
 #define __LC_SVC_OLD_PSW		0x0140
 #define __LC_PGM_OLD_PSW		0x0150
 #define __LC_MCK_OLD_PSW		0x0160
 #define __LC_IO_OLD_PSW			0x0170
-#define __LC_RESTART_PSW		0x01a0
+#define __LC_RST_NEW_PSW		0x01a0
 #define __LC_EXT_NEW_PSW		0x01b0
 #define __LC_SVC_NEW_PSW		0x01c0
 #define __LC_PGM_NEW_PSW		0x01d0
Index: quilt-2.6/arch/s390/kernel/swsusp_asm64.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/swsusp_asm64.S	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/swsusp_asm64.S	2010-02-24 09:44:24.000000000 +0100
@@ -176,7 +176,7 @@
 	cgr	%r1,%r2
 	je	restore_registers		/* r1 = r2 -> nothing to do */
 	larl	%r4,.Lrestart_suspend_psw	/* Set new restart PSW */
-	mvc	__LC_RESTART_PSW(16,%r0),0(%r4)
+	mvc	__LC_RST_NEW_PSW(16,%r0),0(%r4)
 3:
 	sigp	%r9,%r1,__SIGP_INITIAL_CPU_RESET
 	brc	8,4f	/* accepted */
