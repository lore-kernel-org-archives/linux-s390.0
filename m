Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2502F39C7;
	Wed, 16 Sep 2026 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560208; cv=none; b=snhqJBwoFEkrgzaGJu2FAqa677eWygN4RMcsIMHwKpVs8MCJk2gFqAnl/ljesdUmjCzwHJyQcDPvgmbvsTK4ITNHCNSBObFbdyvLXNUFov9Hy+sSsOsw4PR7TJsUoiCaNAXbjnkI8LDebAcS8zREMS0c4M5trydBuYnvmotO1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560208; c=relaxed/simple;
	bh=oaUUL2Z6uTL/fsueJ+wmiwF3r3nbRoUwtNTlWdzZV88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cglZDzpkPEyQWVQqXPKqjJi2ZRNcvP0CRUuu9JINQ7LH7NKEvDEXCx/GJUyUBaDTp571C3SNrVc1+p8SufODS7yNAw6nCXD/QjCSAEmW8GVH3w6d9ELwA/274Ajg1rFjhMJ34dMCKGpvNV2Ppxu7g6mEQHPvICxef94PMmQC0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0FdByJo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0FdByJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F901F000FF;
	Wed, 16 Sep 2026 12:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560200;
	bh=waNeuygMDtlm0C03ZytfUl73M0zkpwkt1aPQuPSWLWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q0FdByJo2zQubwwDanKYIzUBcXtvTMfCBp48qm27YmTgxRoSrMstqxCXZn3n7+Pnh
	 P8XMlopALRmq8brgzuz4FAcRj2moZDa0LqfAbG79mV3jTtUXfv4vdc9jhr0hw73wTo
	 52/CDFK4hCado3mS52WJGzfIygnK84s1ZlEWQ3+ugodrQTObrzgiqOti0s6qzDHZRo
	 tlEV3WM6VvQjmHIY7bIdGGf8DUN05ZodD9RR1JpT5RndszfIbav2A/M2NMdpeGm2Aa
	 bJ8gq6x4hJMLIGe4kbp889e4uiTDAHZCC774BMAR8DI+a4djw/squiF8LHaJTw/eS/
	 HdAYo+u9zYdhQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 16 Sep 2026 15:03:08 +0300
Subject: [PATCH v3 01/13] s390/chsc: Use kzalloc() for CUBs
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-s390-cio-ready-v3-1-39e4894637d6@kernel.org>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
In-Reply-To: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Mike Rapoport <rppt@kernel.org>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.17-dev

cub_alloc() allocates the channel measurement unit blocks and their
extended counterparts.

This memory can be allocated with kmalloc() as there's nothing special
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
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/cio/chsc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index 9689f722c863c..60a4a7e6086ce 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -931,12 +931,12 @@ static int cub_alloc(struct channel_subsystem *css)
 	int i;
 
 	for (i = 0; i < CSS_NUM_CUB_PAGES; i++) {
-		css->cub[i] = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+		css->cub[i] = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 		if (!css->cub[i])
 			return -ENOMEM;
 	}
 	for (i = 0; i < CSS_NUM_ECUB_PAGES; i++) {
-		css->ecub[i] = (void *)get_zeroed_page(GFP_KERNEL);
+		css->ecub[i] = kzalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!css->ecub[i])
 			return -ENOMEM;
 	}
@@ -949,11 +949,11 @@ static void cub_free(struct channel_subsystem *css)
 	int i;
 
 	for (i = 0; i < CSS_NUM_CUB_PAGES; i++) {
-		free_page((unsigned long)css->cub[i]);
+		kfree(css->cub[i]);
 		css->cub[i] = NULL;
 	}
 	for (i = 0; i < CSS_NUM_ECUB_PAGES; i++) {
-		free_page((unsigned long)css->ecub[i]);
+		kfree(css->ecub[i]);
 		css->ecub[i] = NULL;
 	}
 }

-- 
2.53.0

