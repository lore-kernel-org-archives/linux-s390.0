Return-Path: <linux-kernel-owner+w=401wt.eu-S1761100AbYFDMLm@vger.kernel.org>
Message-Id: <20080604115726.830731509@gmail.com>
References: <20080604115633.116832712@gmail.com>
Date: Wed, 04 Jun 2008 20:56:38 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [patch -v3 05/22] s390/vmcp: use simple_read_from_buffer
Content-Disposition: inline; filename=s390-vmcp-use-simple-read-from-buffer.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/char/vmcp.c |   22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

Index: 2.6-git/drivers/s390/char/vmcp.c
===================================================================
--- 2.6-git.orig/drivers/s390/char/vmcp.c
+++ 2.6-git/drivers/s390/char/vmcp.c
@@ -61,30 +61,24 @@ static int vmcp_release(struct inode *in
 static ssize_t
 vmcp_read(struct file *file, char __user *buff, size_t count, loff_t *ppos)
 {
-	size_t tocopy;
+	ssize_t ret;
+	size_t size;
 	struct vmcp_session *session;
 
-	session = (struct vmcp_session *)file->private_data;
+	session = file->private_data;
 	if (mutex_lock_interruptible(&session->mutex))
 		return -ERESTARTSYS;
 	if (!session->response) {
 		mutex_unlock(&session->mutex);
 		return 0;
 	}
-	if (*ppos > session->resp_size) {
-		mutex_unlock(&session->mutex);
-		return 0;
-	}
-	tocopy = min(session->resp_size - (size_t) (*ppos), count);
-	tocopy = min(tocopy, session->bufsize - (size_t) (*ppos));
+	size = min_t(size_t, session->resp_size, session->bufsize);
+	ret = simple_read_from_buffer(buff, count, ppos,
+					session->response, size);
 
-	if (copy_to_user(buff, session->response + (*ppos), tocopy)) {
-		mutex_unlock(&session->mutex);
-		return -EFAULT;
-	}
 	mutex_unlock(&session->mutex);
-	*ppos += tocopy;
-	return tocopy;
+
+	return ret;
 }
 
 static ssize_t

-- 
