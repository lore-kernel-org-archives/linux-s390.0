Return-Path: <linux-kernel-owner+w=401wt.eu-S1757967AbXFSIqy@vger.kernel.org>
Message-Id: <20070619084642.673859525@de.ibm.com>
References: <20070619084516.457715754@de.ibm.com>
Date: Tue, 19 Jun 2007 10:45:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 5/6] Move psw_set_key.
Content-Disposition: inline; filename=005-set-key.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Move psw_set_key() from ptrace.h to processor.h which is a more
suitable place for it. In addition the moves makes the function
invisible to user space.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/traps.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: quilt-2.6/arch/s390/kernel/traps.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/traps.c
+++ quilt-2.6/arch/s390/kernel/traps.c
@@ -253,20 +253,22 @@ void die(const char * str, struct pt_reg
 {
 	static int die_counter;
 
+	oops_enter();
 	debug_stop_all();
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
 	printk("%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
 	print_modules();
-        show_regs(regs);
+	show_regs(regs);
 	bust_spinlocks(0);
-        spin_unlock_irq(&die_lock);
+	spin_unlock_irq(&die_lock);
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 	if (panic_on_oops)
 		panic("Fatal exception: panic_on_oops");
-        do_exit(SIGSEGV);
+	oops_exit();
+	do_exit(SIGSEGV);
 }
 
 static void inline

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
