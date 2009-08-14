Return-Path: <linux-kernel-owner+w=401wt.eu-S1756405AbZHNLdQ@vger.kernel.org>
Message-Id: <20090814112615.383275103@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 12/34] drivers/s390: put NULL test before dereference
Content-Disposition: inline; filename=111-dasd-null-pointer.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Julia Lawall <julia@diku.dk>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Julia Lawall <julia@diku.dk>

If the NULL test on block is needed, it should be before the dereference of
the base field.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
expression E1,E2;
identifier fld;
statement S1,S2;
@@

E1 = E2->fld;
(
if (E1 == NULL) S1 else S2
|
*if (E2 == NULL) S1 else S2
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c
+++ quilt-2.6/drivers/s390/block/dasd.c
@@ -2133,9 +2133,9 @@ static int dasd_getgeo(struct block_devi
 	struct dasd_device *base;
 
 	block = bdev->bd_disk->private_data;
-	base = block->base;
 	if (!block)
 		return -ENODEV;
+	base = block->base;
 
 	if (!base->discipline ||
 	    !base->discipline->fill_geometry)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
