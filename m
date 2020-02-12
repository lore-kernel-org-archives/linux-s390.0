Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37941 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbgBLIEk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 12 Feb 2020 03:04:40 -0500
Date: Wed, 12 Feb 2020 13:34:37 +0530
From: afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: [PATCH 11/18] s390: replace setup_irq() by request_irq()
Message-ID: <30f6d47f87ec794ea3fb91387d43d19016fa10bc.1581478324.git.afzal.mohd.ma@gmail.com>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>

request_irq() is preferred over setup_irq(). Existing callers of
setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

Since cc'ing cover letter to all maintainers/reviewers would be too
many, refer for cover letter,
 https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

 arch/s390/kernel/irq.c  | 8 ++------
 drivers/s390/cio/airq.c | 8 ++------
 drivers/s390/cio/cio.c  | 8 ++------
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 8371855042dc..6dd90e8d4e3a 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -294,11 +294,6 @@ static irqreturn_t do_ext_interrupt(int irq, void *dummy)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction external_interrupt = {
-	.name	 = "EXT",
-	.handler = do_ext_interrupt,
-};
-
 void __init init_ext_interrupts(void)
 {
 	int idx;
@@ -308,7 +303,8 @@ void __init init_ext_interrupts(void)
 
 	irq_set_chip_and_handler(EXT_INTERRUPT,
 				 &dummy_irq_chip, handle_percpu_irq);
-	setup_irq(EXT_INTERRUPT, &external_interrupt);
+	if (request_irq(EXT_INTERRUPT, do_ext_interrupt, 0, "EXT", NULL))
+		pr_err("request_irq() on %s failed\n", "EXT");
 }
 
 static DEFINE_SPINLOCK(irq_subclass_lock);
diff --git a/drivers/s390/cio/airq.c b/drivers/s390/cio/airq.c
index 427b2e24a8ce..773208a3bb68 100644
--- a/drivers/s390/cio/airq.c
+++ b/drivers/s390/cio/airq.c
@@ -105,16 +105,12 @@ static irqreturn_t do_airq_interrupt(int irq, void *dummy)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction airq_interrupt = {
-	.name	 = "AIO",
-	.handler = do_airq_interrupt,
-};
-
 void __init init_airq_interrupts(void)
 {
 	irq_set_chip_and_handler(THIN_INTERRUPT,
 				 &dummy_irq_chip, handle_percpu_irq);
-	setup_irq(THIN_INTERRUPT, &airq_interrupt);
+	if (request_irq(THIN_INTERRUPT, do_airq_interrupt, 0, "AIO", NULL))
+		pr_err("request_irq() on %s failed\n", "AIO");
 }
 
 static inline unsigned long iv_size(unsigned long bits)
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 18f5458f90e8..1b87e2e84007 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -563,16 +563,12 @@ static irqreturn_t do_cio_interrupt(int irq, void *dummy)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction io_interrupt = {
-	.name	 = "I/O",
-	.handler = do_cio_interrupt,
-};
-
 void __init init_cio_interrupts(void)
 {
 	irq_set_chip_and_handler(IO_INTERRUPT,
 				 &dummy_irq_chip, handle_percpu_irq);
-	setup_irq(IO_INTERRUPT, &io_interrupt);
+	if (request_irq(IO_INTERRUPT, do_cio_interrupt, 0, "I/O", NULL))
+		pr_err("request_irq() on %s failed\n", "I/O");
 }
 
 #ifdef CONFIG_CCW_CONSOLE
-- 
2.24.1
