Return-Path: <linux-kernel-owner+w=401wt.eu-S2993002AbXDDQjL@vger.kernel.org>
Date: Wed, 4 Apr 2007 18:39:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Please pull git390 'for-linus' branch
Message-ID: <20070404163922.GA31898@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 drivers/s390/cio/device_status.c |    8 ++++++++
 mm/rmap.c                        |    4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

Cornelia Huck (1):
      [S390] cio: Fix handling of interrupt for csch().

Martin Schwidefsky (1):
      [S390] page_mkclean data corruption.

diff --git a/drivers/s390/cio/device_status.c b/drivers/s390/cio/device_status.c
index 25d99bd..aa96e67 100644
--- a/drivers/s390/cio/device_status.c
+++ b/drivers/s390/cio/device_status.c
@@ -221,6 +221,14 @@ ccw_device_accumulate_irb(struct ccw_device *cdev, struct irb *irb)
 
 	cdev_irb = &cdev->private->irb;
 
+	/*
+	 * If the clear function had been performed, all formerly pending
+	 * status at the subchannel has been cleared and we must not pass
+	 * intermediate accumulated status to the device driver.
+	 */
+	if (irb->scsw.fctl & SCSW_FCTL_CLEAR_FUNC)
+		memset(&cdev->private->irb, 0, sizeof(struct irb));
+
 	/* Copy bits which are valid only for the start function. */
 	if (irb->scsw.fctl & SCSW_FCTL_START_FUNC) {
 		/* Copy key. */
diff --git a/mm/rmap.c b/mm/rmap.c
index 22ed3f7..b82146e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -498,9 +498,9 @@ int page_mkclean(struct page *page)
 		struct address_space *mapping = page_mapping(page);
 		if (mapping)
 			ret = page_mkclean_file(mapping, page);
+		if (page_test_and_clear_dirty(page))
+			ret = 1;
 	}
-	if (page_test_and_clear_dirty(page))
-		ret = 1;
 
 	return ret;
 }
