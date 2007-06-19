Return-Path: <linux-kernel-owner+w=401wt.eu-S1757662AbXFSIqj@vger.kernel.org>
Message-Id: <20070619084642.276549848@de.ibm.com>
References: <20070619084516.457715754@de.ibm.com>
Date: Tue, 19 Jun 2007 10:45:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 4/6] Print list of modules on die().
Content-Disposition: inline; filename=004-printk-modules.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Print list of modules on die() like a lot of other architectures do.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/traps.c |    1 +
 1 file changed, 1 insertion(+)

Index: quilt-2.6/arch/s390/kernel/traps.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/traps.c
+++ quilt-2.6/arch/s390/kernel/traps.c
@@ -258,6 +258,7 @@ void die(const char * str, struct pt_reg
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
 	printk("%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
+	print_modules();
         show_regs(regs);
 	bust_spinlocks(0);
         spin_unlock_irq(&die_lock);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
