Return-Path: <linux-kernel-owner+w=401wt.eu-S934206AbXG0LdG@vger.kernel.org>
Message-Id: <20070727113540.638204787@de.ibm.com>
References: <20070727113348.413110503@de.ibm.com>
Date: Fri, 27 Jul 2007 13:33:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/6] vmur: fix diag14_read.
Content-Disposition: inline; filename=010-vmur-read.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Frank Munzert <munzert@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Frank Munzert <munzert@de.ibm.com>

Record length of spool file must be only stored in 1st SPLINK record

Signed-off-by: Frank Munzert <munzert@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmur.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/char/vmur.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmur.c
+++ quilt-2.6/drivers/s390/char/vmur.c
@@ -486,7 +486,7 @@ static ssize_t diag14_read(struct file *
 		}
 		if (rc)
 			goto fail;
-		if (reclen)
+		if (reclen && (copied == 0) && (*offs < PAGE_SIZE))
 			*((u16 *) &buf[FILE_RECLEN_OFFSET]) = reclen;
 		len = min(count - copied, PAGE_SIZE - res);
 		if (copy_to_user(ubuf + copied, buf + res, len)) {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
