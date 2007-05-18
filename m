From: Christoph Hellwig <hch@lst.de>
Date: Fri, 18 May 2007 13:39:17 +0000
Subject: Re: [PATCH] dasd_eer: use mutex instead of semaphore
Message-Id: <20070518133917.GA5147@lst.de>
In-Reply-To: <20070518133357.GA4780@lst.de>
References: <20070518133357.GA4780@lst.de>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 18, 2007 at 11:55:04AM +0000, Jan Glauber wrote:
> Guess the include for semaphore.h could be removed too.

Updated patch below:


Index: linux-2.6/drivers/s390/block/dasd_eer.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd_eer.c	2007-05-18 14:35:01.000000000 +0200
+++ linux-2.6/drivers/s390/block/dasd_eer.c	2007-05-18 14:35:10.000000000 +0200
@@ -14,9 +14,9 @@
 #include <linux/moduleparam.h>
 #include <linux/device.h>
 #include <linux/poll.h>
+#include <linux/mutex.h>
 
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
 #include <asm/atomic.h>
 #include <asm/ebcdic.h>
 
@@ -514,7 +514,7 @@ void dasd_eer_disable(struct dasd_device
  * to transfer in a readbuffer, which is protected by the readbuffer_mutex.
  */
 static char readbuffer[PAGE_SIZE];
-static DECLARE_MUTEX(readbuffer_mutex);
+static DEFINE_MUTEX(readbuffer_mutex);
 
 static int dasd_eer_open(struct inode *inp, struct file *filp)
 {
@@ -579,7 +579,7 @@ static ssize_t dasd_eer_read(struct file
 	struct eerbuffer *eerb;
 
 	eerb = (struct eerbuffer *) filp->private_data;
-	if (down_interruptible(&readbuffer_mutex))
+	if (mutex_lock_interruptible(&readbuffer_mutex))
 		return -ERESTARTSYS;
 
 	spin_lock_irqsave(&bufferlock, flags);
@@ -588,7 +588,7 @@ static ssize_t dasd_eer_read(struct file
 		                  /* has been deleted             */
 		eerb->residual = 0;
 		spin_unlock_irqrestore(&bufferlock, flags);
-		up(&readbuffer_mutex);
+		mutex_unlock(&readbuffer_mutex);
 		return -EIO;
 	} else if (eerb->residual > 0) {
 		/* OK we still have a second half of a record to deliver */
@@ -602,7 +602,7 @@ static ssize_t dasd_eer_read(struct file
 			if (!tc) {
 				/* no data available */
 				spin_unlock_irqrestore(&bufferlock, flags);
-				up(&readbuffer_mutex);
+				mutex_unlock(&readbuffer_mutex);
 				if (filp->f_flags & O_NONBLOCK)
 					return -EAGAIN;
 				rc = wait_event_interruptible(
@@ -610,7 +610,7 @@ static ssize_t dasd_eer_read(struct file
 					eerb->head != eerb->tail);
 				if (rc)
 					return rc;
-				if (down_interruptible(&readbuffer_mutex))
+				if (mutex_lock_interruptible(&readbuffer_mutex))
 					return -ERESTARTSYS;
 				spin_lock_irqsave(&bufferlock, flags);
 			}
@@ -626,11 +626,11 @@ static ssize_t dasd_eer_read(struct file
 	spin_unlock_irqrestore(&bufferlock, flags);
 
 	if (copy_to_user(buf, readbuffer, effective_count)) {
-		up(&readbuffer_mutex);
+		mutex_unlock(&readbuffer_mutex);
 		return -EFAULT;
 	}
 
-	up(&readbuffer_mutex);
+	mutex_unlock(&readbuffer_mutex);
 	return effective_count;
 }
 
