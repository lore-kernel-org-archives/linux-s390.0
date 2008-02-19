Return-Path: <linux-kernel-owner+w=401wt.eu-S1761442AbYBSOtX@vger.kernel.org>
Message-Id: <20080219144505.490333062@de.ibm.com>
References: <20080219144047.587547541@de.ibm.com>
Date: Tue, 19 Feb 2008 15:40:58 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/13] dcss: Fix Unlikely(x) != y
Content-Disposition: inline; filename=011-dcssblk.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Gerald Schaefer <geraldsc@de.ibm.com>, Stefan Weinhuber <wein@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Roel Kluin <12o3l@tiscali.nl>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Roel Kluin <12o3l@tiscali.nl>

Fix Unlikely(x) != y

Cc: Gerald Schaefer <geraldsc@de.ibm.com>
Cc: Stefan Weinhuber <wein@de.ibm.com>
Cc: Carsten Otte <cotte@de.ibm.com>
Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dcssblk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/block/dcssblk.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dcssblk.c
+++ quilt-2.6/drivers/s390/block/dcssblk.c
@@ -666,7 +666,7 @@ dcssblk_make_request(struct request_queu
 		page_addr = (unsigned long)
 			page_address(bvec->bv_page) + bvec->bv_offset;
 		source_addr = dev_info->start + (index<<12) + bytes_done;
-		if (unlikely(page_addr & 4095) != 0 || (bvec->bv_len & 4095) != 0)
+		if (unlikely((page_addr & 4095) != 0) || (bvec->bv_len & 4095) != 0)
 			// More paranoia.
 			goto fail;
 		if (bio_data_dir(bio) == READ) {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
