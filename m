Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920844;
	b=x5qO1QesK197Mhdf1nsPXmAocGo7bJcff4d+4dxTyxVsbeoviI+jTkd0q06E6h+ZT6ri
	 vll6hNWR5KsvVXZr7QMLHE01S314mrwJv3qyFP/kMaKW7f6MNrx6Oq7jRQSYff6GudUzt
	 hvBgHsUvXHu4bsjbwGaqLwI4RMtGOYVDPzZDZgjQkHIBctENjerBr3tgtS3AdZvFtJU2d
	 JR4Xt1nMpwSM4O9J20PbrRaZHtpa+4F/lFOpZK3cd3FTqWVaylx6AbBozocalfuvlCNC/
	 lgAsuHZvsusXcKcoX/z0YsScUi7zGBMSW3UtSeoIGZFzs18KOIbY2dTxavx/0ZRZpIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920844;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=rTxINdq1VtsyQZerh4nRFT/F142s/ie+jkHVMDTGppw=;
	b=fTURssGjqycO2MWYRWfAXmL1OGLvfIafDeC/wxl/Uo/DM2myhArqFF41wE9ypuVO2xMR
	 9dJKtSuZd3w+CMVQUb3rVrAD7h5vg29+LT0wbUsZk8AQYWOMGp5Mb2Vz2PL5XwNDyh0Hn
	 Hkgwg1Qx7qNpNeMX2J6AVQCe7sr4YwcjSzGcYDC9KCN5iTy8ZC8NuDimRbfad4QG1JoHC
	 U9ye98/HwC+6ygMPyFnxUUYu4wK1hajvj+EWMMH4GM9AjnMdDMhNOkaP517ZuBNcgYNPU
	 Wlbsd4n+Gsf5H0u9gkK3ZiYha6iHdwvtYlyIiIrtXFq4WYHGhtgUsaNWsPbN2rmPANQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QmVRn26F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9B60A3808;
	Tue, 17 Nov 2026 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QmVRn26F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709AA1F000C5;
	Tue, 17 Nov 2026 13:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920843;
	bh=rTxINdq1VtsyQZerh4nRFT/F142s/ie+jkHVMDTGppw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QmVRn26FANsNS9lNj43FkQ78+kse1D98GXuyaYK1IRQIqlvhskvpx3WlSrXW5H8ZV
	 whW5A0u5RxuCHDx6litDOkVDnXCqWTrLmL43UQYoEAiSa+yE0JT2nCUNQ8xDbWtYka
	 2YSHahOpnY25iDyIBECpBb5Qx93PbmKuLmGS8o2VjcD9nvihTAqGsk/BLecr3FU10P
	 IC+5vMAvqsVgAGi0os0s2b2KV2bdcfpdwUGXlTsLz0s921Seca3/dW4K9AoHXJ50PB
	 Jz+JVsCEGWBZRcdzLnS1f3foBgjLXmXJff2O66iamJAHHpagU/+Z6AUmjXF+G01foz
	 +/HsN9lBrV3vw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 17 Nov 2026 15:07:00 +0200
Subject: [PATCH v2 08/14] s390/sclp_sdias: Replace __get_free_page() with
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
Message-Id: <20261117-s390-sclp-ready-v2-8-e518c99622c6@kernel.org>
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

sclp_sdias_init() allocates the SCCB used for the SCLP store dump
information requests.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

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
 drivers/s390/char/sclp_sdias.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_sdias.c b/drivers/s390/char/sclp_sdias.c
index ab8f1b758a1a..a1a17a9e4a91 100644
--- a/drivers/s390/char/sclp_sdias.c
+++ b/drivers/s390/char/sclp_sdias.c
@@ -10,6 +10,7 @@
 
 #include <linux/completion.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
 #include <asm/sclp.h>
 #include <asm/debug.h>
 #include <asm/ipl.h>
@@ -258,7 +259,7 @@ int __init sclp_sdias_init(void)
 {
 	if (!is_ipl_type_dump())
 		return 0;
-	sclp_sdias_sccb = (void *) __get_free_page(GFP_KERNEL | GFP_DMA);
+	sclp_sdias_sccb = kmalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	BUG_ON(!sclp_sdias_sccb);
 	sdias_dbf = debug_register("dump_sdias", 4, 1, 4 * sizeof(long));
 	debug_register_view(sdias_dbf, &debug_sprintf_view);
@@ -268,7 +269,7 @@ int __init sclp_sdias_init(void)
 	if (sclp_sdias_init_async() == 0)
 		goto out;
 	TRACE("init failed\n");
-	free_page((unsigned long) sclp_sdias_sccb);
+	kfree(sclp_sdias_sccb);
 	return -ENODEV;
 out:
 	TRACE("init done\n");

-- 
2.53.0

