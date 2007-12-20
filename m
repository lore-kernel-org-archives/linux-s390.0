Return-Path: <linux-kernel-owner+w=401wt.eu-S935953AbXLTPbg@vger.kernel.org>
Message-Id: <20071220152110.721489956@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:20:00 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 35/47] use LIST_HEAD instead of LIST_HEAD_INIT
Content-Disposition: inline; filename=134-list-head.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Denis Cheng <crquan@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Denis Cheng <crquan@gmail.com>

single list_head variable initialized with LIST_HEAD_INIT could almost
always can be replaced with LIST_HEAD declaration, this shrinks the code
and looks better.

Signed-off-by: Denis Cheng <crquan@gmail.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/extmem.c         |    2 +-
 drivers/s390/block/dcssblk.c  |    2 +-
 drivers/s390/char/raw3270.c   |    4 ++--
 drivers/s390/char/tape_core.c |    2 +-
 drivers/s390/net/netiucv.c    |    3 +--
 drivers/s390/net/smsgiucv.c   |    2 +-
 6 files changed, 7 insertions(+), 8 deletions(-)

Index: quilt-2.6/arch/s390/mm/extmem.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/extmem.c
+++ quilt-2.6/arch/s390/mm/extmem.c
@@ -83,7 +83,7 @@ struct dcss_segment {
 };
 
 static DEFINE_MUTEX(dcss_lock);
-static struct list_head dcss_list = LIST_HEAD_INIT(dcss_list);
+static LIST_HEAD(dcss_list);
 static char *segtype_string[] = { "SW", "EW", "SR", "ER", "SN", "EN", "SC",
 					"EW/EN-MIXED" };
 
Index: quilt-2.6/drivers/s390/block/dcssblk.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dcssblk.c
+++ quilt-2.6/drivers/s390/block/dcssblk.c
@@ -82,7 +82,7 @@ struct dcssblk_dev_info {
 	struct request_queue *dcssblk_queue;
 };
 
-static struct list_head dcssblk_devices = LIST_HEAD_INIT(dcssblk_devices);
+static LIST_HEAD(dcssblk_devices);
 static struct rw_semaphore dcssblk_devices_sem;
 
 /*
Index: quilt-2.6/drivers/s390/char/raw3270.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/raw3270.c
+++ quilt-2.6/drivers/s390/char/raw3270.c
@@ -66,7 +66,7 @@ struct raw3270 {
 static DEFINE_MUTEX(raw3270_mutex);
 
 /* List of 3270 devices. */
-static struct list_head raw3270_devices = LIST_HEAD_INIT(raw3270_devices);
+static LIST_HEAD(raw3270_devices);
 
 /*
  * Flag to indicate if the driver has been registered. Some operations
@@ -1210,7 +1210,7 @@ struct raw3270_notifier {
 	void (*notifier)(int, int);
 };
 
-static struct list_head raw3270_notifier = LIST_HEAD_INIT(raw3270_notifier);
+static LIST_HEAD(raw3270_notifier);
 
 int raw3270_register_notifier(void (*notifier)(int, int))
 {
Index: quilt-2.6/drivers/s390/char/tape_core.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_core.c
+++ quilt-2.6/drivers/s390/char/tape_core.c
@@ -37,7 +37,7 @@ static void tape_long_busy_timeout(unsig
  * we can assign the devices to minor numbers of the same major
  * The list is protected by the rwlock
  */
-static struct list_head tape_device_list = LIST_HEAD_INIT(tape_device_list);
+static LIST_HEAD(tape_device_list);
 static DEFINE_RWLOCK(tape_device_lock);
 
 /*
Index: quilt-2.6/drivers/s390/net/netiucv.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/netiucv.c
+++ quilt-2.6/drivers/s390/net/netiucv.c
@@ -198,8 +198,7 @@ struct iucv_connection {
 /**
  * Linked list of all connection structs.
  */
-static struct list_head iucv_connection_list =
-	LIST_HEAD_INIT(iucv_connection_list);
+static LIST_HEAD(iucv_connection_list);
 static DEFINE_RWLOCK(iucv_connection_rwlock);
 
 /**
Index: quilt-2.6/drivers/s390/net/smsgiucv.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/smsgiucv.c
+++ quilt-2.6/drivers/s390/net/smsgiucv.c
@@ -42,7 +42,7 @@ MODULE_DESCRIPTION ("Linux for S/390 IUC
 static struct iucv_path *smsg_path;
 
 static DEFINE_SPINLOCK(smsg_list_lock);
-static struct list_head smsg_list = LIST_HEAD_INIT(smsg_list);
+static LIST_HEAD(smsg_list);
 
 static int smsg_path_pending(struct iucv_path *, u8 ipvmid[8], u8 ipuser[16]);
 static void smsg_message_pending(struct iucv_path *, struct iucv_message *);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
