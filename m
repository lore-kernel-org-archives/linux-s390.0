Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128703;
	b=if/c2GKjUz3DI4YmGZwMDLCuw53cH0A2+N3dniOPQsy+Lgcb6DqjJ23S6mVvgIQmFJzk
	 S+kDCKYjrF5ih4fe+LCCyS9q3tvjqpAARyM4WnDOR/l5Jtxj2xK9RhPut1NK7yIpZ9Z3Q
	 rMHHq+zkjbQh7y9aGhgOWbh54IB0F028u16EQBc9PQI16kgQFr6h2tJF16RE6HTaf0f+Q
	 EZnMOvwzOd5wCFbHEtq4C8p+iyrBY7d/9VD9vJyaVdFIGm/xMfRqsTtzOrhIfBhPezxig
	 xDod9ae7zFDiG6IQ1bhKHMs8qF9s6o7MWATF911dZAPa7q7Jti1FTGDNZPr23lRPgyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128703;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=sgwy2sLBhkZKtiaNvP4HpJ9fzTrVK7TDxZafS5632ec=;
	b=HeHpa557Nl/iFLg0MMCrg8lVP+qNGiJIjKT8f5xHsCt6c3JmohhUqvWlT7Y0PfcJsJ77
	 66UABw4fhGj/lCSac8jmXJJE8xRdZ0erVU0auaO7XxGcl3h8tx21zdz3WnEeae3o8OEDf
	 ooDuAWWTdxeQCe3/cq5bgk+0hfWZ9IfyhCMP2vaC8kGyEEVRqWvw8+d1XHQZ+rMoro3N3
	 +r37PS7S1V4bDSWfwaBXG4YrjpUIUYG7io4TLSe56nfFvgvTnBSlpSVVKZvlMZiTC39yk
	 BGh3X9y3IxoSb3O1lh2un8J7FXQsrdLdK9FtDViHJ14O8heelejQeH7zquZIlshNL9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q1Cj7oxG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D37606A326;
	Sun,  8 Nov 2026 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q1Cj7oxG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6985D1F0089F;
	Sun,  8 Nov 2026 09:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794128703;
	bh=sgwy2sLBhkZKtiaNvP4HpJ9fzTrVK7TDxZafS5632ec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q1Cj7oxGzsAhAnRq/ZhdMKBRRx/rWlaEbygQnZQSmH26OlI14AkTEH8dwlgMwJ+q0
	 K7OzN0pyEdMwTbJ+4B7NHLxClYFCbms61qVOV7JlCNy02lDKnf2yoIRo6WSPhqZnAo
	 Obqljd3Wk/Qk5EMgfnRs1acIwKigDQg2HVfA07l4ycO20UWsqYPSYeOMDi1wFbFByu
	 wZf7CzCQ0i7ljYKkGF4YGOlt15keX29CRg6bnwPwVhvxjS03sSTqnPIN8PLHCX66nD
	 b720SgkqEZZQnW08Ph+QQnEgIh6Ck260FbNWFlHkQLyi/4S277WgaGf6bTU+YW7uvF
	 T+DR3tJdCeMpw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:58:44 +0200
Subject: [PATCH 13/14] s390/sclp_mem: Replace page allocator calls with
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
Message-Id: <20261108-s390-sclp-ready-v1-13-3e7c90eb6676@kernel.org>
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
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp_mem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
index 6df1926d4c62a..c28460598d385 100644
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

