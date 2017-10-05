Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 4 Oct 2017 17:54:35 -0700
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] s390: qdio: Convert timers to use timer_setup()
Message-ID: <20171005005435.GA23979@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This requires commit 686fef928bba ("timer: Prepare to change timer
callback argument type") in v4.14-rc3, but should be otherwise
stand-alone.
---
 drivers/s390/cio/qdio.h       | 2 +-
 drivers/s390/cio/qdio_main.c  | 4 ++--
 drivers/s390/cio/qdio_setup.c | 3 +--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/cio/qdio.h b/drivers/s390/cio/qdio.h
index 7e70f9298cc1..a99bbd21c793 100644
--- a/drivers/s390/cio/qdio.h
+++ b/drivers/s390/cio/qdio.h
@@ -392,7 +392,7 @@ int test_nonshared_ind(struct qdio_irq *);
 /* prototypes for setup */
 void qdio_inbound_processing(unsigned long data);
 void qdio_outbound_processing(unsigned long data);
-void qdio_outbound_timer(unsigned long data);
+void qdio_outbound_timer(struct timer_list *t);
 void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
 		      struct irb *irb);
 int qdio_allocate_qs(struct qdio_irq *irq_ptr, int nr_input_qs,
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index a4ad39ba3873..86b8a474b9a2 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -894,9 +894,9 @@ void qdio_outbound_processing(unsigned long data)
 	__qdio_outbound_processing(q);
 }
 
-void qdio_outbound_timer(unsigned long data)
+void qdio_outbound_timer(struct timer_list *t)
 {
-	struct qdio_q *q = (struct qdio_q *)data;
+	struct qdio_q *q = from_timer(q, t, o.out.timer);
 
 	qdio_tasklet_schedule(q);
 }
diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
index 48b3866a9ded..9ae1380cbc31 100644
--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -252,8 +252,7 @@ static void setup_queues(struct qdio_irq *irq_ptr,
 
 		tasklet_init(&q->tasklet, qdio_outbound_processing,
 			     (unsigned long) q);
-		setup_timer(&q->u.out.timer, (void(*)(unsigned long))
-			    &qdio_outbound_timer, (unsigned long)q);
+		timer_setup(&q->u.out.timer, qdio_outbound_timer, 0);
 	}
 }
 
-- 
2.7.4


-- 
Kees Cook
Pixel Security
