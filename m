Return-Path: <linux-kernel-owner+w=401wt.eu-S1763726AbZBYPTt@vger.kernel.org>
Message-Id: <20090225150830.567708847@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:35 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 13/46] hvc_iucv: Update and add missing kernel messages
Content-Disposition: inline; filename=112-hvc_iucv-msg.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

If the hvc_iucv= kernel parameter specifies a value that is not
valid, display an error message.
Minor changes to existing kernel messages.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/char/hvc_iucv.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/char/hvc_iucv.c
===================================================================
--- quilt-2.6.orig/drivers/char/hvc_iucv.c
+++ quilt-2.6/drivers/char/hvc_iucv.c
@@ -885,7 +885,7 @@ static int __init hvc_iucv_init(void)
 	unsigned int i;
 
 	if (!MACHINE_IS_VM) {
-		pr_info("The z/VM IUCV HVC device driver cannot "
+		pr_notice("The z/VM IUCV HVC device driver cannot "
 			   "be used without z/VM\n");
 		return -ENODEV;
 	}
@@ -893,8 +893,11 @@ static int __init hvc_iucv_init(void)
 	if (!hvc_iucv_devices)
 		return -ENODEV;
 
-	if (hvc_iucv_devices > MAX_HVC_IUCV_LINES)
+	if (hvc_iucv_devices > MAX_HVC_IUCV_LINES) {
+		pr_err("%lu is not a valid value for the hvc_iucv= "
+			"kernel parameter\n", hvc_iucv_devices);
 		return -EINVAL;
+	}
 
 	hvc_iucv_buffer_cache = kmem_cache_create(KMSG_COMPONENT,
 					   sizeof(struct iucv_tty_buffer),

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
