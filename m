Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D7245D932;
	Sat, 19 Sep 2026 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789812848; cv=none; b=QcMwJD6GmhZEypI5um+G03vt4b8MzMTOBQ7isNAVXpciq3hfKisAvqNOYv/EvVZC6kndCbvcWImaWJCTbMjy9n9QBp7FdMpEtWJ/oI07fEAxgNMn/3mqQCg/0lmG0d2Q0enSn+/uHxIjV3sfM0HG5/8T9PlSwc+0lN0+sL+asaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789812848; c=relaxed/simple;
	bh=ET3FvwGyXsOPaB1nqYS3yhI0YhtaILrYR+8hbIFKAFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMSXD5Uja+5LiczDSXhvwQ8qvN6hbYrs8pMggEJRist7YxkeOr+lADPQjPC417emcnWwvSB97MDxbUjpmQT52SiE0evr8JOI1KFlF0Ekk0kJDYJMG+y1TxorA82L9J47MGlakyYTJgxRv1BqljmbpOziGZyO5aP3Tm3ehlsfN7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=A5YLFeGZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="A5YLFeGZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7B01165C;
	Sat, 19 Sep 2026 03:13:59 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E7693F86F;
	Sat, 19 Sep 2026 03:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789812843; bh=ET3FvwGyXsOPaB1nqYS3yhI0YhtaILrYR+8hbIFKAFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5YLFeGZ8Zun87ka+h8+QBQCSK3/qQmTNs4AeTSBY1I6fxZlh8muzQNXudyPURw+9
	 Vhr9ArzZwSEsfbjjL5hCUDKokAn/Kr0dfu24YPlfpQrdqjxbjLtoWr7POA7xDUUwRU
	 BLrp+fhufuZQjw7SDVmky0z1WTWG1Wh/Efwe7mkY=
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
Date: Sat, 19 Sep 2026 15:43:40 +0530
Message-ID: <20260919101343.1959572-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919101343.1959572-1-anshuman.khandual@arm.com>
References: <20260919101343.1959572-1-anshuman.khandual@arm.com>
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
index 223528c04d739..cda4d5652d609 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -125,9 +125,6 @@ struct vm_area_struct;
 
 #endif
 
-#define ptep_get(ptep) READ_ONCE(*(ptep))
-#define pmdp_get(pmdp) READ_ONCE(*(pmdp))
-
 #define pte_ERROR(e) \
 	pr_err("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -371,12 +368,7 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
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
@@ -611,16 +603,8 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
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
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 3407030f3e7a2..3262dc3a2971e 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -255,3 +255,22 @@ struct execmem_info __init *execmem_arch_setup(void)
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

