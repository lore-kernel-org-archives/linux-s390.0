Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128666;
	b=Rxh6jjxX1JMJjgUlS390WjThYvgYKqbTU3n60OGGTfIJ0KAVSCa9U2mFIoArohvlw1Rt
	 k5pThiEtVOOyRvKPD9y23Ro1I1LYtDdtWC5bBHLzGyUma/3bfOM2UxoUYqkpxvaFfMYUi
	 tqaBOJIiBc9H+KqSzi5Xh7ox9WsXhHxcn7xpusRnf6bfh19jYTgJK8hCuBNWdMVow04N8
	 DHyWKC1cUwV4uiukSm1yKukZ7L7HI1RlDhhUM+pbKW3gEfUptFvP5SKihuFYo3M9POhMQ
	 N62TsC3hIKbvAi39oP6yQJ3V3UOTut7R9BDlica2zglZXbWrW+zuBTNEhIVlYkjKA1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128666;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=x9YVpcaGori2puyE5zAanYRUnygFfhB6f+1WzEAuvFk=;
	b=UmpWfyJ5LUtgDFYtBq54iG/ObuHZGqdCwHgXO5ce/K72oRHvRlu34LcgXUeQzMbX8hIi
	 yz6HPjoB6xIzVjUzsHA1zLaK+DEsZ6iwAX9/4qcu5ZWhzFKRq6KbRixo10B8xT6GwTykw
	 cC+CMd678s4Bosn+ZzJtPgBvnXSWYiQY1uwsarxDlq2AzbwGKVtgkonpxK/kEi+uBHWha
	 mSPYGFb/LANe3ITasFMAFMElcZoj31ZCsjejolIkiXaW1kgxEh4zhLnNF3UukNcnfRvc/
	 QvdBjQYZu84UW8V347OG1AzLn+WLB8lTwM4/EM3VQECJMEN516vnhr71SoBvQV0MYIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fAUL4jLs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230E2606A322;
	Sun,  8 Nov 2026 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fAUL4jLs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E171F008A1;
	Sun,  8 Nov 2026 09:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794128665;
	bh=x9YVpcaGori2puyE5zAanYRUnygFfhB6f+1WzEAuvFk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fAUL4jLscGLJ+tf6SpxzrgIbn+5a29yaeqztlM8AlIqW6u3j1rjfchRY8kQepjSWJ
	 2Jz9llxOvprkl7wswvMtVdRakDmlw+02k9Yh1htoFrluOBplERvtElvqighxFFpIi/
	 qSydWg5GwTOrsbE22DcNB12KM3XQTgxT29w4FvcALD4d8GsJ+ZPLcwdtXMP5yM+XzQ
	 QkE4G1RrGU1lFfaMvK/76XBDultGVMbE8E+XGM7OsVmAATAQHSTLZvFdLS7q/Q2NbI
	 P1H3Z71resEmAMWp2+1+pYu7wHvRSTZ+m6KS0z71oC5xPbzG87oDBj/WAKqIUqUWj1
	 rt5XjFypzC/Yw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:58:32 +0200
Subject: [PATCH 01/14] s390/sclp_vt220: Replace get_zeroed_page() with
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
Message-Id: <20261108-s390-sclp-ready-v1-1-3e7c90eb6676@kernel.org>
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

__sclp_vt220_init() allocates the SCCBs that are used as the output
buffers of the VT220 console driver.

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

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
 drivers/s390/char/sclp_vt220.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index b95af0974624d..e79467c07d244 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -715,7 +715,7 @@ static void __init __sclp_vt220_free_pages(void)
 
 	list_for_each_safe(page, p, &sclp_vt220_empty) {
 		list_del(page);
-		free_page((unsigned long) page);
+		kfree(page);
 	}
 }
 
@@ -750,7 +750,7 @@ static int __init __sclp_vt220_init(int num_pages)
 	/* Allocate pages for output buffering */
 	rc = -ENOMEM;
 	for (i = 0; i < num_pages; i++) {
-		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+		page = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 		if (!page)
 			goto out;
 		list_add_tail(page, &sclp_vt220_empty);

-- 
2.53.0

