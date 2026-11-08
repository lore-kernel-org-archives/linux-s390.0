Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128669;
	b=MfNO1uF5Vegu+AwnLR0oXIFhWOenBWEUHmBIy1xB9XI/863xToFoG2OQeB8qjrPOSVBA
	 rgdFYeAy3NeNu6SqZopmdXsNVd+SCUcL1qsrI0hXYsIJJre4LRBrAUYYtDJmpdFz56LbB
	 8y7ZB9K+I7xRg7oO9G6ESao7QH9cYeBGxNgHvs7NDIU2Bm2bkd0AA8cI2dmxv/hrL1guk
	 T2LL7VDAvr6j9KDUHK52xx5Av2WLRoF5rW4UWNds6TwKUsuqN9zC36KL916z33X0jCSso
	 IkHBsjN/3aYGujiCJcvWgHsCfRf6F7MZM5F0jhoN09RL1NSykO90cev48unT/Y2sjiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128669;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=7dwK/9jxJNdgEEjIHynAy9/D/UKIq5KAErG5vvcQ3cg=;
	b=Y0pzEsSGTksRbGUEoGzOaZIJCnV2TP+A3aQbBhVRQQ+OnslH9YuNilBpzKs5sfVDD+Ge
	 E8XMK2aB3ReVRUo3bb6J9HPjiUsBiVKYPcvJT+XH8fURlMCoO/SyExvrKXKQ0j6scY04v
	 Uzyg9/ntT+Gka33sb9L1GqWj0AhJ3NX2v7TTTeSEAG2N7jdDz0Tcy2AtRHKLICsOiMiUv
	 RP4ZV6YQ6UchNuAhqkrHzc1b6hbobBp1/nulV8hN8+XHaMvxkk3wiOTrC5xpd3WRMJzVz
	 EF6Zx5hPCi8sfsPYr5ttHDYDPRT+n7ro+9M/T89ipQabXhdw7T1ZOONJsVK7qoRNomg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eoOEDJem;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F063A606A33F;
	Sun,  8 Nov 2026 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eoOEDJem
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403D31F0089F;
	Sun,  8 Nov 2026 09:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794128668;
	bh=7dwK/9jxJNdgEEjIHynAy9/D/UKIq5KAErG5vvcQ3cg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eoOEDJem9eyTIF62K6Ym6dt1bY2Cexl7poso3szLa7Cz6TrYDCpvEg1wOIUqQhwTT
	 x+7mmKMIUQswknzccH0pajd9c2/02vMRodg4qY4uP7yoTgETugHKSYBmuTVWHe/zu6
	 /krJJBun3ayu/cvyOdXAb5RVdERWNn2PnoIFHe2ML8A9m7yWOsOK+wAYQxcJORJk7k
	 9YIfWQ+hjdU/wGAKqNfqNZvDN6nBEsZN8B26/yWzKbmf4GHv7KuCpasDICKWvZN/AB
	 cWInBO/aNdk218ix8+t3qNrG33A1pjwy96tIni5vXiet3kWRSvTur57SF5tDJoeyAw
	 JwKaV9Xl8Vjsw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:58:33 +0200
Subject: [PATCH 02/14] s390/sclp_config: Replace get_zeroed_page() with
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
Message-Id: <20261108-s390-sclp-ready-v1-2-3e7c90eb6676@kernel.org>
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
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp_config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_config.c b/drivers/s390/char/sclp_config.c
index 8c77e8c44fc23..16617a679366d 100644
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

