Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1936345C713;
	Sat, 19 Sep 2026 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789812843; cv=none; b=VBMLzCe4OlJvQAq/iFt4L/KwhDCUZzZonTSaVQsKyzCu2Kl3SGuKvcWHq6fSSHBjymwZEaKPu+Kr8Ng6pLzIamGsryxrjOgK+o5+EhtKMAyaIrh97rpiWSYbYDB3kuo/KcDAPSyef5bhHiwoDUOxUgOlhS/UXwxy+D2Fsv+kQ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789812843; c=relaxed/simple;
	bh=PTZcXaFsAbyGmhHrgLdNOiGQw+Rh/lxM4LRL9V2hYS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKEHSuifimv6lRO3dv/Cp0m4qinkrzsDqLaSaosoYaUTqyFYU2Kf7a7hak4b2SzfK2mVrukMyVDRJEXo/QPePJ8y1tol5q8jYaZTLuz/5l/sReIEJICcII3Jf6oK8uutF8FYCp4ec5Pdy+5q0JjR7wSGuF///ftV2U/DZEh6axY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qb07kYdo; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qb07kYdo"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC93E1C01;
	Sat, 19 Sep 2026 03:13:55 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83EB63F86F;
	Sat, 19 Sep 2026 03:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789812839; bh=PTZcXaFsAbyGmhHrgLdNOiGQw+Rh/lxM4LRL9V2hYS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qb07kYdouvddikX3vG/MtEKM4u0Sc3ipdedYhR2lw4ZqG8C16xOauqn/V/0XOrCHm
	 0bYELUvcb38DSoXytnbo9ZGg6g3qr+ZQ2azNfErg1g6mooyywqO1V03Kerwcq/fXzd
	 VbEGFGrBmUeUm1W1PcAOv1gtVceC5a9e7D4F7pTU=
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
Subject: [PATCH 1/3] s390/mm: Drop all pxdp_get()
Date: Sat, 19 Sep 2026 15:43:39 +0530
Message-ID: <20260919101343.1959572-2-anshuman.khandual@arm.com>
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
them redundant. Just add required forward declarations.

Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/s390/include/asm/pgtable.h | 35 +++++----------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 859ce7c7d4544..6aaa7f7ae5a0f 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -25,6 +25,11 @@
 #include <asm/page.h>
 #include <asm/uv.h>
 
+static inline pte_t ptep_get(const pte_t *ptep);
+static inline pud_t pudp_get(const pud_t *pudp);
+static inline p4d_t p4dp_get(const p4d_t *p4dp);
+static inline pgd_t pgdp_get(const pgd_t *pgdp);
+
 extern pgd_t swapper_pg_dir[];
 extern pgd_t invalid_pg_dir[];
 extern void paging_init(void);
@@ -985,36 +990,6 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 	WRITE_ONCE(*ptep, pte);
 }
 
-#define ptep_get ptep_get
-static inline pte_t ptep_get(pte_t *ptep)
-{
-	return READ_ONCE(*ptep);
-}
-
-#define pmdp_get pmdp_get
-static inline pmd_t pmdp_get(pmd_t *pmdp)
-{
-	return READ_ONCE(*pmdp);
-}
-
-#define pudp_get pudp_get
-static inline pud_t pudp_get(pud_t *pudp)
-{
-	return READ_ONCE(*pudp);
-}
-
-#define p4dp_get p4dp_get
-static inline p4d_t p4dp_get(p4d_t *p4dp)
-{
-	return READ_ONCE(*p4dp);
-}
-
-#define pgdp_get pgdp_get
-static inline pgd_t pgdp_get(pgd_t *pgdp)
-{
-	return READ_ONCE(*pgdp);
-}
-
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	set_pte(ptep, __pte(_PAGE_INVALID));
-- 
2.43.0

