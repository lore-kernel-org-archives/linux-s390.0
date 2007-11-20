Return-Path: <linux-kernel-owner+w=401wt.eu-S1758463AbXKTKMH@vger.kernel.org>
Message-Id: <20071120101138.342515469@de.ibm.com>
References: <20071120101046.904031933@de.ibm.com>
Date: Tue, 20 Nov 2007 11:10:47 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/2] Add missing die_notifier() call to die().
Content-Disposition: inline; filename=011-die-notifier.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/traps.c |    1 +
 1 file changed, 1 insertion(+)

Index: quilt-2.6/arch/s390/kernel/traps.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/traps.c
+++ quilt-2.6/arch/s390/kernel/traps.c
@@ -260,6 +260,7 @@ void die(const char * str, struct pt_reg
 	bust_spinlocks(1);
 	printk("%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
 	print_modules();
+	notify_die(DIE_OOPS, str, regs, err, current->thread.trap_no, SIGSEGV);
 	show_regs(regs);
 	bust_spinlocks(0);
 	add_taint(TAINT_DIE);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
