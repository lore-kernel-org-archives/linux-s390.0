Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D97E46C844;
	Mon,  7 Sep 2026 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776670; cv=none; b=PGL+D8KArmcq9fSicQkAgtyzX3VGCk6tTK1cJ9MhGpEhYH8UAKkruwAg54yP5lf4AIW+j57uIJvwRzt0CPSgrEFxjkit0/0/OO1zPgEJ5EW8WGE8OVFrMyuEjmCstF3OBDXaPtSwJJR01T6iEmE8/OOCAYtUZ43ifWMt8Pq9FIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776670; c=relaxed/simple;
	bh=ExZRIfSZYWKiGLqVEza6Pma8epGogrkm5/O+l1yl1Ww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gKoNSRb3wWTxVdFpXCWfMSKvRAc8r++oNwdv0Gvx1k90/GgGSxc6GhGFa/Igj0/kX2nHfTVTc4TmYNKGxdPP67sJtH88yhr3+NZkzw65bh9O7HgT6gURahbOl0qkVP+0gLehZ5hfFLqZl+FQ+X0xQEGNjrC1LNwCeYMU2JbqHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9w2iL9K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9w2iL9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F10A1F00A3A;
	Mon,  7 Sep 2026 10:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788776669;
	bh=kjadfUkSzyOP1zHYpwk4bR2tv8NVDjjU5ZmwfJdW4t8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m9w2iL9KmZjbnwrL0PHYradx8kYA+DJUJqja+5JXA3joouaWZ84qaThOVENwcCa0G
	 ZX6bY8ySJ/fwUO2yJnCE3LA/A73yTEii5MJR8C0IMmDBImhkpY/xFuXWkSzO58yFdB
	 FhyUiskZw/3HT9vOUJzibtohk4EtRNxoVdvw6KZwWjbqTMG2D3mdlAVlmp/Pz24EWh
	 CeuaQAW42sS3OXwyQNx5fy21WGqhT3NHmNZeup5RvDNUqgWQaWny7K1VauWJCfFYfE
	 kpqE+3wjwf8LAzcLP4fhwd6E0A6YOBWsHM68zaqFRDTVAMMuNgqiSF46JD/rzOky0q
	 lb3eJyYGR2H2w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 07 Sep 2026 13:23:52 +0300
Subject: [PATCH 11/13] s390/qdio_setup: Use kzalloc() for the storage list
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-s390-cio-ready-v1-11-ca7f39806234@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
In-Reply-To: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
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

__qdio_allocate_qs() allocates the storage list information block of a
queue.

This memory can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/cio/qdio_setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
index b6f2ff202fe64..7ca8f61a2387b 100644
--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -83,7 +83,7 @@ static void __qdio_free_queues(struct qdio_q **queues, unsigned int count)
 
 	for (i = 0; i < count; i++) {
 		q = queues[i];
-		free_page((unsigned long)q->sl_page);
+		kfree(q->sl_page);
 		kmem_cache_free(qdio_q_cache, q);
 	}
 }
@@ -109,7 +109,7 @@ static int __qdio_allocate_qs(struct qdio_q **irq_ptr_qs, int nr_queues)
 			return -ENOMEM;
 		}
 
-		q->sl_page = (void *)__get_free_page(GFP_KERNEL);
+		q->sl_page = kzalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!q->sl_page) {
 			kmem_cache_free(qdio_q_cache, q);
 			__qdio_free_queues(irq_ptr_qs, i);

-- 
2.53.0

