Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7128F46D542;
	Thu, 10 Sep 2026 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038047; cv=none; b=MSkds2CyqYLQArc6hmNrMtvJIghWsCOyzOLD9oA6jUMbTqZ9HUBRN46b5fYX5Z5/1TNpYoKES2L354bP4c55eXVX9tO2Azk3fsakmUaueoDdiiUSw46o/91B3yIHthfpYWiop7gpAZSTNDsyDZf2/kv/q72mSDMMGajjimFjQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038047; c=relaxed/simple;
	bh=ExZRIfSZYWKiGLqVEza6Pma8epGogrkm5/O+l1yl1Ww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JH0wo8ekAELjfouV3tqj25TX4ZusRG/1/1wBozd+AsFRcSUieQTve9HUFPZCVQ5NOPLDGyS2dfPnIcdwLE2hldgYwtg5JHMZqsPhVva4WBPKa4Nt7jXbHVChwcMYiHExJtVl+WIEdDU9e4BfWz1GKhjQy4VJ3P7RtFqhDcGUs0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WneeTd+w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WneeTd+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585FC1F00893;
	Thu, 10 Sep 2026 11:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038046;
	bh=kjadfUkSzyOP1zHYpwk4bR2tv8NVDjjU5ZmwfJdW4t8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WneeTd+wW5lN9tsU6scOlOCEQrhfC0vBt7gRnjduif9vvCU9to0xuPIZfTlS6Dj59
	 9XC6IKgQKVNJZxNAMVlJL5/ERAnBIGWIWQLC37i/RDN49rUr8/Bjdqj+/DD3AKfZiW
	 WevV+s855628UX6OBQZyFFAMmebgteXfihb29qCMH1GxVEM695LBChQXVHRs+ZQYrE
	 IsdiLWAEhvCKR9DFPeQwR7Z1QxdeC4lITBAxf7xnlhDpaeLMNxA/VAuXvicjw9Zt9x
	 NK8nr7JQqAK4TExYaI4BsXOL0GXhUiwujWRMf79BMV50dNFH86x4xTeZ5OjxoZCi60
	 PMMwO8isMufXg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 10 Sep 2026 14:00:13 +0300
Subject: [PATCH v2 11/13] s390/qdio_setup: Use kzalloc() for the storage
 list
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-s390-cio-ready-v2-11-e931086fdde1@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
In-Reply-To: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
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

