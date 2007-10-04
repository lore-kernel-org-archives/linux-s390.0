Return-Path: <linux-kernel-owner+w=401wt.eu-S1760088AbXJDLfl@vger.kernel.org>
Message-Id: <20071004112829.519250766@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 18/34] appldata_base: Remove module_exit function and modular stuff
Content-Disposition: inline; filename=018-appldata-modexit.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Satyam Sharma <satyam@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Satyam Sharma <satyam@infradead.org>

arch/s390/Kconfig tells us that CONFIG_APPLDATA_BASE is bool and hence can
never be built modular.  Given this, defining appldata_exit() function is
pointless (and wasteful, actually).  Remove all that.

Previous patch annotated appldata_offline_cpu() as __cpuexit, but now with the
__exit function appldata_exit() gone, the only callsite that references it is
__cpuinit, so this function can also be __cpuinit, thereby saving space when
HOTPLUG_CPU=n.

Signed-off-by: Satyam Sharma <satyam@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/appldata/appldata_base.c |   54 +------------------------------------
 1 file changed, 2 insertions(+), 52 deletions(-)

Index: quilt-2.6/arch/s390/appldata/appldata_base.c
===================================================================
--- quilt-2.6.orig/arch/s390/appldata/appldata_base.c
+++ quilt-2.6/arch/s390/appldata/appldata_base.c
@@ -547,7 +547,7 @@ static void __cpuinit appldata_online_cp
 	spin_unlock(&appldata_timer_lock);
 }
 
-static void __cpuexit appldata_offline_cpu(int cpu)
+static void __cpuinit appldata_offline_cpu(int cpu)
 {
 	del_virt_timer(&per_cpu(appldata_timer, cpu));
 	if (atomic_dec_and_test(&appldata_expire_count)) {
@@ -607,65 +607,15 @@ static int __init appldata_init(void)
 	register_hotcpu_notifier(&appldata_nb);
 
 	appldata_sysctl_header = register_sysctl_table(appldata_dir_table);
-#ifdef MODULE
-	appldata_dir_table[0].de->owner = THIS_MODULE;
-	appldata_table[0].de->owner = THIS_MODULE;
-	appldata_table[1].de->owner = THIS_MODULE;
-#endif
 
 	P_DEBUG("Base interface initialized.\n");
 	return 0;
 }
 
-/*
- * appldata_exit()
- *
- * stop timer, unregister /proc entries
- */
-static void __exit appldata_exit(void)
-{
-	struct list_head *lh;
-	struct appldata_ops *ops;
-	int rc, i;
-
-	P_DEBUG("Unloading module ...\n");
-	/*
-	 * ops list should be empty, but just in case something went wrong...
-	 */
-	spin_lock(&appldata_ops_lock);
-	list_for_each(lh, &appldata_ops_list) {
-		ops = list_entry(lh, struct appldata_ops, list);
-		rc = appldata_diag(ops->record_nr, APPLDATA_STOP_REC,
-				(unsigned long) ops->data, ops->size,
-				ops->mod_lvl);
-		if (rc != 0) {
-			P_ERROR("STOP DIAG 0xDC for %s failed, "
-				"return code: %d\n", ops->name, rc);
-		}
-	}
-	spin_unlock(&appldata_ops_lock);
-
-	unregister_hotcpu_notifier(&appldata_nb);
+__initcall(appldata_init);
 
-	for_each_online_cpu(i)
-		appldata_offline_cpu(i);
-
-	appldata_timer_active = 0;
-
-	unregister_sysctl_table(appldata_sysctl_header);
-
-	destroy_workqueue(appldata_wq);
-	P_DEBUG("... module unloaded!\n");
-}
 /**************************** init / exit <END> ******************************/
 
-
-module_init(appldata_init);
-module_exit(appldata_exit);
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Gerald Schaefer");
-MODULE_DESCRIPTION("Linux-VM Monitor Stream, base infrastructure");
-
 EXPORT_SYMBOL_GPL(appldata_register_ops);
 EXPORT_SYMBOL_GPL(appldata_unregister_ops);
 EXPORT_SYMBOL_GPL(appldata_diag);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
