Return-Path: <linux-kernel-owner+w=401wt.eu-S1753975AbXLFPUe@vger.kernel.org>
From: Denis Cheng <crquan@gmail.com>
Subject: [PATCH 09/20] drivers/s390/: use LIST_HEAD instead of LIST_HEAD_INIT
Date: Thu,  6 Dec 2007 23:19:41 +0800
Message-Id: <1196954381-5483-1-git-send-email-crquan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

single list_head variable initialized with LIST_HEAD_INIT could almost
always can be replaced with LIST_HEAD declaration, this shrinks the code
and looks better.

Signed-off-by: Denis Cheng <crquan@gmail.com>
---
 drivers/s390/block/dcssblk.c  |    2 +-
 drivers/s390/char/raw3270.c   |    4 ++--
 drivers/s390/char/tape_core.c |    2 +-
 drivers/s390/net/netiucv.c    |    3 +--
 drivers/s390/net/smsgiucv.c   |    2 +-
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 15a5789..7779bfc 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -82,7 +82,7 @@ struct dcssblk_dev_info {
 	struct request_queue *dcssblk_queue;
 };
 
-static struct list_head dcssblk_devices = LIST_HEAD_INIT(dcssblk_devices);
+static LIST_HEAD(dcssblk_devices);
 static struct rw_semaphore dcssblk_devices_sem;
 
 /*
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index 8d1c64a..0d98f1f 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
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
diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index 2fae633..7ad8cf1 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -37,7 +37,7 @@ static void tape_long_busy_timeout(unsigned long data);
  * we can assign the devices to minor numbers of the same major
  * The list is protected by the rwlock
  */
-static struct list_head tape_device_list = LIST_HEAD_INIT(tape_device_list);
+static LIST_HEAD(tape_device_list);
 static DEFINE_RWLOCK(tape_device_lock);
 
 /*
diff --git a/drivers/s390/net/netiucv.c b/drivers/s390/net/netiucv.c
index 4d18d64..f385350 100644
--- a/drivers/s390/net/netiucv.c
+++ b/drivers/s390/net/netiucv.c
@@ -198,8 +198,7 @@ struct iucv_connection {
 /**
  * Linked list of all connection structs.
  */
-static struct list_head iucv_connection_list =
-	LIST_HEAD_INIT(iucv_connection_list);
+static LIST_HEAD(iucv_connection_list);
 static DEFINE_RWLOCK(iucv_connection_rwlock);
 
 /**
diff --git a/drivers/s390/net/smsgiucv.c b/drivers/s390/net/smsgiucv.c
index 47bb47b..8735a41 100644
--- a/drivers/s390/net/smsgiucv.c
+++ b/drivers/s390/net/smsgiucv.c
@@ -42,7 +42,7 @@ MODULE_DESCRIPTION ("Linux for S/390 IUCV special message driver");
 static struct iucv_path *smsg_path;
 
 static DEFINE_SPINLOCK(smsg_list_lock);
-static struct list_head smsg_list = LIST_HEAD_INIT(smsg_list);
+static LIST_HEAD(smsg_list);
 
 static int smsg_path_pending(struct iucv_path *, u8 ipvmid[8], u8 ipuser[16]);
 static void smsg_message_pending(struct iucv_path *, struct iucv_message *);
-- 
1.5.3.4
