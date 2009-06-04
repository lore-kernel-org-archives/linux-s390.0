Return-Path: <linux-kernel-owner+w=401wt.eu-S1758025AbZFDQVP@vger.kernel.org>
Message-Id: <20090604161902.332403109@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:18:59 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 12/38] pm: add kernel_page_present
Content-Disposition: inline; filename=pm_kernel_page_present.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Hans-Joachim Picht <hans@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hans-Joachim Picht <hans@linux.vnet.ibm.com>

Fix the following build failure caused by make allyesconfig using
CONFIG_HIBERNATION and CONFIG_DEBUG_PAGEALLOC

kernel/built-in.o: In function `saveable_page':
kernel/power/snapshot.c:897: undefined reference to `kernel_page_present'
kernel/built-in.o: In function `safe_copy_page':
kernel/power/snapshot.c:948: undefined reference to `kernel_page_present'
make: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Hans-Joachim Picht <hans@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/mm/pgtable.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Index: linux-2.6/arch/s390/mm/pgtable.c
===================================================================
--- linux-2.6.orig/arch/s390/mm/pgtable.c
+++ linux-2.6/arch/s390/mm/pgtable.c
@@ -313,3 +313,22 @@ int s390_enable_sie(void)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(s390_enable_sie);
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+#ifdef CONFIG_HIBERNATION
+bool kernel_page_present(struct page *page)
+{
+        unsigned long addr;
+	int cc;
+
+	addr = page_to_phys(page);
+	asm("lra %1,0(%1)\n"
+	    "ipm %0\n"
+            "srl %0,28"
+	    :"=d"(cc),"+a"(addr)::"cc");
+	return cc == 0;
+}
+
+#endif /* CONFIG_HIBERNATION */
+#endif /* CONFIG_DEBUG_PAGEALLOC */
+

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
