Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920846;
	b=1pEdvivQ1qg66zx5yC4PMK66SvHQ4gCuGP/2gUvaNNVhLhoNVVfws3b8ULvvCaIF0ZQ4
	 t5varWrumx7YyYcsjoXawCW3WnW70ry35Q8ZTRsFcdOUSiHIosCEsX1kUBNmXySftHmbv
	 qgxxFlnRnVUSXF0sLEmTXnFfQD/v6/hcTx75YmIDYse6OffW//2NGHLa/+r8p9GKW4EN7
	 tLmgSKh+ENPVmkFy7JCzuCuP4wapKWbEp0tt9TD8Khddcq4thb0Gr12nTD0RPMFq3b8op
	 a2OqVhzjRo3LgwmLFIQyflK78tyKCMeJlJET40FdEoVKfWDgZCj0VZJm8P30Kj/FZlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920846;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Q4aAPS3La36qnAuTPtUQpT52zqdMUZ5MW1Cj8yEUWgM=;
	b=0rcoug6tdD7KPGAAxLhHvSvqn/j/5SUYcm06hm+isedoeVtjWesxevanu7p/DJkqlU1S
	 i1xsrSBn4To7Wes/KZB1FqISw+VOTjETzbtkt/lQ4SxXwWXPzJIaO4M7SUz3iuqXnRq1/
	 Kq+znoFmnYN6ZUVxg7AuMjNPfyk6fRDkq2RVESz4DDqU90o4UFHMy2dE6ar8Lv24lyn64
	 iuI/5AykG3px6PyuAmJF556XZ0s6h7vBye/viK09SfzIJHTlvDYnmu8I9LQVWTwH0BAeF
	 KBOliCcuno2D9b/ef0cZLgn/QxWsD/1VdbeWsdl0tIuzas/CWQ2T0WI/6p2u2ZRvIhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMM3NMnl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3160A3813;
	Tue, 17 Nov 2026 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMM3NMnl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564571F000CA;
	Tue, 17 Nov 2026 13:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920846;
	bh=Q4aAPS3La36qnAuTPtUQpT52zqdMUZ5MW1Cj8yEUWgM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BMM3NMnl5lZ4Rl5Wx6Pj9BFq+qsgQLIYxsd4DuJ/Y3390AKe7GJSFAHeFtvVM+JU0
	 KqB5UUK//gKrHzo+RGE+RAgfYHU/13DRgDpvSLT8YoNEPHjBTQT576ghUhJyXbXIAW
	 r9kAsbcdgFF7kZ3vr2pdmhbzFGCmR74/WIT/caQugksDOh1QAwGk4KtFNkMexZJfP1
	 59HGjcNCCsCOIRJr/Hdi3GUfuDcY3MaqDPZIWXU9OHJC1Xhb/4UhDpnwlNX3/M/1Qv
	 iYnr1lElTPTvrZF2ZMuSHkRxnW6y+KARdGpAXB/TlozaVMwhXlIoE3wa9J5lHOcGQ0
	 a0cxEU7FnugRw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 17 Nov 2026 15:07:01 +0200
Subject: [PATCH v2 09/14] s390/sclp_sd: Replace __get_free_page() with
 kmalloc()
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-s390-sclp-ready-v2-9-e518c99622c6@kernel.org>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
In-Reply-To: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Sven Schnelle <svens@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org
X-Mailer: b4 0.16.1-dev

sclp_sd_store_data() allocates the SCCB used for the SCLP store data
requests.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

While on it, pass the SCCB to sclp_sd_sync() as a typed pointer instead
of an unsigned long.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp_sd.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/char/sclp_sd.c b/drivers/s390/char/sclp_sd.c
index c62b2eacdc13..cc0b4481e2be 100644
--- a/drivers/s390/char/sclp_sd.c
+++ b/drivers/s390/char/sclp_sd.c
@@ -173,7 +173,7 @@ static struct sclp_register sclp_sd_register = {
 
 /**
  * sclp_sd_sync() - Perform Store Data request synchronously
- * @page: Address of work page - must be below 2GB
+ * @sccb: Address of work SCCB - must be below 2GB
  * @eq: Input EQ value
  * @di: Input DI value
  * @sat: Input SAT value
@@ -186,10 +186,9 @@ static struct sclp_register sclp_sd_register = {
  * Return %0 on success and store resulting DSIZE and ESIZE values in
  * @dsize_ptr and @esize_ptr (if provided). Return non-zero on error.
  */
-static int sclp_sd_sync(unsigned long page, u8 eq, u8 di, u64 sat, u64 sa,
+static int sclp_sd_sync(struct sclp_sd_sccb *sccb, u8 eq, u8 di, u64 sat, u64 sa,
 			u32 *dsize_ptr, u32 *esize_ptr)
 {
-	struct sclp_sd_sccb *sccb = (void *) page;
 	struct sclp_sd_listener listener;
 	struct sclp_sd_evbuf *evbuf;
 	int rc;
@@ -291,17 +290,18 @@ static int sclp_sd_sync(unsigned long page, u8 eq, u8 di, u64 sat, u64 sa,
  */
 static int sclp_sd_store_data(struct sclp_sd_data *result, u8 di)
 {
+	struct sclp_sd_sccb *sccb;
 	u32 dsize = 0, esize = 0;
-	unsigned long page, asce = 0;
+	unsigned long asce = 0;
 	void *data = NULL;
 	int rc;
 
-	page = __get_free_page(GFP_KERNEL | GFP_DMA);
-	if (!page)
+	sccb = kmalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
+	if (!sccb)
 		return -ENOMEM;
 
 	/* Get size */
-	rc = sclp_sd_sync(page, SD_EQ_SIZE, di, 0, 0, &dsize, &esize);
+	rc = sclp_sd_sync(sccb, SD_EQ_SIZE, di, 0, 0, &dsize, &esize);
 	if (rc)
 		goto out;
 	if (dsize == 0)
@@ -323,12 +323,12 @@ static int sclp_sd_store_data(struct sclp_sd_data *result, u8 di)
 	}
 
 	/* Get data */
-	rc = sclp_sd_sync(page, SD_EQ_STORE_DATA, di, asce, (u64) data, &dsize,
+	rc = sclp_sd_sync(sccb, SD_EQ_STORE_DATA, di, asce, (u64) data, &dsize,
 			  &esize);
 	if (rc) {
 		/* Cancel running request if interrupted or timed out */
 		if (rc == -ERESTARTSYS || rc == -ETIME) {
-			if (sclp_sd_sync(page, SD_EQ_HALT, di, 0, 0, NULL, NULL)) {
+			if (sclp_sd_sync(sccb, SD_EQ_HALT, di, 0, 0, NULL, NULL)) {
 				pr_warn("Could not stop Store Data request - leaking at least %zu bytes\n",
 					(size_t)dsize * PAGE_SIZE);
 				data = NULL;
@@ -346,7 +346,7 @@ static int sclp_sd_store_data(struct sclp_sd_data *result, u8 di)
 
 out:
 	base_asce_free(asce);
-	free_page(page);
+	kfree(sccb);
 
 	return rc;
 }

-- 
2.53.0

