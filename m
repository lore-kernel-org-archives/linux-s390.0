Return-Path: <linux-kernel-owner+w=401wt.eu-S1758285AbYBIMEs@vger.kernel.org>
Message-Id: <20080209120306.989684234@de.ibm.com>
References: <20080209120157.885371603@de.ibm.com>
Date: Sat, 09 Feb 2008 13:02:01 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/11] zcrypt: Do not start ap poll thread per default
Content-Disposition: inline; filename=004-ap-thread.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Felix Beck <felix.beck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Felix Beck <felix.beck@de.ibm.com>

Do not start ap poll thread per default to increase perfomance with 
z/VM.

Signed-off-by: Felix Beck <felix.beck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/crypto/ap_bus.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/ap_bus.c
+++ quilt-2.6/drivers/s390/crypto/ap_bus.c
@@ -61,9 +61,9 @@ module_param_named(domain, ap_domain_ind
 MODULE_PARM_DESC(domain, "domain index for ap devices");
 EXPORT_SYMBOL(ap_domain_index);
 
-static int ap_thread_flag = 1;
+static int ap_thread_flag = 0;
 module_param_named(poll_thread, ap_thread_flag, int, 0000);
-MODULE_PARM_DESC(poll_thread, "Turn on/off poll thread, default is 1 (on).");
+MODULE_PARM_DESC(poll_thread, "Turn on/off poll thread, default is 0 (off).");
 
 static struct device *ap_root_device = NULL;
 static DEFINE_SPINLOCK(ap_device_lock);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
