Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgHQJS0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Aug 2020 05:18:26 -0400
From: Allen Pais <allen.cryptic@gmail.com>
Subject: [PATCH] drivers: vme: convert tasklets to use new tasklet_setup() API
Date: Mon, 17 Aug 2020 14:46:03 +0530
Message-Id: <20200817091617.28119-9-allen.cryptic@gmail.com>
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
 drivers/vme/bridges/vme_fake.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/vme/bridges/vme_fake.c b/drivers/vme/bridges/vme_fake.c
index 6a1bc284f297..38dd5f949cd0 100644
--- a/drivers/vme/bridges/vme_fake.c
+++ b/drivers/vme/bridges/vme_fake.c
@@ -90,13 +90,13 @@ static struct device *vme_root;
 /*
  * Calling VME bus interrupt callback if provided.
  */
-static void fake_VIRQ_tasklet(unsigned long data)
+static void fake_VIRQ_tasklet(struct tasklet_struct *t)
 {
 	struct vme_bridge *fake_bridge;
 	struct fake_driver *bridge;
 
-	fake_bridge = (struct vme_bridge *) data;
-	bridge = fake_bridge->driver_priv;
+	bridge = from_tasklet(bridge, t, int_tasklet);
+	fake_bridge = bridge->parent;
 
 	vme_irq_handler(fake_bridge, bridge->int_level, bridge->int_statid);
 }
@@ -1098,8 +1098,7 @@ static int __init fake_init(void)
 	/* Initialize wait queues & mutual exclusion flags */
 	mutex_init(&fake_device->vme_int);
 	mutex_init(&fake_bridge->irq_mtx);
-	tasklet_init(&fake_device->int_tasklet, fake_VIRQ_tasklet,
-			(unsigned long) fake_bridge);
+	tasklet_setup(&fake_device->int_tasklet, fake_VIRQ_tasklet);
 
 	strcpy(fake_bridge->name, driver_name);
 
-- 
2.17.1
