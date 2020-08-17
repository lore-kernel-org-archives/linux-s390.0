Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgHQJTa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Aug 2020 05:19:30 -0400
From: Allen Pais <allen.cryptic@gmail.com>
Subject: [PATCH 1/2] mailbox: bcm: convert tasklets to use new tasklet_setup() API
Date: Mon, 17 Aug 2020 14:46:08 +0530
Message-Id: <20200817091617.28119-14-allen.cryptic@gmail.com>
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
 drivers/mailbox/bcm-pdc-mailbox.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index 53945ca5d785..5b375985f7b8 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -962,9 +962,9 @@ static irqreturn_t pdc_irq_handler(int irq, void *data)
  * a DMA receive interrupt. Reenables the receive interrupt.
  * @data: PDC state structure
  */
-static void pdc_tasklet_cb(unsigned long data)
+static void pdc_tasklet_cb(struct tasklet_struct *t)
 {
-	struct pdc_state *pdcs = (struct pdc_state *)data;
+	struct pdc_state *pdcs = from_tasklet(pdcs, t, rx_tasklet);
 
 	pdc_receive(pdcs);
 
@@ -1589,7 +1589,7 @@ static int pdc_probe(struct platform_device *pdev)
 	pdc_hw_init(pdcs);
 
 	/* Init tasklet for deferred DMA rx processing */
-	tasklet_init(&pdcs->rx_tasklet, pdc_tasklet_cb, (unsigned long)pdcs);
+	tasklet_setup(&pdcs->rx_tasklet, pdc_tasklet_cb);
 
 	err = pdc_interrupts_init(pdcs);
 	if (err)
-- 
2.17.1
