Return-Path: <linux-kernel-owner+w=401wt.eu-S1753319AbXC2JKq@vger.kernel.org>
Date: Thu, 29 Mar 2007 11:12:18 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [Patch -mm 3/3] s390: cio: Delay uevents for subchannels.
Message-ID: <20070329111218.40c358dd@gondolin.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

We often have the situation that we register a subchannel and start
device recognition, only to find out that the device is not usable
after all, which triggers an unregister of the subchannel. This often
happens on hundreds of subchannels on a LPAR, leading to a storm of
events which aren't of any use. Therefore, use uevent_suppress to
delay the KOBJ_ADD uevent for a subchannel until we know that its
ccw_device is to be registered.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/s390/cio/css.c    |    9 +++++++++
 drivers/s390/cio/device.c |    6 ++++++
 2 files changed, 15 insertions(+)

--- linux-2.6.21-rc5-mm1.orig/drivers/s390/cio/device.c
+++ linux-2.6.21-rc5-mm1/drivers/s390/cio/device.c
@@ -903,6 +903,12 @@ io_subchannel_register(struct work_struc
 		}
 		goto out;
 	}
+	/*
+	 * Now we know this subchannel will stay, we can throw
+	 * our delayed uevent.
+	 */
+	sch->dev.uevent_suppress = 0;
+	kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
 	/* make it known to the system */
 	ret = ccw_device_register(cdev);
 	if (ret) {
--- linux-2.6.21-rc5-mm1.orig/drivers/s390/cio/css.c
+++ linux-2.6.21-rc5-mm1/drivers/s390/cio/css.c
@@ -135,6 +135,15 @@ css_register_subchannel(struct subchanne
 	sch->dev.bus = &css_bus_type;
 	sch->dev.release = &css_subchannel_release;
 	sch->dev.groups = subch_attr_groups;
+	/*
+	 * We don't want to generate uevents for I/O subchannels that don't
+	 * have a working ccw device behind them since they will be
+	 * unregistered before they can be used anyway, so we delay the add
+	 * uevent until after device recognition was successful.
+	 */
+	if (!cio_is_console(sch->schid))
+		/* Console is special, no need to suppress. */
+		sch->dev.uevent_suppress = 1;
 
 	css_get_ssd_info(sch);
 
