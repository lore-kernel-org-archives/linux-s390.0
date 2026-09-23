Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C48F3955CA;
	Wed, 23 Sep 2026 04:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790137967; cv=none; b=SfEAPTmn7CqescaI3vrMAg0u8BcC8uQw/9kLDmI+waitgpdNNdY1gkdFWiKeCstqlHPyuoi8fjDjlR0W6jpmeiIqpqu2q/aR/jNrtVrdl0MCf91Im4gEsMFv+FjpWdvsPXFfQpJe0TOXFksb57N6Foo6+DLu6/9hSmmjz9hdELU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790137967; c=relaxed/simple;
	bh=Blq0g3C+Aco5j50FVYlFra5qoOzNa+7RbX7vJ/LL7hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1vqFk4SXE2xHzyCUYt+juOS/tMa275uMfkriNx41ANw/rFobwYHlswRTKxUCCPpDBJ4sufHSzGqVCzWpjAXJfQBf6QGhTTUBbk/lfs2t/prZPmrnRtEAtgNCqV+CmfpLHFfFPbD7Xrc4Gjd8uLAeZNoIZOJWEOk+5v+sTx4lZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GWw24kQK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GWw24kQK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B7D11655;
	Tue, 22 Sep 2026 21:32:39 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28E6C3F86C;
	Tue, 22 Sep 2026 21:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790137962; bh=Blq0g3C+Aco5j50FVYlFra5qoOzNa+7RbX7vJ/LL7hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GWw24kQKYVL6QVo5QDNfRGhCdHnFv+zt1jcIwVSlUFS61k5th89XJXeFDeGMjNx/U
	 uE2430iBu4OuR5C8oyoeWFjSd8r5WqWrfcTaGvvXEPfXV+AVSGNzda1dXZx2erKFFi
	 KFwSBC/N9CblpexCFxs5ffWhb3pSQ+AL6/G3HNKE=
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Helge Deller <deller@gmx.de>,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] loongarch/mm: Drop all pxdp_get()
Date: Wed, 23 Sep 2026 10:02:21 +0530
Message-ID: <20260923043226.331880-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923043226.331880-1-anshuman.khandual@arm.com>
References: <20260923043226.331880-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current platform specific pxdp_get() helpers are exact same as the default
ones defined in the generic MM header (include/linux/pgtable.h) thus making
them redundant. Move functions that are now depending on generic helpers to
avoid build failure.

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: loongarch@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/loongarch/include/asm/pgtable.h | 20 ++------------------
 arch/loongarch/mm/init.c             | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index a05f6a4928dc6..b1060b86d5353 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -132,9 +132,6 @@ struct vm_area_struct;
 #define DIRECT_MAP_PHYSMEM_END min((1ULL << (cpu_pabits + 1)) - 1, (1ULL << MAX_PHYSMEM_BITS) - 1)
 #endif
 
-#define ptep_get(ptep) READ_ONCE(*(ptep))
-#define pmdp_get(pmdp) READ_ONCE(*(pmdp))
-
 #define pte_ERROR(e) \
 	pr_err("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -378,12 +375,7 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 #endif
 }
 
-static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
-{
-	pte_t pte = ptep_get(ptep);
-	pte_val(pte) &= _PAGE_GLOBAL;
-	set_pte(ptep, pte);
-}
+void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 
 #define PGD_T_LOG2	(__builtin_ffs(sizeof(pgd_t)) - 1)
 #define PMD_T_LOG2	(__builtin_ffs(sizeof(pmd_t)) - 1)
@@ -618,16 +610,8 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
  * different prototype.
  */
 #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
-static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
-					    unsigned long address, pmd_t *pmdp)
-{
-	pmd_t old = pmdp_get(pmdp);
-
-	pmd_clear(pmdp);
-
-	return old;
-}
 
+pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm, unsigned long address, pmd_t *pmdp);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #ifdef CONFIG_ARCH_HAS_PTE_PROTNONE
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 4b46c5d30708d..5751b3bcca994 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -266,3 +266,22 @@ struct execmem_info __init *execmem_arch_setup(void)
 	return &execmem_info;
 }
 #endif /* CONFIG_EXECMEM && MODULES_VADDR */
+
+void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	pte_t pte = ptep_get(ptep);
+
+	pte_val(pte) &= _PAGE_GLOBAL;
+	set_pte(ptep, pte);
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm, unsigned long address, pmd_t *pmdp)
+{
+	pmd_t old = pmdp_get(pmdp);
+
+	pmd_clear(pmdp);
+
+	return old;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-- 
2.43.0

