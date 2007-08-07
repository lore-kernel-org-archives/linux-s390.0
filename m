Return-Path: <linux-kernel-owner+w=401wt.eu-S1760580AbXHGLQc@vger.kernel.org>
Message-Id: <20070807111847.096356469@de.ibm.com>
References: <20070807111519.972871123@de.ibm.com>
Date: Tue, 07 Aug 2007 13:15:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/18] monwriter: Serialization bug for multithreaded applications.
Content-Disposition: inline; filename=010-monwriter.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Melissa Howland <melissah@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Melissa Howland <melissah@us.ibm.com>

Locking added so that multithreaded applications can now do writes 
from different threads without the risk of storage corruption.

Signed-off-by: Melissa Howland <melissah@us.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/monwriter.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: quilt-2.6/drivers/s390/char/monwriter.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/monwriter.c
+++ quilt-2.6/drivers/s390/char/monwriter.c
@@ -17,6 +17,7 @@
 #include <linux/miscdevice.h>
 #include <linux/ctype.h>
 #include <linux/poll.h>
+#include <linux/mutex.h>
 #include <asm/uaccess.h>
 #include <asm/ebcdic.h>
 #include <asm/io.h>
@@ -41,6 +42,7 @@ struct mon_private {
 	size_t hdr_to_read;
 	size_t data_to_read;
 	struct mon_buf *current_buf;
+	struct mutex thread_mutex;
 };
 
 /*
@@ -179,6 +181,7 @@ static int monwrite_open(struct inode *i
 		return -ENOMEM;
 	INIT_LIST_HEAD(&monpriv->list);
 	monpriv->hdr_to_read = sizeof(monpriv->hdr);
+	mutex_init(&monpriv->thread_mutex);
 	filp->private_data = monpriv;
 	return nonseekable_open(inode, filp);
 }
@@ -209,6 +212,7 @@ static ssize_t monwrite_write(struct fil
 	void *to;
 	int rc;
 
+	mutex_lock(&monpriv->thread_mutex);
 	for (written = 0; written < count; ) {
 		if (monpriv->hdr_to_read) {
 			len = min(count - written, monpriv->hdr_to_read);
@@ -247,11 +251,13 @@ static ssize_t monwrite_write(struct fil
 		}
 		monpriv->hdr_to_read = sizeof(monpriv->hdr);
 	}
+	mutex_unlock(&monpriv->thread_mutex);
 	return written;
 
 out_error:
 	monpriv->data_to_read = 0;
 	monpriv->hdr_to_read = sizeof(struct monwrite_hdr);
+	mutex_unlock(&monpriv->thread_mutex);
 	return rc;
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
