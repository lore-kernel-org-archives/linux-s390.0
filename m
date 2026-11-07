Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025952;
	b=2dt1pbkdcrLJOfcXSGXInJdPGvk77XTJgxguWE+H/oGTG64L2nWjq0GTIHIICgpXfMPX
	 qkZVLE9g056UDaSRRlG5kMmGRWmnM9pckG6DDflreoIUYUhm+52NeOC4tZM/5B0CmJOuQ
	 5zohE5uiP+IcdewK+Vq7+b3GoukUaelZj3sc/YI+kI9ml0yX8mQ60iv24ZejESIsPo2YM
	 6kOy2EP/fEGEchf0+55eJS6Pt4ROh8a3osnUaF3TFArtgzJORd135nVXtRezfjvzAhl9E
	 G1dps3N/2GI6Ca1P2DOzAvy5kIUWpcEKNt/h/7BiKEwJZf+eNocMZsvJY9QnP9BxJjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BY1PW5EQCsSwahWNQsNirKWCM+cX6Fs3QmmMD9rosww=;
	b=YjKKpZnsut9FvD1PnxT2kb36L1JcXqqpSwlMX0qeemSLVmf44zZT7vl0tOcAlprFFv/U
	 kDDw+jQLAQEvvvgWIKzNWG82ihOHEJ1sqIyAdUweQSuV6q2/42G28UPrLQiAPrAlJUJm6
	 PzcgsR0I46DpQCXWQbDhQ9X2WSKZ44ZQO2Ja4jVInA5DdTUoMQ4TmpHBznkpW7dE5PRJE
	 CSzmKJM8XlcVjbLoJm8TLsBF2fz5/BOEQUGznDHWhLQQO1YFNdtCorc2GwjuGtTfP0Hyi
	 KoUmWMj7lNuYs4BSFDLbUscy7W3xi4USK6N7jXng7D+YOHn+48nvXa5I0guFIyu842A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b="Yw/xntLX";
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2339606A32F
	for <linux-s390@vger.kernel.org>; Sat,  7 Nov 2026 04:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2339606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Yw/xntLX
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e977109392so6413335ad.0
        for <linux-s390@vger.kernel.org>; Fri, 06 Nov 2026 20:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794025951; x=1794630751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BY1PW5EQCsSwahWNQsNirKWCM+cX6Fs3QmmMD9rosww=;
        b=Yw/xntLX1Emc5Zji6LogGgC+qzrpcJwEieREH8IPXZncmX0OfpYUecfbwqxo+QkeHM
         Rau0Gi2zXSKDuAELU3lh1PdrD8Zf8wVigmZh9ysbYvhOTbJx6mBjStuSAk05BrRJY7mG
         mEJNzSNKl1vYAv2YyT7HZEd9ucNYGEAFHnqn6YHy9h9b4thDr1S9HkMAPqFwmwK0F2ZN
         FsfBOl2Rh8Fi3+FUWkVQA6+gEfGhz/IcWMfgQeZsckT7q+R0wl3hPf6HaeJzT7QWFd2y
         ZYtvJ+FGXP6Np2X4FOsrx87TX3Ks30H3y0vOH5OY/LS/0m2HFSkezhEtIV8y9H0/HyrR
         BPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794025951; x=1794630751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BY1PW5EQCsSwahWNQsNirKWCM+cX6Fs3QmmMD9rosww=;
        b=D0Wm3+q4v1hkx1Cn7UIblTUlQyEjmXqIIM4MTkccNmyE/G+BtpMg6QjxCwehYrCLYE
         EavqlXR5JQt86V6zlApWSHQ0hOJtFvN7xwv4UKQcVj7OR/aNfjiyQtcpHM8qDWR8GtOO
         DMBxQUgaAgg2eJt+O9mFK3GDdSnHSq90KGm+4Jdujp9enSGkzVdII3QbWwwPtwGo5ZD/
         2T2Fe8OwvlrmxyUtoYyebz19wH4ZyMOnhcT3EWkyx+nPdeKVH3IfKRrMcvQXCRnCQZHY
         Swt60ON1sxNhawCm0x5/Z6aIQc1r8M2eaAvDKHX42bRQQNToezSC9hWBLirWfQKlMwsC
         OOaw==
X-Forwarded-Encrypted: i=1; AL+hErEHZFtcGKSxg/4MOe1QLw6yTjIwhNwfMKfCXpnDMQIQOFelKjXK4ikFkipA10u3CbrDUcWArFoc24Q4@vger.kernel.org
X-Gm-Message-State: APuU4Z/n2d/Yb4Mj8ELhzkTbHIuvvuE+YxwbgCxchigTMw1l18Sxkvi6
	tHQn2VLxBrmqfnV8bXrGgfnR+EuKlhd5m4jhEX3vPwvEbLR/9AkgmgLEtWBWA6bRkY8=
X-Gm-Gg: AYBFou3/XOEW7Z5AjzOqEGqWYKVKN8Wf6Ca0kA8GU3tDTbm/mM+ui/2rRplBzbSAIYf
	MuqBy41ogFbzCcRjY6O39EuA4BbDb3mnAnI9ap0WSeuOFh2PTEd1cvyN0wDaYgC9Stz9kF5oVhP
	9gbkPXivdn5OFbNLb7mZsWXLXLpP7N8NGL0pH4pUa1N8ZZe/lJQHgFIsMJwxH/RG6MIjOgPkRjw
	Fm3wYA5COwV+AeBefFHYYgqFqHUKfA3TjrNpsmACCDfTXVspKOq04nYGCAzP+UiSbcp3Ry95xey
	dC1Kqdf2ZRIcJiVM6UWe0lmDgvGjqzifpNvXRrHRjUAzT+QNtd/RXPSDbiWxwIhv5wvAms2YLqM
	Nt+eC+6krMlE3sYdrF5wrivSBFUlmTk9U5jLbEZQ9kJQEaJ4JXPjTyQdD22NsQTbMOrqyBATA1M
	Enl4qnE1e3FfhO3DA/hZWEigWDi+YWPVt/9PfJ7Yx8fKfgdchWHa+bi6RsN43Jzayu9MLB1Xul2
	7jambt3k5gWSEtTh6ewFoCZiTagpdbougIY6l+LmmbPTfZLk2noTnAnnlmU+4AW2Qv+JRQdfG+D
	7/Di7bKYgZ3e1icpCMZ7Vt1IqkbsWsgj8iIwwFyFvtXKkleg3lYwYIrMO+VolvSaYl4uDLOPmek
	paYV36g==
X-Received: by 2002:a17:90b:530c:b0:3a8:59d3:530f with SMTP id 98e67ed59e1d1-3b0db71d480mr4559125a91.57.1794025951057;
        Fri, 06 Nov 2026 20:32:31 -0800 (PST)
Received: from G6L4RL2QG9 ([2409:8a00:1832:6900:c8de:13da:804b:a0fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10584b66bsm1578451a91.14.2026.11.06.20.32.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 20:32:30 -0800 (PST)
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
Subject: [PATCH v3 4/5] mm/sparse-vmemmap: drop vmemmap_can_optimize()
Date: Sat,  7 Nov 2026 12:31:21 +0800
Message-ID: <20261107043122.25650-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107043122.25650-1-songmuchun@bytedance.com>
References: <20261107043122.25650-1-songmuchun@bytedance.com>
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
index 2d0b8a4c9974..43eb19474d26 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -38,7 +38,6 @@
 #include <linux/bitops.h>
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/kcsan-checks.h>
-#include <linux/vmemmap-optimization.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -5385,42 +5384,6 @@ static inline void vmem_altmap_free(struct vmem_altmap *altmap,
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
index 22e5a322be0b..985a37dfcab7 100644
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
@@ -109,15 +123,4 @@ static inline bool vmemmap_optimizable_pfn(unsigned long pfn, unsigned int order
 
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
index 57aa5c2d8034..f6a8b8e51b6c 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -490,6 +490,9 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
+	/* Altmap-backed vmemmap pages cannot be optimized. */
+	if (altmap)
+		section_vmemmap_optimization_disable(start, end);
 	r = vmemmap_populate(start, end, nid, altmap);
 	if (r < 0)
 		return NULL;
@@ -717,10 +720,9 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
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

