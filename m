Return-Path: <linux-kernel-owner+w=401wt.eu-S1758137AbZFDQVj@vger.kernel.org>
Message-Id: <20090604161903.039335640@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:02 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 15/38] pm: con3215 power management callbacks
Content-Disposition: inline; filename=pm_3215.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Introduce the power management callbacks to the 3215 console. On suspend
the console buffer is flushed to the 3215 device to have an empty console
buffer. Printks done while the 3215 device is suspended are buffered in
the 64K buffer of the 3215 device. If the buffer is full new messages will
push out the oldest messages to make room for the most recent message.
On resume the buffered messages are printed. If the system panics before
the 3215 device is resumed ccw_device_force_console is used to get the
console working again.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/char/con3215.c |  205 +++++++++++++++++++++++++-------------------
 1 file changed, 120 insertions(+), 85 deletions(-)

Index: linux-2.6/drivers/s390/char/con3215.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/con3215.c
+++ linux-2.6/drivers/s390/char/con3215.c
@@ -1,14 +1,12 @@
 /*
- *  drivers/s390/char/con3215.c
- *    3215 line mode terminal driver.
+ * 3215 line mode terminal driver.
  *
- *  S390 version
- *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
+ * Copyright IBM Corp. 1999, 2009
+ * Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *  Updated:
- *   Aug-2000: Added tab support
- *	       Dan Morrison, IBM Corporation (dmorriso@cse.buffalo.edu)
+ * Updated:
+ *  Aug-2000: Added tab support
+ *	      Dan Morrison, IBM Corporation <dmorriso@cse.buffalo.edu>
  */
 
 #include <linux/module.h>
@@ -56,6 +54,7 @@
 #define RAW3215_CLOSING	    32	      /* set while in close process */
 #define RAW3215_TIMER_RUNS  64	      /* set if the output delay timer is on */
 #define RAW3215_FLUSHING    128	      /* set to flush buffer (no delay) */
+#define RAW3215_FROZEN      256	      /* set if 3215 is frozen for suspend */
 
 #define TAB_STOP_SIZE	    8	      /* tab stop size */
 
@@ -111,8 +110,8 @@ static struct tty_driver *tty3215_driver
 /*
  * Get a request structure from the free list
  */
-static inline struct raw3215_req *
-raw3215_alloc_req(void) {
+static inline struct raw3215_req *raw3215_alloc_req(void)
+{
 	struct raw3215_req *req;
 	unsigned long flags;
 
@@ -126,8 +125,8 @@ raw3215_alloc_req(void) {
 /*
  * Put a request structure back to the free list
  */
-static inline void
-raw3215_free_req(struct raw3215_req *req) {
+static inline void raw3215_free_req(struct raw3215_req *req)
+{
 	unsigned long flags;
 
 	if (req->type == RAW3215_FREE)
@@ -145,8 +144,7 @@ raw3215_free_req(struct raw3215_req *req
  * because a 3215 terminal won't accept a new read before the old one is
  * completed.
  */
-static void
-raw3215_mk_read_req(struct raw3215_info *raw)
+static void raw3215_mk_read_req(struct raw3215_info *raw)
 {
 	struct raw3215_req *req;
 	struct ccw1 *ccw;
@@ -174,8 +172,7 @@ raw3215_mk_read_req(struct raw3215_info 
  * buffer to the 3215 device. If a queued write exists it is replaced by
  * the new, probably lengthened request.
  */
-static void
-raw3215_mk_write_req(struct raw3215_info *raw)
+static void raw3215_mk_write_req(struct raw3215_info *raw)
 {
 	struct raw3215_req *req;
 	struct ccw1 *ccw;
@@ -251,8 +248,7 @@ raw3215_mk_write_req(struct raw3215_info
 /*
  * Start a read or a write request
  */
-static void
-raw3215_start_io(struct raw3215_info *raw)
+static void raw3215_start_io(struct raw3215_info *raw)
 {
 	struct raw3215_req *req;
 	int res;
@@ -290,8 +286,7 @@ raw3215_start_io(struct raw3215_info *ra
 /*
  * Function to start a delayed output after RAW3215_TIMEOUT seconds
  */
-static void
-raw3215_timeout(unsigned long __data)
+static void raw3215_timeout(unsigned long __data)
 {
 	struct raw3215_info *raw = (struct raw3215_info *) __data;
 	unsigned long flags;
@@ -300,8 +295,10 @@ raw3215_timeout(unsigned long __data)
 	if (raw->flags & RAW3215_TIMER_RUNS) {
 		del_timer(&raw->timer);
 		raw->flags &= ~RAW3215_TIMER_RUNS;
-		raw3215_mk_write_req(raw);
-		raw3215_start_io(raw);
+		if (!(raw->flags & RAW3215_FROZEN)) {
+			raw3215_mk_write_req(raw);
+			raw3215_start_io(raw);
+		}
 	}
 	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
 }
@@ -312,10 +309,9 @@ raw3215_timeout(unsigned long __data)
  * amount of data is bigger than RAW3215_MIN_WRITE. If a write is not
  * done immediately a timer is started with a delay of RAW3215_TIMEOUT.
  */
-static inline void
-raw3215_try_io(struct raw3215_info *raw)
+static inline void raw3215_try_io(struct raw3215_info *raw)
 {
-	if (!(raw->flags & RAW3215_ACTIVE))
+	if (!(raw->flags & RAW3215_ACTIVE) || (raw->flags & RAW3215_FROZEN))
 		return;
 	if (raw->queued_read != NULL)
 		raw3215_start_io(raw);
@@ -359,8 +355,8 @@ static void raw3215_next_io(struct raw32
 /*
  * Interrupt routine, called from common io layer
  */
-static void
-raw3215_irq(struct ccw_device *cdev, unsigned long intparm, struct irb *irb)
+static void raw3215_irq(struct ccw_device *cdev, unsigned long intparm,
+			struct irb *irb)
 {
 	struct raw3215_info *raw;
 	struct raw3215_req *req;
@@ -459,14 +455,40 @@ raw3215_irq(struct ccw_device *cdev, uns
 }
 
 /*
+ * Drop the oldest line from the output buffer.
+ */
+static void raw3215_drop_line(struct raw3215_info *raw)
+{
+	int ix;
+	char ch;
+
+	BUG_ON(raw->written != 0);
+	ix = (raw->head - raw->count) & (RAW3215_BUFFER_SIZE - 1);
+	while (raw->count > 0) {
+		ch = raw->buffer[ix];
+		ix = (ix + 1) & (RAW3215_BUFFER_SIZE - 1);
+		raw->count--;
+		if (ch == 0x15)
+			break;
+	}
+	raw->head = ix;
+}
+
+/*
  * Wait until length bytes are available int the output buffer.
  * Has to be called with the s390irq lock held. Can be called
  * disabled.
  */
-static void
-raw3215_make_room(struct raw3215_info *raw, unsigned int length)
+static void raw3215_make_room(struct raw3215_info *raw, unsigned int length)
 {
 	while (RAW3215_BUFFER_SIZE - raw->count < length) {
+		/* While console is frozen for suspend we have no other
+		 * choice but to drop message from the buffer to make
+		 * room for even more messages. */
+		if (raw->flags & RAW3215_FROZEN) {
+			raw3215_drop_line(raw);
+			continue;
+		}
 		/* there might be a request pending */
 		raw->flags |= RAW3215_FLUSHING;
 		raw3215_mk_write_req(raw);
@@ -488,8 +510,8 @@ raw3215_make_room(struct raw3215_info *r
 /*
  * String write routine for 3215 devices
  */
-static void
-raw3215_write(struct raw3215_info *raw, const char *str, unsigned int length)
+static void raw3215_write(struct raw3215_info *raw, const char *str,
+			  unsigned int length)
 {
 	unsigned long flags;
 	int c, count;
@@ -529,8 +551,7 @@ raw3215_write(struct raw3215_info *raw, 
 /*
  * Put character routine for 3215 devices
  */
-static void
-raw3215_putchar(struct raw3215_info *raw, unsigned char ch)
+static void raw3215_putchar(struct raw3215_info *raw, unsigned char ch)
 {
 	unsigned long flags;
 	unsigned int length, i;
@@ -566,8 +587,7 @@ raw3215_putchar(struct raw3215_info *raw
  * Flush routine, it simply sets the flush flag and tries to start
  * pending IO.
  */
-static void
-raw3215_flush_buffer(struct raw3215_info *raw)
+static void raw3215_flush_buffer(struct raw3215_info *raw)
 {
 	unsigned long flags;
 
@@ -583,8 +603,7 @@ raw3215_flush_buffer(struct raw3215_info
 /*
  * Fire up a 3215 device.
  */
-static int
-raw3215_startup(struct raw3215_info *raw)
+static int raw3215_startup(struct raw3215_info *raw)
 {
 	unsigned long flags;
 
@@ -602,8 +621,7 @@ raw3215_startup(struct raw3215_info *raw
 /*
  * Shutdown a 3215 device.
  */
-static void
-raw3215_shutdown(struct raw3215_info *raw)
+static void raw3215_shutdown(struct raw3215_info *raw)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
@@ -628,8 +646,7 @@ raw3215_shutdown(struct raw3215_info *ra
 	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
 }
 
-static int
-raw3215_probe (struct ccw_device *cdev)
+static int raw3215_probe (struct ccw_device *cdev)
 {
 	struct raw3215_info *raw;
 	int line;
@@ -675,8 +692,7 @@ raw3215_probe (struct ccw_device *cdev)
 	return 0;
 }
 
-static void
-raw3215_remove (struct ccw_device *cdev)
+static void raw3215_remove (struct ccw_device *cdev)
 {
 	struct raw3215_info *raw;
 
@@ -689,8 +705,7 @@ raw3215_remove (struct ccw_device *cdev)
 	}
 }
 
-static int
-raw3215_set_online (struct ccw_device *cdev)
+static int raw3215_set_online (struct ccw_device *cdev)
 {
 	struct raw3215_info *raw;
 
@@ -701,8 +716,7 @@ raw3215_set_online (struct ccw_device *c
 	return raw3215_startup(raw);
 }
 
-static int
-raw3215_set_offline (struct ccw_device *cdev)
+static int raw3215_set_offline (struct ccw_device *cdev)
 {
 	struct raw3215_info *raw;
 
@@ -715,6 +729,36 @@ raw3215_set_offline (struct ccw_device *
 	return 0;
 }
 
+static int raw3215_pm_stop(struct ccw_device *cdev)
+{
+	struct raw3215_info *raw;
+	unsigned long flags;
+
+	/* Empty the output buffer, then prevent new I/O. */
+	raw = cdev->dev.driver_data;
+	spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
+	raw3215_make_room(raw, RAW3215_BUFFER_SIZE);
+	raw->flags |= RAW3215_FROZEN;
+	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
+	return 0;
+}
+
+static int raw3215_pm_start(struct ccw_device *cdev)
+{
+	struct raw3215_info *raw;
+	unsigned long flags;
+
+	/* Allow I/O again and flush output buffer. */
+	raw = cdev->dev.driver_data;
+	spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
+	raw->flags &= ~RAW3215_FROZEN;
+	raw->flags |= RAW3215_FLUSHING;
+	raw3215_try_io(raw);
+	raw->flags &= ~RAW3215_FLUSHING;
+	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
+	return 0;
+}
+
 static struct ccw_device_id raw3215_id[] = {
 	{ CCW_DEVICE(0x3215, 0) },
 	{ /* end of list */ },
@@ -728,14 +772,17 @@ static struct ccw_driver raw3215_ccw_dri
 	.remove		= &raw3215_remove,
 	.set_online	= &raw3215_set_online,
 	.set_offline	= &raw3215_set_offline,
+	.freeze		= &raw3215_pm_stop,
+	.thaw		= &raw3215_pm_start,
+	.restore	= &raw3215_pm_start,
 };
 
 #ifdef CONFIG_TN3215_CONSOLE
 /*
  * Write a string to the 3215 console
  */
-static void
-con3215_write(struct console *co, const char *str, unsigned int count)
+static void con3215_write(struct console *co, const char *str,
+			  unsigned int count)
 {
 	struct raw3215_info *raw;
 	int i;
@@ -768,13 +815,17 @@ static struct tty_driver *con3215_device
  * panic() calls con3215_flush through a panic_notifier
  * before the system enters a disabled, endless loop.
  */
-static void
-con3215_flush(void)
+static void con3215_flush(void)
 {
 	struct raw3215_info *raw;
 	unsigned long flags;
 
 	raw = raw3215[0];  /* console 3215 is the first one */
+	if (raw->flags & RAW3215_FROZEN)
+		/* The console is still frozen for suspend. */
+		if (ccw_device_force_console())
+			/* Forcing didn't work, no panic message .. */
+			return;
 	spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 	raw3215_make_room(raw, RAW3215_BUFFER_SIZE);
 	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
@@ -811,8 +862,7 @@ static struct console con3215 = {
  * 3215 console initialization code called from console_init().
  * NOTE: This is called before kmalloc is available.
  */
-static int __init
-con3215_init(void)
+static int __init con3215_init(void)
 {
 	struct ccw_device *cdev;
 	struct raw3215_info *raw;
@@ -875,8 +925,7 @@ console_initcall(con3215_init);
  *
  * This routine is called whenever a 3215 tty is opened.
  */
-static int
-tty3215_open(struct tty_struct *tty, struct file * filp)
+static int tty3215_open(struct tty_struct *tty, struct file * filp)
 {
 	struct raw3215_info *raw;
 	int retval, line;
@@ -909,8 +958,7 @@ tty3215_open(struct tty_struct *tty, str
  * This routine is called when the 3215 tty is closed. We wait
  * for the remaining request to be completed. Then we clean up.
  */
-static void
-tty3215_close(struct tty_struct *tty, struct file * filp)
+static void tty3215_close(struct tty_struct *tty, struct file * filp)
 {
 	struct raw3215_info *raw;
 
@@ -927,8 +975,7 @@ tty3215_close(struct tty_struct *tty, st
 /*
  * Returns the amount of free space in the output buffer.
  */
-static int
-tty3215_write_room(struct tty_struct *tty)
+static int tty3215_write_room(struct tty_struct *tty)
 {
 	struct raw3215_info *raw;
 
@@ -944,9 +991,8 @@ tty3215_write_room(struct tty_struct *tt
 /*
  * String write routine for 3215 ttys
  */
-static int
-tty3215_write(struct tty_struct * tty,
-	      const unsigned char *buf, int count)
+static int tty3215_write(struct tty_struct * tty,
+			 const unsigned char *buf, int count)
 {
 	struct raw3215_info *raw;
 
@@ -960,8 +1006,7 @@ tty3215_write(struct tty_struct * tty,
 /*
  * Put character routine for 3215 ttys
  */
-static int
-tty3215_put_char(struct tty_struct *tty, unsigned char ch)
+static int tty3215_put_char(struct tty_struct *tty, unsigned char ch)
 {
 	struct raw3215_info *raw;
 
@@ -972,16 +1017,14 @@ tty3215_put_char(struct tty_struct *tty,
 	return 1;
 }
 
-static void
-tty3215_flush_chars(struct tty_struct *tty)
+static void tty3215_flush_chars(struct tty_struct *tty)
 {
 }
 
 /*
  * Returns the number of characters in the output buffer
  */
-static int
-tty3215_chars_in_buffer(struct tty_struct *tty)
+static int tty3215_chars_in_buffer(struct tty_struct *tty)
 {
 	struct raw3215_info *raw;
 
@@ -989,8 +1032,7 @@ tty3215_chars_in_buffer(struct tty_struc
 	return raw->count;
 }
 
-static void
-tty3215_flush_buffer(struct tty_struct *tty)
+static void tty3215_flush_buffer(struct tty_struct *tty)
 {
 	struct raw3215_info *raw;
 
@@ -1002,9 +1044,8 @@ tty3215_flush_buffer(struct tty_struct *
 /*
  * Currently we don't have any io controls for 3215 ttys
  */
-static int
-tty3215_ioctl(struct tty_struct *tty, struct file * file,
-	      unsigned int cmd, unsigned long arg)
+static int tty3215_ioctl(struct tty_struct *tty, struct file * file,
+			 unsigned int cmd, unsigned long arg)
 {
 	if (tty->flags & (1 << TTY_IO_ERROR))
 		return -EIO;
@@ -1019,8 +1060,7 @@ tty3215_ioctl(struct tty_struct *tty, st
 /*
  * Disable reading from a 3215 tty
  */
-static void
-tty3215_throttle(struct tty_struct * tty)
+static void tty3215_throttle(struct tty_struct * tty)
 {
 	struct raw3215_info *raw;
 
@@ -1031,8 +1071,7 @@ tty3215_throttle(struct tty_struct * tty
 /*
  * Enable reading from a 3215 tty
  */
-static void
-tty3215_unthrottle(struct tty_struct * tty)
+static void tty3215_unthrottle(struct tty_struct * tty)
 {
 	struct raw3215_info *raw;
 	unsigned long flags;
@@ -1049,8 +1088,7 @@ tty3215_unthrottle(struct tty_struct * t
 /*
  * Disable writing to a 3215 tty
  */
-static void
-tty3215_stop(struct tty_struct *tty)
+static void tty3215_stop(struct tty_struct *tty)
 {
 	struct raw3215_info *raw;
 
@@ -1061,8 +1099,7 @@ tty3215_stop(struct tty_struct *tty)
 /*
  * Enable writing to a 3215 tty
  */
-static void
-tty3215_start(struct tty_struct *tty)
+static void tty3215_start(struct tty_struct *tty)
 {
 	struct raw3215_info *raw;
 	unsigned long flags;
@@ -1096,8 +1133,7 @@ static const struct tty_operations tty32
  * 3215 tty registration code called from tty_init().
  * Most kernel services (incl. kmalloc) are available at this poimt.
  */
-static int __init
-tty3215_init(void)
+static int __init tty3215_init(void)
 {
 	struct tty_driver *driver;
 	int ret;
@@ -1142,8 +1178,7 @@ tty3215_init(void)
 	return 0;
 }
 
-static void __exit
-tty3215_exit(void)
+static void __exit tty3215_exit(void)
 {
 	tty_unregister_driver(tty3215_driver);
 	put_tty_driver(tty3215_driver);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
