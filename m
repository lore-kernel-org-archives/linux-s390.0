Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC4C23EAB3;
	Thu, 19 Mar 2026 03:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773890664; cv=none; b=ftkaQWRVgSN5SlXvHbIdJWA+CWMbvQT23npr4MF/fmoq6f3aeRuvHaqfoawqxqSCemXp2PHQfUpbqY1H+GH+UvnLRFGHxYuC+I7SpVSwxKZ1DakT5B3HNbNxsOPEjl/lwwI7mNG/vT/lnF66nSDKBxkUpfSKq/GRntLhQ4IBFk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773890664; c=relaxed/simple;
	bh=eQizYT8/Rm2xSpBjA1nmbjZ9S4LDnEuwZdRCc6lfF3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqjjnJ7al9lVc0Y/kB+LFwh1a9cAlidse1noiM7rP6ohU40pgIGS0F5gViUeXnUUnhiWfOe85WLq89EYcVxniSAkv/KXK8PDL1dyBlxF6bB6mBkHkpAX5Sxp34ZjKnXdylDt5YR6YUkQQNfSsiyCq9wca7UrMOqPUmcHk6CI0nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O7eUj5Vr; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O7eUj5Vr"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773890659; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9ZvFasi/0Yj+erdMhL0ZepZHbRAvJJtjAuaFua/OpdM=;
	b=O7eUj5Vr2m8msYaK5zWpK5hTEHkGteR1q/xPrqJKOo9Z+Ji/b4xHXxC69H82TGxW/lAS9lTMzp5NTlLJf/vtjjMAI71nsLO4mq8Qh8UFXns7a3qaf8oQnbl28BU4RjSHYiG/dJpRkngXjB4v+O/rvD23nOeE+jkzZ2LOkE8tdlo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X.GtLOR_1773890657;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.GtLOR_1773890657 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Mar 2026 11:24:18 +0800
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
Subject: [PATCH 1/6] mm: change to return bool for ptep_test_and_clear_young()
Date: Thu, 19 Mar 2026 11:24:00 +0800
Message-ID: <3fa94c3c89fd93fe22c8cb59967f064787d686aa.1773890510.git.baolin.wang@linux.alibaba.com>
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

Callers use ptep_test_and_clear_young() to clear the young flag and check
whether it was set. Change the return type to bool to make the intention
clearer.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 arch/arm64/include/asm/pgtable.h             |  8 ++++----
 arch/arm64/mm/contpte.c                      |  4 ++--
 arch/microblaze/include/asm/pgtable.h        |  2 +-
 arch/parisc/include/asm/pgtable.h            |  6 +++---
 arch/powerpc/include/asm/book3s/32/pgtable.h |  4 ++--
 arch/powerpc/include/asm/book3s/64/pgtable.h |  6 +++---
 arch/powerpc/include/asm/nohash/pgtable.h    |  4 ++--
 arch/riscv/include/asm/pgtable.h             |  4 ++--
 arch/riscv/mm/pgtable.c                      |  8 ++++----
 arch/s390/include/asm/pgtable.h              |  4 ++--
 arch/x86/include/asm/pgtable.h               |  4 ++--
 arch/x86/mm/pgtable.c                        |  6 +++---
 arch/xtensa/include/asm/pgtable.h            |  6 +++---
 include/linux/pgtable.h                      | 16 ++++++++--------
 14 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index ab451d20e4c5..8c651695204c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1282,7 +1282,7 @@ static inline void __pte_clear(struct mm_struct *mm,
 	__set_pte(ptep, __pte(0));
 }
 
-static inline int __ptep_test_and_clear_young(struct vm_area_struct *vma,
+static inline bool __ptep_test_and_clear_young(struct vm_area_struct *vma,
 					      unsigned long address,
 					      pte_t *ptep)
 {
@@ -1646,7 +1646,7 @@ extern void contpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
 extern pte_t contpte_get_and_clear_full_ptes(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep,
 				unsigned int nr, int full);
-int contpte_test_and_clear_young_ptes(struct vm_area_struct *vma,
+bool contpte_test_and_clear_young_ptes(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep, unsigned int nr);
 int contpte_clear_flush_young_ptes(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep, unsigned int nr);
@@ -1813,7 +1813,7 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 }
 
 #define test_and_clear_young_ptes test_and_clear_young_ptes
-static inline int test_and_clear_young_ptes(struct vm_area_struct *vma,
+static inline bool test_and_clear_young_ptes(struct vm_area_struct *vma,
 					    unsigned long addr, pte_t *ptep,
 					    unsigned int nr)
 {
@@ -1824,7 +1824,7 @@ static inline int test_and_clear_young_ptes(struct vm_area_struct *vma,
 }
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
+static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep)
 {
 	return test_and_clear_young_ptes(vma, addr, ptep, 1);
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 1519d090d5ea..0b88278927a4 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -508,7 +508,7 @@ pte_t contpte_get_and_clear_full_ptes(struct mm_struct *mm,
 }
 EXPORT_SYMBOL_GPL(contpte_get_and_clear_full_ptes);
 
-int contpte_test_and_clear_young_ptes(struct vm_area_struct *vma,
+bool contpte_test_and_clear_young_ptes(struct vm_area_struct *vma,
 					unsigned long addr, pte_t *ptep,
 					unsigned int nr)
 {
@@ -525,7 +525,7 @@ int contpte_test_and_clear_young_ptes(struct vm_area_struct *vma,
 	 */
 
 	unsigned long end = addr + nr * PAGE_SIZE;
-	int young = 0;
+	bool young = false;
 
 	ptep = contpte_align_addr_ptep(&addr, &end, ptep, nr);
 	for (; addr != end; ptep++, addr += PAGE_SIZE)
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index ea72291de553..7678c040a2fd 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -318,7 +318,7 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 struct vm_area_struct;
-static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
+static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
 		unsigned long address, pte_t *ptep)
 {
 	return (pte_update(ptep, _PAGE_ACCESSED, 0) & _PAGE_ACCESSED) != 0;
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index f6fb99cb94d9..d5e39f2eb415 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -438,16 +438,16 @@ static inline pte_t ptep_get(pte_t *ptep)
 }
 #define ptep_get ptep_get
 
-static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
+static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
 	pte_t pte;
 
 	pte = ptep_get(ptep);
 	if (!pte_young(pte)) {
-		return 0;
+		return false;
 	}
 	set_pte_at(vma->vm_mm, addr, ptep, pte_mkold(pte));
-	return 1;
+	return true;
 }
 
 int ptep_clear_flush_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 001e28f9eabc..2a889e2093e8 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -295,8 +295,8 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
  * for our hash-based implementation, we fix that up here.
  */
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
-					      unsigned long addr, pte_t *ptep)
+static inline bool __ptep_test_and_clear_young(struct mm_struct *mm,
+					       unsigned long addr, pte_t *ptep)
 {
 	unsigned long old;
 	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 1a91762b455d..25e3a86943e2 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -349,13 +349,13 @@ static inline unsigned long pte_update(struct mm_struct *mm, unsigned long addr,
  * For radix: H_PAGE_HASHPTE should be zero. Hence we can use the same
  * function for both hash and radix.
  */
-static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
-					      unsigned long addr, pte_t *ptep)
+static inline bool __ptep_test_and_clear_young(struct mm_struct *mm,
+					       unsigned long addr, pte_t *ptep)
 {
 	unsigned long old;
 
 	if ((pte_raw(*ptep) & cpu_to_be64(_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
-		return 0;
+		return false;
 	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
 	return (old & _PAGE_ACCESSED) != 0;
 }
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index e6da5eaccff6..43cf52f0c7d6 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -101,8 +101,8 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
 }
 #endif
 
-static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
-					    unsigned long addr, pte_t *ptep)
+static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
+					     unsigned long addr, pte_t *ptep)
 {
 	unsigned long old;
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ab4ce1cc9d9c..fb010dcdf343 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -659,8 +659,8 @@ static inline void pte_clear(struct mm_struct *mm,
 extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 				 pte_t *ptep, pte_t entry, int dirty);
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG	/* defined in mm/pgtable.c */
-extern int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long address,
-				     pte_t *ptep);
+extern bool ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long address,
+				      pte_t *ptep);
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index b1ed2f14dc3a..de24a19e8ebd 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -29,12 +29,12 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 	return true;
 }
 
-int ptep_test_and_clear_young(struct vm_area_struct *vma,
-			      unsigned long address,
-			      pte_t *ptep)
+bool ptep_test_and_clear_young(struct vm_area_struct *vma,
+			       unsigned long address,
+			       pte_t *ptep)
 {
 	if (!pte_young(ptep_get(ptep)))
-		return 0;
+		return false;
 	return test_and_clear_bit(_PAGE_ACCESSED_OFFSET, &pte_val(*ptep));
 }
 EXPORT_SYMBOL_GPL(ptep_test_and_clear_young);
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 1c3c3be93be9..da1a7a31fa22 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1164,8 +1164,8 @@ pte_t ptep_xchg_direct(struct mm_struct *, unsigned long, pte_t *, pte_t);
 pte_t ptep_xchg_lazy(struct mm_struct *, unsigned long, pte_t *, pte_t);
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
-					    unsigned long addr, pte_t *ptep)
+static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
+					     unsigned long addr, pte_t *ptep)
 {
 	pte_t pte = *ptep;
 
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 54289f4587a4..563a6289ea44 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1232,8 +1232,8 @@ extern int ptep_set_access_flags(struct vm_area_struct *vma,
 				 pte_t entry, int dirty);
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-extern int ptep_test_and_clear_young(struct vm_area_struct *vma,
-				     unsigned long addr, pte_t *ptep);
+extern bool ptep_test_and_clear_young(struct vm_area_struct *vma,
+				      unsigned long addr, pte_t *ptep);
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 extern int ptep_clear_flush_young(struct vm_area_struct *vma,
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 2e5ecfdce73c..c594976afc5c 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -443,10 +443,10 @@ int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 }
 #endif
 
-int ptep_test_and_clear_young(struct vm_area_struct *vma,
-			      unsigned long addr, pte_t *ptep)
+bool ptep_test_and_clear_young(struct vm_area_struct *vma,
+			       unsigned long addr, pte_t *ptep)
 {
-	int ret = 0;
+	bool ret = false;
 
 	if (pte_young(*ptep))
 		ret = test_and_clear_bit(_PAGE_BIT_ACCESSED,
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index 61f07d981a94..b962ef4652f5 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -304,15 +304,15 @@ set_pmd(pmd_t *pmdp, pmd_t pmdval)
 
 struct vm_area_struct;
 
-static inline int
+static inline bool
 ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr,
 			  pte_t *ptep)
 {
 	pte_t pte = *ptep;
 	if (!pte_young(pte))
-		return 0;
+		return false;
 	update_pte(ptep, pte_mkold(pte));
-	return 1;
+	return true;
 }
 
 static inline pte_t
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 17d961c612fc..8e75dc9f7932 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -491,17 +491,17 @@ static inline pgd_t pgdp_get(pgd_t *pgdp)
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
-					    unsigned long address,
-					    pte_t *ptep)
+static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
+		unsigned long address, pte_t *ptep)
 {
 	pte_t pte = ptep_get(ptep);
-	int r = 1;
+	bool young = true;
+
 	if (!pte_young(pte))
-		r = 0;
+		young = false;
 	else
 		set_pte_at(vma->vm_mm, address, ptep, pte_mkold(pte));
-	return r;
+	return young;
 }
 #endif
 
@@ -1123,10 +1123,10 @@ static inline int clear_flush_young_ptes(struct vm_area_struct *vma,
  *
  * Returns: whether any PTE was young.
  */
-static inline int test_and_clear_young_ptes(struct vm_area_struct *vma,
+static inline bool test_and_clear_young_ptes(struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep, unsigned int nr)
 {
-	int young = 0;
+	bool young = false;
 
 	for (;;) {
 		young |= ptep_test_and_clear_young(vma, addr, ptep);
-- 
2.47.3

