Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859185;
	b=z5pEbuCr5L00phl+nXelpD12hhBtDlh3zJ+IcKFAsFFoXMBuvF63AyQ0m6YUT2ta5cOF
	 nkF+x/QCEealXSEFtKtQIrEwDYtTJqkMujfqzumrIf7LaIYb1uGrrltU9yewiwb4b5pnD
	 DggLbnvtfllbV8mDh4cmedmXNVIhQ/BV0xrB314Fl5ZefCAgD7JaRcZMrZGAi7zerh1Kf
	 RJ8PRGE+vd0WnKDa9zQ7rFG7GNdRT/I+L4ZM/NVNx6HqEgJvy4jVxJy+BFgC9sKYu4Mz+
	 Z+uO7+akdSMDQUSM4o9aQEORL58shy6S3svD/2w9L22pHzr7srkofXnvF1LRIAW6r8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NCLGTKCHoNQl6zGrnHHJ6bDiMkCD24v1Hv0NuRQZaOo=;
	b=r3ijWGX5BPwE2V+eI3w9wh5ZrEYJcpU83xF9G6id4ohFp6DKHV7Wokisq/fUDLQ1I8UI
	 HU89cBMUzuTd67JWXrZD2wesDSeuxMOXqPc3lDK/UOIMu2OUT5KudLaZBPh0Bhw1mo01d
	 GRiOHac1z1UMYQ2XI1E/9cCQR/uGe1K5kpiI+C+GxzN6jcPWfrYaqF5nGp3DB0qW/V/x7
	 7voIkQ96kMvoKuD5ZbtikMgavJ9sl3JZSuRBcIxtyJxobsb14O/SJF8DJY5vD0RAAgDky
	 hZnGTQWeplJ8Y3ZqdyV4TyNlwUNAFY3sbGR+C8FhQguWp97N9roG4Ypo2SibKm+wnEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=CzHQ7sI9;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2029B606A32D
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 06:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2029B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=CzHQ7sI9
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc7d154ec4fso700763a12.0
        for <linux-s390@vger.kernel.org>; Wed, 04 Nov 2026 22:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793859184; x=1794463984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NCLGTKCHoNQl6zGrnHHJ6bDiMkCD24v1Hv0NuRQZaOo=;
        b=CzHQ7sI9fJD3oZ2IAu/ajNltazLVoEN8o4ML6yWQ8qHEgYhOKa7PWKYK5FKJ8TvgWy
         eNcm4O5Wc10RVKN1CDQff1ditECXHzcQ6pCaYtu+Nsyyog7f+qOJadetUmrxAJSKucVQ
         ayJbxqZO5GhJQIlj8kssywSxx6GTIy+yY3eYOkoiKVeRpXQaRfa+MhGSHWC2CHrJET1t
         yyAMawfdiFAbgTQk86/MFbJ2D37zUKPEjV1FVNUUqBxSH2uXgnuvRnHiivoggNWZnC51
         pzA030sr0DFhiLUY2ix1Gdf+BDsXSL3qR2WZqkanXM3dWFd1zAYlQTJvvPmkTvBemZsg
         wU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793859184; x=1794463984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NCLGTKCHoNQl6zGrnHHJ6bDiMkCD24v1Hv0NuRQZaOo=;
        b=f7hfOR2m8JtzFH8ZHKmf9R/P3LEkrWc3Zpw5IaBnCm6BZ9RwpX8H95dLgYqcDFtN4Z
         yERoFR6eQ4/GN5L/yY6gxmx6eJ5xrsVL/5iOlLe0Zf6Qnb9ccP+dZfoZIbEWuhf+VERB
         Gl69WvWzqhVUNY7+uWnrctv36P8WflfzKHppYYmB1GIB92ocbY/zjcIYBacxeivf1Dnv
         wao/9hkikrOOvCv++eJi+veTzYYW5OLhlh9W1GIF4gbIPIMfLsKI/MNE9cmC+iuWhgN4
         QDbuGHlXvnq7dYCSDSUQbgSiBVDFVTXcIuuZRIR1tQj/c82wbwWnPO3SL7esBH6uXqN/
         msGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSrddWxKthM/+o71up9SSHmn8wOZSl8CHFNi53i/QyDlZakeTvScrF1WRNLq4EQFNEHf3AJm2nwRIl@vger.kernel.org
X-Gm-Message-State: APuU4Z9xVqybTYnJDM49RDWzX3Vn5TTdWgrcQoeqE8LlYE88YVMPtjD1
	h2WmzvCff7oC+XNEtEJV1eKh3QcNCPaeE3CCLeXdyPaUbltrAYUoyn9whHy2nKJfAOY=
X-Gm-Gg: AYBFou176QE7Lug4mwbLxyXCwrLAloCzQz0sOV4ulVgOcpSbLjZvfRRQuvQRdwtW2fM
	4kzs7uHn84v0579L2XOgQkv1YGGGSz8TF61WK3UCSh6WRl/To+/Tw70h/bCovDlTQMSpQZg15CS
	vzP0VQWy8mz8J59/wHcR+yR+a/C3IL/yOvhXYIuroalxAIpng4s62NRd3KLi3JAkM4s3VD/bvHG
	NczETSS0gTvL79bblgMCffPeTiqGUaayvwAIw8GYHc+pF5keKtE8sH8oh6jOTq+03XBNpPfI+8m
	6p7TkdcRDmDHLvqTPTmnY2fNwLUNQDkBTddi9nOf6v+SmprokwcHsW9eJYybtFRXKBwdgHhVm+t
	21yJikM5Td3bbaZiFcDQwLiRfx4aOLGUPg6RgIWk76YwoTwGVSnu2bgfXHtbhsirzVPTR8LLeu0
	ah7rp1rqAcWVIj+ScXI3zZvK98syVdr1ETLHZTpjO+9SdHzC2XcT3836nXkl3Fzo1xXYpeRMUP9
	tEpIMnO0IhtMHhyg5+HybyEj9J7Wu9ec+BpKFOSseoEoDZXCCJH8erNN5Z5b4B5CwuVvzQSrcth
	6mb5ZCxtE2UYFVsCwr9FhbD0q894WvkEHxBHQEBAroGlvSpADtE634X4fKHSL24y5A==
X-Received: by 2002:a17:90b:17cd:b0:3ac:b7b9:6471 with SMTP id 98e67ed59e1d1-3ae8987a7bfmr15529450a91.65.1793859183930;
        Wed, 04 Nov 2026 22:13:03 -0800 (PST)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323a1fdsm2107528a91.5.2026.11.04.22.12.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 22:13:03 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <lance.yang@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 5/5] mm/sparse-vmemmap: drop @pgmap from vmemmap population APIs
Date: Thu,  5 Nov 2026 14:12:17 +0800
Message-ID: <20261105061217.13302-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105061217.13302-1-songmuchun@bytedance.com>
References: <20261105061217.13302-1-songmuchun@bytedance.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vmemmap population and memory hotplug paths no longer need @pgmap
to decide whether a mapping can be optimized. That state is now carried
in mem_section, and the architecture-specific population code can make
the remaining decisions internally.

Drop the @pgmap parameter from the vmemmap population helpers and the
related memory hotplug interfaces, and remove the remaining
dev_pagemap-specific coupling from those call chains.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/arm64/mm/mmu.c                        |  5 ++---
 arch/loongarch/mm/init.c                   |  5 ++---
 arch/powerpc/include/asm/book3s/64/radix.h |  1 -
 arch/powerpc/mm/mem.c                      |  5 ++---
 arch/riscv/mm/init.c                       |  5 ++---
 arch/s390/mm/init.c                        |  5 ++---
 arch/x86/mm/init_64.c                      |  5 ++---
 include/linux/memory_hotplug.h             |  8 +++-----
 include/linux/mm.h                         |  3 +--
 mm/memory_hotplug.c                        | 16 +++++++--------
 mm/memremap.c                              |  4 ++--
 mm/sparse-vmemmap.c                        | 23 ++++++++++------------
 mm/sparse.c                                |  6 ++----
 13 files changed, 37 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 19459a4a870a..a6b5774005b6 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -2038,13 +2038,12 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	return ret;
 }
 
-void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
-			struct dev_pagemap *pgmap)
+void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
-	__remove_pages(start_pfn, nr_pages, altmap, pgmap);
+	__remove_pages(start_pfn, nr_pages, altmap);
 	__remove_pgd_mapping(swapper_pg_dir, __phys_to_virt(start), size);
 }
 
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index ea769e479241..c91afce46136 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -120,13 +120,12 @@ int arch_add_memory(int nid, u64 start, u64 size, struct mhp_params *params)
 	return ret;
 }
 
-void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
-			struct dev_pagemap *pgmap)
+void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
-	__remove_pages(start_pfn, nr_pages, altmap, pgmap);
+	__remove_pages(start_pfn, nr_pages, altmap);
 }
 #endif
 
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index df67209b0c5b..0c9195dd50c9 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -316,7 +316,6 @@ static inline int radix__has_transparent_pud_hugepage(void)
 #endif
 
 struct vmem_altmap;
-struct dev_pagemap;
 extern int __meminit radix__vmemmap_create_mapping(unsigned long start,
 					     unsigned long page_size,
 					     unsigned long phys);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index b617b69452cd..2432ff888c03 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -158,13 +158,12 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
 	return rc;
 }
 
-void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
-			      struct dev_pagemap *pgmap)
+void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
-	__remove_pages(start_pfn, nr_pages, altmap, pgmap);
+	__remove_pages(start_pfn, nr_pages, altmap);
 	arch_remove_linear_mapping(start, size);
 }
 #endif
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e822fce0af4b..6f064875ce8d 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1749,10 +1749,9 @@ int __ref arch_add_memory(int nid, u64 start, u64 size, struct mhp_params *param
 	return ret;
 }
 
-void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
-			      struct dev_pagemap *pgmap)
+void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 {
-	__remove_pages(start >> PAGE_SHIFT, size >> PAGE_SHIFT, altmap, pgmap);
+	__remove_pages(start >> PAGE_SHIFT, size >> PAGE_SHIFT, altmap);
 	remove_linear_mapping(start, size);
 	flush_tlb_all();
 }
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index be7e009e7b59..91c0edccbb12 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -293,13 +293,12 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	return rc;
 }
 
-void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
-			struct dev_pagemap *pgmap)
+void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
-	__remove_pages(start_pfn, nr_pages, altmap, pgmap);
+	__remove_pages(start_pfn, nr_pages, altmap);
 	vmem_remove_mapping(start, size);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 8b6d86fb5a42..2a635b7f78ea 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1273,13 +1273,12 @@ kernel_physical_mapping_remove(unsigned long start, unsigned long end)
 	remove_pagetable(start, end, true, NULL);
 }
 
-void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
-			      struct dev_pagemap *pgmap)
+void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
-	__remove_pages(start_pfn, nr_pages, altmap, pgmap);
+	__remove_pages(start_pfn, nr_pages, altmap);
 	kernel_physical_mapping_remove(start, start + size);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index b39605d30896..ec71debc0673 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -136,10 +136,9 @@ static inline bool movable_node_is_enabled(void)
 	return movable_node_enabled;
 }
 
-extern void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
-			       struct dev_pagemap *pgmap);
+extern void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap);
 extern void __remove_pages(unsigned long start_pfn, unsigned long nr_pages,
-			   struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
+			   struct vmem_altmap *altmap);
 
 /* reasonably generic interface to expand the physical pages */
 extern int __add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
@@ -320,8 +319,7 @@ extern int sparse_add_section(int nid, unsigned long pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap);
 extern void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
-				  struct vmem_altmap *altmap,
-				  struct dev_pagemap *pgmap);
+				  struct vmem_altmap *altmap);
 extern struct zone *zone_for_pfn_range(enum mmop online_type,
 		int nid, struct memory_group *group, unsigned long start_pfn,
 		unsigned long nr_pages);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2fa5ce73b382..eb11212be0d4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5316,8 +5316,7 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
 #endif
 
 struct page * __populate_section_memmap(unsigned long pfn,
-		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
-		struct dev_pagemap *pgmap);
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap);
 void *vmemmap_alloc_block(unsigned long size, int node);
 struct vmem_altmap;
 void *vmemmap_alloc_block_buf(unsigned long size, int node,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1bfd1f4daeb2..f04a248d8ada 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -416,8 +416,7 @@ int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 		err = sparse_add_section(nid, pfn, cur_nr_pages, altmap,
 					 params->pgmap);
 		if (err) {
-			__remove_pages(start_pfn, pfn - start_pfn, altmap,
-				       params->pgmap);
+			__remove_pages(start_pfn, pfn - start_pfn, altmap);
 			break;
 		}
 		cond_resched();
@@ -565,7 +564,6 @@ void remove_pfn_range_from_zone(struct zone *zone,
  * @pfn: starting pageframe (must be aligned to start of a section)
  * @nr_pages: number of pages to remove (must be multiple of section size)
  * @altmap: alternative device page map or %NULL if default memmap is used
- * @pgmap: device page map or %NULL if not ZONE_DEVICE
  *
  * Generic helper function to remove section mappings and sysfs entries
  * for the section of the memory we are removing. Caller needs to make
@@ -573,7 +571,7 @@ void remove_pfn_range_from_zone(struct zone *zone,
  * calling offline_pages().
  */
 void __remove_pages(unsigned long pfn, unsigned long nr_pages,
-		    struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+		    struct vmem_altmap *altmap)
 {
 	const unsigned long end_pfn = pfn + nr_pages;
 	unsigned long cur_nr_pages;
@@ -588,7 +586,7 @@ void __remove_pages(unsigned long pfn, unsigned long nr_pages,
 		/* Select all remaining pages up to the next section boundary */
 		cur_nr_pages = min(end_pfn - pfn,
 				   SECTION_ALIGN_UP(pfn + 1) - pfn);
-		sparse_remove_section(pfn, cur_nr_pages, altmap, pgmap);
+		sparse_remove_section(pfn, cur_nr_pages, altmap);
 	}
 }
 
@@ -1421,7 +1419,7 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
 		memory_block_put(mem);
 
 		remove_memory_block_devices(cur_start, memblock_size);
-		arch_remove_memory(cur_start, memblock_size, altmap, NULL);
+		arch_remove_memory(cur_start, memblock_size, altmap);
 		altmap_free(altmap);
 	}
 }
@@ -1461,7 +1459,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 		ret = create_memory_block_devices(cur_start, memblock_size, nid,
 						  params.altmap, group);
 		if (ret) {
-			arch_remove_memory(cur_start, memblock_size, params.altmap, NULL);
+			arch_remove_memory(cur_start, memblock_size, params.altmap);
 			altmap_free(params.altmap);
 			goto out;
 		}
@@ -1548,7 +1546,7 @@ static int __add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags,
 		/* create memory block devices after memory was added */
 		ret = create_memory_block_devices(start, size, nid, NULL, group);
 		if (ret) {
-			arch_remove_memory(start, size, params.altmap, NULL);
+			arch_remove_memory(start, size, params.altmap);
 			goto error;
 		}
 	}
@@ -2309,7 +2307,7 @@ static int try_remove_memory(u64 start, u64 size)
 		 * No altmaps present, do the removal directly
 		 */
 		remove_memory_block_devices(start, size);
-		arch_remove_memory(start, size, NULL, NULL);
+		arch_remove_memory(start, size, NULL);
 	} else {
 		/* all memblocks in the range have altmaps */
 		remove_memory_blocks_and_altmaps(start, size);
diff --git a/mm/memremap.c b/mm/memremap.c
index accba23aef28..683a77dd679d 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -97,10 +97,10 @@ static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
 				   PHYS_PFN(range_len(range)));
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
 		__remove_pages(PHYS_PFN(range->start),
-			       PHYS_PFN(range_len(range)), NULL, pgmap);
+			       PHYS_PFN(range_len(range)), NULL);
 	} else {
 		arch_remove_memory(range->start, range_len(range),
-				pgmap_altmap(pgmap), pgmap);
+				pgmap_altmap(pgmap));
 		kasan_remove_zero_shadow(__va(range->start), range_len(range));
 	}
 	mem_hotplug_done();
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 71a927d67a9f..5777f2e29684 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -462,8 +462,7 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 }
 
 struct page * __meminit __populate_section_memmap(unsigned long pfn,
-		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
-		struct dev_pagemap *pgmap)
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
@@ -555,11 +554,9 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 }
 
 static struct page * __meminit populate_section_memmap(unsigned long pfn,
-		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
-		struct dev_pagemap *pgmap)
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
-	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
-						      pgmap);
+	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap);
 
 	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages));
 
@@ -567,7 +564,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 }
 
 static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+		struct vmem_altmap *altmap)
 {
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
@@ -648,7 +645,7 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
  * usage map, but still need to free the vmemmap range.
  */
 static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+		struct vmem_altmap *altmap)
 {
 	struct mem_section *ms = __pfn_to_section(pfn);
 	bool section_is_early = early_section(ms);
@@ -686,7 +683,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	 * section_activate() and pfn_valid() .
 	 */
 	if (!section_is_early)
-		depopulate_section_memmap(pfn, nr_pages, altmap, pgmap);
+		depopulate_section_memmap(pfn, nr_pages, altmap);
 	else if (memmap)
 		free_map_bootmem(memmap);
 
@@ -735,9 +732,9 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 		return pfn_to_page(pfn);
 
 	section_set_compound_order_range(pfn, nr_pages, order);
-	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
+	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap);
 	if (!memmap) {
-		section_deactivate(pfn, nr_pages, altmap, pgmap);
+		section_deactivate(pfn, nr_pages, altmap);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -801,13 +798,13 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 }
 
 void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+		struct vmem_altmap *altmap)
 {
 	struct mem_section *ms = __pfn_to_section(pfn);
 
 	if (WARN_ON_ONCE(!valid_section(ms)))
 		return;
 
-	section_deactivate(pfn, nr_pages, altmap, pgmap);
+	section_deactivate(pfn, nr_pages, altmap);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
diff --git a/mm/sparse.c b/mm/sparse.c
index 6acb628c8a73..0b9a6c23a227 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -204,8 +204,7 @@ void __init sparse_sections_init(void)
 }
 #ifndef CONFIG_SPARSEMEM_VMEMMAP
 struct page __init *__populate_section_memmap(unsigned long pfn,
-		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
-		struct dev_pagemap *pgmap)
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
 	const unsigned long size = PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
 
@@ -236,8 +235,7 @@ static void __init sparse_metadata_init_nid(int nid,
 		if (section_nr >= end_section_nr)
 			break;
 
-		mem_map = __populate_section_memmap(pfn, PAGES_PER_SECTION, nid,
-						    NULL, NULL);
+		mem_map = __populate_section_memmap(pfn, PAGES_PER_SECTION, nid, NULL);
 		if (!mem_map)
 			panic("Failed to allocate memmap for section %lu\n",
 			      section_nr);
-- 
2.54.0

