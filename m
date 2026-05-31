Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9852329C7B
	for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780236534; cv=none; b=fvyZ8Y0W+mtWtEz+5+DxkKtqdMCYUjQnlIVolg0Ity50k+L8FsdO05FcQjbqtUbz19D8NLygcACUkMBhca39d8502u5VGgh1gjIpLjEYdigawqXd1nRw2ENHh6yTPq5F0pSPd6QRyjcqTKOLJz8fGfvb5BIvrty84Nh7YM7PgTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780236534; c=relaxed/simple;
	bh=Ky9/HE9g5x/sCQ8YF4QkkDh5TEQQ9p4PlQ5bOasY7NM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wylctin7yv+AIutIYoo+eqKVLrtoqVFpEd99d4wFU86J93RweuBAdU1Xg1+mcqXqT+vevVHKSQnIdsbgXcErSN0g32Kik1W27EJRzA/nHPH5G+pPskQ/ZeknnyPQ5wb+f2TI9ZBvKRr2r68FZJIYgx8Vi26R0Caqlr1HoxGhYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI98ydgC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI98ydgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541C01F00893;
	Sun, 31 May 2026 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780236532;
	bh=Eee/0/uyTqGPmYlUkfdEYR3wUkHVXrSrSZh1//521xE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MI98ydgCowjjQ8wLbxbHu/mfZdOeMla4b/KZgOUUgvgSBuH4CvkbcEJsM5P+ynAVJ
	 71Gfrnc6WxJHD6SdlOZ8D7BeHPc+4wmpE69aOK+kiML6OE5fUFcyZnegeT2ev+ZUDU
	 rRzV5cBE4Q9K7p57FkV9x5KcQ5Vw1763eOVnW+ZhbxvumeBiVWCHj/Kcc5NOKSddVm
	 iBlzeDKfnObbXoUrGk/FWhZ4+S3f7RQaSTYmWZJ/1o2WbqApyUeEsnlCAV+ekilysE
	 Sj94pA6Es1F2VfTzv+fV2x6I1KALNMJ7N0IT4KAks8Nop8Tc7PIaeJSeGksF6J+LKL
	 vLffjKbyB3yhA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 31 May 2026 17:08:27 +0300
Subject: [PATCH v2 6/6] s390/zcrypt: replace get_zeroed_page() with
 kzalloc()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-b4-s390-drivers-v2-6-f7985308ed90@kernel.org>
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

zcrypt_rng_device_add() allocates a buffer for the software random
number generator data cache.

This buffer can be allocated with kmalloc() as there's nothing special
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
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/crypto/zcrypt_api.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index d6a455df228d..f57189c2b839 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -1782,7 +1782,7 @@ int zcrypt_rng_device_add(void)
 
 	mutex_lock(&zcrypt_rng_mutex);
 	if (zcrypt_rng_device_count == 0) {
-		zcrypt_rng_buffer = (u32 *)get_zeroed_page(GFP_KERNEL);
+		zcrypt_rng_buffer = kzalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!zcrypt_rng_buffer) {
 			rc = -ENOMEM;
 			goto out;
@@ -1799,7 +1799,7 @@ int zcrypt_rng_device_add(void)
 	return 0;
 
 out_free:
-	free_page((unsigned long)zcrypt_rng_buffer);
+	kfree(zcrypt_rng_buffer);
 out:
 	mutex_unlock(&zcrypt_rng_mutex);
 	return rc;
@@ -1811,7 +1811,7 @@ void zcrypt_rng_device_remove(void)
 	zcrypt_rng_device_count--;
 	if (zcrypt_rng_device_count == 0) {
 		hwrng_unregister(&zcrypt_rng_dev);
-		free_page((unsigned long)zcrypt_rng_buffer);
+		kfree(zcrypt_rng_buffer);
 	}
 	mutex_unlock(&zcrypt_rng_mutex);
 }

-- 
2.53.0

