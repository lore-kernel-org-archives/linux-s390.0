From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Date: Mon, 16 Apr 2007 14:18:23 +0000
Subject: Re: appldata & nr_threads
Message-Id: <462385AF.5060401@de.ibm.com>
In-Reply-To: <20070415171531.GA25629@infradead.org>
References: <20070415171531.GA25629@infradead.org>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Christoph Hellwig schrieb:
> arch/s390/appldata/appldata_base.c:int nr_threads = -1;
> arch/s390/appldata/appldata_base.c:EXPORT_SYMBOL_GPL(nr_threads);
> arch/s390/appldata/appldata_os.c:       u32 nr_threads;         /* number of threads               */
> arch/s390/appldata/appldata_os.c:       P_DEBUG("nr_threads   = %u\n", os_data->nr_threads);
> arch/s390/appldata/appldata_os.c:       os_data->nr_threads = nr_threads;
> 
> include/linux/sched.h:extern int nr_threads;
> kernel/fork.c:int nr_threads;           /* The idle threads do not count.. */
> 
> 
> Can someone explain what's going on here?  appldata_os.c apparently
> uses the appldata_base.c nr_threads because only that is exported.
> But it's always -1.  Then again I don't quite understand how the linker
> doesn't complain about the two nr_threads symbols.
> 
> Could it be that s390 doesn't use -fno-common when compiling the kernel?

There is an #ifdef MODULE around the definition of nr_threads, so the linker
won't see the two symbols.
This #ifdef MODULE code was just used for debugging once and it is completely
irrelevant (junk) now since there is not even a module config option for
appldata_base. So it's probably best to throw away that junk (this wouldn't
even compile as a module because there is no struct page_state anymore).

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
---

 appldata_base.c |   38 --------------------------------------
 1 files changed, 38 deletions(-)

diff -urpN linux-2.6/arch/s390/appldata/appldata_base.c linux-2.6-patched/arch/s390/appldata/appldata_base.c
--- linux-2.6/arch/s390/appldata/appldata_base.c	2007-04-16 13:47:11.000000000 +0200
+++ linux-2.6-patched/arch/s390/appldata/appldata_base.c	2007-04-16 13:55:48.000000000 +0200
@@ -668,45 +668,7 @@ EXPORT_SYMBOL_GPL(appldata_register_ops)
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
