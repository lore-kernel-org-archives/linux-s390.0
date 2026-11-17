Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920826;
	b=jdQuceaBg8I5sb2nwuRwtd60UMewfktS6mmDfwjhfeONIZxB4hbHfrtW1h1lR6gGHc8V
	 kc2Q3DiaDeucrprSgniUTykv7iY3PF/ifLSaEbPexqMhspwQulWBWcGttNeYBTDmwVccm
	 Q2x4N9VdZe9pT+vy9GWMefOPrU3BdKxTShsWQp98sU8FfF1uLQjzfqt1IsUJPKjQvCz28
	 CcgfUkJOCI/wNuj+CJ5yQP4z9tXXZHi8YQTaWOfq2mChXcu71bXPTGDldChUZIGwa//aI
	 vqTWDcHzk3N6ToIzm+DPplDuPZkEeOPPP428A7mnzZIMfbP+D5jUO3c6iI5J7DfFQVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920826;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=uys2UBDVsuwnr9rkivnHsjzKN4wH7PF/d/BG6IyiUZs=;
	b=MNilpkgVs9wA3AukCvuZswOVHVu67J2RMDnumCuAU+IhiDIuvs4QQdADzemWvYKHsJLA
	 CDDwd1LSynLp3GBZDFSwoKUHGC32F5MizNYxCObJVIBDhNrLPQ483EDl4AGMhPM+eKb+/
	 MMr59g5UalrSruzItGZYGS0aqI0MOxHCFlaiAZvVEB1rxw47MY332VjtAKu9Y/66Pjepp
	 Lz3QsrmD1Lvqi+AA64N1BfpjMWdtTt42a1K6h9jz7QcVk2JZAXoRHcp5Utyylt7ZQnDvm
	 c+6JJ/ETMdY4+NIDth9at91jC35clDkOLON46PeM1XADgBlZcakzOkSrLW3BkVkqaSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iwl9SP5i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12E1606A8B5;
	Tue, 17 Nov 2026 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iwl9SP5i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1449D1F00926;
	Tue, 17 Nov 2026 13:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920826;
	bh=uys2UBDVsuwnr9rkivnHsjzKN4wH7PF/d/BG6IyiUZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Iwl9SP5iBv+dmCOjDRreWUCiUR08o8DWwfDthI/7iPKXhyIvvt/2CaaKeEvXucIib
	 fuqsPEqvTdp4gTiNXaRKp23Ew7PY1bmEem/yxi62xjG7M3BeFdYadlQxei6rssC8or
	 bQUy5YprG6FuHQHlPQPQFMLTJRr/jbvr1XydY7IbvkV7X7zmqfXAfmhV41JUVIdH2P
	 y6tDY0q+ygE204WQOqZlVh9HEt0eY/jlk6R9t6V/B9aQamw3DAbleYluQUtJZzA5R9
	 xi6MNEutu5tZGkPmpVGZ1vvbOtRrZfSn/kqgL/l0grbVLJ/1OxnIeR3VtXxlfPjpnV
	 r3JvmJ62+FO8w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 17 Nov 2026 15:06:54 +0200
Subject: [PATCH v2 02/14] s390/sclp_config: Replace get_zeroed_page() with
 kzalloc()
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
Message-Id: <20261117-s390-sclp-ready-v2-2-e518c99622c6@kernel.org>
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

sclp_ofb_send_req() allocates the SCCB used to send an
"Open For Business" event notification to the SCLP.

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
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp_config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_config.c b/drivers/s390/char/sclp_config.c
index 8c77e8c44fc2..16617a679366 100644
--- a/drivers/s390/char/sclp_config.c
+++ b/drivers/s390/char/sclp_config.c
@@ -93,7 +93,7 @@ static int sclp_ofb_send_req(char *ev_data, size_t len)
 
 	if (len > OFB_DATA_MAX)
 		return -EINVAL;
-	sccb = (struct sclp_ofb_sccb *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sccb)
 		return -ENOMEM;
 	/* Setup SCCB for Control-Program Identification */
@@ -119,7 +119,7 @@ static int sclp_ofb_send_req(char *ev_data, size_t len)
 		rc = -EIO;
 	}
 out:
-	free_page((unsigned long)sccb);
+	kfree(sccb);
 	return rc;
 }
 

-- 
2.53.0

