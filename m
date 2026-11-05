Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859178;
	b=PxsotoDrHfhA3AUP5lChcZTPopbhDdaOn7i9x1dhd05WyW2dzvm6KPZgLk4oWZ63BUL4
	 I01bjzlXCO4N/zQK/kGD4sXfVDATkjxqk8q4/wWrSPDgjVDC8xXeS0iZXXSpapknYM3Vb
	 V9GOzQLUpbf1Z4rFeEuje4z2ZahGAujemn4xEXJkFuq+xnSCKKm5jfQlUJVLX5lL7auAf
	 Oe1c+HAFpMJoxyqMc9cpos3U9AKORPi05pgNMip6h8IVgmoCRWZhJu0BRWzzGP8C1oEZv
	 R8/JbQTvp91TjqzbtFxoPRXRqhnBHS86UHBb5akvw9cO9Ac9VMhxGT+97qetBT+WTWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kKRQNq+YvdEons4PssMSMvDyZ1aDaAIj0dg+GEUgY+U=;
	b=a2TY+UgrJxIsE/IB7bBA+2EvZFznOiQUxXh1aIZ0amPHQunbkQmb3Uzlglow0IktdqMu
	 lzcP9rAulbM2LNyV08LFqFb39B2asl7V1wuyyga6HT7vGseAl9dTFiUkHFH/KsNSTDj9J
	 gQie0Jkve1+RaHz/UDn75TGb8J7VtoAw3kxS9ER0G+43te6pTQijHW/legSqrWK1lReUr
	 DSwhQ6MdzJDGC/qztQJoHe12A0yK4egdaVlMc7yxY7lj1qlrr2+5xBQXNrXDBDYZeJ752
	 EJkK1dWaVki2/IZ2qr7VD1y1oXLkARbpSwI7gl9wpQrRfZSHyiiVcY2w6zpryOM2m8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dBbhsXtL;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8E9606A32C
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 06:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F8E9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dBbhsXtL
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso1052940a91.0
        for <linux-s390@vger.kernel.org>; Wed, 04 Nov 2026 22:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793859178; x=1794463978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kKRQNq+YvdEons4PssMSMvDyZ1aDaAIj0dg+GEUgY+U=;
        b=dBbhsXtLFdFBkSvwxnyskg9ourqHABJHSQ09odjJUEvYlL9vuRyImYwG4ymSaPqec+
         VJQyqxdg23C7JLAQEFd4ayXmyL3uh8nGtwEvMonkBqKTCgdPs9LxUJxBSRNkMgnX2cce
         8ntm2nt2w9f3WCGmi2SHfSc+fCuvRhMEmjQfyiapCtHnl2aGUzzKuXmYhBiWyWA5kuet
         Gf3MKF9stoCF+QZb2eT6BvHdNUzAxRvVViOk1KZiWCKkyVrJGcrIZT4UBMZ7XFC5/SNq
         dbb9U7JF4y+hrNV4jkAg7NfLYkLWFnctS6Yh8gJ15lLXjoy3Dskeo/x4Jy7y3LsSfJKn
         Wznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793859178; x=1794463978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kKRQNq+YvdEons4PssMSMvDyZ1aDaAIj0dg+GEUgY+U=;
        b=11vRKRAyLUgtusk3lbexH1AbxyPxsEM6BiflKzL8+YIbYf6scChuzetdi8moNGzuVZ
         8XvqYhSzz+wl/rt721pzhnOWIIk1Nr33hb1xtcUX0Km/VI2r2ijDKPH/cJYvYD4R2hfp
         kziPQCNy7h3b5ZszSchcWoPUF31J8cBA83sL69bEzQs76Hhe992oT8IYa0M8mqXZU4GF
         epWWMzn9hEUc1hR6k8tVfFxPMbPCB1pvrt3IV1vxPYT57lbrvbRnqzsicJPm5jTiK+uY
         ouOJNsJ03QXeRpUNQpFZPOYGnRQIzek8+PAbVFvde49TXb717kbcTUOtXywCVIUXkJu4
         oOMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxSoQ3Xr1uRFYfEf2sdKVvikSt9hdQq5eCBA87Fxz915mmafhXphlXKVMuyT+Hs5J5ykMp5OqUR+a9t@vger.kernel.org
X-Gm-Message-State: APuU4Z8yq6jmZKUz3YbR+GpUjB5iKPgMneT1su7FuEnR4s49c5Kw2XSV
	t4Px6TPuu9awJgnSejDX162mDbTpo0SIkCSzdnuvfNpkjz+7NAskwacpTg427bt8XMc=
X-Gm-Gg: AYBFou0Xq88UcLVEgcC6/9mjjaD3Z/aVKDtdoprx20Sr884lUUW25lBFQgAmyPJ60VD
	EqGOH8udE9B0uJVQVuWiCGNC/XE5LGIUlJujCgpljFBZTvEtaAji0YMYUSZV6xcLu9ZxvtVniHI
	Qbi4YNhs69gf+STB4IKXRuzwfOav4+DwsCftaZejsLquLYEaj+rdj8E/3O61nM8cDLSvBfX99ev
	1MbqLLwaf/ctrnWEyOSIGWc/lJy7dL9YWK7TV4ebb00KxMgXfFxXqtwVxeR+Aexv1ENKmFdaMKI
	OluQOJyzFOIU7AApRJFUsq1iRQZTMX6mM81Lz1cvi2+IVhkG4DBKX0ZfGXoiBmYXLsL6Sd9M3LE
	cfSk1XSGQIehiyX8YsAmMF6+MwFm4IcWdPcy1vm2ATnyDLfNtjtH7AvDuhreyVrfAf7w1+qwnTm
	S2EAtyEdLv/kh/dBnbP7XQukl4JQJrTwwbgINP2HclOAQEiDePUsSSq55GZOsuw371W3CGv40y0
	RJwOHyoJKHSt2t/tE0IzQeujg7spfXBzN8AVrQ+BdQUwEVhvZP3QyR1XUD3R3aodGmCjeU/jL0a
	LxEg8VMYRCUSbo8P9KHsI4g+LPHqWJxKlilqw0IExhYoOy9SbBQ3gvKpMDChxgP1MA==
X-Received: by 2002:a17:90b:380c:b0:3a7:250:333e with SMTP id 98e67ed59e1d1-3ae896f8315mr16195357a91.11.1793859177566;
        Wed, 04 Nov 2026 22:12:57 -0800 (PST)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323a1fdsm2107528a91.5.2026.11.04.22.12.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 22:12:57 -0800 (PST)
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
Subject: [PATCH v2 4/5] mm/sparse-vmemmap: drop vmemmap_can_optimize()
Date: Thu,  5 Nov 2026 14:12:16 +0800
Message-ID: <20261105061217.13302-5-songmuchun@bytedance.com>
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

section_vmemmap_optimizable() can already decide whether a section uses
vmemmap optimization based on the section compound order. The DAX-specific
vmemmap_can_optimize() helper duplicates that policy, so remove it to
simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
- Ignore non-optimizable nonzero section orders while retaining zero
  as the reset value (reported by Sashiko)
- Use section_vmemmap_optimization_disable() for the altmap fallback
- Move vmemmap_optimizable_order() before its first caller
---
 include/linux/mm.h                   | 37 ----------------------------
 include/linux/vmemmap-optimization.h | 25 ++++++++++---------
 mm/sparse-vmemmap.c                  |  6 +++--
 3 files changed, 18 insertions(+), 50 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a060a7150401..2fa5ce73b382 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -38,7 +38,6 @@
 #include <linux/bitops.h>
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/kcsan-checks.h>
-#include <linux/vmemmap-optimization.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -5366,42 +5365,6 @@ static inline void vmem_altmap_free(struct vmem_altmap *altmap,
 }
 #endif
 
-#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
-static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
-					  struct dev_pagemap *pgmap)
-{
-	unsigned long nr_pages;
-	unsigned long nr_vmemmap_pages;
-
-	if (!IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION))
-		return false;
-
-	if (!pgmap || !is_power_of_2(sizeof(struct page)))
-		return false;
-
-	nr_pages = pgmap_vmemmap_nr(pgmap);
-	nr_vmemmap_pages = ((nr_pages * sizeof(struct page)) >> PAGE_SHIFT);
-	/*
-	 * For vmemmap optimization with DAX we need minimum 2 vmemmap
-	 * pages. See layout diagram in Documentation/mm/vmemmap_dedup.rst
-	 */
-	return !altmap && (nr_vmemmap_pages > VMEMMAP_OPTIMIZATION_PAGES);
-}
-/*
- * If we don't have an architecture override, use the generic rule
- */
-#ifndef vmemmap_can_optimize
-#define vmemmap_can_optimize __vmemmap_can_optimize
-#endif
-
-#else
-static inline bool vmemmap_can_optimize(struct vmem_altmap *altmap,
-					   struct dev_pagemap *pgmap)
-{
-	return false;
-}
-#endif
-
 enum mf_flags {
 	MF_COUNT_INCREASED = 1 << 0,
 	MF_ACTION_REQUIRED = 1 << 1,
diff --git a/include/linux/vmemmap-optimization.h b/include/linux/vmemmap-optimization.h
index 5c09da4df4d8..9d9f7a67d195 100644
--- a/include/linux/vmemmap-optimization.h
+++ b/include/linux/vmemmap-optimization.h
@@ -31,6 +31,17 @@
 #define VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES	(VMEMMAP_OPTIMIZATION_SIZE / sizeof(struct page))
 #define VMEMMAP_OPTIMIZATION_MIN_ORDER		(ilog2(VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) + 1)
 
+static inline bool vmemmap_optimizable_order(unsigned int order)
+{
+	if (!IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION))
+		return false;
+
+	if (!is_power_of_2(sizeof(struct page)))
+		return false;
+
+	return order >= VMEMMAP_OPTIMIZATION_MIN_ORDER;
+}
+
 #ifdef CONFIG_VMEMMAP_OPTIMIZATION
 static inline unsigned int section_compound_order(const struct mem_section *section)
 {
@@ -40,6 +51,9 @@ static inline unsigned int section_compound_order(const struct mem_section *sect
 static inline void section_set_compound_order(struct mem_section *section,
 					      unsigned int order)
 {
+	if (order && !vmemmap_optimizable_order(order))
+		return;
+
 	VM_WARN_ON(section_compound_order(section) && order &&
 		   section_compound_order(section) != order);
 	section->compound_page_order = order;
@@ -134,15 +148,4 @@ static inline bool vmemmap_optimizable_pfn(unsigned long pfn, unsigned int order
 
 	return (pfn & (nr_pages - 1)) >= VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES;
 }
-
-static inline bool vmemmap_optimizable_order(unsigned int order)
-{
-	if (!IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION))
-		return false;
-
-	if (!is_power_of_2(sizeof(struct page)))
-		return false;
-
-	return order >= VMEMMAP_OPTIMIZATION_MIN_ORDER;
-}
 #endif /* _LINUX_VMEMMAP_OPTIMIZATION_H */
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index b8b55e12f5ba..71a927d67a9f 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -473,6 +473,9 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
+	/* Altmap-backed vmemmap pages cannot be optimized. */
+	if (altmap)
+		section_vmemmap_optimization_disable(start, end);
 	r = vmemmap_populate(start, end, nid, altmap);
 	if (r < 0)
 		return NULL;
@@ -700,10 +703,9 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 	struct mem_section *ms = __pfn_to_section(pfn);
 	struct mem_section_usage *usage = NULL;
 	struct page *memmap;
-	unsigned int order;
+	unsigned int order = pgmap ? pgmap->vmemmap_shift : 0;
 	int rc;
 
-	order = vmemmap_can_optimize(altmap, pgmap) ? pgmap->vmemmap_shift : 0;
 	if (nr_pages < PAGES_PER_SECTION && section_compound_order(ms))
 		return ERR_PTR(-EOPNOTSUPP);
 
-- 
2.54.0

