Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369333;
	b=pkKblne9ZiAq5OHdTIgawq1rGprO6lcfDFsiELSegTy8bAIJqhZDkFuG8nTf4oiJl8rs
	 ph2TmtVIaGMUikZEVRllOG17uiB8vFWP6bUR/4ONreQkbXUP2DgPH+ZnH0eRDDdfd1zww
	 o94H1T6d8kgrju7AePSl31A+7/kL5Q0PnLY9w/xgWcYuYBTIbXzo/89+jxzjdNTDaxxRL
	 GrIeEBenaHiV6b/mFl6gn9wH4NO6A36rU6wguAjlVB+necLKLWgKiYeYmGk84JVxxhXQU
	 vuj6K5U6IJQivdercon7730DCLI8TQ1B2adm7O7sakeQ1jL1F/F4BDcBXLMsMpCc24g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QjoN4+6LqE6BOGR2vrR9uNSgacxzY3BRDUxvEZuPaiQ=;
	b=JutCnJvHuXCMjfyQlylO5O/AooPjBlIft6UvGhjUeEPmrZcGS4+GPC3vTnpKbsnxjh8q
	 QaT11YnqLcYxzESx2yW1RtRdm8YpJy42v1tTOw6MVea20kSMAZWvkiR4WxlmHixpg0Ic9
	 3ahkIcl2ELwZRggXQxAeODnFGlPLou8JepPQeON2HJz4GfYmVNyW6FA/+OGw65DFnpcHy
	 T5aTxWyeJv1En5yBpZ/KBKiDuu3D7baBaUSxgSlwRFCHF4SnmyCqDmPfXIt4vxhksakhk
	 GP5d9trlXocTysD0c1DNBxd/6LDutHayo6FNxnrq/oMWaNEPARtQ83LqG9fm/dE9v1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b="gSPpLx/s";
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5323606A31A
	for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 14:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5323606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gSPpLx/s
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e985106c0cso7148205ad.2
        for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 07:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793369332; x=1793974132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QjoN4+6LqE6BOGR2vrR9uNSgacxzY3BRDUxvEZuPaiQ=;
        b=gSPpLx/sl2uTzFuR1TXspjH6kzLCRaz8U2BZyl1YoorPJXwXUyJUSuk4IvscCPQhNL
         L4YKu44Xc9Lb6N5H7CtGGG7BICO7Wiotzi1J3hGobL6tImXseBpYVj/+W7TeVkUlkw11
         AuUR321nHXNErWnNp2zRT2YhLtjS9wfcF/bDAjzOsU1NhBnkClI8cs6inVHEKAOlhrNA
         qMseSSiueG5Et6zil9Ns7ITzsLLeZkg586SttCPrNgyYL2rNReZYGSmmOi7NA9SeRULS
         95zTiogvFuCvOP6bhtWYl3svoHo9ZULKEBpz4mzFLie7eTn3gdymvBOBciqpGbsFojoE
         cS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369332; x=1793974132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QjoN4+6LqE6BOGR2vrR9uNSgacxzY3BRDUxvEZuPaiQ=;
        b=U7NY7QpSRURQaOBRcGid/zxkGYsCi1n981qSomHUhR3zgOrhblbtt6vad8lDAU4Gxa
         KU4aAA8GNVGVoYFNGaYlthzykunp+u9oZIGamZ0oNmLJsiRejczbpKvDS2uq46zv9mQq
         ZRR4gJRHz0EBqF76saTuFG2gJgsKsNY2lbPekdehEKkWNVUAOG0jMKSRw7I1MFvdGr+O
         b0lv6VAMxivcYra6ygNCeVIfYYE/MXttUUP9YDOoVunJS829QPAEG5BgtQz+kuPSFHAq
         4AcAke9E3UUOyiuWwRQxBACWpIjw5Gy6oa1NrlESWaUCt6e3dom2sGX/XUd6MWIGf+jc
         BVgg==
X-Forwarded-Encrypted: i=1; AKwUvBy22GvStSJFZlZgDn+W4eoY4cdfdur2GAgbMaFKC2TNLiITXsc6wWbQHQzCIvKMOD/vTFo9IgQ6C3eR@vger.kernel.org
X-Gm-Message-State: AFq9FYIygWhUS/9quIN8kx3OeTHRjGOc/GGjUER/o3uoDgYodfnkupJZ
	zdkD6G+U+KRmdNizK0NazIJN1oieD4M2WC0hAJWqLX43i+NBu2IfP6HS7iKlbZW+h6Q=
X-Gm-Gg: AYBFou14GLh8zv6hY+Rcq26N2ULYnsG7jOSEw/pCizGjMQgd035VfK8vbfWT5JwJ+6h
	/QEC+T3caHoebW2HOLXQaySg27exiPZPqB8L40wV7kpdj42uf8p8/VdEToSf9vxaFD01hnp+GZw
	iBBW05uLVq4kKoxo0IWH9EfQRuS6ZuNp1x7UP3SpZ8d2It/2gYMNdOqWVPalZzWKIKWAG3IokXc
	/1+EGNyeXdkHNk1n2lWUdYYjWm5017bOapd1s5UaeQw0xC6JOxX/4rnNfsHw9WgMRQcdSXdPzTQ
	n0Am1qlw/ZgMpBuImZZOogHZaHlrfNZhtQEGaEMGmSObvUPHMCHI4zZDE4u6J4PkEjXpdKQNPu7
	OC820GQlZs4JD6cH2kS9tudT0VxLsrwDVlMvEY7YWwPSSLazHVaqP/z0rtco0Lvl11DDKlP5MFr
	4xhtjabERRkJr52xsqTonfkjVESQPPwKRYBRv1VEkeCOXxzhlZyuhCNeN3+e0XxMi8yT2s2jboq
	wwGiwhy+QWt8W4lISyZE+PPquX2iFwJf4rjRvyvZa4IoFwPXWhDj7ctLC3VFtC5h/pLV4FKGjY5
	Wg+x/Oq4W4PROWfzg5S2LXAGswEIqOhb8pJAFLv9xc4/LhkeKPYmpamXWgxP+zNHsat1vuwA
X-Received: by 2002:a17:903:2f03:b0:2e9:4f7b:affd with SMTP id d9443c01a7336-2eb36415069mr25082595ad.6.1793369332072;
        Fri, 30 Oct 2026 07:08:52 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3929b27bsm7601795ad.62.2026.10.30.07.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:08:51 -0700 (PDT)
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
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/4] mm/sparse-vmemmap: drop vmemmap_can_optimize()
Date: Fri, 30 Oct 2026 22:07:19 +0800
Message-ID: <20261030140720.1256062-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030140720.1256062-1-songmuchun@bytedance.com>
References: <20261030140720.1256062-1-songmuchun@bytedance.com>
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
 include/linux/mm.h  | 37 -------------------------------------
 mm/sparse-vmemmap.c | 11 +++++++++--
 2 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e875f73b0c6f..4fb48fbe712d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -38,7 +38,6 @@
 #include <linux/bitops.h>
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/kcsan-checks.h>
-#include <linux/vmemmap-optimization.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -5395,42 +5394,6 @@ static inline void vmem_altmap_free(struct vmem_altmap *altmap,
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
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 3e9d6617c4bb..43559593107c 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -466,12 +466,20 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 {
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
+	struct mem_section *ms = __pfn_to_section(pfn);
 	int r;
 
 	if (WARN_ON_ONCE(!IS_ALIGNED(pfn, PAGES_PER_SUBSECTION) ||
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
+	/*
+	 * Vmemmap optimization is not supported when vmemmap pages are backed
+	 * by an altmap.
+	 */
+	if (altmap && section_vmemmap_optimizable(ms))
+		section_set_compound_order(ms, 0);
+
 	r = vmemmap_populate(start, end, nid, altmap);
 	if (r < 0)
 		return NULL;
@@ -699,10 +707,9 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
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

