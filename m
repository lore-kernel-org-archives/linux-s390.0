Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920841;
	b=INW1u35OSU7JYc/K1QR6Vf/Giwawu7tjxhb49Wlxx5Su2j/omjsXhKnntqqpfY9OwAMP
	 RHpsJBcZFQD0gQXSpYZSbV9q5Npti62PI5vSGLM/mSOteMEGitQ4zTGTqzeddEhMCQfup
	 O6N8bqt+Q0BNmQ2HOLN9KiV+RpdXbU7U+mCx8mHJQUwDaIPgzJtzu6avpxcQhNy5b3EX+
	 PNepJvDp0MSxilmqBZNDDJME5CO0Vjn7dET/ddRuy8vkmy7kae54RJXz5SqDK/gNmEzkc
	 ZCLLN0uOVWLG52Nab+S/6Z1O680CdplmEivViWZB1jpfdngIKeSDwSMF0ldJvkGOnIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920841;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=DqGa1GEvMVM4CUAHQZQ4hNfpxe8V705FHjpxYKPLcQE=;
	b=erzens/QIz9cvZ1WbNUZ/NdmhLAWoq3/qyyHZkS6GOnDvbOIa3+5gShhi3269j0CUOz4
	 MVlx9ncWFmf/PRXZWL/WZBefjqFs1TbKXWctnwY3wlM1ePh9DCMQ9SbrCb4WmGPJbJB1D
	 3TNnpqrCNzbyzKGrWUETL/wTCNQ2CG+WIs2mNBvsh5Xg92LeyQGWoza2VvSTB0ExZbZM5
	 t/LdtdRLCnKSPDRQmv6YOssGg8PR24JGF3M9c0wpUIfTMj0gC1fUs6BNBLxoK03R1+RL1
	 refgb8LkKABqAi5GlyqSIAHIn8JyJSgr+/qpzuhvAgo4QWgKoQrWC+DJuxLqtW3+Wbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Dt25Ba+/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61853606A893;
	Tue, 17 Nov 2026 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dt25Ba+/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0BE1F000C6;
	Tue, 17 Nov 2026 13:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920841;
	bh=DqGa1GEvMVM4CUAHQZQ4hNfpxe8V705FHjpxYKPLcQE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Dt25Ba+/d3PdJXh1Je/uB2LSw98YGFMW+Q+U4uVkA9E5Z2DHBmURph3zRvJU/T9GI
	 ZzY1FqVTo1vZXhKm8RazcA8XSvCe7TqycChOfMER1kzKYA2ocX9AQ5+dUpBImmn8j3
	 V+ykP7ihIjjgmJ+zgdsKJ0y3B3k6AXs/l9FDMuup1H68HpOMW1zlL3a0ZU+5VLfAiS
	 ECat5yJQADnDFpDtXwy01MyNZNQA0hpylmEUd4eCqnVS3+s9MTgbjEX7eO9ZmmhqNO
	 9QerUrcxmqbzqaw096lpJO1lhqH/PRWd7JTkT1nNWcOaeiMustWRobLwM334s+ZqT9
	 l6yRLZjUPg2/g==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 17 Nov 2026 15:06:59 +0200
Subject: [PATCH v2 07/14] s390/sclp: Replace __get_free_page() with
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
Message-Id: <20261117-s390-sclp-ready-v2-7-e518c99622c6@kernel.org>
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

sclp_init() allocates the SCCBs used for reading SCLP events and for
the SCLP init mask request.

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index 98e334724a62..bfbac6dfa053 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -20,6 +20,7 @@
 #include <linux/jiffies.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <asm/types.h>
 #include <asm/irq.h>
 #include <asm/debug.h>
@@ -1268,8 +1269,8 @@ int sclp_init(void)
 	if (sclp_init_state != sclp_init_state_uninitialized)
 		goto fail_unlock;
 	sclp_init_state = sclp_init_state_initializing;
-	sclp_read_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
-	sclp_init_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
+	sclp_read_sccb = kmalloc(PAGE_SIZE, GFP_ATOMIC | GFP_DMA);
+	sclp_init_sccb = kmalloc(PAGE_SIZE, GFP_ATOMIC | GFP_DMA);
 	BUG_ON(!sclp_read_sccb || !sclp_init_sccb);
 	/* Set up variables */
 	list_add(&sclp_state_change_event.list, &sclp_reg_list);
@@ -1302,8 +1303,8 @@ int sclp_init(void)
 fail_init_state_uninitialized:
 	list_del(&sclp_state_change_event.list);
 	sclp_init_state = sclp_init_state_uninitialized;
-	free_page((unsigned long) sclp_read_sccb);
-	free_page((unsigned long) sclp_init_sccb);
+	kfree(sclp_read_sccb);
+	kfree(sclp_init_sccb);
 fail_unlock:
 	spin_unlock_irqrestore(&sclp_lock, flags);
 	return rc;

-- 
2.53.0

