Return-Path: <linux-kernel-owner+w=401wt.eu-S1757479AbYFAXek@vger.kernel.org>
Message-Id: <20080601231643.286530029@gmail.com>
References: <20080601231329.223608711@gmail.com>
Date: Mon, 02 Jun 2008 08:13:50 +0900
From: akinobu.mita@gmail.com
Subject: [patch -v2 21/23] s390: use memory_read_from_buffer
Content-Disposition: inline; filename=s390-ipl-use-memory-read-from-buffer.patch
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
 arch/s390/kernel/ipl.c |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

Index: 2.6-git/arch/s390/kernel/ipl.c
===================================================================
--- 2.6-git.orig/arch/s390/kernel/ipl.c
+++ 2.6-git/arch/s390/kernel/ipl.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/ctype.h>
+#include <linux/fs.h>
 #include <asm/ipl.h>
 #include <asm/smp.h>
 #include <asm/setup.h>
@@ -285,14 +286,8 @@ static struct kobj_attribute sys_ipl_dev
 static ssize_t ipl_parameter_read(struct kobject *kobj, struct bin_attribute *attr,
 				  char *buf, loff_t off, size_t count)
 {
-	unsigned int size = IPL_PARMBLOCK_SIZE;
-
-	if (off > size)
-		return 0;
-	if (off + count > size)
-		count = size - off;
-	memcpy(buf, (void *)IPL_PARMBLOCK_START + off, count);
-	return count;
+	return memory_read_from_buffer(buf, count, &off, IPL_PARMBLOCK_START,
+					IPL_PARMBLOCK_SIZE);
 }
 
 static struct bin_attribute ipl_parameter_attr = {
@@ -310,12 +305,7 @@ static ssize_t ipl_scp_data_read(struct 
 	unsigned int size = IPL_PARMBLOCK_START->ipl_info.fcp.scp_data_len;
 	void *scp_data = &IPL_PARMBLOCK_START->ipl_info.fcp.scp_data;
 
-	if (off > size)
-		return 0;
-	if (off + count > size)
-		count = size - off;
-	memcpy(buf, scp_data + off, count);
-	return count;
+	return memory_read_from_buffer(buf, count, &off, scp_data, size);
 }
 
 static struct bin_attribute ipl_scp_data_attr = {

-- 
