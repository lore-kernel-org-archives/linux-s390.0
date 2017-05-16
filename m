Return-Path: <BATV+d8c56d9a67374e13c9b4+5014+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 8/9] tlclk: switch switchover_timer to a modern timer
Date: Tue, 16 May 2017 13:48:11 +0200
Message-Id: <20170516114812.10660-9-hch@lst.de>
In-Reply-To: <20170516114812.10660-1-hch@lst.de>
References: <20170516114812.10660-1-hch@lst.de>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Gross <mark.gross@intel.com>, Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

And remove a superflous double-initialization.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/char/tlclk.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/char/tlclk.c b/drivers/char/tlclk.c
index 572a51704e67..7144016da82c 100644
--- a/drivers/char/tlclk.c
+++ b/drivers/char/tlclk.c
@@ -184,10 +184,14 @@ static unsigned int telclk_interrupt;
 static int int_events;		/* Event that generate a interrupt */
 static int got_event;		/* if events processing have been done */
 
-static void switchover_timeout(unsigned long data);
-static struct timer_list switchover_timer =
-	TIMER_INITIALIZER(switchover_timeout , 0, 0);
-static unsigned long tlclk_timer_data;
+static void switchover_timeout(struct timer_list *timer);
+
+static struct switchover_timer {
+	struct timer_list timer;
+	unsigned long data;
+} switchover_timer = {
+	.timer = INIT_TIMER(switchover_timeout, 0, TIMER_DEFERRABLE),
+};
 
 static struct tlclk_alarms *alarm_events;
 
@@ -805,8 +809,6 @@ static int __init tlclk_init(void)
 		goto out3;
 	}
 
-	init_timer(&switchover_timer);
-
 	ret = misc_register(&tlclk_miscdev);
 	if (ret < 0) {
 		printk(KERN_ERR "tlclk: misc_register returns %d.\n", ret);
@@ -850,25 +852,26 @@ static void __exit tlclk_cleanup(void)
 	unregister_chrdev(tlclk_major, "telco_clock");
 
 	release_region(TLCLK_BASE, 8);
-	del_timer_sync(&switchover_timer);
+	del_timer_sync(&switchover_timer.timer);
 	kfree(alarm_events);
 
 }
 
-static void switchover_timeout(unsigned long data)
+static void switchover_timeout(struct timer_list *timer)
 {
-	unsigned long flags = *(unsigned long *) data;
+	struct switchover_timer *s =
+		container_of(timer, struct switchover_timer, timer);
 
-	if ((flags & 1)) {
-		if ((inb(TLCLK_REG1) & 0x08) != (flags & 0x08))
+	if ((s->data & 1)) {
+		if ((inb(TLCLK_REG1) & 0x08) != (s->data & 0x08))
 			alarm_events->switchover_primary++;
 	} else {
-		if ((inb(TLCLK_REG1) & 0x08) != (flags & 0x08))
+		if ((inb(TLCLK_REG1) & 0x08) != (s->data & 0x08))
 			alarm_events->switchover_secondary++;
 	}
 
 	/* Alarm processing is done, wake up read task */
-	del_timer(&switchover_timer);
+	del_timer(&switchover_timer.timer);
 	got_event = 1;
 	wake_up(&wq);
 }
@@ -920,10 +923,9 @@ static irqreturn_t tlclk_interrupt(int irq, void *dev_id)
 		alarm_events->pll_holdover++;
 
 		/* TIMEOUT in ~10ms */
-		switchover_timer.expires = jiffies + msecs_to_jiffies(10);
-		tlclk_timer_data = inb(TLCLK_REG1);
-		switchover_timer.data = (unsigned long) &tlclk_timer_data;
-		mod_timer(&switchover_timer, switchover_timer.expires);
+		switchover_timer.data = inb(TLCLK_REG1);
+		mod_timer(&switchover_timer.timer,
+				jiffies + msecs_to_jiffies(10));
 	} else {
 		got_event = 1;
 		wake_up(&wq);
-- 
2.11.0
