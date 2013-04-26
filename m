From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: [PATCH RESEND 1/9] zfcp: cfdc fops add owner
Date: Fri, 26 Apr 2013 16:13:47 +0200
Message-ID: <1366985635-38270-2-git-send-email-maier@linux.vnet.ibm.com>
References: <1366985635-38270-1-git-send-email-maier@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1366985635-38270-1-git-send-email-maier@linux.vnet.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steffen Maier <maier@linux.vnet.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

Set the owner member of zfcp_cfdc_fops, to ensure that the
caller of these functions holds a module reference.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
---
 drivers/s390/scsi/zfcp_cfdc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/s390/scsi/zfcp_cfdc.c
+++ b/drivers/s390/scsi/zfcp_cfdc.c
@@ -14,6 +14,7 @@
 #include <linux/compat.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/module.h>
 #include <linux/miscdevice.h>
 #include <asm/compat.h>
 #include <asm/ccwdev.h>
@@ -250,6 +251,7 @@ static long zfcp_cfdc_dev_ioctl(struct f
 }
 
 static const struct file_operations zfcp_cfdc_fops = {
+	.owner = THIS_MODULE,
 	.open = nonseekable_open,
 	.unlocked_ioctl = zfcp_cfdc_dev_ioctl,
 #ifdef CONFIG_COMPAT
