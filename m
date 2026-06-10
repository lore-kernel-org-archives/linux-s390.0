Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BAA31F98E
	for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2026 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101431; cv=none; b=Wps16cnib/e6tDHJxehDrcI9ePFuGHwATAGdmwiXuFjERstKPn6APeEsLDolsf06Llz6mfL2l9s/URryY2jiDvrI/n1/kDAEU0B8x8QXdejcvdUYf9CLppFiD4Xc8VqoXHqtxUAOt/NsC8RoRLRljx5W0Br1ggVa/5kJXuyHj9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101431; c=relaxed/simple;
	bh=8mPfyyoNCUBTEo0ky0/MzA0ZzyD72RHYKbfDkhMqGbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=otDh0HwT90/FgoTM62/Hx0TWJ9znXSPp0rE/+BARor1e9wofi7nvPsZk7XE8XOLJKvm9ZFyjcLCy37sw6M7ynQDD6M38DKKLYgInJhvk2doVgxy2+AN8Q/iEAaOk+HYUslFS1UmRAaQWHXx1Ic3yvNnqECQG7XmiGfx+nYkK+GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QMvwJ3hN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QMvwJ3hN"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf114b0cf9so62907715ad.2
        for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2026 07:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781101428; x=1781706228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RIgrfTieRwmLlw1dLE2AIE0y0j3JlRfXfzK5v3rBlwE=;
        b=QMvwJ3hNtNFZhRifyU09FGDQVs2MkJhnV7EpdE5BuxgPzIMXTAaKts1+HioKh99RAb
         +IfdudzaQRxi7/9wUMZs990u4vWyZHgKcgTMDaNdixZfJ7OuCXjvdsvIJMewpr+9G1EI
         zmnr1xngneECqAt9iuQcH9dM9Y9/3nM551BpEhCC6CT8tpEFpKRrCbRQIwuPS/ko+I9h
         8jBPtC6wqNw+omO7RASlIXrsxQAvK7ycH/47uBLNa+yWnMrqqVT0v3w/QrTKvQjl7n7s
         DXss2ibUQEfKNC5DKdGkYZqM2Dj9rcRkTSL3u8cHVSOhjUu7bfyBaKhEr7s3uGce+Lrz
         exDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781101428; x=1781706228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIgrfTieRwmLlw1dLE2AIE0y0j3JlRfXfzK5v3rBlwE=;
        b=lGqLPreHE7otLDZpF1DMhFYk5HKUV9A71KiLXAjWsdNnfjOJxUlmNyihR9qYe5fImP
         9d5/mK2Jq+hyn/KUnk0RUQqmmUhe1OXfa13DxXCzukn6T5bHN6F0lHGUhX1g+vNLmJ6G
         IyoUEgoPTJnH+pYItED5T5ojnt/ZZ5jJgru1XMlQw36PQ1SZ02n915t84Twg1bFzvbeZ
         fsObsxYuucdAFzA1Dv9MLzGjfs815uwqWhxAfbbQzeHCQNnCnp0u3vlkh90WRlJNR4zC
         08Avh1Q11WWPG6Su9Mud86r/KtO64Y1TyM4dxpM56Ft0caD8nzSgOGmgBxtN8szUUSyz
         r7UA==
X-Forwarded-Encrypted: i=1; AFNElJ+0BQRY4wh5xoqdwr4Hda5jqrLGNXwFoznRTcbAkfAvArMHe4cIn1dZxsH1LKTyKkSGemePa0vQI/y4@vger.kernel.org
X-Gm-Message-State: AOJu0YxHgsPfTPHtHuqr9WNlAX28oOWQ/8EYctqhYjHzSO0qfEEEvKva
	VjrM6rE+LM9nu8P9jOrJaqPK7lCCVJIBBc49x2bTFfi+lVmSiA2so9BXaW2EyXBPLWM=
X-Gm-Gg: Acq92OE2xc0y69ZZ7wx5ZJbyZrvD0AF9eS6s32BSddfzW7biCVtlfPDWKkBrOC8KihR
	QkgSehUA24aMlWpc6ARzLXvfkSC9Nnoi4kBzI79Q+yL7OggOsf24Daa7ilaIfhxRUBZVMVLNJWS
	90bh6D+mSGPeKeUUSwxE6tFl6u2XJKfC8e8f0JOh+qNhy6Ug0KNTAPoVxCm0oq3pXNAG3k7PFsr
	oYt4ZJbk3N9ug5C5Vd3kBcDOC6H5RWcH2iGHNR7HZtHQjm245+KLWhKVp3tOeqLnyRAYtiPxCO1
	5fKcNpPbGVXSn3JzukZuoLc58Ew2lewk5UfjWNg+LYdW0aEj3botoDtwzB5Qkpgr5YPXCobGoVX
	bDxkKtLQK/sYPMvLRD1EtCBRDN03tyObdpQXZQT4o/fnJBQT9pvgbA5tC8zCHcr3pGZGcK0zBiw
	DmCbUJC5VhyH5DEGJq47YEM8akj5/7RCPwFB/L9fI5ftbY5IdfNazjZw==
X-Received: by 2002:a17:902:e752:b0:2b2:5515:661c with SMTP id d9443c01a7336-2c1e893d62dmr281727295ad.31.1781101427890;
        Wed, 10 Jun 2026 07:23:47 -0700 (PDT)
Received: from nagraj.tail8a2ac.ts.net ([2406:7400:98:3ab:da47:17e2:32f7:c4d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d318sm265761935ad.15.2026.06.10.07.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 07:23:47 -0700 (PDT)
From: Sumit Semwal <sumit.semwal@linaro.org>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: jgg@ziepe.ca,
	jiri@resnulli.us,
	hch@infradead.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lkp@intel.com,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	linux-s390@vger.kernel.org,
	djbw@kernel.org,
	thomas.lendacky@amd.com,
	x86@kernel.org,
	arnd@linaro.org,
	benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com,
	jstultz@google.com,
	tjmercier@google.com,
	mripard@kernel.org,
	afd@ti.com,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] dma-buf: move system_cc_shared heap under separate Kconfig
Date: Wed, 10 Jun 2026 19:53:29 +0530
Message-ID: <20260610142329.3836808-1-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

While system heap and system_cc_shared heap share a lot of code
and hence the same source file, their users have different needs.

system heap users need it to be a loadable module, while
system_cc_shared heap users don't.

Building as a loadable module breaks system_cc_shared heap on
powerpc and s390 due to un-exported set_memory_encrypted /
set_memory_decrypted functions.

Fix these by reorganising code to put the system_cc_shared heap
under a new Kconfig symbol, which allows either building both
into the kernel, or leave encryption up to the consumers of the
system heap.

Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
---
 drivers/dma-buf/heaps/Kconfig       |  8 ++++++++
 drivers/dma-buf/heaps/system_heap.c | 16 ++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
index e273fb18feca..a39decdcf067 100644
--- a/drivers/dma-buf/heaps/Kconfig
+++ b/drivers/dma-buf/heaps/Kconfig
@@ -5,6 +5,14 @@ config DMABUF_HEAPS_SYSTEM
 	  Choose this option to enable the system dmabuf heap. The system heap
 	  is backed by pages from the buddy allocator. If in doubt, say Y.
 
+config DMABUF_HEAPS_CC_SYSTEM
+	bool "DMA-BUF System Heap for decrypted CoCo VMs"
+	depends on DMABUF_HEAPS && ARCH_HAS_MEM_ENCRYPT && DMABUF_HEAPS_SYSTEM=y
+	help
+	  Choose this option to enable the system_cc_shared dmabuf heap. This
+	  allows allocating shared (decrypted) memory for confidential computing
+	  (CoCo) VMs.
+
 config DMABUF_HEAPS_CMA
 	tristate "DMA-BUF CMA Heap"
 	depends on DMABUF_HEAPS && DMA_CMA
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index c92bdec356fc..71d9028cc3df 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -48,6 +48,9 @@ struct dma_heap_attachment {
 	bool cc_shared;
 };
 
+#define cc_shared_buffer(b) (IS_ENABLED(CONFIG_DMABUF_HEAPS_CC_SYSTEM) && \
+				(b)->cc_shared)
+
 #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO)
 #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
 				| __GFP_NORETRY) & ~__GFP_RECLAIM) \
@@ -161,7 +164,7 @@ static struct sg_table *system_heap_map_dma_buf(struct dma_buf_attachment *attac
 	unsigned long attrs;
 	int ret;
 
-	attrs = a->cc_shared ? DMA_ATTR_CC_SHARED : 0;
+	attrs = cc_shared_buffer(a) ? DMA_ATTR_CC_SHARED : 0;
 	ret = dma_map_sgtable(attachment->dev, table, direction, attrs);
 	if (ret)
 		return ERR_PTR(ret);
@@ -233,7 +236,7 @@ static int system_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 	int i, ret;
 
 	prot = vma->vm_page_prot;
-	if (buffer->cc_shared)
+	if (cc_shared_buffer(buffer))
 		prot = pgprot_decrypted(prot);
 
 	for_each_sgtable_sg(table, sg, i) {
@@ -282,7 +285,7 @@ static void *system_heap_do_vmap(struct system_heap_buffer *buffer)
 	}
 
 	prot = PAGE_KERNEL;
-	if (buffer->cc_shared)
+	if (cc_shared_buffer(buffer))
 		prot = pgprot_decrypted(prot);
 	vaddr = vmap(pages, npages, VM_MAP, prot);
 	vfree(pages);
@@ -349,7 +352,7 @@ static void system_heap_dma_buf_release(struct dma_buf *dmabuf)
 		 * Intentionally leak pages that cannot be re-encrypted
 		 * to prevent shared memory from being reused.
 		 */
-		if (buffer->cc_shared &&
+		if (cc_shared_buffer(buffer) &&
 		    system_heap_set_page_encrypted(page))
 			continue;
 
@@ -456,7 +459,7 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 		list_del(&page->lru);
 	}
 
-	if (cc_shared) {
+	if (cc_shared_buffer(buffer)) {
 		for_each_sgtable_sg(table, sg, i) {
 			ret = system_heap_set_page_decrypted(sg_page(sg));
 			if (ret)
@@ -485,7 +488,7 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 		 * Intentionally leak pages that cannot be re-encrypted
 		 * to prevent shared memory from being reused.
 		 */
-		if (buffer->cc_shared &&
+		if (cc_shared_buffer(buffer) &&
 		    system_heap_set_page_encrypted(p))
 			continue;
 		__free_pages(p, compound_order(p));
@@ -525,6 +528,7 @@ static int __init system_heap_create(void)
 		return PTR_ERR(sys_heap);
 
 	if (IS_ENABLED(CONFIG_HIGHMEM) ||
+	    !IS_ENABLED(CONFIG_DMABUF_HEAPS_CC_SYSTEM) ||
 	    !cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return 0;
 
-- 
2.43.0

