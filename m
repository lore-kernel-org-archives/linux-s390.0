Return-Path: <linux-kernel-owner+w=401wt.eu-S1762066AbXHVMdv@vger.kernel.org>
Message-Id: <20070822123642.278525659@de.ibm.com>
References: <20070822123603.501231302@de.ibm.com>
Date: Wed, 22 Aug 2007 14:36:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/10] cio: change confusing message in cmf.
Content-Disposition: inline; filename=002-cio-cmf.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

cmf currently prints a message that more than 4096 channels are not
allowed in basic mode - however, this can only be enforced if cmf was
a module (which is no longer possible). It makes much more sense to
not check the specified number of channels and just print a message if
the block for basic mode could not be allocated (which may happen for
any number of specified channels).

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cmf.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

Index: quilt-2.6/drivers/s390/cio/cmf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cmf.c
+++ quilt-2.6/drivers/s390/cio/cmf.c
@@ -594,6 +594,9 @@ alloc_cmb (struct ccw_device *cdev)
 			free_pages((unsigned long)mem, get_order(size));
 		} else if (!mem) {
 			/* no luck */
+			printk(KERN_WARNING "cio: failed to allocate area "
+			       "for measuring %d subchannels\n",
+			       cmb_area.num_channels);
 			ret = -ENOMEM;
 			goto out;
 		} else {
@@ -1279,13 +1282,6 @@ init_cmf(void)
 	case CMF_BASIC:
 		format_string = "basic";
 		cmbops = &cmbops_basic;
-		if (cmb_area.num_channels > 4096 || cmb_area.num_channels < 1) {
-			printk(KERN_ERR "cio: Basic channel measurement "
-			       "facility can only use 1 to 4096 devices\n"
-			       KERN_ERR "when the cmf driver is built"
-			       " as a loadable module\n");
-			return 1;
-		}
 		break;
 	case CMF_EXTENDED:
  		format_string = "extended";

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
