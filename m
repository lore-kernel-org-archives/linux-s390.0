Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692084;
	b=5of/NEIyjBBfJyC+j59HhFiB3tFEAROtwV1I1gH5oWUScil+BuaKK9bxIE9l/90HqolQ
	 CCc4CKwyq2OUAbM7TNGMfU+sfQdkasSvSr3gsfJYtCVMZZCsePtsAO63DQOHTU2RaEsrr
	 Jt5Sg0cGhwyyl9mb8S4ydZclyKO00qQzatG2Xe5HQ9khq2PlAD02w3Yk2O5MX9IfmgCDy
	 RfE96DSv5/L0j91q/7DI9JyJ2W7/QLzCiOrT9FEntap1GMriF+2XNKMj6WA/OPO+0HJdm
	 wanxvLyi2QraZgE1zj0seCF3smwKeVmy5ENSqOcf84NEokLb75QUpRa8d7qYDViBTEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692084;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=oczPXoX6LmrOL71NJs0ylkVxm4d3C/x+BrDR38WYHaE=;
	b=lD3fwaF9l1rb/9R2LjGZdBkr+5r9o7Adja5efqeHSAiT01ILm6sWHCMVqSsEbh125LWm
	 Q06/jwJq71UCWRaoiifMoEMW40OWLgJylerGoMrwg1g3Mm9e7O6rz3QuduIuxxIROAXEw
	 FsN0eDfZ9XcHBKLuwuifru4lJ9ivAlGOZim9CcawQqYxOFthH25auY6Hpj9N42OgMJOkw
	 9u0lr+3icb1ycwpQ8rdYquMad5BVQED46mlhthNVpo06ESooOrNYfvAGakMhHUguT7xTu
	 KPsl5npJb+6a0ZLYY7dv+spx/PHCnB2LvQBnPYWL0f+dWKsoTNV0DwCo9puMDQ5EBNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MdONGc5D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450F7606A332;
	Thu, 26 Nov 2026 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MdONGc5D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1641F000C0;
	Thu, 26 Nov 2026 11:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692083;
	bh=oczPXoX6LmrOL71NJs0ylkVxm4d3C/x+BrDR38WYHaE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MdONGc5D6rm4fAIyBNnofa7zpl+ADVHNhC4NDJwfkNfn8091gbfJmZAzoRVlM/UAl
	 38krRg5mk0qAmdNSn25jievEXiTiFYMnALk5q/eCta1QCgZ9gXPatAvYcRG58uVVBE
	 3wm4HYstziFwb74euNhfATKEVwYpu+Z970spJ7A+TWt8ilM4sCBjHWuMBCVIPGSzRx
	 /6zudqAJDsL4am9+DVg43+2gXxLgl6UsPiaIN70VlmvNQeb+uYNXnrQTMkVGavd135
	 nxFSo02+WGH/4IoofGf/gRphDaH3v6Nduf1B5F3XSAOCSmOauduVMTOdJZelQ13K7m
	 +/5p7bR7Qt+Hg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:56 +0200
Subject: [PATCH RFC v2 43/54] mm/pageattr: let an architecture allocate the
 page tables for a split
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-43-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev

The core allocates the page table for a split with pte_alloc_one_kernel()
and pmd_alloc_one(). s390 cannot use them.

vmem_map_init() write protects the kernel image before the page allocator
is up, so a split at that time has to allocate from memblock.

A fallback to memblock in the core would not be enough. With CMMA, the
decompressor marks all memory as no-DAT, and a page has to be switched back
to DAT before it is used as a page table.

vmem_pte_alloc() and vmem_crst_alloc() do both: they fall back to memblock
and initialize the page.

Memory hot-remove frees the tables of the identity map with
vmem_free_pages(), so a segment table in the identity map has to come from
vmem_crst_alloc() rather than from pmd_alloc_one().

Let an architecture provide arch_cpa_alloc_pgtable() and
arch_cpa_free_pgtable().

There are no users yet. s390 will use them when it switches to the core.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/pageattr.h | 6 ++++++
 mm/pageattr.c            | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/pageattr.h b/include/linux/pageattr.h
index 091408ad328f..1a4e7c5dca98 100644
--- a/include/linux/pageattr.h
+++ b/include/linux/pageattr.h
@@ -111,6 +111,12 @@ static inline int arch_cpa_split_leaf(struct cpa_data *cpa,
 }
 #endif
 
+#ifndef arch_cpa_alloc_pgtable
+void *arch_cpa_alloc_pgtable(struct cpa_leaf *leaf);
+
+void arch_cpa_free_pgtable(struct cpa_leaf *leaf, void *table);
+#endif
+
 #ifndef cpa_is_direct_map
 static inline bool cpa_is_direct_map(unsigned long addr)
 {
diff --git a/mm/pageattr.c b/mm/pageattr.c
index 2f357a8c24d2..e05281a2b169 100644
--- a/mm/pageattr.c
+++ b/mm/pageattr.c
@@ -249,7 +249,8 @@ static pte_t *cpa_lookup(struct cpa_data *cpa, unsigned long address,
 	return leaf->kpte;
 }
 
-static void *arch_cpa_alloc_pgtable(struct cpa_leaf *leaf)
+#ifndef arch_cpa_alloc_pgtable
+void *arch_cpa_alloc_pgtable(struct cpa_leaf *leaf)
 {
 	if (leaf->level == PGTABLE_LEVEL_PMD)
 		return pte_alloc_one_kernel(&init_mm);
@@ -257,13 +258,14 @@ static void *arch_cpa_alloc_pgtable(struct cpa_leaf *leaf)
 	return pmd_alloc_one(&init_mm, leaf->addr);
 }
 
-static void arch_cpa_free_pgtable(struct cpa_leaf *leaf, void *table)
+void arch_cpa_free_pgtable(struct cpa_leaf *leaf, void *table)
 {
 	if (leaf->level == PGTABLE_LEVEL_PMD)
 		pte_free_kernel(&init_mm, table);
 	else
 		pmd_free(&init_mm, table);
 }
+#endif
 
 static int should_split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf)
 {

-- 
2.53.0

