Return-Path: <linux-kernel-owner+w=401wt.eu-S1755609AbYBPQQn@vger.kernel.org>
Message-ID: <47B70C5A.8070202@tiscali.nl>
Date: Sat, 16 Feb 2008 17:16:26 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
Subject: [PATCH 3/3] drivers/s390/block/dcssblk.c: Fix Unlikely(x) != y
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

The patch below was not yet tested. If it's correct as it is, please comment.
---
Fix Unlikely(x) != y

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 3faf053..e6c94db 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -666,7 +666,7 @@ dcssblk_make_request(struct request_queue *q, struct bio *bio)
 		page_addr = (unsigned long)
 			page_address(bvec->bv_page) + bvec->bv_offset;
 		source_addr = dev_info->start + (index<<12) + bytes_done;
-		if (unlikely(page_addr & 4095) != 0 || (bvec->bv_len & 4095) != 0)
+		if (unlikely((page_addr & 4095) != 0) || (bvec->bv_len & 4095) != 0)
 			// More paranoia.
 			goto fail;
 		if (bio_data_dir(bio) == READ) {
