Return-Path: <linux-kernel-owner+w=401wt.eu-S1761253AbYFDML4@vger.kernel.org>
Message-Id: <20080604115731.998579106@gmail.com>
References: <20080604115633.116832712@gmail.com>
Date: Wed, 04 Jun 2008 20:56:39 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [patch -v3 06/22] s390: use simple_read_from_buffer
Content-Disposition: inline; filename=hypfs-use-simple-read-from-buffer.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
---
 arch/s390/hypfs/inode.c |   29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

Index: 2.6-git/arch/s390/hypfs/inode.c
===================================================================
--- 2.6-git.orig/arch/s390/hypfs/inode.c
+++ 2.6-git/arch/s390/hypfs/inode.c
@@ -150,33 +150,24 @@ static ssize_t hypfs_aio_read(struct kio
 			      unsigned long nr_segs, loff_t offset)
 {
 	char *data;
-	size_t len;
+	ssize_t ret;
 	struct file *filp = iocb->ki_filp;
 	/* XXX: temporary */
 	char __user *buf = iov[0].iov_base;
 	size_t count = iov[0].iov_len;
 
-	if (nr_segs != 1) {
-		count = -EINVAL;
-		goto out;
-	}
+	if (nr_segs != 1)
+		return -EINVAL;
 
 	data = filp->private_data;
-	len = strlen(data);
-	if (offset > len) {
-		count = 0;
-		goto out;
-	}
-	if (count > len - offset)
-		count = len - offset;
-	if (copy_to_user(buf, data + offset, count)) {
-		count = -EFAULT;
-		goto out;
-	}
-	iocb->ki_pos += count;
+	ret = simple_read_from_buffer(buf, count, &offset, data, strlen(data));
+	if (ret <= 0)
+		return ret;
+
+	iocb->ki_pos += ret;
 	file_accessed(filp);
-out:
-	return count;
+
+	return ret;
 }
 static ssize_t hypfs_aio_write(struct kiocb *iocb, const struct iovec *iov,
 			      unsigned long nr_segs, loff_t offset)

-- 
