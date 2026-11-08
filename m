Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128691;
	b=aJ4MEhYyo1fX+7Ho2nFzKEG3PQ9k9qgcQu9pgY+iyx0DcC7deey5Rs/3fVw0fXx4cRdP
	 Y/ArlofmWlDPOl85MrpEADXMm+kFxdDJ1qP1k975Fya9RuT6uXw4JYvbPxCLdTJJpEazn
	 6yPwplYP9DQQJ/BLp/vaZiM64DZrMLNojJHz7WRybVRf5XZlDyzwEAvFBu61zTW4kYPGc
	 p9gyHYOSLHNY2PH5ZqGb+/MFHCiXeXOCE9Oeco5w8Gw42S7r3FirAoT8fjs1RsYdUDktW
	 v7PsZd7ffrUTm/bVX+2mvz9SvlcXCTPTHx4Lr471jCYu9vHm4jt88Nqx8TjLua7QCIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128691;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=zCDh0FdJGHHHcm++4vUSEYxnfXFdYYVf2X8ZgoxAVCA=;
	b=ADUzAHfjob+LAHd1uFRVq4bXDee89L8eUe/ucSzcjoXkbExd6+eJ5nu36jDd9f1qSM6Z
	 kikPiL0Qru0aLev5gjMHdH7W7cop/atbuh8dnrIb9xxtiDVyVqV3JUFSPm3sV8VOFcVuj
	 lY/Jj5Q9seUVIF0ae0CGc1HNCD/JtJPvBpZI9Xy/pFdf7hhy44KOsSJVIknytFVkcKg7G
	 E6Zi4xwCm7ZG3C0RS5OTWyfg+s+BW+X1H4aXTH5UOstxWYUaz8QO0L68zdkKR91F+9NrW
	 wqCcHm3yR1wQIS62fukNPmmVt9sJbqh83Xs1YHNdVJMYcDqSY6Lhae8Cgma/1DxQy7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bL9za9zi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0976606A323;
	Sun,  8 Nov 2026 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bL9za9zi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF361F008A3;
	Sun,  8 Nov 2026 09:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794128690;
	bh=zCDh0FdJGHHHcm++4vUSEYxnfXFdYYVf2X8ZgoxAVCA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bL9za9ziX7V458bEKKQ9e+tbRc5SidIFKqY8Umw4kkv8inrgSUZnusyctE2cD/try
	 m0OXS5dJqQhMtrvgzcnYchDDRbG8efCtZUZ0i8/cUnmG4EBKg7bSLNugUgqhGq8Nqn
	 lVwrRYKiKpZxAEOOXbZI0wg2ASrDRe/9YoFI+ryey+1tGc9PLeeBu/sBR0fvZ3h2o+
	 Botp0WmwSHfujfTU8EfQhmJaIobIR7LVPcO3y6ZwBxvjTGQcZvEzr1xKH+L8Xwk5cR
	 fh9+Gn9aY0lBRP+DnN7fHfvBTyhP3FLZbAdm0pc3aXGg5Qh0fEThOnsaXGO0LU5dzY
	 GjhlBoPic0Hug==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:58:40 +0200
Subject: [PATCH 09/14] s390/sclp_sd: Replace __get_free_page() with
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
Message-Id: <20261108-s390-sclp-ready-v1-9-3e7c90eb6676@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
In-Reply-To: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
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
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp_sd.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/char/sclp_sd.c b/drivers/s390/char/sclp_sd.c
index c62b2eacdc131..cc0b4481e2bed 100644
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

