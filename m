Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920852;
	b=YS8z+hdm5VpNtV+XvKTGF+5NovxVDqOISO6d7BAnPJRiUivR873uLU3bhzwATgi40hAL
	 EB6KryAWTPcbf4gA66IOvwotteDPaCl+NL9K8Oay58bMLOtS1FT4rsGfxYhVD/+Ocm71f
	 uoqBp1WqMjfTAnYFbrPZfo+Mm8645n3+/LEsUinbzOeyFG8biP/SZ13oK05dgmwPYWJYz
	 Dvvf994m7yHEdDh9JGEzG6eh3c43Fv05NfKzcoxCChSLLRQ6+4avziL7WCJuYFuvqn8EA
	 dwdaqdH3BsgGURO3O4H/ehi1L0dw3sVT6tNDmMQoO6KD0AhP0+WTGluV8zFimx2CyHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920852;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=MBR9b/K32BoRw8TtSOA9dgWxNmbnE1ZmoY0n9+2HAHE=;
	b=sf3B3/zIoxvgi/o55sPlGUaoEVIHBfcQ9VGSrjQeivrGG5ztvgO6/NuOlY729iaxaGkd
	 wNJYTljyaQVjWsKjV3vd6yi24/ERX4x4UE4sr4qa7WRKAeDXYP7wKOkEAXQXEv5WF5KML
	 WgTv1kMmPvk4H05bsFQ/pkVqOwlc2Aqhgoc+12BxIAoEobsSwtmoyAkllhHbg0FWT0yNs
	 KrirTumNZKmQrzaeT7jzytZDgWUvIf/0nRjh0GBuLvoIGr7n7H1D5L86PBVTUe9k06hDc
	 R1gzMCQ/KPYFyofMxjGnUGveB/MygkbMHsuawkclHpSGqhBfUfX6dPnGsFRJiMbhnRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TfjLmBLG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD047606A8B4;
	Tue, 17 Nov 2026 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TfjLmBLG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2346C1F000C6;
	Tue, 17 Nov 2026 13:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920852;
	bh=MBR9b/K32BoRw8TtSOA9dgWxNmbnE1ZmoY0n9+2HAHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TfjLmBLGZIehSAdiJx/3bs8koYeTSqi29GejP+Kw8dUIeDnkRn9yc3SxUR2t33pyW
	 5m7dEycjFd5BX1ORh0TzLYgpYDu4+lsRdp7wBDaFya88vJOFp8hzzL3DbFPuV2KPuL
	 LnFoFlWeuKLM+VsBj6YzQI2+VK+c8gE1Ri1kfc/ldqPYkWLqVAY+ZRuOm1wwGtAae5
	 OUOj96KlkkUu8ItgVL4npceuw55GuQQ9JWxKzXwgDpJPnjbQsl9Ht+5O9lenRZQIgV
	 Tbn8DLDpm2oxrtF8J3ubt2dt7S+1NZwUf/IIDBp+iGoLI2CLq68L8j64wWuRQJs242
	 cWzpWUBGtONgg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 17 Nov 2026 15:07:03 +0200
Subject: [PATCH v2 11/14] s390/sclp_cpi: Replace get_zeroed_page() with
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
Message-Id: <20261117-s390-sclp-ready-v2-11-e518c99622c6@kernel.org>
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
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp_cpi_sys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_cpi_sys.c b/drivers/s390/char/sclp_cpi_sys.c
index b80f73fa1e01..8bca2cdb34c1 100644
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

