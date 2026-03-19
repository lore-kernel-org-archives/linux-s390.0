Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72238B7A3;
	Thu, 19 Mar 2026 03:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773890672; cv=none; b=sQMpEkpvWAvf3MR5sTkgmZGpZ70Uvcts5OVuHMb7t4kAmXVwb2nkWz5QunUZlErDXngC9ArZu2DTgYjIMMCPD1P4EcOK5gl93AMVC2C/Ev0ulT9EihmLZm5kZgbg1cR5IE0aOJAFtBnqfTJ1J97rnsSS2IqOYMRZGs891npNzOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773890672; c=relaxed/simple;
	bh=2zbDulrXptxAaHATU7/zV609JGrtc7d0bjHFuxwUZr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVu8U8PPj3sL/4gU+Dj3QqeRZg8I8Tjh4RbYHChJozpXcDk0bnk8sB0lRLYvdiyvmJNOZXPj2gPUOS2vmzB+a+doDwPmVcc1cL6FI4kcwcXHZLFhHpdGh8ynWcUNIKa8Pm5bqOjaJuIXyJ0Aam3VgaZMcpXA0VUv+6aNeBJzyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S8OKPe67; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S8OKPe67"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773890662; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wZ0qad0Pm6XxHYmd2R3Uz8rTNICSFBFKR16MZOCoaNo=;
	b=S8OKPe671q5R+yYGNFR0OwkVu91rrm6KrZTI8bT8yh9lWdsm4P8BdOMafCzzL9JOzPM08F4LzkG+kIMEQjf39ZgBicBM+b/fyrO0a3O8WrHp4qVj/eD2UMg2jd9rPn0fEVqW8i16NVWOZaVLn4q2ThoB65quH67rhwT+htNEC5E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X.Gt-CL_1773890660;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.Gt-CL_1773890660 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Mar 2026 11:24:21 +0800
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
Subject: [PATCH 3/6] mm: change to return bool for pmdp_test_and_clear_young()
Date: Thu, 19 Mar 2026 11:24:02 +0800
Message-ID: <8025b898d0841a4bcbd766998959b4e2ae4d4abc.1773890510.git.baolin.wang@linux.alibaba.com>
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

Callers use pmdp_test_and_clear_young() to clear the young flag and check
whether it was set for this PMD entry. Change the return type to bool to
make the intention clearer.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 arch/arm64/include/asm/pgtable.h             |  6 +++---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++-----
 arch/powerpc/mm/book3s64/pgtable.c           |  4 ++--
 arch/riscv/include/asm/pgtable.h             |  2 +-
 arch/s390/include/asm/pgtable.h              |  4 ++--
 arch/x86/include/asm/pgtable.h               |  4 ++--
 arch/x86/mm/pgtable.c                        |  6 +++---
 include/linux/pgtable.h                      | 19 +++++++++----------
 8 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 393a9d1873f6..7ea16f6ad564 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1321,9 +1321,9 @@ static inline bool __ptep_clear_flush_young(struct vm_area_struct *vma,
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
 #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
-static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-					    unsigned long address,
-					    pmd_t *pmdp)
+static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
+					     unsigned long address,
+					     pmd_t *pmdp)
 {
 	/* Operation applies to PMD table entry only if FEAT_HAFT is enabled */
 	VM_WARN_ON(pmd_table(READ_ONCE(*pmdp)) && !system_supports_haft());
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 25e3a86943e2..0f34011665a6 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1161,13 +1161,13 @@ pud_hugepage_update(struct mm_struct *mm, unsigned long addr, pud_t *pudp,
  * For radix we should always find H_PAGE_HASHPTE zero. Hence
  * the below will work for radix too
  */
-static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
-					      unsigned long addr, pmd_t *pmdp)
+static inline bool __pmdp_test_and_clear_young(struct mm_struct *mm,
+					       unsigned long addr, pmd_t *pmdp)
 {
 	unsigned long old;
 
 	if ((pmd_raw(*pmdp) & cpu_to_be64(_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
-		return 0;
+		return false;
 	old = pmd_hugepage_update(mm, addr, pmdp, _PAGE_ACCESSED, 0);
 	return ((old & _PAGE_ACCESSED) != 0);
 }
@@ -1300,8 +1300,8 @@ extern int pudp_set_access_flags(struct vm_area_struct *vma,
 				 pud_t entry, int dirty);
 
 #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
-extern int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-				     unsigned long address, pmd_t *pmdp);
+extern bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
+				      unsigned long address, pmd_t *pmdp);
 #define __HAVE_ARCH_PUDP_TEST_AND_CLEAR_YOUNG
 extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
 				     unsigned long address, pud_t *pudp);
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 4b09c04654a8..aed39bba891e 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -98,8 +98,8 @@ int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 }
 
 
-int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-			      unsigned long address, pmd_t *pmdp)
+bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
+			       unsigned long address, pmd_t *pmdp)
 {
 	return __pmdp_test_and_clear_young(vma->vm_mm, address, pmdp);
 }
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 11f57ccf6dc9..bac559d29036 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -1015,7 +1015,7 @@ static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
 }
 
 #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
-static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
+static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
 					unsigned long address, pmd_t *pmdp)
 {
 	return ptep_test_and_clear_young(vma, address, (pte_t *)pmdp);
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index c9ab81caaf75..1f5efb7be71d 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1683,8 +1683,8 @@ static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
 }
 
 #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
-static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-					    unsigned long addr, pmd_t *pmdp)
+static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
+					     unsigned long addr, pmd_t *pmdp)
 {
 	pmd_t pmd = *pmdp;
 
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 554dea93eb99..bd02ee730a23 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1295,8 +1295,8 @@ extern int pudp_set_access_flags(struct vm_area_struct *vma,
 				 pud_t entry, int dirty);
 
 #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
-extern int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-				     unsigned long addr, pmd_t *pmdp);
+extern bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
+				      unsigned long addr, pmd_t *pmdp);
 extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
 				     unsigned long addr, pud_t *pudp);
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 0007dc3d739e..10a5e0b2be36 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -456,10 +456,10 @@ bool ptep_test_and_clear_young(struct vm_area_struct *vma,
 }
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
-int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-			      unsigned long addr, pmd_t *pmdp)
+bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
+			       unsigned long addr, pmd_t *pmdp)
 {
-	int ret = 0;
+	bool ret = false;
 
 	if (pmd_young(*pmdp))
 		ret = test_and_clear_bit(_PAGE_BIT_ACCESSED,
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 1198e216fde3..e53220b0a9a3 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -507,25 +507,24 @@ static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
 
 #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
-static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-					    unsigned long address,
-					    pmd_t *pmdp)
+static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
+		unsigned long address, pmd_t *pmdp)
 {
 	pmd_t pmd = *pmdp;
-	int r = 1;
+	bool young = true;
+
 	if (!pmd_young(pmd))
-		r = 0;
+		young = false;
 	else
 		set_pmd_at(vma->vm_mm, address, pmdp, pmd_mkold(pmd));
-	return r;
+	return young;
 }
 #else
-static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-					    unsigned long address,
-					    pmd_t *pmdp)
+static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
+		unsigned long address, pmd_t *pmdp)
 {
 	BUILD_BUG();
-	return 0;
+	return false;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG */
 #endif
-- 
2.47.3

