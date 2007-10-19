Return-Path: <linux-kernel-owner+w=401wt.eu-S932185AbXJSRUf@vger.kernel.org>
Message-Id: <20071019171944.566891659@de.ibm.com>
References: <20071019171857.430999834@de.ibm.com>
Date: Fri, 19 Oct 2007 19:19:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/10] cio: Fix incomplete commit for uevent suppression.
Content-Disposition: inline; filename=004-cio-uevent.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Commit fa1a8c23eb7d3ded8a3c6d0e653339a2bc7fca9e intended to
introduce uevent suppression for subchannels, but half of it was
lost somewhere. Now, we end up with two uevents for every registered
subchannel :( So we should better add the missing part from
http://marc.info/?l=linux-kernel&m=117515953113974&w=2.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/css.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -182,6 +182,15 @@ static int css_register_subchannel(struc
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
 	css_update_ssd_info(sch);
 	/* make it known to the system */
 	ret = css_sch_device_register(sch);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
