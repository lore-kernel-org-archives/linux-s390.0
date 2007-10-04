Return-Path: <linux-kernel-owner+w=401wt.eu-S1760699AbXJDLm3@vger.kernel.org>
Message-Id: <20071004112826.700814369@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:14 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/34] cio: Disable channel path measurements on shutdown/reboot.
Content-Disposition: inline; filename=008-cio-cmf.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Make sure channel path measurements are disabled via a reboot notifier
since we cannot rely on userspace to disable it again after enabling
it. This is 1. clean and 2. makes sure that channel path measurements
do not stay enabled after a reboot not involving a subsystem reset
(which would lead to the channel subsystem scribbling onto random
memory).

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/css.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/list.h>
+#include <linux/reboot.h>
 
 #include "css.h"
 #include "cio.h"
@@ -632,6 +633,29 @@ static int __init setup_css(int nr)
 	return 0;
 }
 
+static int css_reboot_event(struct notifier_block *this,
+			    unsigned long event,
+			    void *ptr)
+{
+	int ret, i;
+
+	ret = NOTIFY_DONE;
+	for (i = 0; i <= __MAX_CSSID; i++) {
+		struct channel_subsystem *css;
+
+		css = channel_subsystems[i];
+		if (css->cm_enabled)
+			if (chsc_secm(css, 0))
+				ret = NOTIFY_BAD;
+	}
+
+	return ret;
+}
+
+static struct notifier_block css_reboot_notifier = {
+	.notifier_call = css_reboot_event,
+};
+
 /*
  * Now that the driver core is running, we can setup our channel subsystem.
  * The struct subchannel's are created during probing (except for the
@@ -697,12 +721,17 @@ init_channel_subsystem (void)
 		if (ret)
 			goto out_file;
 	}
+	ret = register_reboot_notifier(&css_reboot_notifier);
+	if (ret)
+		goto out_pseudo;
 	css_init_done = 1;
 
 	ctl_set_bit(6, 28);
 
 	for_each_subchannel(__init_channel_subsystem, NULL);
 	return 0;
+out_pseudo:
+	device_unregister(&channel_subsystems[i]->pseudo_subchannel->dev);
 out_file:
 	device_remove_file(&channel_subsystems[i]->device,
 			   &dev_attr_cm_enable);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
