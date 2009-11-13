Return-Path: <linux-kernel-owner+w=401wt.eu-S1757201AbZKMPQ7@vger.kernel.org>
Message-Id: <20091113150910.841947994@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:33 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/52] [PATCH] cmm: free pages on hibernate.
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=108-cmm-suspend.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The pages allocated by the cmm memory balloon should be freed before
the hibernation image is created. Otherwise the memory reserved by the
balloon gets written to the swap device but there is no content in
these pages that need to be preserved.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/cmm.c |   61 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 11 deletions(-)

Index: quilt-2.6/arch/s390/mm/cmm.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/cmm.c	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/mm/cmm.c	2009-11-13 16:08:14.000000000 +0100
@@ -18,6 +18,7 @@
 #include <linux/swap.h>
 #include <linux/kthread.h>
 #include <linux/oom.h>
+#include <linux/suspend.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -44,6 +45,7 @@
 static volatile long cmm_timed_pages_target;
 static long cmm_timeout_pages;
 static long cmm_timeout_seconds;
+static int cmm_suspended;
 
 static struct cmm_page_array *cmm_page_list;
 static struct cmm_page_array *cmm_timed_page_list;
@@ -147,9 +149,9 @@
 
 	while (1) {
 		rc = wait_event_interruptible(cmm_thread_wait,
-			(cmm_pages != cmm_pages_target ||
-			 cmm_timed_pages != cmm_timed_pages_target ||
-			 kthread_should_stop()));
+			(!cmm_suspended && (cmm_pages != cmm_pages_target ||
+			 cmm_timed_pages != cmm_timed_pages_target)) ||
+			 kthread_should_stop());
 		if (kthread_should_stop() || rc == -ERESTARTSYS) {
 			cmm_pages_target = cmm_pages;
 			cmm_timed_pages_target = cmm_timed_pages;
@@ -411,6 +413,38 @@
 
 static struct ctl_table_header *cmm_sysctl_header;
 
+static int cmm_suspend(void)
+{
+	cmm_suspended = 1;
+	cmm_free_pages(cmm_pages, &cmm_pages, &cmm_page_list);
+	cmm_free_pages(cmm_timed_pages, &cmm_timed_pages, &cmm_timed_page_list);
+	return 0;
+}
+
+static int cmm_resume(void)
+{
+	cmm_suspended = 0;
+	cmm_kick_thread();
+	return 0;
+}
+
+static int cmm_power_event(struct notifier_block *this,
+			   unsigned long event, void *ptr)
+{
+	switch (event) {
+	case PM_POST_HIBERNATION:
+		return cmm_resume();
+	case PM_HIBERNATION_PREPARE:
+		return cmm_suspend();
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static struct notifier_block cmm_power_notifier = {
+	.notifier_call = cmm_power_event,
+};
+
 static int
 cmm_init (void)
 {
@@ -419,7 +453,7 @@
 #ifdef CONFIG_CMM_PROC
 	cmm_sysctl_header = register_sysctl_table(cmm_dir_table);
 	if (!cmm_sysctl_header)
-		goto out;
+		goto out_sysctl;
 #endif
 #ifdef CONFIG_CMM_IUCV
 	rc = smsg_register_callback(SMSG_PREFIX, cmm_smsg_target);
@@ -429,17 +463,21 @@
 	rc = register_oom_notifier(&cmm_oom_nb);
 	if (rc < 0)
 		goto out_oom_notify;
+	rc = register_pm_notifier(&cmm_power_notifier);
+	if (rc)
+		goto out_pm;
 	init_waitqueue_head(&cmm_thread_wait);
 	init_timer(&cmm_timer);
 	cmm_thread_ptr = kthread_run(cmm_thread, NULL, "cmmthread");
 	rc = IS_ERR(cmm_thread_ptr) ? PTR_ERR(cmm_thread_ptr) : 0;
-	if (!rc)
-		goto out;
-	/*
-	 * kthread_create failed. undo all the stuff from above again.
-	 */
-	unregister_oom_notifier(&cmm_oom_nb);
+	if (rc)
+		goto out_kthread;
+	return 0;
 
+out_kthread:
+	unregister_pm_notifier(&cmm_power_notifier);
+out_pm:
+	unregister_oom_notifier(&cmm_oom_nb);
 out_oom_notify:
 #ifdef CONFIG_CMM_IUCV
 	smsg_unregister_callback(SMSG_PREFIX, cmm_smsg_target);
@@ -447,8 +485,8 @@
 #endif
 #ifdef CONFIG_CMM_PROC
 	unregister_sysctl_table(cmm_sysctl_header);
+out_sysctl:
 #endif
-out:
 	return rc;
 }
 
@@ -456,6 +494,7 @@
 cmm_exit(void)
 {
 	kthread_stop(cmm_thread_ptr);
+	unregister_pm_notifier(&cmm_power_notifier);
 	unregister_oom_notifier(&cmm_oom_nb);
 	cmm_free_pages(cmm_pages, &cmm_pages, &cmm_page_list);
 	cmm_free_pages(cmm_timed_pages, &cmm_timed_pages, &cmm_timed_page_list);
