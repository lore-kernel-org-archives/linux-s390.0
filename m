Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920858;
	b=EblgTGhUD4XaqJbeddsMaOlsXh6Gu4du/57Gz0RCuMUSkQQ1wb6xsZsCypT4ABFvGpuf
	 GdjSs4yp3HzAtIEK5sCZhn/sv2QiQjgZG4GHbu1JIXcGBfYH3eb62V3u83z8cuPD4n8bJ
	 phH7Qa4U8hlRarr3QNzGq0XrW/ymsDyLhNI9iXFydWXOqgR98snl30YxWdGuyvGjMrWin
	 FewBoVFUXcyuLJq0yD7c/X3USxQME4JpZrDBiU5ShvXdiS/dWs3HKzTl1/PdawhmKsT79
	 +HaKsx4YAYBJLd+sSzHjmSOPQbFhqAVpQFat/JnVr5VUrJh8YdOs5/7XeGcFy47M26A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920858;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=okQA4ysbt0GoyeeAquPH2+CuQPaFH4ebJwUmvndIC94=;
	b=DIMqbYssOIctxmHPSw/8NaqwbArPlHli1zcLz8LY2+FvrdiD1C8BVMkUqQeH38CB8c6B
	 ulzT8KdjaRpY0z5ma1shPz/Ss56dI9KXf+gMRDjNC2TTKz1bWa3ChWqQWWbdDC3UBrEQA
	 CskYbL31PS7FnwNBwEGpG/8Zsdl1sAauq/bZjhT2vzZcaTlwOgMOKR8UNXVjbgkdnC5jG
	 y4zLXwbN2VGKiVyhtccEOAyTtFGJc72Fo1G6k1rQr8KjqW0Gtn5CTsym29Ahmu1LU7BOI
	 W4bq5V5PRn+5QyUWceM1DzDb5sBX6UHP7wuJ8XcW760pM1r0XPOjMyqQCNybP29rPgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyzyRvRJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC982606A89F;
	Tue, 17 Nov 2026 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyzyRvRJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26FF1F000C6;
	Tue, 17 Nov 2026 13:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920858;
	bh=okQA4ysbt0GoyeeAquPH2+CuQPaFH4ebJwUmvndIC94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JyzyRvRJpRWi+1vaFp6LViQmrRrGAKf/rrz6mXqm7Gb4bk0Gp202abACa7fJDKtLl
	 Y3vrr1uQK1uQm3/k+C1Lj0YaUW7JysXzLMtMpCLl6J9QFXQm3WqGr/5Prc7OtX9gwK
	 r8i/PXDJNhaivdhNHBUr2aHkdu8GwssfXRee3wC2knWvK5CM/IPYUYEm8kpANmBhss
	 ALaxHCs6aRSVUOguz01laJBttmBjJ+k4wupN+fvIUFyXoG6+zPgfu6mGz5mbmqXdI6
	 uTrPDeKsknTYfDmxPSjrBNv6Ls5x0bXxaxWJ3tkcqI2sbql3035nGsPlBN/e68O9xm
	 G/JCIeEnSi0rA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 17 Nov 2026 15:07:05 +0200
Subject: [PATCH v2 13/14] s390/sclp_mem: Replace page allocator calls with
 k[mz]alloc()
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
Message-Id: <20261117-s390-sclp-ready-v2-13-e518c99622c6@kernel.org>
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

do_assign_storage(), sclp_attach_storage() and sclp_setup_memory()
allocate the SCCBs used to assign, attach and query standby memory.

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of get_zeroed_page() with kzalloc(), __get_free_page() with
kmalloc() and free_page() with kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp_mem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
index 6df1926d4c62..c28460598d38 100644
--- a/drivers/s390/char/sclp_mem.c
+++ b/drivers/s390/char/sclp_mem.c
@@ -84,7 +84,7 @@ static int do_assign_storage(sclp_cmdw_t cmd, u16 rn)
 	struct assign_storage_sccb *sccb;
 	int rc;
 
-	sccb = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sccb)
 		return -ENOMEM;
 	sccb->header.length = PAGE_SIZE;
@@ -103,7 +103,7 @@ static int do_assign_storage(sclp_cmdw_t cmd, u16 rn)
 		break;
 	}
 out:
-	free_page((unsigned long)sccb);
+	kfree(sccb);
 	return rc;
 }
 
@@ -130,7 +130,7 @@ static int sclp_attach_storage(u8 id)
 	struct attach_storage_sccb *sccb;
 	int rc, i;
 
-	sccb = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sccb)
 		return -ENOMEM;
 	sccb->header.length = PAGE_SIZE;
@@ -152,7 +152,7 @@ static int sclp_attach_storage(u8 id)
 		break;
 	}
 out:
-	free_page((unsigned long)sccb);
+	kfree(sccb);
 	return rc;
 }
 
@@ -487,7 +487,7 @@ static int __init sclp_setup_memory(void)
 	if ((sclp.facilities & 0xe00000000000UL) != 0xe00000000000UL)
 		return 0;
 	rc = -ENOMEM;
-	sccb = (void *)__get_free_page(GFP_KERNEL | GFP_DMA);
+	sccb = kmalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sccb)
 		goto out;
 	assigned = 0;
@@ -530,7 +530,7 @@ static int __init sclp_setup_memory(void)
 		insert_increment(0, 1, 0);
 	rc = sclp_init_mem();
 out:
-	free_page((unsigned long)sccb);
+	kfree(sccb);
 	return rc;
 }
 __initcall(sclp_setup_memory);

-- 
2.53.0

