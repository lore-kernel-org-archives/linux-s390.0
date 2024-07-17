Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79E433C4
	for <linux-s390@vger.kernel.org>; Wed, 17 Jul 2024 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721253753; cv=none; b=TgZfPu7xI2hF2y1BePXXoZA7cL5jhXZ/9KQVdeV0tXoMUiD+5kAW5sWUdE2rJC6U3BGPSQTHLx8zrTVJZlVC1wew7zr+d7x82uT70bFWQsPaiXNaDpnC+S4mTf5GJsUCNGcJdftkW4IOo6WIVVzYuz0ZB+YCg9z5rLysMZKVWoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721253753; c=relaxed/simple;
	bh=bJ/9dQ+ygLqKtCXT7Q51ms41RIzdrRAfp5bW2qmdICI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SihMSkCWPua6ge/AamyS9TtjDfBOoNPEyd/8NhXOFpA/PZmzYEN/f5ck3z6K+TLGNFC3jBQQ8rpKpSU6PHGGZa+p4G0zQRCBRqurgi2Hu+T+Vi5bZa6u60A2N/1xtbyup4IYYve7kBBZjtBkGmby4vlzJDSiUsl9VMDMgMN24aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=igzX8HF5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igzX8HF5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721253750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/8FqM8MHmMc+CPhzIMhMKyvtEdM/efe50XUln9udmc=;
	b=igzX8HF5paYV9HfSONlNwzBfVPyd7tpoyXYcoSOx6p28iJNA/z8ekSjsxJQvn28QkXQwvR
	8B3oaX6RYBofEUH5Xboq/vX6ueEfUv9VQBuQxjR+VpzJh4sFmXf4jIbBGADp9OSxYXs6o6
	/Z5AG8yyzT3C6HL2cUQkuquY+A/Ns38=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-JqcWX0NMMOGGh9WA0nrfgA-1; Wed, 17 Jul 2024 18:02:29 -0400
X-MC-Unique: JqcWX0NMMOGGh9WA0nrfgA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b5dd89dfa7so421436d6.0
        for <linux-s390@vger.kernel.org>; Wed, 17 Jul 2024 15:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721253749; x=1721858549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/8FqM8MHmMc+CPhzIMhMKyvtEdM/efe50XUln9udmc=;
        b=KZ+7vACBBMLxTFsG4gLGMmWvooxDg9zR0XkL7QeIDz+8ipS/QDtEhzMXyOqugN5RqH
         zO6PwUL07s5yZdbSU1eH3eH/gh9/i4n6ULAFxYB+d/4qZpQy3b1mBNENA3TlLhRCdpBN
         rD0BvLvYgd+x9aqCSBrxmMNTkPr/8lb7vJqcsPCBvoJDL7gok6tLThuyXEzwYnp/jlBr
         Ju5pPOI2TaeuPjIzbQrsiP1JslMsBv7/qJE3foFoEzY75SS8UkRnnuFFOvYIezhFnK7m
         FjEfVXhh+uC4Ie7JFJeG9oz8i8j+qyM4jzoyXHTrqoxJfnAcchCBOyuxV1OedcqRc+k/
         zf3A==
X-Forwarded-Encrypted: i=1; AJvYcCVE1vwE4kFzkehINJkhI9hg98PKOpWwKtKxIH9WyS5pQoB3w1h/nq2R39K4EUVrsbCGKuH5FWXptNm4WS4nWbGZrgbRQWeIo+T7og==
X-Gm-Message-State: AOJu0YzV0Tnxujjm1qsCgZOJoFfIDJCgzQrix3ORx4DLlpXEzUOuBArk
	QII85vSDR2iT4vTXY8RiicvvVCxGI7WybTA0gwFR68dhOdgoBscB9ijmo9XOcIP2U5aUYuFwwK3
	D4behDuTAzWEwaNO0XwAgFir3JYKkegx1+pKdERRR9UtAzKiqKh+AoZ9XHPk=
X-Received: by 2002:ac8:5e4e:0:b0:44f:89e3:e8d2 with SMTP id d75a77b69052e-44f89e3ec09mr15925731cf.12.1721253748779;
        Wed, 17 Jul 2024 15:02:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkh4XOnr3AtOIW10S+BWZqmnCIDsT2k5pxPdK7+Hm3t/qz0UGl/1x0RrFHwUrrZQJVVqVXtg==
X-Received: by 2002:ac8:5e4e:0:b0:44f:89e3:e8d2 with SMTP id d75a77b69052e-44f89e3ec09mr15925451cf.12.1721253748289;
        Wed, 17 Jul 2024 15:02:28 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b83f632sm53071651cf.85.2024.07.17.15.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 15:02:27 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	peterx@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	linux-s390@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@kernel.org>,
	linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	x86@kernel.org,
	Alistair Popple <apopple@nvidia.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH RFC 3/6] mm/treewide: Make pgtable-generic.c THP agnostic
Date: Wed, 17 Jul 2024 18:02:16 -0400
Message-ID: <20240717220219.3743374-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240717220219.3743374-1-peterx@redhat.com>
References: <20240717220219.3743374-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make pmd/pud helpers to rely on the new PGTABLE_HAS_*_LEAVES option, rather
than THP alone, as THP is only one form of huge mapping.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/include/asm/pgtable.h             |  6 ++--
 arch/powerpc/include/asm/book3s/64/pgtable.h |  2 +-
 arch/powerpc/mm/book3s64/pgtable.c           |  2 +-
 arch/riscv/include/asm/pgtable.h             |  4 +--
 arch/s390/include/asm/pgtable.h              |  2 +-
 arch/s390/mm/pgtable.c                       |  4 +--
 arch/sparc/mm/tlb.c                          |  2 +-
 arch/x86/mm/pgtable.c                        | 15 ++++-----
 include/linux/mm_types.h                     |  2 +-
 include/linux/pgtable.h                      |  4 +--
 mm/memory.c                                  |  2 +-
 mm/pgtable-generic.c                         | 32 ++++++++++----------
 12 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 5d5d1b18b837..b93c03256ada 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1105,7 +1105,7 @@ extern int __ptep_set_access_flags(struct vm_area_struct *vma,
 				 unsigned long address, pte_t *ptep,
 				 pte_t entry, int dirty);
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_PMD_LEAVES
 #define __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
 static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
 					unsigned long address, pmd_t *pmdp,
@@ -1114,7 +1114,9 @@ static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
 	return __ptep_set_access_flags(vma, address, (pte_t *)pmdp,
 							pmd_pte(entry), dirty);
 }
+#endif
 
+#ifdef CONFIG_PGTABLE_HAS_PUD_LEAVES
 static inline int pud_devmap(pud_t pud)
 {
 	return 0;
@@ -1178,7 +1180,7 @@ static inline int __ptep_clear_flush_young(struct vm_area_struct *vma,
 	return young;
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_PMD_LEAVES
 #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
 static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long address,
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 051b1b6d729c..84cf55e18334 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1119,7 +1119,7 @@ static inline bool pmd_access_permitted(pmd_t pmd, bool write)
 	return pte_access_permitted(pmd_pte(pmd), write);
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_PMD_LEAVES
 extern pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot);
 extern pud_t pfn_pud(unsigned long pfn, pgprot_t pgprot);
 extern pmd_t mk_pmd(struct page *page, pgprot_t pgprot);
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 5a4a75369043..d6a5457627df 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -37,7 +37,7 @@ EXPORT_SYMBOL(__pmd_frag_nr);
 unsigned long __pmd_frag_size_shift;
 EXPORT_SYMBOL(__pmd_frag_size_shift);
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 /*
  * This is called when relaxing access to a hugepage. It's also called in the page
  * fault path when we don't hit any of the major fault cases, ie, a minor
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ebfe8faafb79..8c28f15f601b 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -752,7 +752,7 @@ static inline bool pud_user_accessible_page(pud_t pud)
 }
 #endif
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_PMD_LEAVES
 static inline int pmd_trans_huge(pmd_t pmd)
 {
 	return pmd_leaf(pmd);
@@ -802,7 +802,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 #define pmdp_collapse_flush pmdp_collapse_flush
 extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 				 unsigned long address, pmd_t *pmdp);
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif /* CONFIG_PGTABLE_HAS_PMD_LEAVES */
 
 /*
  * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index fb6870384b97..398bbed20dee 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1710,7 +1710,7 @@ pmd_t pmdp_xchg_direct(struct mm_struct *, unsigned long, pmd_t *, pmd_t);
 pmd_t pmdp_xchg_lazy(struct mm_struct *, unsigned long, pmd_t *, pmd_t);
 pud_t pudp_xchg_direct(struct mm_struct *, unsigned long, pud_t *, pud_t);
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_PMD_LEAVES
 
 #define __HAVE_ARCH_PGTABLE_DEPOSIT
 void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 2c944bafb030..c4481068734e 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -561,7 +561,7 @@ pud_t pudp_xchg_direct(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL(pudp_xchg_direct);
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_PMD_LEAVES
 void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 				pgtable_t pgtable)
 {
@@ -600,7 +600,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 	set_pte(ptep, __pte(_PAGE_INVALID));
 	return pgtable;
 }
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif /* CONFIG_PGTABLE_HAS_PMD_LEAVES */
 
 #ifdef CONFIG_PGSTE
 void ptep_set_pte_at(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 8648a50afe88..140813d07c9f 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -143,7 +143,7 @@ void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
 		tlb_batch_add_one(mm, vaddr, pte_exec(orig), hugepage_shift);
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_PMD_LEAVES
 static void tlb_batch_pmd_scan(struct mm_struct *mm, unsigned long vaddr,
 			       pmd_t pmd)
 {
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index fa77411bb266..7b10d4a0c0cd 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -511,7 +511,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 	return changed;
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_PMD_LEAVES
 int pmdp_set_access_flags(struct vm_area_struct *vma,
 			  unsigned long address, pmd_t *pmdp,
 			  pmd_t entry, int dirty)
@@ -532,7 +532,9 @@ int pmdp_set_access_flags(struct vm_area_struct *vma,
 
 	return changed;
 }
+#endif	/* PGTABLE_HAS_PMD_LEAVES */
 
+#ifdef CONFIG_PGTABLE_HAS_PUD_LEAVES
 int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 			  pud_t *pudp, pud_t entry, int dirty)
 {
@@ -552,7 +554,7 @@ int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 
 	return changed;
 }
-#endif
+#endif	/* PGTABLE_HAS_PUD_LEAVES */
 
 int ptep_test_and_clear_young(struct vm_area_struct *vma,
 			      unsigned long addr, pte_t *ptep)
@@ -566,7 +568,7 @@ int ptep_test_and_clear_young(struct vm_area_struct *vma,
 	return ret;
 }
 
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
+#if defined(CONFIG_PGTABLE_HAS_PMD_LEAVES) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
 int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 			      unsigned long addr, pmd_t *pmdp)
 {
@@ -580,7 +582,7 @@ int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 }
 #endif
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_PUD_LEAVES
 int pudp_test_and_clear_young(struct vm_area_struct *vma,
 			      unsigned long addr, pud_t *pudp)
 {
@@ -613,7 +615,7 @@ int ptep_clear_flush_young(struct vm_area_struct *vma,
 	return ptep_test_and_clear_young(vma, address, ptep);
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_PMD_LEAVES
 int pmdp_clear_flush_young(struct vm_area_struct *vma,
 			   unsigned long address, pmd_t *pmdp)
 {
@@ -641,8 +643,7 @@ pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
 }
 #endif
 
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
-	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
+#ifdef CONFIG_PGTABLE_HAS_PUD_LEAVES
 pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pud_t *pudp)
 {
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index ef09c4eef6d3..44ef91ce720c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -942,7 +942,7 @@ struct mm_struct {
 #ifdef CONFIG_MMU_NOTIFIER
 		struct mmu_notifier_subscriptions *notifier_subscriptions;
 #endif
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
+#if defined(CONFIG_PGTABLE_HAS_PMD_LEAVES) && !USE_SPLIT_PMD_PTLOCKS
 		pgtable_t pmd_huge_pte; /* protected by page_table_lock */
 #endif
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 0a904300ac90..5a5aaee5fa1c 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -362,7 +362,7 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 #endif
 
 #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
+#if defined(CONFIG_PGTABLE_HAS_PMD_LEAVES) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
 static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long address,
 					    pmd_t *pmdp)
@@ -383,7 +383,7 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 	BUILD_BUG();
 	return 0;
 }
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG */
+#endif /* CONFIG_PGTABLE_HAS_PMD_LEAVES || CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG */
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
diff --git a/mm/memory.c b/mm/memory.c
index 802d0d8a40f9..126ee0903c79 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -666,7 +666,7 @@ struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
 	return NULL;
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_PMD_LEAVES
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 				pmd_t pmd)
 {
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index a78a4adf711a..e9fc3f6774a6 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -103,7 +103,7 @@ pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long address,
 }
 #endif
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_PMD_LEAVES
 
 #ifndef __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
 int pmdp_set_access_flags(struct vm_area_struct *vma,
@@ -145,20 +145,6 @@ pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return pmd;
 }
-
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-pud_t pudp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
-			    pud_t *pudp)
-{
-	pud_t pud;
-
-	VM_BUG_ON(address & ~HPAGE_PUD_MASK);
-	VM_BUG_ON(!pud_trans_huge(*pudp) && !pud_devmap(*pudp));
-	pud = pudp_huge_get_and_clear(vma->vm_mm, address, pudp);
-	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
-	return pud;
-}
-#endif
 #endif
 
 #ifndef __HAVE_ARCH_PGTABLE_DEPOSIT
@@ -252,7 +238,21 @@ void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
 	call_rcu(&page->rcu_head, pte_free_now);
 }
 #endif /* pte_free_defer */
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif /* CONFIG_PGTABLE_HAS_PMD_LEAVES */
+
+#ifdef CONFIG_PGTABLE_HAS_PUD_LEAVES
+pud_t pudp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
+			    pud_t *pudp)
+{
+	pud_t pud;
+
+	VM_BUG_ON(address & ~HPAGE_PUD_MASK);
+	VM_BUG_ON(!pud_trans_huge(*pudp) && !pud_devmap(*pudp));
+	pud = pudp_huge_get_and_clear(vma->vm_mm, address, pudp);
+	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
+	return pud;
+}
+#endif	/* CONFIG_PGTABLE_HAS_PUD_LEAVES */
 
 #if defined(CONFIG_GUP_GET_PXX_LOW_HIGH) && \
 	(defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RCU))
-- 
2.45.0

