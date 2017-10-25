Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 25 Oct 2017 03:27:37 -0700
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] s390/ap_bus: Convert timers to use timer_setup()
Message-ID: <20171025102737.GA145851@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Harald Freudenberger <freude@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Harald Freudenberger <freude@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/s390/crypto/ap_bus.c   | 10 +++++-----
 drivers/s390/crypto/ap_bus.h   |  2 +-
 drivers/s390/crypto/ap_queue.c |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 5f0be2040272..7bd18624e96e 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -362,13 +362,13 @@ void ap_wait(enum ap_wait wait)
 
 /**
  * ap_request_timeout(): Handling of request timeouts
- * @data: Holds the AP device.
+ * @t: timer making this callback
  *
  * Handles request timeouts.
  */
-void ap_request_timeout(unsigned long data)
+void ap_request_timeout(struct timer_list *t)
 {
-	struct ap_queue *aq = (struct ap_queue *) data;
+	struct ap_queue *aq = from_timer(aq, t, timeout);
 
 	if (ap_suspend_flag)
 		return;
@@ -1147,7 +1147,7 @@ static void ap_scan_bus(struct work_struct *unused)
 	mod_timer(&ap_config_timer, jiffies + ap_config_time * HZ);
 }
 
-static void ap_config_timeout(unsigned long ptr)
+static void ap_config_timeout(struct timer_list *unused)
 {
 	if (ap_suspend_flag)
 		return;
@@ -1250,7 +1250,7 @@ int __init ap_module_init(void)
 		goto out_bus;
 
 	/* Setup the AP bus rescan timer. */
-	setup_timer(&ap_config_timer, ap_config_timeout, 0);
+	timer_setup(&ap_config_timer, ap_config_timeout, 0);
 
 	/*
 	 * Setup the high resultion poll timer.
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 754cf2223cfb..e7077820ae46 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -241,7 +241,7 @@ void ap_flush_queue(struct ap_queue *aq);
 
 void *ap_airq_ptr(void);
 void ap_wait(enum ap_wait wait);
-void ap_request_timeout(unsigned long data);
+void ap_request_timeout(struct timer_list *t);
 void ap_bus_force_rescan(void);
 
 void ap_queue_init_reply(struct ap_queue *aq, struct ap_message *ap_msg);
diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index 56b96edffd5b..f4782113e4a3 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -635,7 +635,7 @@ struct ap_queue *ap_queue_create(ap_qid_t qid, int device_type)
 	spin_lock_init(&aq->lock);
 	INIT_LIST_HEAD(&aq->pendingq);
 	INIT_LIST_HEAD(&aq->requestq);
-	setup_timer(&aq->timeout, ap_request_timeout, (unsigned long) aq);
+	timer_setup(&aq->timeout, ap_request_timeout, 0);
 
 	return aq;
 }
-- 
2.7.4


-- 
Kees Cook
Pixel Security
