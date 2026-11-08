Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128694;
	b=nltZWBdAgsEgBAyH/nCvvHXdo/ND0A9C7rqvTeRr4Tx5RBWTvSbru6OZJEYmB+mo+sDx
	 jbuJ7ug1fqdUP/mjgvfpxfo57UHbnnKUubmTvmfOuC76zpkMRAw+A6qU1eqjPCy9MFKyL
	 Tw8gT+4b6hGYQ/QqdHeMyB0uF58TJtGvsWk2rp1Me8VbQnQCKWQ9ASz0xZ5/EVqS5xoQH
	 kA/OL24sw3szcI2y1nsYFXuNhh5bJKoK1A3WruFZLPmyUrUSDm9K6qGfyDqEMCtTPmNDl
	 zkZfrz77OGXlqDtukGxpF4h1/sArPpqHLDVHuKMiah6VSXlO/GGGAaWSUPm9p44sjTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128694;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=pP3ktJZe7/4XiaZRjUU/IjnOlBafkxzysIooIWss1Wk=;
	b=QrPRSVKB9SXA9wJcBKhdv8bAoS9QsZ3G2ixOxlfrQSP9DarUsfCwY2gQbLZQfmZ0S7YF
	 MKMfYXUzm2yuUQdTOPqrSnxdJLPLDesK4PVkP3IuQN9Pk0k0Ej62cvJ+hXYfkxGGwstmU
	 Naz3cCXXyw4qLXqmUBN9+BVZY/l4SFZ5AStFmQyHivZImRZeX+SJAWP43x+KyqeqlNLcJ
	 BtY1gFhcNh/ByyBmot+JvwOtPq0+nuEupk0WlOuGp2jzrZKlP4+hYnpX2A+mIy86W94qG
	 cLf8X4yHr95MONKSyoORDmjT7ll8bqzFWRzhi5Y6Bja3853EDxOiMsl3sbhMGXa4kZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoVQx5Kz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD94A606A330;
	Sun,  8 Nov 2026 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoVQx5Kz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D311F008A4;
	Sun,  8 Nov 2026 09:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794128693;
	bh=pP3ktJZe7/4XiaZRjUU/IjnOlBafkxzysIooIWss1Wk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LoVQx5KzYgmXuTXBDQRa7GMLEFPRhxzVTl1tSIRpwrCTpWrus3265PEN6qUN2MGEb
	 qryy7pS5cdDXPuoLXjNc6Y4/bMrZJyLNWZG5K7cjE1vlvYL4e3OCbLqSLUR3hR90BN
	 75bW8dqrxim+6oD0L9sXZ4Voc/ivsAKR53bMwXv1eJbmqidpPu2sxqareVu7tgG1xL
	 Jr/NHeq5XhwP2tn2/ID/1TzJQhXXVeRTxuCNOI5/MRHbEEg5eJJJCsO1iJQ9wWRAk5
	 361OE40X1l0ztxjV3DG6F+8NMnYd2NAk/YtUUvNELe+/B1rXJRg/SZ39hLF/vIAnRI
	 u/faWXXf2K7sA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:58:41 +0200
Subject: [PATCH 10/14] s390/sclp_cmd: Replace page allocator calls with
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
Message-Id: <20261108-s390-sclp-ready-v1-10-3e7c90eb6676@kernel.org>
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

_sclp_get_core_info(), do_chp_configure() and sclp_chp_read_info()
allocate the SCCBs used to read the CPU information, to configure a
channel path and to read the channel path information.

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

While on it, allocate only the amount of memory the SCCB actually
requires in _sclp_get_core_info() rather than rounding it up to the next
power of two. An SCCB must be page aligned and kmalloc() guarantees that
the alignment of an allocation is at least its largest power of two
divisor, so the extended SCCB is still page aligned.

Replace use of __get_free_pages() and get_zeroed_page() with kzalloc()
and free_page[s]() with kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp_cmd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
index 1dc93d945be6f..6aaf1f6a3633f 100644
--- a/drivers/s390/char/sclp_cmd.c
+++ b/drivers/s390/char/sclp_cmd.c
@@ -102,7 +102,7 @@ int _sclp_get_core_info(struct sclp_core_info *info)
 		return -EOPNOTSUPP;
 
 	length = test_facility(140) ? EXT_SCCB_READ_CPU : PAGE_SIZE;
-	sccb = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA | __GFP_ZERO, get_order(length));
+	sccb = kzalloc(length, GFP_KERNEL | GFP_DMA);
 	if (!sccb)
 		return -ENOMEM;
 	sccb->header.length = length;
@@ -119,7 +119,7 @@ int _sclp_get_core_info(struct sclp_core_info *info)
 	}
 	sclp_fill_core_info(info, sccb);
 out:
-	free_pages((unsigned long)sccb, get_order(length));
+	kfree(sccb);
 	return rc;
 }
 
@@ -173,7 +173,7 @@ static int do_chp_configure(sclp_cmdw_t cmd)
 
 	if (!SCLP_HAS_CHP_RECONFIG)
 		return -EOPNOTSUPP;
-	sccb = (struct chp_cfg_sccb *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sccb)
 		return -ENOMEM;
 	sccb->header.length = sizeof(*sccb);
@@ -193,7 +193,7 @@ static int do_chp_configure(sclp_cmdw_t cmd)
 		break;
 	}
 out:
-	free_page((unsigned long)sccb);
+	kfree(sccb);
 	return rc;
 }
 
@@ -236,7 +236,7 @@ int sclp_chp_read_info(struct sclp_chp_info *info)
 
 	if (!SCLP_HAS_CHP_INFO)
 		return -EOPNOTSUPP;
-	sccb = (struct chp_info_sccb *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sccb)
 		return -ENOMEM;
 	sccb->header.length = sizeof(*sccb);
@@ -253,6 +253,6 @@ int sclp_chp_read_info(struct sclp_chp_info *info)
 	memcpy(info->standby, sccb->standby, SCLP_CHP_INFO_MASK_SIZE);
 	memcpy(info->configured, sccb->configured, SCLP_CHP_INFO_MASK_SIZE);
 out:
-	free_page((unsigned long)sccb);
+	kfree(sccb);
 	return rc;
 }

-- 
2.53.0

