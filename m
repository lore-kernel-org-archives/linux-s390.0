Return-Path: <linux-kernel-owner+w=401wt.eu-S1755855AbZHNL0p@vger.kernel.org>
Message-Id: <20090814112619.141728093@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:45 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 28/34] remove unused irq_cpustat_t defintion
Content-Disposition: inline; filename=127-remove-irq_cpustat_t.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christoph Hellwig <hch@lst.de>

No need to defined a irq_cpustat_t type if __ARCH_IRQ_STAT is defined.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/hardirq.h |    7 -------
 1 file changed, 7 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/hardirq.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/hardirq.h
+++ quilt-2.6/arch/s390/include/asm/hardirq.h
@@ -18,13 +18,6 @@
 #include <linux/interrupt.h>
 #include <asm/lowcore.h>
 
-/* irq_cpustat_t is unused currently, but could be converted
- * into a percpu variable instead of storing softirq_pending
- * on the lowcore */
-typedef struct {
-	unsigned int __softirq_pending;
-} irq_cpustat_t;
-
 #define local_softirq_pending() (S390_lowcore.softirq_pending)
 
 #define __ARCH_IRQ_STAT

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
