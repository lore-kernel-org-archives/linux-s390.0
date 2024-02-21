Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A685D4F885;
	Wed, 21 Feb 2024 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520090; cv=none; b=FxiJodNAGrGWZ/SpM8TxY1hemIcP5AZjjauexoYUvOFzTIi8uR60ADv7OQzpnooy86n9RpMyPWrYrycmqN1llwrctBDFiZMGKgy7eFgSZN1t2OmFQdpOQPu9JXIxSfFylHhy3lI38GXG9lUZeOWUsyUqDJJH6lFbuUPDyZr8vlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520090; c=relaxed/simple;
	bh=2DeyzBQGyB4Bp94ybbTKln2BpVhwbcuxMz//V4CTeZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Plh2Nah58uvVGZTbBALUXV1eRUAVelYu9LSGsBji6RzMMBlizBgCBlJhiCFd38FeDyiKxKwSZYyn7EPfk1qN0ZhrbcRDuTfgL+5cDiZ5FbqIPnld0lR4Vh20hi+GuVfoi9CKOKAgA+a97BIi/xAQ4JjBAtW+1oZHcAXKBD+UpuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ySZyQ6cs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ySZyQ6cs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=c5T0NIfQF08Vs7xosYpDpRT80TMut9HNaXT3LOugXIs=; b=ySZyQ6csCSi86bVM5r7jKaZFxM
	u1XJtw3PSl0WmJBy7qjtXrOByjyzlftqEZ6JLwjuO5Hi1PTrdRlct1D1i1Lc43rkqVhL2GrNliHIg
	WgYofAySC6A58dJ7q9RlhTyxMGDX40CaZs0gjf9PXf6oc1v4kww4h5I/scD3/MZ9f/qbY4mUWA+vK
	6c0/IxivG8Nn9732zDeCZwQpLCptlUYJZgyjwF47hrRAY9zkQTO3vF1lR5uwHaKpHeNtg88BfDNE9
	NUbPbM7es/WAK5jUvJl4ldIIJ2/dj7VPvEaFcGIDciADwfZaXJRhDoL7TMvIS/UpcX0B8dzlVTisK
	5VHHhXKw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcm7b-00000000vKX-23aJ;
	Wed, 21 Feb 2024 12:54:48 +0000
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
Subject: [PATCH 2/3] dasd: move queue setup to common code
Date: Wed, 21 Feb 2024 13:54:37 +0100
Message-Id: <20240221125438.3609762-3-hch@lst.de>
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

Most of the code in setup_blk_queue is shared between all disciplines.
Move it to common code and leave a method to query the maximum number
of transferable blocks, and a flag to indicate discard support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/dasd.c      | 29 +++++++++++++++++++++++++++--
 drivers/s390/block/dasd_diag.c | 22 +++-------------------
 drivers/s390/block/dasd_eckd.c | 29 ++++++-----------------------
 drivers/s390/block/dasd_fba.c  | 33 ++++-----------------------------
 drivers/s390/block/dasd_int.h  |  6 ++----
 5 files changed, 42 insertions(+), 77 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index e754e4f81b2dff..665f69dbb9eab1 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -308,6 +308,7 @@ static int dasd_state_basic_to_known(struct dasd_device *device)
 static int dasd_state_basic_to_ready(struct dasd_device *device)
 {
 	struct dasd_block *block = device->block;
+	struct request_queue *q;
 	int rc = 0;
 
 	/* make disk known with correct capacity */
@@ -327,8 +328,32 @@ static int dasd_state_basic_to_ready(struct dasd_device *device)
 		goto out;
 	}
 
-	if (device->discipline->setup_blk_queue)
-		device->discipline->setup_blk_queue(block);
+	q = block->gdp->queue;
+	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
+	q->limits.max_dev_sectors = device->discipline->max_transfer(block);
+	blk_queue_max_hw_sectors(q, q->limits.max_dev_sectors);
+	blk_queue_logical_block_size(q, block->bp_block);
+	blk_queue_max_segments(q, USHRT_MAX);
+
+	/* With page sized segments each segment can be translated into one idaw/tidaw */
+	blk_queue_max_segment_size(q, PAGE_SIZE);
+	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
+	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
+
+	if (device->discipline->has_discard) {
+		unsigned int max_bytes, max_discard_sectors;
+
+		q->limits.discard_granularity = block->bp_block;
+
+		/* Calculate max_discard_sectors and make it PAGE aligned */
+		max_bytes = USHRT_MAX * block->bp_block;
+		max_bytes = ALIGN_DOWN(max_bytes, PAGE_SIZE);
+		max_discard_sectors = max_bytes / block->bp_block;
+
+		blk_queue_max_discard_sectors(q, max_discard_sectors);
+		blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
+	}
+
 	set_capacity(block->gdp, block->blocks << block->s2b_shift);
 	device->state = DASD_STATE_READY;
 
diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index 041088c7e90915..688097036c6a37 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -617,25 +617,9 @@ dasd_diag_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		    "dump sense not available for DIAG data");
 }
 
-/*
- * Initialize block layer request queue.
- */
-static void dasd_diag_setup_blk_queue(struct dasd_block *block)
+static unsigned int dasd_diag_max_transfer(struct dasd_block *block)
 {
-	unsigned int logical_block_size = block->bp_block;
-	struct request_queue *q = block->gdp->queue;
-	int max;
-
-	max = DIAG_MAX_BLOCKS << block->s2b_shift;
-	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
-	q->limits.max_dev_sectors = max;
-	blk_queue_logical_block_size(q, logical_block_size);
-	blk_queue_max_hw_sectors(q, max);
-	blk_queue_max_segments(q, USHRT_MAX);
-	/* With page sized segments each segment can be translated into one idaw/tidaw */
-	blk_queue_max_segment_size(q, PAGE_SIZE);
-	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
-	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
+	return DIAG_MAX_BLOCKS;
 }
 
 static int dasd_diag_pe_handler(struct dasd_device *device,
@@ -648,10 +632,10 @@ static struct dasd_discipline dasd_diag_discipline = {
 	.owner = THIS_MODULE,
 	.name = "DIAG",
 	.ebcname = "DIAG",
+	.max_transfer = dasd_diag_max_transfer,
 	.check_device = dasd_diag_check_device,
 	.pe_handler = dasd_diag_pe_handler,
 	.fill_geometry = dasd_diag_fill_geometry,
-	.setup_blk_queue = dasd_diag_setup_blk_queue,
 	.start_IO = dasd_start_diag,
 	.term_IO = dasd_diag_term_IO,
 	.handle_terminated_request = dasd_diag_handle_terminated_request,
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 8aade17d885cc9..8574516bf66e01 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -6826,17 +6826,9 @@ static void dasd_eckd_handle_hpf_error(struct dasd_device *device,
 	dasd_schedule_requeue(device);
 }
 
-/*
- * Initialize block layer request queue.
- */
-static void dasd_eckd_setup_blk_queue(struct dasd_block *block)
+static unsigned int dasd_eckd_max_transfer(struct dasd_block *block)
 {
-	unsigned int logical_block_size = block->bp_block;
-	struct request_queue *q = block->gdp->queue;
-	struct dasd_device *device = block->base;
-	int max;
-
-	if (device->features & DASD_FEATURE_USERAW) {
+	if (block->base->features & DASD_FEATURE_USERAW) {
 		/*
 		 * the max_blocks value for raw_track access is 256
 		 * it is higher than the native ECKD value because we
@@ -6844,19 +6836,10 @@ static void dasd_eckd_setup_blk_queue(struct dasd_block *block)
 		 * so the max_hw_sectors are
 		 * 2048 x 512B = 1024kB = 16 tracks
 		 */
-		max = DASD_ECKD_MAX_BLOCKS_RAW << block->s2b_shift;
-	} else {
-		max = DASD_ECKD_MAX_BLOCKS << block->s2b_shift;
+		return DASD_ECKD_MAX_BLOCKS_RAW;
 	}
-	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
-	q->limits.max_dev_sectors = max;
-	blk_queue_logical_block_size(q, logical_block_size);
-	blk_queue_max_hw_sectors(q, max);
-	blk_queue_max_segments(q, USHRT_MAX);
-	/* With page sized segments each segment can be translated into one idaw/tidaw */
-	blk_queue_max_segment_size(q, PAGE_SIZE);
-	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
-	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
+
+	return DASD_ECKD_MAX_BLOCKS;
 }
 
 static struct ccw_driver dasd_eckd_driver = {
@@ -6888,7 +6871,7 @@ static struct dasd_discipline dasd_eckd_discipline = {
 	.basic_to_ready = dasd_eckd_basic_to_ready,
 	.online_to_ready = dasd_eckd_online_to_ready,
 	.basic_to_known = dasd_eckd_basic_to_known,
-	.setup_blk_queue = dasd_eckd_setup_blk_queue,
+	.max_transfer = dasd_eckd_max_transfer,
 	.fill_geometry = dasd_eckd_fill_geometry,
 	.start_IO = dasd_start_IO,
 	.term_IO = dasd_term_IO,
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 045e548630dfb1..d075e70d3796bd 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -748,35 +748,9 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 	free_page((unsigned long) page);
 }
 
-/*
- * Initialize block layer request queue.
- */
-static void dasd_fba_setup_blk_queue(struct dasd_block *block)
+static unsigned int dasd_fba_max_transfer(struct dasd_block *block)
 {
-	unsigned int logical_block_size = block->bp_block;
-	struct request_queue *q = block->gdp->queue;
-	unsigned int max_bytes, max_discard_sectors;
-	int max;
-
-	max = DASD_FBA_MAX_BLOCKS << block->s2b_shift;
-	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
-	q->limits.max_dev_sectors = max;
-	blk_queue_logical_block_size(q, logical_block_size);
-	blk_queue_max_hw_sectors(q, max);
-	blk_queue_max_segments(q, USHRT_MAX);
-	/* With page sized segments each segment can be translated into one idaw/tidaw */
-	blk_queue_max_segment_size(q, PAGE_SIZE);
-	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
-
-	q->limits.discard_granularity = logical_block_size;
-
-	/* Calculate max_discard_sectors and make it PAGE aligned */
-	max_bytes = USHRT_MAX * logical_block_size;
-	max_bytes = ALIGN_DOWN(max_bytes, PAGE_SIZE);
-	max_discard_sectors = max_bytes / logical_block_size;
-
-	blk_queue_max_discard_sectors(q, max_discard_sectors);
-	blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
+	return DASD_FBA_MAX_BLOCKS;
 }
 
 static int dasd_fba_pe_handler(struct dasd_device *device,
@@ -789,10 +763,11 @@ static struct dasd_discipline dasd_fba_discipline = {
 	.owner = THIS_MODULE,
 	.name = "FBA ",
 	.ebcname = "FBA ",
+	.has_discard = true,
 	.check_device = dasd_fba_check_characteristics,
 	.do_analysis = dasd_fba_do_analysis,
 	.pe_handler = dasd_fba_pe_handler,
-	.setup_blk_queue = dasd_fba_setup_blk_queue,
+	.max_transfer = dasd_fba_max_transfer,
 	.fill_geometry = dasd_fba_fill_geometry,
 	.start_IO = dasd_start_IO,
 	.term_IO = dasd_term_IO,
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index a6c5f1fa2d8798..fac69985df5aa7 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -293,6 +293,7 @@ struct dasd_discipline {
 	struct module *owner;
 	char ebcname[8];	/* a name used for tagging and printks */
 	char name[8];		/* a name used for tagging and printks */
+	bool has_discard;
 
 	struct list_head list;	/* used for list of disciplines */
 
@@ -331,10 +332,7 @@ struct dasd_discipline {
 	int (*online_to_ready) (struct dasd_device *);
 	int (*basic_to_known)(struct dasd_device *);
 
-	/*
-	 * Initialize block layer request queue.
-	 */
-	void (*setup_blk_queue)(struct dasd_block *);
+	unsigned int (*max_transfer)(struct dasd_block *);
 	/* (struct dasd_device *);
 	 * Device operation functions. build_cp creates a ccw chain for
 	 * a block device request, start_io starts the request and
-- 
2.39.2

