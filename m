Return-Path: <linux-kernel-owner+w=401wt.eu-S1757298AbYK0Krt@vger.kernel.org>
Message-Id: <20081127103141.798495350@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:31:10 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 50/60] convert ap_bus printks to pr_xxx macros.
Content-Disposition: inline; filename=165-kmsg-ap.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Index: quilt-2.6/drivers/s390/crypto/ap_bus.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/ap_bus.c
+++ quilt-2.6/drivers/s390/crypto/ap_bus.c
@@ -24,6 +24,9 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#define KMSG_COMPONENT "ap"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -1487,12 +1490,13 @@ int __init ap_module_init(void)
 	int rc, i;
 
 	if (ap_domain_index < -1 || ap_domain_index >= AP_DOMAINS) {
-		printk(KERN_WARNING "Invalid param: domain = %d. "
-		       " Not loading.\n", ap_domain_index);
+		pr_warning("%d is not a valid cryptographic domain\n",
+			   ap_domain_index);
 		return -EINVAL;
 	}
 	if (ap_instructions_available() != 0) {
-		printk(KERN_WARNING "AP instructions not installed.\n");
+		pr_warning("The hardware system does not support "
+			   "AP instructions\n");
 		return -ENODEV;
 	}
 	if (ap_interrupts_available()) {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
