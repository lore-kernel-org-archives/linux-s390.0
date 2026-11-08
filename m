Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128688;
	b=0FdIlf+6OBkeRC8DXzd385JSge+WHknOQRVWTbWQ6HOWOKPOstfXMkYAI3307x0p5639
	 5Z0H57OlL9NarXRKmYmSzi/YnV2tmXsTfTbZB8tIaZ24FEX3IQx+VMeDlMnirJmaEvAHQ
	 D0x0YAzCaB2ayKsWNm3tFwuIgJWQPvsCw6mQtaVlnRByoPFCv0CwOf5fqQZuqMCTHjuup
	 BhHOMsAwwRM3rJR8SwfhBhRBY0rMf20BsNJb0QC4KyyIoDsZsvR+VPPaOZaKbV53KViax
	 nUf5IH7d6Dut2xAuVaWloAJP09CmAfc/GVOcJ9AwvHUFn4y68eN/xcLH7x8mCfXzBSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128688;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=eVjgamAGA0x/mZWw8oJ1JRlsWUIipJQvor5krq7d3j0=;
	b=b80kZo3PW+PiKeuFwF+y3RwDl5xnos+ZTu9L4iWOCxYX7Vami3q5r226sS1COmWGlz1r
	 4Kq863KdWINUy5TbZ1dPvTQIrhdvEu4ktgnVcfbS+gS5cEmOuHxBPIl0g1IdlfPi27KMs
	 RPZXpOQAkYFJSe2BmrO2IEAgChq3ECRBHZb6CFYfQfxRVhRosZbHq4pfU/FGKtS8RxOIM
	 1BJw6gfssxY09amFndF5KYF/Sw4mNoj8saN8KNY0nLknhFaYLhZsqu+PcassJYJOdk1yy
	 7GSbbM2Dhy1SZvxAMKHgM1G69bp96PnBxhPV/tQu/lTFqtfo0Mp0jDPC93xgJWC9TRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4DzYOfY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF658606A320;
	Sun,  8 Nov 2026 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4DzYOfY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56F21F0089F;
	Sun,  8 Nov 2026 09:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794128687;
	bh=eVjgamAGA0x/mZWw8oJ1JRlsWUIipJQvor5krq7d3j0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=P4DzYOfYNpRbO6T8CYFXNnq1IhQp48EHXievjIGpiy3BACYQFcvjL3KyJRZwqh+uA
	 qhfQDqBKIIXyC1gG1kE++/BvsT76oNepBCCOx5K794qDV7i5N0VYf3ERP5ke20A5DO
	 DpyGnDNQFh0imMrn5G1IglH7GaWZDQ4Yequm1tZnpheTKhvAMqSHFFNeoEPgnc47Hv
	 WXudf89FviD0dDWOrBCJZITICnzXB2LC0Y+2l4Y9Ae/56mYkr6AzyoLgi5/lFeISGP
	 92Ac7foROfQ68mlMcVcaCblVODN4QtF65d88cAwOcGqKeZAEZI86FunMvQ++t72NtU
	 anWRlK+FfxxQQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:58:39 +0200
Subject: [PATCH 08/14] s390/sclp_sdias: Replace __get_free_page() with
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
Message-Id: <20261108-s390-sclp-ready-v1-8-3e7c90eb6676@kernel.org>
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
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp_sdias.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_sdias.c b/drivers/s390/char/sclp_sdias.c
index ab8f1b758a1a8..a1a17a9e4a910 100644
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

