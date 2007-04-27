Return-Path: <linux-kernel-owner+w=401wt.eu-S1755939AbXD0OHj@vger.kernel.org>
Message-Id: <20070427140520.368302413@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:39 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 36/38] Remove debugging junk.
Content-Disposition: inline; filename=139-appldata.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Gerald Schaefer <geraldsc@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

arch/s390/appldata/appldata_base.c has some confusing debugging code left
over to allow compiling it as a module. In practice, it cannot be configured
as module and there is no need to keep that code.

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/appldata/appldata_base.c |   38 -------------------------------------
 1 files changed, 38 deletions(-)

Index: quilt-2.6/arch/s390/appldata/appldata_base.c
===================================================================
--- quilt-2.6.orig/arch/s390/appldata/appldata_base.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/appldata/appldata_base.c	2007-04-27 16:05:01.000000000 +0200
@@ -668,45 +668,7 @@
 EXPORT_SYMBOL_GPL(appldata_unregister_ops);
 EXPORT_SYMBOL_GPL(appldata_diag);
 
-#ifdef MODULE
-/*
- * Kernel symbols needed by appldata_mem and appldata_os modules.
- * However, if this file is compiled as a module (for testing only), these
- * symbols are not exported. In this case, we define them locally and export
- * those.
- */
-void si_swapinfo(struct sysinfo *val)
-{
-	val->freeswap = -1ul;
-	val->totalswap = -1ul;
-}
-
-unsigned long avenrun[3] = {-1 - FIXED_1/200, -1 - FIXED_1/200,
-				-1 - FIXED_1/200};
-int nr_threads = -1;
-
-void get_full_page_state(struct page_state *ps)
-{
-	memset(ps, -1, sizeof(struct page_state));
-}
-
-unsigned long nr_running(void)
-{
-	return -1;
-}
-
-unsigned long nr_iowait(void)
-{
-	return -1;
-}
-
-/*unsigned long nr_context_switches(void)
-{
-	return -1;
-}*/
-#endif /* MODULE */
 EXPORT_SYMBOL_GPL(si_swapinfo);
 EXPORT_SYMBOL_GPL(nr_threads);
 EXPORT_SYMBOL_GPL(nr_running);
 EXPORT_SYMBOL_GPL(nr_iowait);
-//EXPORT_SYMBOL_GPL(nr_context_switches);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
