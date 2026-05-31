Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C23314A6F
	for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780236519; cv=none; b=GBIIhL5iBvpvkr8MEYv66JbqiPAosnI/k1i0jAb3vCKR3zfGNTIYFYzWybeZEnRbd8EDFVn0iRMb8pJTKS3Q0kiFzqdzGk9yJBYB3JKHK3QHOVPET2LCWs+04/JvWtRqeFrT44KGuj+IV8vBQLSvBcPYch4+EMODxB40UZb+zKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780236519; c=relaxed/simple;
	bh=Uz3LwrRLcO7BAgimobCrqSt46W5MPbUzCuE4oIHHl4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z8P6IWEguE18ZLtlDMPcTzgTOIR1Phyks2+/7Kebt7U0Y176sHoSDwP0IBtnyzGOetAGvFDttFXCgnp7mgstAZWOkgwqeerBW3PErlx6vpVTEEyEcNUZve5g3UpJqX6mJ16nW8YucIQOHDVPAFWtx5yGbCSPei3TpxwAcC1Zi0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PglkLAl8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PglkLAl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C27B1F00893;
	Sun, 31 May 2026 14:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780236517;
	bh=qexmpAzJ545MdbzqBVYLZRSqltDDhrq4Efh2udLlC+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PglkLAl8lUOR8iqUEuTwaRRSXQ2d+ii3Ssx8XUJHlRpZoltHF5RrtKVuhIWJiF8Ye
	 +nD/WBeZdx+l4OCLwAvuowdgEhNsHl1vtZ/sY4+1u4v6WgzZGn0nzqYOm5j6NeZB5j
	 Si9d3uwqRi4e2n7+wRD1DteLE1+Qxtx6R4KasyxVFCJArdVOg1yQryZw6T17LMdxtR
	 0JJm/kb6wQDcrePjMZWmqokd1JUsVOl3X4/9DDAldYRE3LAUcETBap6uSyNXFP+PUx
	 lJHT2sWoWUyPHQBK0LOVbAdzZTL66v3lxtynNHw8Lfk4wruqWp0j/rHZ6Z2ySacB4n
	 yU02FUkVdnEMw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 31 May 2026 17:08:23 +0300
Subject: [PATCH v2 2/6] s390/dasd: replace get_zeroed_page() with kzalloc()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-b4-s390-drivers-v2-2-f7985308ed90@kernel.org>
References: <20260531-b4-s390-drivers-v2-0-f7985308ed90@kernel.org>
In-Reply-To: <20260531-b4-s390-drivers-v2-0-f7985308ed90@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>, 
 Aswin Karuvally <aswin@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Harald Freudenberger <freude@linux.ibm.com>, 
 Holger Dengler <dengler@linux.ibm.com>, 
 Jan Hoeppner <hoeppner@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
 Stefan Haberland <sth@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
 Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org
X-Mailer: b4 0.15.2

DASD driver uses get_zeroed_page() to allocate pages for the Extended Error
Reporting software ring buffer and for a scratch buffer for formatting
sense dump diagnostic text.

These buffers can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/block/dasd_eckd.c | 8 ++++----
 drivers/s390/block/dasd_eer.c  | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 14e58c336baa..74fe73b5738a 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -5569,7 +5569,7 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 
 	dev = &device->cdev->dev;
 
-	page = (char *) get_zeroed_page(GFP_ATOMIC);
+	page = kzalloc(PAGE_SIZE, GFP_ATOMIC);
 	if (page == NULL) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			      "No memory to dump sense data\n");
@@ -5644,7 +5644,7 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 		}
 		dasd_eckd_dump_ccw_range(device, from, last, page + len);
 	}
-	free_page((unsigned long) page);
+	kfree(page);
 }
 
 
@@ -5659,7 +5659,7 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 	struct tsb *tsb;
 	u8 *sense, *rcq;
 
-	page = (char *) get_zeroed_page(GFP_ATOMIC);
+	page = kzalloc(PAGE_SIZE, GFP_ATOMIC);
 	if (page == NULL) {
 		DBF_DEV_EVENT(DBF_WARNING, device, " %s",
 			    "No memory to dump sense data");
@@ -5759,7 +5759,7 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 		sprintf(page + len, "SORRY - NO TSB DATA AVAILABLE\n");
 	}
 	dev_err(&device->cdev->dev, "%s", page);
-	free_page((unsigned long) page);
+	kfree(page);
 }
 
 static void dasd_eckd_dump_sense(struct dasd_device *device,
diff --git a/drivers/s390/block/dasd_eer.c b/drivers/s390/block/dasd_eer.c
index 78d66e2711cd..e96d1805b7bb 100644
--- a/drivers/s390/block/dasd_eer.c
+++ b/drivers/s390/block/dasd_eer.c
@@ -211,7 +211,7 @@ static void dasd_eer_free_buffer_pages(char **buf, int no_pages)
 	int i;
 
 	for (i = 0; i < no_pages; i++)
-		free_page((unsigned long) buf[i]);
+		kfree(buf[i]);
 }
 
 /*
@@ -222,7 +222,7 @@ static int dasd_eer_allocate_buffer_pages(char **buf, int no_pages)
 	int i;
 
 	for (i = 0; i < no_pages; i++) {
-		buf[i] = (char *) get_zeroed_page(GFP_KERNEL);
+		buf[i] = kzalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!buf[i]) {
 			dasd_eer_free_buffer_pages(buf, i);
 			return -ENOMEM;

-- 
2.53.0

