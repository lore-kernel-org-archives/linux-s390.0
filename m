Return-Path: <linux-kernel-owner+w=401wt.eu-S1763879AbZBYPUI@vger.kernel.org>
Message-Id: <20090225150832.061592948@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:40 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 18/46] ftrace: dont trace machine check handler
Content-Disposition: inline; filename=117-ftrace-notrace.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The ftrace code is currently not reentrant, so we better don't trace
our machine check handler. Machine checks are handled like NMIs on s390.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/s390mach.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/s390mach.c
===================================================================
--- quilt-2.6.orig/drivers/s390/s390mach.c
+++ quilt-2.6/drivers/s390/s390mach.c
@@ -357,8 +357,7 @@ s390_revalidate_registers(struct mci *mc
 /*
  * machine check handler.
  */
-void
-s390_do_machine_check(struct pt_regs *regs)
+void notrace s390_do_machine_check(struct pt_regs *regs)
 {
 	static DEFINE_SPINLOCK(ipd_lock);
 	static unsigned long long last_ipd;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
