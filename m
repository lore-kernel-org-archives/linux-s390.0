Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFDD4F885;
	Wed, 21 Feb 2024 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520093; cv=none; b=ew7I3iI+7iVkxqiylAmR/etQ92+gaVIFn5mD6W/TovlSAWjbsrw7L1yUbgzsTzLD5rrVU3G6uQYpOrNVKaowDWPIyLF5VnzSuYOijHnB2u7kmlpTppIn6XaTVC1T0SVlqBpgdM2FPoFzstwD9mRKTAO8YVVNltgJSHG+Vw9R0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520093; c=relaxed/simple;
	bh=WawsVR8hkjNPB/qd+sfLt5WMg9S1nM1nW88Y0W1SQu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W6U/o/tajVaHrlUhNhz8xYr83+P3m7ePkgzvLPnYbl1nbGNTZxDKEyrlHaGKLuRhMivz3jZJ9lLkvsGPvn03oSIp6TwvUFJbCPYoPIDs9qJDk6euNmvo1fjfnME56H4CsDpVUzkqsbDu1Ph/MTe8bN26M29oRDueS7qTD+jjpso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KI32FTdw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KI32FTdw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0uSWpeGqnS7eKcirKPpWIPTNTYG+uy2cC/BTGTzDV1Q=; b=KI32FTdws5lKbOY3HZDwycvdU5
	aNaNDrDpIGsFc5QQvK9BYJKtq22GZXYiqqGg0mmgjwGdnfKScLmgsKB2dEAvbMgMB8RE85eSTS6rw
	4Dq9BBlYQ/4Z4YA8WMTmupSOYOsRdls6N1F98vrDCo4uXsGDa9qAFWnCtI1h0L9SWgc3027AzRArB
	+OKtqg0rL3vGoQwoq5m9+4YaiBSTZsRYIh33sefkRPQxYmMjD9oAdKEGXYDpCJzpF5H3KKZc5pzML
	G3EIPUl60ClzPx8deCa0O+rMk2n0GuDpzNvrbp840Gnpe1PQJ0TkOjmfuDoq7f86L6v0AHGegB0GV
	NP0FKW/g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcm7e-00000000vLr-47JE;
	Wed, 21 Feb 2024 12:54:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH 3/3] dasd: use the atomic queue limits API
Date: Wed, 21 Feb 2024 13:54:38 +0100
Message-Id: <20240221125438.3609762-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240221125438.3609762-1-hch@lst.de>
References: <20240221125438.3609762-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Pass the constant limits directly to blk_mq_alloc_disk, set the nonrot
flag there as well, and then use the commit API to change the transfer
size and logical block size dependent values.

This relies on the assumption that no I/O can be pending before the
devices moves into the ready state and doesn't need extra freezing
for changes to the queue limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/dasd.c       | 29 ++++++++++++-----------------
 drivers/s390/block/dasd_genhd.c | 13 ++++++++++++-
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 665f69dbb9eab1..51fbff81bc1214 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -308,7 +308,7 @@ static int dasd_state_basic_to_known(struct dasd_device *device)
 static int dasd_state_basic_to_ready(struct dasd_device *device)
 {
 	struct dasd_block *block = device->block;
-	struct request_queue *q;
+	struct queue_limits lim;
 	int rc = 0;
 
 	/* make disk known with correct capacity */
@@ -328,31 +328,26 @@ static int dasd_state_basic_to_ready(struct dasd_device *device)
 		goto out;
 	}
 
-	q = block->gdp->queue;
-	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
-	q->limits.max_dev_sectors = device->discipline->max_transfer(block);
-	blk_queue_max_hw_sectors(q, q->limits.max_dev_sectors);
-	blk_queue_logical_block_size(q, block->bp_block);
-	blk_queue_max_segments(q, USHRT_MAX);
-
-	/* With page sized segments each segment can be translated into one idaw/tidaw */
-	blk_queue_max_segment_size(q, PAGE_SIZE);
-	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
-	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
+	lim = queue_limits_start_update(block->gdp->queue);
+	lim.max_dev_sectors = device->discipline->max_transfer(block);
+	lim.max_hw_sectors = lim.max_dev_sectors;
+	lim.logical_block_size = block->bp_block;
 
 	if (device->discipline->has_discard) {
-		unsigned int max_bytes, max_discard_sectors;
+		unsigned int max_bytes;
 
-		q->limits.discard_granularity = block->bp_block;
+		lim.discard_granularity = block->bp_block;
 
 		/* Calculate max_discard_sectors and make it PAGE aligned */
 		max_bytes = USHRT_MAX * block->bp_block;
 		max_bytes = ALIGN_DOWN(max_bytes, PAGE_SIZE);
-		max_discard_sectors = max_bytes / block->bp_block;
 
-		blk_queue_max_discard_sectors(q, max_discard_sectors);
-		blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
+		lim.max_hw_discard_sectors = max_bytes / block->bp_block;
+		lim.max_write_zeroes_sectors = lim.max_hw_discard_sectors;
 	}
+	rc = queue_limits_commit_update(block->gdp->queue, &lim);
+	if (rc)
+		return rc;
 
 	set_capacity(block->gdp, block->blocks << block->s2b_shift);
 	device->state = DASD_STATE_READY;
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 0465b706745f64..528e2d38d9bfcc 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -34,6 +34,16 @@ MODULE_PARM_DESC(nr_hw_queues, "Default number of hardware queues for new DASD d
  */
 int dasd_gendisk_alloc(struct dasd_block *block)
 {
+	struct queue_limits lim = {
+		/*
+		 * With page sized segments, each segment can be translated into
+		 * one idaw/tidaw.
+		 */
+		.max_segment_size = PAGE_SIZE,
+		.seg_boundary_mask = PAGE_SIZE - 1,
+		.dma_alignment = PAGE_SIZE - 1,
+		.max_segments = USHRT_MAX,
+	};
 	struct gendisk *gdp;
 	struct dasd_device *base;
 	int len, rc;
@@ -53,11 +63,12 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 	if (rc)
 		return rc;
 
-	gdp = blk_mq_alloc_disk(&block->tag_set, NULL, block);
+	gdp = blk_mq_alloc_disk(&block->tag_set, &lim, block);
 	if (IS_ERR(gdp)) {
 		blk_mq_free_tag_set(&block->tag_set);
 		return PTR_ERR(gdp);
 	}
+	blk_queue_flag_set(QUEUE_FLAG_NONROT, gdp->queue);
 
 	/* Initialize gendisk structure. */
 	gdp->major = DASD_MAJOR;
-- 
2.39.2

