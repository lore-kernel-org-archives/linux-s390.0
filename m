Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084447.955310300@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:35 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/32] [PATCH] cio: wait for channel report
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=104-cio-wait-channel-report.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

To fetch a pending channel report word (crw) we use a kernel
thread which triggers stcrw and sleeps on a semaphore. The s390
machine check handler uses crw_handle_channel_report to handle
one crw if needed.

This patch replaces the semaphore with a waitqueue (to block the
kernel thread) and an atomic_t (to count the number of pending
requests).

By this we achieve the ability to force this thread to check for
a pending crw (independent on when it is triggered by the machine
check handler) and wait for this action to finish.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/crw.h |    1 +
 drivers/s390/cio/crw.c      |   29 +++++++++++++++--------------
 2 files changed, 16 insertions(+), 14 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/crw.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/crw.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/crw.h	2010-02-24 09:44:23.000000000 +0100
@@ -32,6 +32,7 @@
 extern int crw_register_handler(int rsc, crw_handler_t handler);
 extern void crw_unregister_handler(int rsc);
 extern void crw_handle_channel_report(void);
+void crw_wait_for_channel_report(void);
 
 #define NR_RSCS 16
 
Index: quilt-2.6/drivers/s390/cio/crw.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/crw.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/crw.c	2010-02-24 09:44:23.000000000 +0100
@@ -8,15 +8,16 @@
  *		 Heiko Carstens <heiko.carstens@de.ibm.com>,
  */
 
-#include <linux/semaphore.h>
 #include <linux/mutex.h>
 #include <linux/kthread.h>
 #include <linux/init.h>
+#include <linux/wait.h>
 #include <asm/crw.h>
 
-static struct semaphore crw_semaphore;
 static DEFINE_MUTEX(crw_handler_mutex);
 static crw_handler_t crw_handlers[NR_RSCS];
+static atomic_t crw_nr_req = ATOMIC_INIT(0);
+static DECLARE_WAIT_QUEUE_HEAD(crw_handler_wait_q);
 
 /**
  * crw_register_handler() - register a channel report word handler
@@ -59,12 +60,14 @@
 static int crw_collect_info(void *unused)
 {
 	struct crw crw[2];
-	int ccode;
+	int ccode, signal;
 	unsigned int chain;
-	int ignore;
 
 repeat:
-	ignore = down_interruptible(&crw_semaphore);
+	signal = wait_event_interruptible(crw_handler_wait_q,
+					  atomic_read(&crw_nr_req) > 0);
+	if (unlikely(signal))
+		atomic_inc(&crw_nr_req);
 	chain = 0;
 	while (1) {
 		crw_handler_t handler;
@@ -122,25 +125,23 @@
 		/* chain is always 0 or 1 here. */
 		chain = crw[chain].chn ? chain + 1 : 0;
 	}
+	if (atomic_dec_and_test(&crw_nr_req))
+		wake_up(&crw_handler_wait_q);
 	goto repeat;
 	return 0;
 }
 
 void crw_handle_channel_report(void)
 {
-	up(&crw_semaphore);
+	atomic_inc(&crw_nr_req);
+	wake_up(&crw_handler_wait_q);
 }
 
-/*
- * Separate initcall needed for semaphore initialization since
- * crw_handle_channel_report might be called before crw_machine_check_init.
- */
-static int __init crw_init_semaphore(void)
+void crw_wait_for_channel_report(void)
 {
-	init_MUTEX_LOCKED(&crw_semaphore);
-	return 0;
+	crw_handle_channel_report();
+	wait_event(crw_handler_wait_q, atomic_read(&crw_nr_req) == 0);
 }
-pure_initcall(crw_init_semaphore);
 
 /*
  * Machine checks for the channel subsystem must be enabled
