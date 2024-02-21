Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AEF69D1B;
	Wed, 21 Feb 2024 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520086; cv=none; b=LaqPtMY9JZZzXb88EBfdbwuFxAbsO44VUH+1hukTNmMwf3ti4/prwrWbOh1drzx4AcvFvDo3DFc2MtzOVo+1L6kRFDBUtdm7qaXaB66OAeYOl6XtTn9KAe/bZLUeCHrWaWqPnmY4qs+sszejColKvBzWSGLeQA7e998FrXdKt+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520086; c=relaxed/simple;
	bh=jMWaw2QgeQI09RIyMhQu6rCM3GUghdO/TgZR03VVWiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=molrBM/FBAWbXgw4m7RqDVkIHLLFMU6pSNR0fDl9hi9ljhjZUIE8OMlFzK8tV4/3s9fSKzixXvMDo+4nUE5G4mt3ygbhvNJTpG7WwrWQPVOQGuD97DVXT69qECCqP+w4s14pmzFjFYEGh8K54InOSbTzDwCsbEc8QA9PKsb8nc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tQneR0bq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tQneR0bq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dBG930IPRrwiglKBZChP2sqApGpTkObBftGmfAAMrqI=; b=tQneR0bq2Ll88jffUUUdfuWYIO
	spAGFl0RKklTrvAMsNHsNJutffurwuTIBLEgwGrmG14AUBh0xofgIEZ310+UxM2+fnX2HPeufFN0j
	DvB3rOVnvQrM9eVe6s7qx/m9Qpplm4RWVkWgAHQVdwbkzyPVl2u0zWWj03BWauskdCTqNr3ZaoMH8
	mh9DExN4P7qsUkyRDXczEJyIGLr03aCOjlopxizVpO1z6rV1LBYSvsAcWLvmqGwJGoKoONK9weqip
	bQpnI/+u0TUrUpjoASg126MwfMb6fknh2Ae2lxOYieq+uCrx3uOfQQ5SrdiGVH7HFdeOMkbMjSO22
	Rkei66MA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcm7Y-00000000vK7-03D7;
	Wed, 21 Feb 2024 12:54:44 +0000
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
Date: Wed, 21 Feb 2024 13:54:36 +0100
Message-Id: <20240221125438.3609762-2-hch@lst.de>
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

Reflow dasd_state_basic_to_ready a bit to make it easier to modify.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

