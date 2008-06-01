Return-Path: <linux-kernel-owner+w=401wt.eu-S1758215AbYFAXeX@vger.kernel.org>
Message-Id: <20080601231638.355013541@gmail.com>
References: <20080601231329.223608711@gmail.com>
Date: Mon, 02 Jun 2008 08:13:49 +0900
From: akinobu.mita@gmail.com
Subject: [patch -v2 20/23] s390/cio: use memory_read_from_buffer
Content-Disposition: inline; filename=cio-use-memory-read-from-buffer.patch
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
 drivers/s390/cio/chp.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

Index: 2.6-git/drivers/s390/cio/chp.c
===================================================================
--- 2.6-git.orig/drivers/s390/cio/chp.c
+++ 2.6-git/drivers/s390/cio/chp.c
@@ -15,6 +15,7 @@
 #include <linux/wait.h>
 #include <linux/mutex.h>
 #include <linux/errno.h>
+#include <linux/fs.h>
 #include <asm/chpid.h>
 #include <asm/sclp.h>
 
@@ -141,21 +142,14 @@ static ssize_t chp_measurement_chars_rea
 {
 	struct channel_path *chp;
 	struct device *device;
-	unsigned int size;
 
 	device = container_of(kobj, struct device, kobj);
 	chp = to_channelpath(device);
 	if (!chp->cmg_chars)
 		return 0;
 
-	size = sizeof(struct cmg_chars);
-
-	if (off > size)
-		return 0;
-	if (off + count > size)
-		count = size - off;
-	memcpy(buf, chp->cmg_chars + off, count);
-	return count;
+	return memory_read_from_buffer(buf, count, &off,
+				chp->cmg_chars, sizeof(struct cmg_chars));
 }
 
 static struct bin_attribute chp_measurement_chars_attr = {

-- 
