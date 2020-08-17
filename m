Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgHQJRd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Aug 2020 05:17:33 -0400
From: Allen Pais <allen.cryptic@gmail.com>
Subject: [PATCH] drivers: atm: convert tasklets to use new tasklet_setup() API
Date: Mon, 17 Aug 2020 14:45:59 +0530
Message-Id: <20200817091617.28119-5-allen.cryptic@gmail.com>
In-Reply-To: <20200817091617.28119-1-allen.cryptic@gmail.com>
References: <20200817091617.28119-1-allen.cryptic@gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, 3chas3@gmail.com, axboe@kernel.dk, stefanr@s5r6.in-berlin.de, airlied@linux.ie, daniel@ffwll.ch, sre@kernel.org, James.Bottomley@HansenPartnership.com, kys@microsoft.com, deller@gmx.de, dmitry.torokhov@gmail.com, jassisinghbrar@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de, maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org, mporter@kernel.crashing.org, alex.bou9@gmail.com, broonie@kernel.org, martyn@welchs.me.uk, manohar.vanga@gmail.com, mitch@sfgoth.com, davem@davemloft.net, kuba@kernel.org
Cc: keescook@chromium.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org, openipmi-developer@lists.sourceforge.net, linux1394-devel@lists.sourceforge.net, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, linux-parisc@vger.kernel.org, linux-input@vger.kernel.org, linux-mmc@vger.kernel.org, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, linux-spi@vger.kernel.org, devel@driverdev.osuosl.org, Allen Pais <allen.lkml@gmail.com>, Romain Perier <romain.perier@gmail.com>

From: Allen Pais <allen.lkml@gmail.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/atm/eni.c       |  9 +++++----
 drivers/atm/fore200e.c  | 14 +++++++-------
 drivers/atm/he.c        |  8 ++++----
 drivers/atm/solos-pci.c |  8 ++++----
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/atm/eni.c b/drivers/atm/eni.c
index 39be444534d0..540edea0ad7a 100644
--- a/drivers/atm/eni.c
+++ b/drivers/atm/eni.c
@@ -1521,10 +1521,11 @@ static irqreturn_t eni_int(int irq,void *dev_id)
 }
 
 
-static void eni_tasklet(unsigned long data)
+static void eni_tasklet(struct tasklet_struct *t)
 {
-	struct atm_dev *dev = (struct atm_dev *) data;
-	struct eni_dev *eni_dev = ENI_DEV(dev);
+	struct eni_dev *eni_dev = from_tasklet(eni_dev, t, task);
+	struct atm_dev *dev = container_of((void *)eni_dev, typeof(*dev),
+					  dev_data);
 	unsigned long flags;
 	u32 events;
 
@@ -1838,7 +1839,7 @@ static int eni_start(struct atm_dev *dev)
 	     eni_dev->vci,eni_dev->rx_dma,eni_dev->tx_dma,
 	     eni_dev->service,buf);
 	spin_lock_init(&eni_dev->lock);
-	tasklet_init(&eni_dev->task,eni_tasklet,(unsigned long) dev);
+	tasklet_setup(&eni_dev->task,eni_tasklet);
 	eni_dev->events = 0;
 	/* initialize memory management */
 	buffer_mem = eni_dev->mem - (buf - eni_dev->ram);
diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index a81bc49c14ac..8c6226b50e4d 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -1180,9 +1180,9 @@ fore200e_interrupt(int irq, void* dev)
 
 #ifdef FORE200E_USE_TASKLET
 static void
-fore200e_tx_tasklet(unsigned long data)
+fore200e_tx_tasklet(struct tasklet_struct *t)
 {
-    struct fore200e* fore200e = (struct fore200e*) data;
+    struct fore200e* fore200e = from_tasklet(fore200e, t, tx_tasklet);
     unsigned long flags;
 
     DPRINTK(3, "tx tasklet scheduled for device %d\n", fore200e->atm_dev->number);
@@ -1194,15 +1194,15 @@ fore200e_tx_tasklet(unsigned long data)
 
 
 static void
-fore200e_rx_tasklet(unsigned long data)
+fore200e_rx_tasklet(struct tasklet_struct *t)
 {
-    struct fore200e* fore200e = (struct fore200e*) data;
+    struct fore200e* fore200e = from_tasklet(fore200e, t, rx_tasklet);
     unsigned long    flags;
 
     DPRINTK(3, "rx tasklet scheduled for device %d\n", fore200e->atm_dev->number);
 
     spin_lock_irqsave(&fore200e->q_lock, flags);
-    fore200e_rx_irq((struct fore200e*) data);
+    fore200e_rx_irq(fore200e);
     spin_unlock_irqrestore(&fore200e->q_lock, flags);
 }
 #endif
@@ -1943,8 +1943,8 @@ static int fore200e_irq_request(struct fore200e *fore200e)
 	   fore200e_irq_itoa(fore200e->irq), fore200e->name);
 
 #ifdef FORE200E_USE_TASKLET
-    tasklet_init(&fore200e->tx_tasklet, fore200e_tx_tasklet, (unsigned long)fore200e);
-    tasklet_init(&fore200e->rx_tasklet, fore200e_rx_tasklet, (unsigned long)fore200e);
+    tasklet_setup(&fore200e->tx_tasklet, fore200e_tx_tasklet);
+    tasklet_setup(&fore200e->rx_tasklet, fore200e_rx_tasklet);
 #endif
 
     fore200e->state = FORE200E_STATE_IRQ;
diff --git a/drivers/atm/he.c b/drivers/atm/he.c
index 8af793f5e811..9c36fea4336f 100644
--- a/drivers/atm/he.c
+++ b/drivers/atm/he.c
@@ -100,7 +100,7 @@ static void he_close(struct atm_vcc *vcc);
 static int he_send(struct atm_vcc *vcc, struct sk_buff *skb);
 static int he_ioctl(struct atm_dev *dev, unsigned int cmd, void __user *arg);
 static irqreturn_t he_irq_handler(int irq, void *dev_id);
-static void he_tasklet(unsigned long data);
+static void he_tasklet(struct tasklet_struct *t);
 static int he_proc_read(struct atm_dev *dev,loff_t *pos,char *page);
 static int he_start(struct atm_dev *dev);
 static void he_stop(struct he_dev *dev);
@@ -383,7 +383,7 @@ static int he_init_one(struct pci_dev *pci_dev,
 	he_dev->atm_dev->dev_data = he_dev;
 	atm_dev->dev_data = he_dev;
 	he_dev->number = atm_dev->number;
-	tasklet_init(&he_dev->tasklet, he_tasklet, (unsigned long) he_dev);
+	tasklet_setup(&he_dev->tasklet, he_tasklet);
 	spin_lock_init(&he_dev->global_lock);
 
 	if (he_start(atm_dev)) {
@@ -1925,10 +1925,10 @@ he_service_rbpl(struct he_dev *he_dev, int group)
 }
 
 static void
-he_tasklet(unsigned long data)
+he_tasklet(struct tasklet_struct *t)
 {
 	unsigned long flags;
-	struct he_dev *he_dev = (struct he_dev *) data;
+	struct he_dev *he_dev = from_tasklet(he_dev, t, tasklet);
 	int group, type;
 	int updated = 0;
 
diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index 94fbc3abe60e..f44e1880cb74 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -167,7 +167,7 @@ static struct atm_vcc* find_vcc(struct atm_dev *dev, short vpi, int vci);
 static int atm_init(struct solos_card *, struct device *);
 static void atm_remove(struct solos_card *);
 static int send_command(struct solos_card *card, int dev, const char *buf, size_t size);
-static void solos_bh(unsigned long);
+static void solos_bh(struct tasklet_struct *t);
 static int print_buffer(struct sk_buff *buf);
 
 static inline void solos_pop(struct atm_vcc *vcc, struct sk_buff *skb)
@@ -754,9 +754,9 @@ static irqreturn_t solos_irq(int irq, void *dev_id)
 	return IRQ_RETVAL(handled);
 }
 
-static void solos_bh(unsigned long card_arg)
+static void solos_bh(struct tasklet_struct *t)
 {
-	struct solos_card *card = (void *)card_arg;
+	struct solos_card *card = from_tasklet(card, t, tlet);
 	uint32_t card_flags;
 	uint32_t rx_done = 0;
 	int port;
@@ -1294,7 +1294,7 @@ static int fpga_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	pci_set_drvdata(dev, card);
 
-	tasklet_init(&card->tlet, solos_bh, (unsigned long)card);
+	tasklet_setup(&card->tlet, solos_bh);
 	spin_lock_init(&card->tx_lock);
 	spin_lock_init(&card->tx_queue_lock);
 	spin_lock_init(&card->cli_queue_lock);
-- 
2.17.1
