Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128697;
	b=nAwxD+wwqDbCybPosuMoHdJ2NCEuLnmPdjdL/iahuhhbuBdofpL0xWGABriv6VW5khjJ
	 m8v3yNz1RWw4QY3WkvudgxOfiKlLSLHvvigG6HPyCBLlBlqFla/BGtpkiAix+7oHnW3Tx
	 HKZu1VYS//Bbakzz7LNE4y4NMvvSjxab4qcPcT5+HZB5Z+Q6b9LHYKwyNU0pkar7n7+13
	 bX/8itMxP4GaJ8ZYllmVvYSjzjoDMpBRxLhcNMmpXhhYtPYmzDnlPBpSiZZzh+KUcvZ4A
	 OwaYBB9HJyRBBt1exZv5o3oF9SYMfV4k1CY+tNhXK4mX4Y83t4NyLp9OdaFwdQElvKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128697;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=5eT9qpycRrSs6FOiikbaYya5uDEBcnf4nUnejqd5/AQ=;
	b=w4HzYyll2S1Gtyr76sJ+/VbDQFOxP6u91mjwFrcG/EicsXa2X7Qp/ahxbQUeyKS0gzuy
	 91Y4d8XQQ9w5gOVOUHK97auoIbUBJ5QuGh247ywAyiwqV+YRm+ue4Trl0aXmux5tNBZgx
	 1ttUs8aMwIXUwLSmKbJCbWuoT1yNcxphQCyeF/JRksaQZsthUEhfNfD8oXDW0wK4xz1Ob
	 m3aPlCjA4nuB5sjKahhwz+3xxM3m1min6a/myLu4BDyotjW3v/I5m3rQs2lzEzKAjL7DA
	 8sIntBmFlGMRyyJ0EPsZen+6JpSXFpopCPBrkfGLJGURyAzUb6ESJx+EMSY+7zb/guQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vy2SIHoW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E537606A31C;
	Sun,  8 Nov 2026 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vy2SIHoW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C841F008A1;
	Sun,  8 Nov 2026 09:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794128696;
	bh=5eT9qpycRrSs6FOiikbaYya5uDEBcnf4nUnejqd5/AQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Vy2SIHoWEqvLXlrOvgUlKYUdiU/lprj+MEj+iBun4RUrEeEei1b1ViYsmk1nY1rLG
	 YR0v5xHaD1SQXy8mQeLvWwSrzER96+Knoe27hBnFxKx56Yno+DvLh9FvSyiWxy4PiM
	 T6o5ZJnaLsITBJXSt0fSHpfOLzj6t9/VfmP/nAE9HiHC68K/6PXN43GgJ16BeEgVlK
	 aGWExFWE8+Rq9l80IVVYjFBjmaUuE64+t2v6k7NzpBOfZYC0TPZwD2guYplp7BRxmK
	 TafEHhR0/QmHfARx6R1Es17OvlkCnHHClX0l7mdfLQ/nWxCScpwcIae+DrT6vHRO+C
	 hKDVkDKpryi/g==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:58:42 +0200
Subject: [PATCH 11/14] s390/sclp_cpi: Replace get_zeroed_page() with
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
Message-Id: <20261108-s390-sclp-ready-v1-11-3e7c90eb6676@kernel.org>
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

cpi_prepare_req() allocates the SCCB used to send the control program
identification to the SCLP.

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
 drivers/s390/char/sclp_cpi_sys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_cpi_sys.c b/drivers/s390/char/sclp_cpi_sys.c
index b80f73fa1e01b..8bca2cdb34c10 100644
--- a/drivers/s390/char/sclp_cpi_sys.c
+++ b/drivers/s390/char/sclp_cpi_sys.c
@@ -84,7 +84,7 @@ static struct sclp_req *cpi_prepare_req(void)
 	req = kzalloc_obj(struct sclp_req);
 	if (!req)
 		return ERR_PTR(-ENOMEM);
-	sccb = (struct cpi_sccb *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sccb) {
 		kfree(req);
 		return ERR_PTR(-ENOMEM);
@@ -118,7 +118,7 @@ static struct sclp_req *cpi_prepare_req(void)
 
 static void cpi_free_req(struct sclp_req *req)
 {
-	free_page((unsigned long) req->sccb);
+	kfree(req->sccb);
 	kfree(req);
 }
 

-- 
2.53.0

