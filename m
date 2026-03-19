Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C0835B64B;
	Thu, 19 Mar 2026 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773890665; cv=none; b=F83LtnD09YzKgUk/HB43/pPJCDt7ylPayCEdwsdmmHsBBbBWTsbOWrhTNq6YxNfl/96PJxbbWTLK0JLtqUDh4JhCz/9eNtbo9XAnEw7Ai2fZaB05yFpXFag7cwPR1NnWeZuEuZhCEuPFKKLi6yyRz7p2IfdDMuq/+f0udxqTaII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773890665; c=relaxed/simple;
	bh=oMeEvcaydsacjDm1psCbBW/Sd7l4zA+QGwUR8TB9Wos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRpZjuy2iDt9nzFC6bRyYK0R+5x+Q/CnDavfioHgGSxc/KVdhT9m9/S7rB0ctMTEQ7NzpevKRgFCtZa1BXJlr5mZic2X7JjYpSrvWXhmqJLbGMre/yiWpxwJrx4l5vZ/e6+YkkxabYk+U52FxPuuD0NPfAM46O89bXV+RrRqXpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DEu2mzbI; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DEu2mzbI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773890660; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=X6l6KoTpEXERAeGDFQhqpgsjuu2KQfJTQ5hxLP+6Eu8=;
	b=DEu2mzbI7RwmkHSMYIdRnPzbUnVwNcABuQ+kRg8QTUNGR3ShkiHo5PL1R3fMVV3NIaCrQn1q1cdj3+KXZlI16c2ldEJYUmys9XOqhpOOBK2tNNVHDYU/CKQqqlIcu1UYFKmZVOmIHV63pejojCR5czWSKehaS5+0ERKXz7Us1fo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X.GpFaD_1773890659;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.GpFaD_1773890659 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Mar 2026 11:24:19 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	david@kernel.org
Cc: ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	baolin.wang@linux.alibaba.com,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org (open),
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] mm: change to return bool for ptep_clear_flush_young()/clear_flush_young_ptes()
Date: Thu, 19 Mar 2026 11:24:01 +0800
Message-ID: <5d24b34d8b7860dc2188408b3fa530193bcc5caa.1773890510.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ptep_clear_flush_young() and clear_flush_young_ptes() are used to clear
the young flag and flush the TLB, returning whether the young flag was set.
Change the return type to bool to make the intention clearer.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 arch/arm64/include/asm/pgtable.h             | 15 +++++++--------
 arch/arm64/mm/contpte.c                      |  4 ++--
 arch/parisc/include/asm/pgtable.h            |  2 +-
 arch/parisc/kernel/cache.c                   |  8 ++++----
 arch/powerpc/include/asm/nohash/64/pgtable.h |  2 +-
 arch/riscv/include/asm/pgtable.h             |  4 ++--
 arch/s390/include/asm/pgtable.h              |  4 ++--
 arch/x86/include/asm/pgtable.h               |  4 ++--
 arch/x86/mm/pgtable.c                        |  4 ++--
 include/linux/pgtable.h                      |  8 ++++----
 mm/pgtable-generic.c                         |  7 ++++---
 11 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 8c651695204c..393a9d1873f6 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1299,10 +1299,10 @@ static inline bool __ptep_test_and_clear_young(struct vm_area_struct *vma,
 	return pte_young(pte);
 }
 
-static inline int __ptep_clear_flush_young(struct vm_area_struct *vma,
-					 unsigned long address, pte_t *ptep)
+static inline bool __ptep_clear_flush_young(struct vm_area_struct *vma,
+					    unsigned long address, pte_t *ptep)
 {
-	int young = __ptep_test_and_clear_young(vma, address, ptep);
+	bool young = __ptep_test_and_clear_young(vma, address, ptep);
 
 	if (young) {
 		/*
@@ -1648,7 +1648,7 @@ extern pte_t contpte_get_and_clear_full_ptes(struct mm_struct *mm,
 				unsigned int nr, int full);
 bool contpte_test_and_clear_young_ptes(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep, unsigned int nr);
-int contpte_clear_flush_young_ptes(struct vm_area_struct *vma,
+bool contpte_clear_flush_young_ptes(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep, unsigned int nr);
 extern void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, unsigned int nr);
@@ -1831,7 +1831,7 @@ static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
+static inline bool ptep_clear_flush_young(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep)
 {
 	pte_t orig_pte = __ptep_get(ptep);
@@ -1843,9 +1843,8 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 }
 
 #define clear_flush_young_ptes clear_flush_young_ptes
-static inline int clear_flush_young_ptes(struct vm_area_struct *vma,
-					 unsigned long addr, pte_t *ptep,
-					 unsigned int nr)
+static inline bool clear_flush_young_ptes(struct vm_area_struct *vma,
+				unsigned long addr, pte_t *ptep, unsigned int nr)
 {
 	if (likely(nr == 1 && !pte_cont(__ptep_get(ptep))))
 		return __ptep_clear_flush_young(vma, addr, ptep);
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 0b88278927a4..2ef4bff3b998 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -535,11 +535,11 @@ bool contpte_test_and_clear_young_ptes(struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL_GPL(contpte_test_and_clear_young_ptes);
 
-int contpte_clear_flush_young_ptes(struct vm_area_struct *vma,
+bool contpte_clear_flush_young_ptes(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep,
 				unsigned int nr)
 {
-	int young;
+	bool young;
 
 	young = contpte_test_and_clear_young_ptes(vma, addr, ptep, nr);
 
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index d5e39f2eb415..f6984b3ba531 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -450,7 +450,7 @@ static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma, unsigne
 	return true;
 }
 
-int ptep_clear_flush_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
+bool ptep_clear_flush_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
 pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
 
 struct mm_struct;
diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 4c5240d3a3c7..268530eb107d 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -781,18 +781,18 @@ void flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned lon
 	__flush_cache_page(vma, vmaddr, PFN_PHYS(page_to_pfn(page)));
 }
 
-int ptep_clear_flush_young(struct vm_area_struct *vma, unsigned long addr,
-			   pte_t *ptep)
+bool ptep_clear_flush_young(struct vm_area_struct *vma, unsigned long addr,
+			    pte_t *ptep)
 {
 	pte_t pte = ptep_get(ptep);
 
 	if (!pte_young(pte))
-		return 0;
+		return false;
 	set_pte(ptep, pte_mkold(pte));
 #if CONFIG_FLUSH_PAGE_ACCESSED
 	__flush_cache_page(vma, addr, PFN_PHYS(pte_pfn(pte)));
 #endif
-	return 1;
+	return true;
 }
 
 /*
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 2deb955b7bc8..661eb3820d12 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -155,7 +155,7 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 #define ptep_clear_flush_young(__vma, __address, __ptep)		\
 ({									\
-	int __young = ptep_test_and_clear_young(__vma, __address, __ptep);\
+	bool __young = ptep_test_and_clear_young(__vma, __address, __ptep);\
 	__young;							\
 })
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index fb010dcdf343..11f57ccf6dc9 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -695,8 +695,8 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm,
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
-					 unsigned long address, pte_t *ptep)
+static inline bool ptep_clear_flush_young(struct vm_area_struct *vma,
+					  unsigned long address, pte_t *ptep)
 {
 	/*
 	 * This comment is borrowed from x86, but applies equally to RISC-V:
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index da1a7a31fa22..c9ab81caaf75 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1174,8 +1174,8 @@ static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
-					 unsigned long address, pte_t *ptep)
+static inline bool ptep_clear_flush_young(struct vm_area_struct *vma,
+					  unsigned long address, pte_t *ptep)
 {
 	return ptep_test_and_clear_young(vma, address, ptep);
 }
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 563a6289ea44..554dea93eb99 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1236,8 +1236,8 @@ extern bool ptep_test_and_clear_young(struct vm_area_struct *vma,
 				      unsigned long addr, pte_t *ptep);
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-extern int ptep_clear_flush_young(struct vm_area_struct *vma,
-				  unsigned long address, pte_t *ptep);
+extern bool ptep_clear_flush_young(struct vm_area_struct *vma,
+				   unsigned long address, pte_t *ptep);
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index c594976afc5c..0007dc3d739e 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -483,8 +483,8 @@ int pudp_test_and_clear_young(struct vm_area_struct *vma,
 }
 #endif
 
-int ptep_clear_flush_young(struct vm_area_struct *vma,
-			   unsigned long address, pte_t *ptep)
+bool ptep_clear_flush_young(struct vm_area_struct *vma,
+			    unsigned long address, pte_t *ptep)
 {
 	/*
 	 * On x86 CPUs, clearing the accessed bit without a TLB flush
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8e75dc9f7932..1198e216fde3 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -531,8 +531,8 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-int ptep_clear_flush_young(struct vm_area_struct *vma,
-			   unsigned long address, pte_t *ptep);
+bool ptep_clear_flush_young(struct vm_area_struct *vma,
+			    unsigned long address, pte_t *ptep);
 #endif
 
 #ifndef __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
@@ -1086,10 +1086,10 @@ static inline void wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
  * Context: The caller holds the page table lock.  The PTEs map consecutive
  * pages that belong to the same folio.  The PTEs are all in the same PMD.
  */
-static inline int clear_flush_young_ptes(struct vm_area_struct *vma,
+static inline bool clear_flush_young_ptes(struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep, unsigned int nr)
 {
-	int young = 0;
+	bool young = false;
 
 	for (;;) {
 		young |= ptep_clear_flush_young(vma, addr, ptep);
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index af7966169d69..db0ee918b08a 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -81,10 +81,11 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-int ptep_clear_flush_young(struct vm_area_struct *vma,
-			   unsigned long address, pte_t *ptep)
+bool ptep_clear_flush_young(struct vm_area_struct *vma,
+		unsigned long address, pte_t *ptep)
 {
-	int young;
+	bool young;
+
 	young = ptep_test_and_clear_young(vma, address, ptep);
 	if (young)
 		flush_tlb_page(vma, address);
-- 
2.47.3

