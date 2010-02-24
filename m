Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084451.692379800@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:52 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 22/32] [PATCH] use kprobes_built_in() in mm/fault code
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=121-kprobes_built_in.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Use kprobes_built_in() to avoid ifdefs like most other architectures do.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/fault.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: quilt-2.6/arch/s390/mm/fault.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/fault.c	2010-02-24 09:44:26.000000000 +0100
+++ quilt-2.6/arch/s390/mm/fault.c	2010-02-24 09:44:27.000000000 +0100
@@ -60,15 +60,13 @@
 {
 	int ret = 0;
 
-#ifdef CONFIG_KPROBES
 	/* kprobe_running() needs smp_processor_id() */
-	if (!user_mode(regs)) {
+	if (kprobes_built_in() && !user_mode(regs)) {
 		preempt_disable();
 		if (kprobe_running() && kprobe_fault_handler(regs, 14))
 			ret = 1;
 		preempt_enable();
 	}
-#endif
 	return ret;
 }
 
