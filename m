Return-Path: <linux-kernel-owner+w=401wt.eu-S1753401AbZG1RLH@vger.kernel.org>
Date: Tue, 28 Jul 2009 19:09:59 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
Subject: [PATCH] drivers/s390: put NULL test before dereference
Message-ID: <Pine.LNX.4.64.0907281909190.28189@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux390@de.ibm.com, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
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

---
 drivers/s390/block/dasd.c           |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 001af66..e109da4 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2133,9 +2133,9 @@ static int dasd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	struct dasd_device *base;
 
 	block = bdev->bd_disk->private_data;
-	base = block->base;
 	if (!block)
 		return -ENODEV;
+	base = block->base;
 
 	if (!base->discipline ||
 	    !base->discipline->fill_geometry)
