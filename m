Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982A738AC99;
	Thu, 19 Mar 2026 03:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773890671; cv=none; b=PgVUOE0maSEhdG7LnapOQmLk5J88r+sCgfvWzqQl0TYGgX/aN39swkGMG3vE6NdRH/K+Z93Xw40/mC/0VmZAqqDXic4t6OfFTzT+yZxtjdidnnEljE9cNW+1Rz4EZvfFC6OyRvJDMuRGj6/NhOTm/dk7uUlhc1mwGCr3rBe+o7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773890671; c=relaxed/simple;
	bh=3rJcQdtVMtqWmqDIOW2RieVHbmhHWjXiyPorr2ccwFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZtRUkP/zOsuQiRjiMKnYQIuCApw/o4GzxA5MmN+5jhlPRzNWAVwRkCs++U9QNlROyyPes7Jr11h4gajOTGonSS57H1Rlc3/OlDdDA0dDzDDonpGdTRukRegCfm+V0z3+EKiClqVi19DrvgvGw2Kn20kaipajbS6sfniD7PmEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VAEFSVBV; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VAEFSVBV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773890666; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KmTpbZpS8VOu0ETweBFTEwO9A4/EC6KlltYP5/7+63w=;
	b=VAEFSVBVc240NhLYnk7RbLXvAK+CizWrUbTBLE/8wm36wM3gt5CEAQj/wz36jWbloljZzIek71Zw8Szwqsabuu3VA6MMK5qDQBQIOJ1OeTPtqxTy/WOLQUQVT5+kui+oD0qLGg3kWs2EQnU2jy0qeN8gHGASzJm+J74k4ryDPQ0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X.GqPS6_1773890663;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.GqPS6_1773890663 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Mar 2026 11:24:24 +0800
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
Subject: [PATCH 5/6] mm: change to return bool for pudp_test_and_clear_young()
Date: Thu, 19 Mar 2026 11:24:04 +0800
Message-ID: <2711ec4bf6c30182004e34027fb31a2e8e24749e.1773890510.git.baolin.wang@linux.alibaba.com>
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

The pudp_test_and_clear_young() is used to clear the young flag,
returning whether the young flag was set for this PUD entry. Change
the return type to bool to make the intention clearer.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++-----
 arch/powerpc/mm/book3s64/pgtable.c           |  4 ++--
 arch/riscv/include/asm/pgtable.h             |  4 ++--
 arch/x86/include/asm/pgtable.h               |  4 ++--
 arch/x86/mm/pgtable.c                        |  6 +++---
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 0f34011665a6..083c4b9ed5b3 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1172,13 +1172,13 @@ static inline bool __pmdp_test_and_clear_young(struct mm_struct *mm,
 	return ((old & _PAGE_ACCESSED) != 0);
 }
 
-static inline int __pudp_test_and_clear_young(struct mm_struct *mm,
-					      unsigned long addr, pud_t *pudp)
+static inline bool __pudp_test_and_clear_young(struct mm_struct *mm,
+					       unsigned long addr, pud_t *pudp)
 {
 	unsigned long old;
 
 	if ((pud_raw(*pudp) & cpu_to_be64(_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
-		return 0;
+		return false;
 	old = pud_hugepage_update(mm, addr, pudp, _PAGE_ACCESSED, 0);
 	return ((old & _PAGE_ACCESSED) != 0);
 }
@@ -1303,8 +1303,8 @@ extern int pudp_set_access_flags(struct vm_area_struct *vma,
 extern bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
 				      unsigned long address, pmd_t *pmdp);
 #define __HAVE_ARCH_PUDP_TEST_AND_CLEAR_YOUNG
-extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
-				     unsigned long address, pud_t *pudp);
+extern bool pudp_test_and_clear_young(struct vm_area_struct *vma,
+				      unsigned long address, pud_t *pudp);
 
 
 #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index aed39bba891e..838cb4a8e2cf 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -104,8 +104,8 @@ bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
 	return __pmdp_test_and_clear_young(vma->vm_mm, address, pmdp);
 }
 
-int pudp_test_and_clear_young(struct vm_area_struct *vma,
-			      unsigned long address, pud_t *pudp)
+bool pudp_test_and_clear_young(struct vm_area_struct *vma,
+			       unsigned long address, pud_t *pudp)
 {
 	return __pudp_test_and_clear_young(vma->vm_mm, address, pudp);
 }
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index bac559d29036..88fa63186ca5 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -1109,8 +1109,8 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
 	return ptep_set_access_flags(vma, address, (pte_t *)pudp, pud_pte(entry), dirty);
 }
 
-static inline int pudp_test_and_clear_young(struct vm_area_struct *vma,
-					    unsigned long address, pud_t *pudp)
+static inline bool pudp_test_and_clear_young(struct vm_area_struct *vma,
+					     unsigned long address, pud_t *pudp)
 {
 	return ptep_test_and_clear_young(vma, address, (pte_t *)pudp);
 }
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index f9439449c9bd..6ca1fdd25191 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1297,8 +1297,8 @@ extern int pudp_set_access_flags(struct vm_area_struct *vma,
 #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
 extern bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
 				      unsigned long addr, pmd_t *pmdp);
-extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
-				     unsigned long addr, pud_t *pudp);
+extern bool pudp_test_and_clear_young(struct vm_area_struct *vma,
+				      unsigned long addr, pud_t *pudp);
 
 #define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
 extern bool pmdp_clear_flush_young(struct vm_area_struct *vma,
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 8c336edf0e65..2677dcf0bbce 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -470,10 +470,10 @@ bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
 #endif
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-int pudp_test_and_clear_young(struct vm_area_struct *vma,
-			      unsigned long addr, pud_t *pudp)
+bool pudp_test_and_clear_young(struct vm_area_struct *vma,
+			       unsigned long addr, pud_t *pudp)
 {
-	int ret = 0;
+	bool ret = false;
 
 	if (pud_young(*pudp))
 		ret = test_and_clear_bit(_PAGE_BIT_ACCESSED,
-- 
2.47.3

