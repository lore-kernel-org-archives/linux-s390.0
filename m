Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB9214AD3B;
	Wed, 28 Feb 2024 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127467; cv=none; b=aLSiSy3UCYDuckx82NTAp1Vj/0sUA7w0jTYz8agvTHkDC8LQFhE8NqjhWuSb0kQP7cJmHDOpnRbi4O9u6dhG4jUr5z7Jh87L3Q9V4St7aMEXPPjRDFyCJITc+TufiU+WFgexQ82AP+sJdDDnLAZkpLk5z97lnvv6akPQwyLlESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127467; c=relaxed/simple;
	bh=IU1v18F7dZ7zNJb/sV8gparqcvcJ6I3YZ8Edc2ry7Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t/5PEXGp7DOiSTPOjCVZlmp9HEfyBwOTgfwzsNJj1OT/8pjzpcqOOsfO2+/weDw+f2b8ant3gs3x0/wsNjm1dM9mPZTODNsS8eXEyRauEL0ljsQclMmDmTRaohDLPhSfKd25s0IIsn69XojmWdJsLfo0vGzkFVIMtyoIsIRxkno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dxolwTBh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dxolwTBh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qWTJBjtlwCafEejI848+uDZIagZJE5HRUL7YZhCiV0Q=; b=dxolwTBh9FrJ/yMYDDIKQWahDd
	OeH5oOqD2ydtd5R/jvi3H7Qp2Et8ybwv7FJOKPxYitMoYbe2EEy16H6/jeONUc0yyWX2tQT5wlc5j
	LNerEm3MMpEsgsKDvscoB7Onb+qGlYbjTqLswbdDnJ0IFC5FenBVzTH9DDb0Lreb64sAZ4hdgxFQu
	JEh4rZt+4QN2D/e+wkz36Na1nUGxrDVc82OdXz0GmVyHIlvMpmlQ2rp5jZ9x4QiRtQMHqdDXwMqD8
	KaM4EXcoz7H89tmVTR5MH/zpwiRVDWc3g7+Nr+xEYErFJs/QzmE29yaguLK3W6cBUbTPqQz9mMOKT
	I8m3tz4Q==;
Received: from [12.229.247.3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfK81-00000009V8b-0q43;
	Wed, 28 Feb 2024 13:37:45 +0000
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
Subject: [PATCH 1/3] dasd: cleamup dasd_state_basic_to_ready
Date: Wed, 28 Feb 2024 05:37:40 -0800
Message-Id: <20240228133742.806274-2-hch@lst.de>
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

Reflow dasd_state_basic_to_ready a bit to make it easier to modify.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 54 +++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 2f3adf5d8fee44..e754e4f81b2dff 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -307,39 +307,37 @@ static int dasd_state_basic_to_known(struct dasd_device *device)
  */
 static int dasd_state_basic_to_ready(struct dasd_device *device)
 {
-	int rc;
-	struct dasd_block *block;
-	struct gendisk *disk;
+	struct dasd_block *block = device->block;
+	int rc = 0;
 
-	rc = 0;
-	block = device->block;
 	/* make disk known with correct capacity */
-	if (block) {
-		if (block->base->discipline->do_analysis != NULL)
-			rc = block->base->discipline->do_analysis(block);
-		if (rc) {
-			if (rc != -EAGAIN) {
-				device->state = DASD_STATE_UNFMT;
-				disk = device->block->gdp;
-				kobject_uevent(&disk_to_dev(disk)->kobj,
-					       KOBJ_CHANGE);
-				goto out;
-			}
-			return rc;
-		}
-		if (device->discipline->setup_blk_queue)
-			device->discipline->setup_blk_queue(block);
-		set_capacity(block->gdp,
-			     block->blocks << block->s2b_shift);
+	if (!block) {
 		device->state = DASD_STATE_READY;
-		rc = dasd_scan_partitions(block);
-		if (rc) {
-			device->state = DASD_STATE_BASIC;
+		goto out;
+	}
+
+	if (block->base->discipline->do_analysis != NULL)
+		rc = block->base->discipline->do_analysis(block);
+	if (rc) {
+		if (rc == -EAGAIN)
 			return rc;
-		}
-	} else {
-		device->state = DASD_STATE_READY;
+		device->state = DASD_STATE_UNFMT;
+		kobject_uevent(&disk_to_dev(device->block->gdp)->kobj,
+			       KOBJ_CHANGE);
+		goto out;
 	}
+
+	if (device->discipline->setup_blk_queue)
+		device->discipline->setup_blk_queue(block);
+	set_capacity(block->gdp, block->blocks << block->s2b_shift);
+	device->state = DASD_STATE_READY;
+
+	rc = dasd_scan_partitions(block);
+	if (rc) {
+		device->state = DASD_STATE_BASIC;
+		return rc;
+	}
+
 out:
 	if (device->discipline->basic_to_ready)
 		rc = device->discipline->basic_to_ready(device);
-- 
2.39.2

