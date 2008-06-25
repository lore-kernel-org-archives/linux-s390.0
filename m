Return-Path: <linux-kernel-owner+w=401wt.eu-S1758547AbYFYOjA@vger.kernel.org>
Message-Id: <20080625143613.663567264@de.ibm.com>
References: <20080625143459.100139455@de.ibm.com>
Date: Wed, 25 Jun 2008 16:35:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/21] Cleanup vmwatch printk messages.
Content-Disposition: inline; filename=808-printk-vmwatchdog.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmwatchdog.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

Index: quilt-2.6/drivers/s390/char/vmwatchdog.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmwatchdog.c
+++ quilt-2.6/drivers/s390/char/vmwatchdog.c
@@ -92,23 +92,15 @@ static int vmwdt_keepalive(void)
 
 	func = vmwdt_conceal ? (wdt_init | wdt_conceal) : wdt_init;
 	ret = __diag288(func, vmwdt_interval, ebc_cmd, len);
+	WARN_ON(ret != 0);
 	kfree(ebc_cmd);
-
-	if (ret) {
-		printk(KERN_WARNING "%s: problem setting interval %d, "
-			"cmd %s\n", __func__, vmwdt_interval,
-			vmwdt_cmd);
-	}
 	return ret;
 }
 
 static int vmwdt_disable(void)
 {
 	int ret = __diag288(wdt_cancel, 0, "", 0);
-	if (ret) {
-		printk(KERN_WARNING "%s: problem disabling watchdog\n",
-			__func__);
-	}
+	WARN_ON(ret != 0);
 	return ret;
 }
 
@@ -121,10 +113,8 @@ static int __init vmwdt_probe(void)
 	static char __initdata ebc_begin[] = {
 		194, 197, 199, 201, 213
 	};
-	if (__diag288(wdt_init, 15, ebc_begin, sizeof(ebc_begin)) != 0) {
-		printk(KERN_INFO "z/VM watchdog not available\n");
+	if (__diag288(wdt_init, 15, ebc_begin, sizeof(ebc_begin)) != 0)
 		return -EINVAL;
-	}
 	return vmwdt_disable();
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
