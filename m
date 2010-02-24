Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084449.732641600@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:43 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 13/32] [PATCH] add MACHINE_IS_LPAR flag
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=112-lpar-machine-flag.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Introduce the MACHINE_IS_LPAR flag for code that should only be
executed if Linux is running in an LPAR.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/setup.h |    3 +++
 arch/s390/kernel/early.c      |    9 ++++++---
 arch/s390/kernel/setup.c      |    4 ++--
 drivers/s390/cio/cio.c        |    2 +-
 drivers/s390/cio/qdio_main.c  |    2 +-
 5 files changed, 13 insertions(+), 7 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/setup.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/setup.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/setup.h	2010-02-24 09:44:25.000000000 +0100
@@ -71,9 +71,12 @@
 #define MACHINE_FLAG_KVM	(1UL << 9)
 #define MACHINE_FLAG_HPAGE	(1UL << 10)
 #define MACHINE_FLAG_PFMF	(1UL << 11)
+#define MACHINE_FLAG_LPAR	(1UL << 12)
 
 #define MACHINE_IS_VM		(S390_lowcore.machine_flags & MACHINE_FLAG_VM)
 #define MACHINE_IS_KVM		(S390_lowcore.machine_flags & MACHINE_FLAG_KVM)
+#define MACHINE_IS_LPAR		(S390_lowcore.machine_flags & MACHINE_FLAG_LPAR)
+
 #define MACHINE_HAS_DIAG9C	(S390_lowcore.machine_flags & MACHINE_FLAG_DIAG9C)
 
 #ifndef __s390x__
Index: quilt-2.6/arch/s390/kernel/early.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/early.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/early.c	2010-02-24 09:44:25.000000000 +0100
@@ -214,10 +214,13 @@
 
 static noinline __init void detect_machine_type(void)
 {
-	/* No VM information? Looks like LPAR */
-	if (stsi(&vmms, 3, 2, 2) == -ENOSYS)
+	/* Check current-configuration-level */
+	if ((stsi(NULL, 0, 0, 0) >> 28) <= 2) {
+		S390_lowcore.machine_flags |= MACHINE_FLAG_LPAR;
 		return;
-	if (!vmms.count)
+	}
+	/* Get virtual-machine cpu information. */
+	if (stsi(&vmms, 3, 2, 2) == -ENOSYS || !vmms.count)
 		return;
 
 	/* Running under KVM? If not we assume z/VM */
Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/setup.c	2010-02-24 09:44:25.000000000 +0100
@@ -804,7 +804,7 @@
 	if (MACHINE_IS_VM)
 		pr_info("Linux is running as a z/VM "
 			"guest operating system in 31-bit mode\n");
-	else
+	else if (MACHINE_IS_LPAR)
 		pr_info("Linux is running natively in 31-bit mode\n");
 	if (MACHINE_HAS_IEEE)
 		pr_info("The hardware system has IEEE compatible "
@@ -818,7 +818,7 @@
 			"guest operating system in 64-bit mode\n");
 	else if (MACHINE_IS_KVM)
 		pr_info("Linux is running under KVM in 64-bit mode\n");
-	else
+	else if (MACHINE_IS_LPAR)
 		pr_info("Linux is running natively in 64-bit mode\n");
 #endif /* CONFIG_64BIT */
 
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/cio.c	2010-02-24 09:44:25.000000000 +0100
@@ -661,7 +661,7 @@
 		 * We don't do this for VM because a tpi drops the cpu
 		 * out of the sie which costs more cycles than it saves.
 		 */
-	} while (!MACHINE_IS_VM && tpi (NULL) != 0);
+	} while (MACHINE_IS_LPAR && tpi(NULL) != 0);
 	irq_exit();
 	set_irq_regs(old_regs);
 }
Index: quilt-2.6/drivers/s390/cio/qdio_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_main.c	2010-02-24 09:44:25.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/qdio_main.c	2010-02-24 09:44:25.000000000 +0100
@@ -534,7 +534,7 @@
 
 	if ((bufnr != q->last_move) || q->qdio_error) {
 		q->last_move = bufnr;
-		if (!is_thinint_irq(q->irq_ptr) && !MACHINE_IS_VM)
+		if (!is_thinint_irq(q->irq_ptr) && MACHINE_IS_LPAR)
 			q->u.in.timestamp = get_usecs();
 		return 1;
 	} else
