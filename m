Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A7344D85
	for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952213; cv=none; b=u9bJSLZihMarofRX1kyZn4lm+TdBQ9yjenarc8oP5/wt8oTPasfys1s7T2a2QegJ7PaKIE3QFAHNOTei4S63/anGGsOYFPBWqXQuYKekIHBepQNnD9OJCG90b69x3Ph8YY4iYAMrJvE9miZCHCAG4tJcTuV9AQP2IDpkaPwNLnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952213; c=relaxed/simple;
	bh=I1ondsfE6pLBzhB25mbV94e3hJfZSAGqKFBRP0zw4SY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M5WhkdQ8nwktBug7cGZ00koHd/QMzYgJmLmxCz6w/IfsvEoEuie4tGuVXVVuLF5ZZEsxH7zYL9+vSwED8dsk4tZCrS6v2AQODNhz51eWilEvSyhPpaLylpxYrcqc+PnrqQJrLVupUMuz7JmM+6ql8ti1IE+/yCmFw9OJ2jC29ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=judH+zIu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="judH+zIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBC71F00A3A;
	Thu, 28 May 2026 07:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779952211;
	bh=1c1GxBaRK4i2VrYKc1D7SrDxaN7Mwh02iqTmnc2kKIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=judH+zIufc5v9Co6ZyKVvqRlnK5XMljRF7ehfTBH0XG81wGenBM1rTxdcUI+V/c+1
	 3sXWvL39a9VKVeHJvo7MaitEJ+ckehXXd4/n6I6G23PZQItw4b+B8OXL1tTMaUEVWh
	 ARAjBxiYwdNgssAQjvfktZy3tEtN0vOsvQXLEjNEXjyFG2nqCmP88MruuuLpS2emdn
	 1bnunzLhHwx++q+kbj9/18pqLsz68VINvlcN3nQrXIfL15bWjM4BfTS+KAbf6BbUtx
	 zzqOs8+/7lErO2NlGXLZE3zrx0zs9w1+LoNR4tbV/yg44o3aKul16V3tRlb2qv+TkT
	 ZO4rRZZ0wpdJg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 28 May 2026 10:09:50 +0300
Subject: [PATCH 2/6] s390/dasd: replace get_zeroed_page() with kzalloc()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-b4-s390-drivers-v1-2-b7108f54d722@kernel.org>
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
In-Reply-To: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>, 
 Aswin Karuvally <aswin@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Harald Freudenberger <freude@linux.ibm.com>, 
 Holger Dengler <dengler@linux.ibm.com>, 
 Jan Hoeppner <hoeppner@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
 Stefan Haberland <sth@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
 linux-s390@vger.kernel.org
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
 drivers/s390/block/dasd_eckd.c | 12 ++++++------
 drivers/s390/block/dasd_eer.c  |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 14e58c336baa..3d6cb07e5217 100644
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
@@ -6958,7 +6958,7 @@ dasd_eckd_init(void)
 		kfree(pe_handler_worker);
 		kfree(dasd_reserve_req);
 		kfree(dasd_vol_info_req);
-		free_page((unsigned long)rawpadpage);
+		kfree(rawpadpage);
 	}
 	return ret;
 }
@@ -6969,7 +6969,7 @@ dasd_eckd_cleanup(void)
 	ccw_driver_unregister(&dasd_eckd_driver);
 	kfree(pe_handler_worker);
 	kfree(dasd_reserve_req);
-	free_page((unsigned long)rawpadpage);
+	kfree(rawpadpage);
 }
 
 module_init(dasd_eckd_init);
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

