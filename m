Return-Path: <linux-kernel-owner+w=401wt.eu-S932500AbYEOPG4@vger.kernel.org>
Message-Id: <20080515150010.115638864@de.ibm.com>
References: <20080515145705.188435204@de.ibm.com>
Date: Thu, 15 May 2008 16:57:16 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/11] show_interrupts: prevent cpu hotplug when walking cpu_online_map.
Content-Disposition: inline; filename=011-show-interrupts.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Surround all the code withing show_interrupts() with
get/put_online_cpus() to prevent strange results wrt cpu hotplug.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/irq.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/kernel/irq.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/irq.c
+++ quilt-2.6/arch/s390/kernel/irq.c
@@ -25,6 +25,7 @@ int show_interrupts(struct seq_file *p, 
 	static const char *intrclass_names[] = { "EXT", "I/O", };
 	int i = *(loff_t *) v, j;
 
+	get_online_cpus();
 	if (i == 0) {
 		seq_puts(p, "           ");
 		for_each_online_cpu(j)
@@ -43,7 +44,7 @@ int show_interrupts(struct seq_file *p, 
                 seq_putc(p, '\n');
 
         }
-
+	put_online_cpus();
         return 0;
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
