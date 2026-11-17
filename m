Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920861;
	b=QQyPV359IuzL5hMnXJMqvFzPKcJO4tbyO5MFKlKEJZd5Kbc7QJwJC72RsuL0WNU7NYZd
	 Gd0j8IUYIkZFC/ykHZEuXRBN9lmvteYTT5CUdEhf3LZhU97lXUnbkGBbA3wIr7GEqLMvH
	 9lrbT3jAe4MJwnE63rx2Tnhfhh7aw3Zr+8fmKAvv27m18MWj00Q2y5rRXFEC35mSPBkDh
	 rkHK8QzmtGI49EEwTXRH4BNr3jNo6x4wIApTCKHS+yYboHEqXAt6DaHusNVQ/9EHppigm
	 LcPAwKe3iBkMgh6lMc4P+u1uzP2Ooo0FhrVoRtoyqpZoz2TJlfPlGmTjMP8Z8Tl+UcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920861;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=hj69K2vm8ZEVPGY7njQT5Zr87Alx64EswQJRpbuiDuY=;
	b=PJMpb4U1Gc4p0JeHpv+JaqzTgHJjsyYT6uA+i8qdk1MqmiqKK4vrOZIoUvsij9Jwai3E
	 SBD4e8Cy0BmZf/xdo+kLE7PUX1Ugid5fDwIZndb1MFP0uTJewly3jt9SyRjAOWWwae8kO
	 PWQ/zrRLJnozyIG+H1Og4WSYq8LFkrQ3rJPVrTk6+mgwH3tXDiUoOHZOz8IlTci3eNSiN
	 cW1w4rPWAzOd4M8JGrycxBPT+K2HYlfoMmWtT39dSrpODqACKtdv7h8+VZJUCf2b9gkxw
	 unWxYO6JawE56+UvKCTxOOhusN9y5ZnZo9+l1V9QkjI4PFti2R6K4WLWMamudQcuiVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJzFZ3wG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD00606AF52;
	Tue, 17 Nov 2026 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJzFZ3wG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C977E1F000C7;
	Tue, 17 Nov 2026 13:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920861;
	bh=hj69K2vm8ZEVPGY7njQT5Zr87Alx64EswQJRpbuiDuY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SJzFZ3wGnfWsIG427ElOibz3m53GNhvmBF7aHBPElQs89O2PA9Fh7tjNGfuNqQVq/
	 CCkjVlT/M3MWEtq2FrQJ2O1SKHVReShxJH/Q3J6FSbxo2t5YX6gyEghSNhPxhO1ydd
	 5ged+faH3jLgeFhL7DOpyCrXEjQW/PFe/wFYvH/0fhk115a5QcT04frbrMDxhXSxIe
	 0t/WeH2jCMR7PvTmJ6/Ea/ZPQdAM26WxBLsrWQx2SoMGRgcIRtKu5fheVzud7eBBXB
	 uAeCqzuwgE+K+fVigqd7uq8BhIn56p6rgppwp0Yj7nDUCWeVGM1icHZEQ6qilQQ8+5
	 GLOBDtinIoJUw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 17 Nov 2026 15:07:06 +0200
Subject: [PATCH v2 14/14] s390/sclp_ap: Replace get_zeroed_page() with
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
Message-Id: <20261117-s390-sclp-ready-v2-14-e518c99622c6@kernel.org>
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

do_ap_configure() allocates the SCCB used to configure and deconfigure
AP adapters.

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
 drivers/s390/char/sclp_ap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_ap.c b/drivers/s390/char/sclp_ap.c
index 18bb018b4e0c..15dff5dc0cac 100644
--- a/drivers/s390/char/sclp_ap.c
+++ b/drivers/s390/char/sclp_ap.c
@@ -26,7 +26,7 @@ static int do_ap_configure(sclp_cmdw_t cmd, u32 apid)
 	if (!SCLP_HAS_AP_RECONFIG)
 		return -EOPNOTSUPP;
 
-	sccb = (struct ap_cfg_sccb *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sccb)
 		return -ENOMEM;
 
@@ -45,7 +45,7 @@ static int do_ap_configure(sclp_cmdw_t cmd, u32 apid)
 		break;
 	}
 out:
-	free_page((unsigned long) sccb);
+	kfree(sccb);
 	return rc;
 }
 

-- 
2.53.0

