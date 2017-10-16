Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 16 Oct 2017 16:44:30 -0700
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] s390/sclp: Convert timers to use timer_setup()
Message-ID: <20171016234430.GA102114@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly. Instead of creating an external static
data variable, just define a separate callback which encodes the "force
restart" desire.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/s390/char/con3215.c    |  6 +++---
 drivers/s390/char/con3270.c    | 10 +++++-----
 drivers/s390/char/sclp.c       | 45 ++++++++++++++++++++++++------------------
 drivers/s390/char/sclp_con.c   |  5 ++---
 drivers/s390/char/sclp_tty.c   |  5 ++---
 drivers/s390/char/sclp_vt220.c |  6 ++----
 drivers/s390/char/tape_core.c  | 14 ++++---------
 drivers/s390/char/tty3270.c    |  8 ++++----
 8 files changed, 48 insertions(+), 51 deletions(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 9ec4ae056158..2f94a438966d 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -281,9 +281,9 @@ static void raw3215_start_io(struct raw3215_info *raw)
 /*
  * Function to start a delayed output after RAW3215_TIMEOUT seconds
  */
-static void raw3215_timeout(unsigned long __data)
+static void raw3215_timeout(struct timer_list *t)
 {
-	struct raw3215_info *raw = (struct raw3215_info *) __data;
+	struct raw3215_info *raw = from_timer(raw, t, timer);
 	unsigned long flags;
 
 	spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
@@ -669,7 +669,7 @@ static struct raw3215_info *raw3215_alloc_info(void)
 		return NULL;
 	}
 
-	setup_timer(&info->timer, raw3215_timeout, (unsigned long)info);
+	timer_setup(&info->timer, raw3215_timeout, 0);
 	init_waitqueue_head(&info->empty_wait);
 	tasklet_init(&info->tlet, raw3215_wakeup, (unsigned long)info);
 	tty_port_init(&info->port);
diff --git a/drivers/s390/char/con3270.c b/drivers/s390/char/con3270.c
index 8522cfce5b4e..62a9061f02d8 100644
--- a/drivers/s390/char/con3270.c
+++ b/drivers/s390/char/con3270.c
@@ -68,7 +68,7 @@ static struct con3270 *condev;
 #define CON_UPDATE_STATUS	4	/* Update status line. */
 #define CON_UPDATE_ALL		8	/* Recreate screen. */
 
-static void con3270_update(struct con3270 *);
+static void con3270_update(struct timer_list *);
 
 /*
  * Setup timeout for a device. On timeout trigger an update.
@@ -204,8 +204,9 @@ con3270_write_callback(struct raw3270_request *rq, void *data)
  * Update console display.
  */
 static void
-con3270_update(struct con3270 *cp)
+con3270_update(struct timer_list *t)
 {
+	struct con3270 *cp = from_timer(cp, t, timer);
 	struct raw3270_request *wrq;
 	char wcc, prolog[6];
 	unsigned long flags;
@@ -551,7 +552,7 @@ con3270_flush(void)
 	con3270_update_status(cp);
 	while (cp->update_flags != 0) {
 		spin_unlock_irqrestore(&cp->view.lock, flags);
-		con3270_update(cp);
+		con3270_update(&cp->timer);
 		spin_lock_irqsave(&cp->view.lock, flags);
 		con3270_wait_write(cp);
 	}
@@ -622,8 +623,7 @@ con3270_init(void)
 
 	INIT_LIST_HEAD(&condev->lines);
 	INIT_LIST_HEAD(&condev->update);
-	setup_timer(&condev->timer, (void (*)(unsigned long)) con3270_update,
-		    (unsigned long) condev);
+	timer_setup(&condev->timer, con3270_update, 0);
 	tasklet_init(&condev->readlet, 
 		     (void (*)(unsigned long)) con3270_read_tasklet,
 		     (unsigned long) condev->read);
diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index 6111c1fa2d1e..eb1f021b05c1 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -135,6 +135,7 @@ static enum sclp_suspend_state_t {
 #define SCLP_BUSY_INTERVAL	10
 #define SCLP_RETRY_INTERVAL	30
 
+static void sclp_request_timeout(bool force_restart);
 static void sclp_process_queue(void);
 static void __sclp_make_read_req(void);
 static int sclp_init_mask(int calculate);
@@ -153,25 +154,32 @@ __sclp_queue_read_req(void)
 
 /* Set up request retry timer. Called while sclp_lock is locked. */
 static inline void
-__sclp_set_request_timer(unsigned long time, void (*function)(unsigned long),
-			 unsigned long data)
+__sclp_set_request_timer(unsigned long time, void (*cb)(struct timer_list *))
 {
 	del_timer(&sclp_request_timer);
-	sclp_request_timer.function = function;
-	sclp_request_timer.data = data;
+	sclp_request_timer.function = (TIMER_FUNC_TYPE)cb;
 	sclp_request_timer.expires = jiffies + time;
 	add_timer(&sclp_request_timer);
 }
 
-/* Request timeout handler. Restart the request queue. If DATA is non-zero,
+static void sclp_request_timeout_restart(struct timer_list *unused)
+{
+	sclp_request_timeout(true);
+}
+
+static void sclp_request_timeout_normal(struct timer_list *unused)
+{
+	sclp_request_timeout(false);
+}
+
+/* Request timeout handler. Restart the request queue. If force_restart,
  * force restart of running request. */
-static void
-sclp_request_timeout(unsigned long data)
+static void sclp_request_timeout(bool force_restart)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&sclp_lock, flags);
-	if (data) {
+	if (force_restart) {
 		if (sclp_running_state == sclp_running_state_running) {
 			/* Break running state and queue NOP read event request
 			 * to get a defined interface state. */
@@ -180,7 +188,7 @@ sclp_request_timeout(unsigned long data)
 		}
 	} else {
 		__sclp_set_request_timer(SCLP_BUSY_INTERVAL * HZ,
-					 sclp_request_timeout, 0);
+					 sclp_request_timeout_normal);
 	}
 	spin_unlock_irqrestore(&sclp_lock, flags);
 	sclp_process_queue();
@@ -238,7 +246,7 @@ static struct sclp_req *__sclp_req_queue_remove_expired_req(void)
  * invokes callback. This timer can be set per request in situations where
  * waiting too long would be harmful to the system, e.g. during SE reboot.
  */
-static void sclp_req_queue_timeout(unsigned long data)
+static void sclp_req_queue_timeout(struct timer_list *unused)
 {
 	unsigned long flags, expires_next;
 	struct sclp_req *req;
@@ -275,12 +283,12 @@ __sclp_start_request(struct sclp_req *req)
 		req->status = SCLP_REQ_RUNNING;
 		sclp_running_state = sclp_running_state_running;
 		__sclp_set_request_timer(SCLP_RETRY_INTERVAL * HZ,
-					 sclp_request_timeout, 1);
+					 sclp_request_timeout_restart);
 		return 0;
 	} else if (rc == -EBUSY) {
 		/* Try again later */
 		__sclp_set_request_timer(SCLP_BUSY_INTERVAL * HZ,
-					 sclp_request_timeout, 0);
+					 sclp_request_timeout_normal);
 		return 0;
 	}
 	/* Request failed */
@@ -314,7 +322,7 @@ sclp_process_queue(void)
 			/* Cannot abort already submitted request - could still
 			 * be active at the SCLP */
 			__sclp_set_request_timer(SCLP_BUSY_INTERVAL * HZ,
-						 sclp_request_timeout, 0);
+						 sclp_request_timeout_normal);
 			break;
 		}
 do_post:
@@ -557,7 +565,7 @@ sclp_sync_wait(void)
 		if (timer_pending(&sclp_request_timer) &&
 		    get_tod_clock_fast() > timeout &&
 		    del_timer(&sclp_request_timer))
-			sclp_request_timer.function(sclp_request_timer.data);
+			sclp_request_timer.function(&sclp_request_timer);
 		cpu_relax();
 	}
 	local_irq_disable();
@@ -914,7 +922,7 @@ static void sclp_check_handler(struct ext_code ext_code,
 
 /* Initial init mask request timed out. Modify request state to failed. */
 static void
-sclp_check_timeout(unsigned long data)
+sclp_check_timeout(struct timer_list *unused)
 {
 	unsigned long flags;
 
@@ -953,7 +961,7 @@ sclp_check_interface(void)
 		sclp_init_req.status = SCLP_REQ_RUNNING;
 		sclp_running_state = sclp_running_state_running;
 		__sclp_set_request_timer(SCLP_RETRY_INTERVAL * HZ,
-					 sclp_check_timeout, 0);
+					 sclp_check_timeout);
 		spin_unlock_irqrestore(&sclp_lock, flags);
 		/* Enable service-signal interruption - needs to happen
 		 * with IRQs enabled. */
@@ -1158,9 +1166,8 @@ sclp_init(void)
 	INIT_LIST_HEAD(&sclp_req_queue);
 	INIT_LIST_HEAD(&sclp_reg_list);
 	list_add(&sclp_state_change_event.list, &sclp_reg_list);
-	init_timer(&sclp_request_timer);
-	init_timer(&sclp_queue_timer);
-	sclp_queue_timer.function = sclp_req_queue_timeout;
+	timer_setup(&sclp_request_timer, NULL, 0);
+	timer_setup(&sclp_queue_timer, sclp_req_queue_timeout, 0);
 	/* Check interface */
 	spin_unlock_irqrestore(&sclp_lock, flags);
 	rc = sclp_check_interface();
diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
index 9b5ac8f8c206..7a5d3e8cb290 100644
--- a/drivers/s390/char/sclp_con.c
+++ b/drivers/s390/char/sclp_con.c
@@ -124,7 +124,7 @@ static void sclp_console_sync_queue(void)
  * temporary write buffer without further waiting on a final new line.
  */
 static void
-sclp_console_timeout(unsigned long data)
+sclp_console_timeout(struct timer_list *unused)
 {
 	sclp_conbuf_emit();
 }
@@ -210,7 +210,6 @@ sclp_console_write(struct console *console, const char *message,
 	/* Setup timer to output current console buffer after 1/10 second */
 	if (sclp_conbuf != NULL && sclp_chars_in_buffer(sclp_conbuf) != 0 &&
 	    !timer_pending(&sclp_con_timer)) {
-		setup_timer(&sclp_con_timer, sclp_console_timeout, 0UL);
 		mod_timer(&sclp_con_timer, jiffies + HZ / 10);
 	}
 out:
@@ -331,7 +330,7 @@ sclp_console_init(void)
 	INIT_LIST_HEAD(&sclp_con_outqueue);
 	spin_lock_init(&sclp_con_lock);
 	sclp_conbuf = NULL;
-	init_timer(&sclp_con_timer);
+	timer_setup(&sclp_con_timer, sclp_console_timeout, 0);
 
 	/* Set output format */
 	if (MACHINE_IS_VM)
diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 469487e09671..4a0bf38a1b3c 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -150,7 +150,7 @@ __sclp_ttybuf_emit(struct sclp_buffer *buffer)
  * temporary write buffer.
  */
 static void
-sclp_tty_timeout(unsigned long data)
+sclp_tty_timeout(struct timer_list *unused)
 {
 	unsigned long flags;
 	struct sclp_buffer *buf;
@@ -217,7 +217,6 @@ static int sclp_tty_write_string(const unsigned char *str, int count, int may_fa
 	/* Setup timer to output current console buffer after 1/10 second */
 	if (sclp_ttybuf && sclp_chars_in_buffer(sclp_ttybuf) &&
 	    !timer_pending(&sclp_tty_timer)) {
-		setup_timer(&sclp_tty_timer, sclp_tty_timeout, 0UL);
 		mod_timer(&sclp_tty_timer, jiffies + HZ / 10);
 	}
 	spin_unlock_irqrestore(&sclp_tty_lock, flags);
@@ -525,7 +524,7 @@ sclp_tty_init(void)
 	}
 	INIT_LIST_HEAD(&sclp_tty_outqueue);
 	spin_lock_init(&sclp_tty_lock);
-	init_timer(&sclp_tty_timer);
+	timer_setup(&sclp_tty_timer, sclp_tty_timeout, 0);
 	sclp_ttybuf = NULL;
 	sclp_tty_buffer_count = 0;
 	if (MACHINE_IS_VM) {
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 095481d32236..8d0049030b1b 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -356,7 +356,7 @@ sclp_vt220_add_msg(struct sclp_vt220_request *request,
  * Emit buffer after having waited long enough for more data to arrive.
  */
 static void
-sclp_vt220_timeout(unsigned long data)
+sclp_vt220_timeout(struct timer_list *unused)
 {
 	sclp_vt220_emit_current();
 }
@@ -453,8 +453,6 @@ __sclp_vt220_write(const unsigned char *buf, int count, int do_schedule,
 	/* Setup timer to output current console buffer after some time */
 	if (sclp_vt220_current_request != NULL &&
 	    !timer_pending(&sclp_vt220_timer) && do_schedule) {
-		sclp_vt220_timer.function = sclp_vt220_timeout;
-		sclp_vt220_timer.data = 0UL;
 		sclp_vt220_timer.expires = jiffies + BUFFER_MAX_DELAY;
 		add_timer(&sclp_vt220_timer);
 	}
@@ -698,7 +696,7 @@ static int __init __sclp_vt220_init(int num_pages)
 	spin_lock_init(&sclp_vt220_lock);
 	INIT_LIST_HEAD(&sclp_vt220_empty);
 	INIT_LIST_HEAD(&sclp_vt220_outqueue);
-	init_timer(&sclp_vt220_timer);
+	timer_setup(&sclp_vt220_timer, sclp_vt220_timeout, 0);
 	tty_port_init(&sclp_vt220_port);
 	sclp_vt220_current_request = NULL;
 	sclp_vt220_buffered_chars = 0;
diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index 9dd4534823b3..32503a60ee85 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -32,7 +32,7 @@
 
 static void __tape_do_irq (struct ccw_device *, unsigned long, struct irb *);
 static void tape_delayed_next_request(struct work_struct *);
-static void tape_long_busy_timeout(unsigned long data);
+static void tape_long_busy_timeout(struct timer_list *t);
 
 /*
  * One list to contain all tape devices of all disciplines, so
@@ -381,8 +381,7 @@ tape_generic_online(struct tape_device *device,
 		return -EINVAL;
 	}
 
-	init_timer(&device->lb_timeout);
-	device->lb_timeout.function = tape_long_busy_timeout;
+	timer_setup(&device->lb_timeout, tape_long_busy_timeout, 0);
 
 	/* Let the discipline have a go at the device. */
 	device->discipline = discipline;
@@ -867,18 +866,16 @@ tape_delayed_next_request(struct work_struct *work)
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 }
 
-static void tape_long_busy_timeout(unsigned long data)
+static void tape_long_busy_timeout(struct timer_list *t)
 {
+	struct tape_device *device = from_timer(device, t, lb_timeout);
 	struct tape_request *request;
-	struct tape_device *device;
 
-	device = (struct tape_device *) data;
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	request = list_entry(device->req_queue.next, struct tape_request, list);
 	BUG_ON(request->status != TAPE_REQUEST_LONG_BUSY);
 	DBF_LH(6, "%08x: Long busy timeout.\n", device->cdev_id);
 	__tape_start_next_request(device);
-	device->lb_timeout.data = 0UL;
 	tape_put_device(device);
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 }
@@ -1157,7 +1154,6 @@ __tape_do_irq (struct ccw_device *cdev, unsigned long intparm, struct irb *irb)
 		if (req->status == TAPE_REQUEST_LONG_BUSY) {
 			DBF_EVENT(3, "(%08x): del timer\n", device->cdev_id);
 			if (del_timer(&device->lb_timeout)) {
-				device->lb_timeout.data = 0UL;
 				tape_put_device(device);
 				__tape_start_next_request(device);
 			}
@@ -1212,8 +1208,6 @@ __tape_do_irq (struct ccw_device *cdev, unsigned long intparm, struct irb *irb)
 		case TAPE_IO_PENDING:
 			break;
 		case TAPE_IO_LONG_BUSY:
-			device->lb_timeout.data =
-				(unsigned long) tape_get_device(device);
 			device->lb_timeout.expires = jiffies +
 				LONG_BUSY_TIMEOUT * HZ;
 			DBF_EVENT(3, "(%08x): add timer\n", device->cdev_id);
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index e5ebe2fbee23..e417ccd9e299 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -118,7 +118,7 @@ struct tty3270 {
 #define TTY_UPDATE_STATUS	8	/* Update status line. */
 #define TTY_UPDATE_ALL		16	/* Recreate screen. */
 
-static void tty3270_update(struct tty3270 *);
+static void tty3270_update(struct timer_list *);
 static void tty3270_resize_work(struct work_struct *work);
 
 /*
@@ -361,8 +361,9 @@ tty3270_write_callback(struct raw3270_request *rq, void *data)
  * Update 3270 display.
  */
 static void
-tty3270_update(struct tty3270 *tp)
+tty3270_update(struct timer_list *t)
 {
+	struct tty3270 *tp = from_timer(tp, t, timer);
 	static char invalid_sba[2] = { 0xff, 0xff };
 	struct raw3270_request *wrq;
 	unsigned long updated;
@@ -748,8 +749,7 @@ tty3270_alloc_view(void)
 		goto out_reset;
 
 	tty_port_init(&tp->port);
-	setup_timer(&tp->timer, (void (*)(unsigned long)) tty3270_update,
-		    (unsigned long) tp);
+	timer_setup(&tp->timer, tty3270_update, 0);
 	tasklet_init(&tp->readlet,
 		     (void (*)(unsigned long)) tty3270_read_tasklet,
 		     (unsigned long) tp->read);
-- 
2.7.4


-- 
Kees Cook
Pixel Security
