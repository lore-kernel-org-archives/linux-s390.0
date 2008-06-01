Return-Path: <linux-kernel-owner+w=401wt.eu-S1756632AbYFAX3h@vger.kernel.org>
Message-Id: <20080601231515.779423991@gmail.com>
References: <20080601231329.223608711@gmail.com>
Date: Mon, 02 Jun 2008 08:13:35 +0900
From: akinobu.mita@gmail.com
Subject: [patch -v2 06/23] s390/vmcp: use simple_read_from_buffer
Content-Disposition: inline; filename=s390-vmcp-use-simple-read-from-buffer.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/char/vmcp.c |   20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

Index: 2.6-git/drivers/s390/char/vmcp.c
===================================================================
--- 2.6-git.orig/drivers/s390/char/vmcp.c
+++ 2.6-git/drivers/s390/char/vmcp.c
@@ -61,30 +61,22 @@ static int vmcp_release(struct inode *in
 static ssize_t
 vmcp_read(struct file *file, char __user *buff, size_t count, loff_t *ppos)
 {
-	size_t tocopy;
+	ssize_t ret;
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
+	ret = simple_read_from_buffer(buff, count, ppos,
+				session->response, session->resp_size);
 
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
