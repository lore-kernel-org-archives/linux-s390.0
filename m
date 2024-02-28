Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89F14AD07;
	Wed, 28 Feb 2024 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127469; cv=none; b=i7Ol8W4hrHK5wkKqSzHZUv2/ej9vvzroFCWO85JXYyaeLOS28cYA/lqkbbzOy+ATTpzRbnDdx57w7qYY9oc0jZ+rtseAW2SfgM+tiZjfQKCifR3d6XmxmvQwTdZq/V3xSYHDYaV1ZsRFXfgFYA098MI9rKM3TrVjYd//FKdLxeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127469; c=relaxed/simple;
	bh=+9i0r5EWSsRDqpfAlFeaIQ3wmx62+ebcdZ1S7w5L3dk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HPmNwVbsVF0fyIQ0J1sCHxxJUg/bhi4W1+jGh9O6wkHAY+TYOGVVKMAmMW/V92UgeaUMR6wJrm/+opWjGROnBzHPxpzInBy++vNHFecDuOQJWrGFMGHuZObYptzfDKbrZJpNBh9umropHLi8PctKit8lNCqoZDZg1UiGWAwNyt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cHuT+VvJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cHuT+VvJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gSXo3wlx2LwAnipTedH4KXRUtpY1E223waguUMMdvVs=; b=cHuT+VvJoEGrglOb0KTPEx4+hJ
	T8Ap4DgojvgcnWNlUBFueEEBifItyRhiN9e0F9Xs5hosOmKAwpjDynZ+eLYsl5eHuxhwLb4jnSmHO
	qHehtWCg0Cb1WlFrajqkAb0xNiCk1/qZzPGP5fIxcLj4YafNwrVkDtpMkGeN8oc+qe3KL/2hi0Gql
	Vhj0n8kj2CXB4I/kmx4JMPKhfumRn2nhX96qDmn6L+S4E5am+eihfOvKMKFHuotxxrs+tguS581L8
	9Aut5VeoFr+3FUZXb7W/QTYAV+Y3Db6AadHJp36S0fmmBg0k9k/NkvXnX4dzgV8aqbi+mNQE7ay5k
	CQfFAQqQ==;
Received: from [12.229.247.3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfK82-00000009V90-37b0;
	Wed, 28 Feb 2024 13:37:46 +0000
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
Date: Wed, 28 Feb 2024 05:37:42 -0800
Message-Id: <20240228133742.806274-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228133742.806274-1-hch@lst.de>
References: <20240228133742.806274-1-hch@lst.de>
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
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c       | 29 ++++++++++++-----------------
 drivers/s390/block/dasd_genhd.c | 13 ++++++++++++-
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index bdeab447adfc9d..e8eb710bd25d7c 100644
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
-	q->limits.max_dev_sectors = device->discipline->max_sectors(block);
-	blk_queue_max_hw_sectors(q, q->limits.max_dev_sectors);
-	blk_queue_logical_block_size(q, block->bp_block);
-	blk_queue_max_segments(q, USHRT_MAX);
-
-	/* With page sized segments each segment can be translated into one idaw/tidaw */
-	blk_queue_max_segment_size(q, PAGE_SIZE);
-	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
-	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
+	lim = queue_limits_start_update(block->gdp->queue);
+	lim.max_dev_sectors = device->discipline->max_sectors(block);
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

