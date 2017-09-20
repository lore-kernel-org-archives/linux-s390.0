Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 21/31] s390/char/sclp: Use separate static data field with with static timer
Date: Wed, 20 Sep 2017 16:27:45 -0700
Message-Id: <1505950075-50223-22-git-send-email-keescook@chromium.org>
In-Reply-To: <1505950075-50223-1-git-send-email-keescook@chromium.org>
References: <1505950075-50223-1-git-send-email-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@chromium.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

In preparation for changing the timer callback argument to the timer
pointer, move to a separate static data variable.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/s390/char/sclp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index d0157067a80a..40794f9f1598 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -90,6 +90,7 @@ static struct sclp_req sclp_suspend_req;
 
 /* Timer for request retries. */
 static struct timer_list sclp_request_timer;
+static unsigned long sclp_request_timer_data;
 
 /* Timer for queued requests. */
 static struct timer_list sclp_queue_timer;
@@ -158,7 +159,7 @@ __sclp_set_request_timer(unsigned long time, void (*function)(unsigned long),
 {
 	del_timer(&sclp_request_timer);
 	sclp_request_timer.function = function;
-	sclp_request_timer.data = data;
+	sclp_request_timer_data = data;
 	sclp_request_timer.expires = jiffies + time;
 	add_timer(&sclp_request_timer);
 }
@@ -166,12 +167,12 @@ __sclp_set_request_timer(unsigned long time, void (*function)(unsigned long),
 /* Request timeout handler. Restart the request queue. If DATA is non-zero,
  * force restart of running request. */
 static void
-sclp_request_timeout(unsigned long data)
+sclp_request_timeout(unsigned long unused)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&sclp_lock, flags);
-	if (data) {
+	if (sclp_request_timer_data) {
 		if (sclp_running_state == sclp_running_state_running) {
 			/* Break running state and queue NOP read event request
 			 * to get a defined interface state. */
@@ -557,7 +558,7 @@ sclp_sync_wait(void)
 		if (timer_pending(&sclp_request_timer) &&
 		    get_tod_clock_fast() > timeout &&
 		    del_timer(&sclp_request_timer))
-			sclp_request_timer.function(sclp_request_timer.data);
+			sclp_request_timer.function(0);
 		cpu_relax();
 	}
 	local_irq_disable();
@@ -914,7 +915,7 @@ static void sclp_check_handler(struct ext_code ext_code,
 
 /* Initial init mask request timed out. Modify request state to failed. */
 static void
-sclp_check_timeout(unsigned long data)
+sclp_check_timeout(unsigned long unused)
 {
 	unsigned long flags;
 
-- 
2.7.4
