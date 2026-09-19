Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E5C45DF6C;
	Sat, 19 Sep 2026 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789812852; cv=none; b=HnbluQGxXWjXvvdpvGJkqv0sm7EsvX02wKa4GSrO22jPJNGq4kr3noXknd8TVMTEzxopGgaXdpex/xSpmJCcvs5ZCPVD/MIRAqH7+0ErQJp1vWuRbehx0hwzN/mjSj8i3OTQx/TSn9QsrMXByipqmcjKl0wPZHwhAcCDUEjgAXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789812852; c=relaxed/simple;
	bh=XcLwHk06QSGKe2Ods7V5zqX1zXNtJInI09P5mJmD2K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2xSuiGqwFY/5seRZv/qEbtq7Ey6dFc86nSRRlEWq3kvFRUjmWH0Cc1WwI91FNYZE/9AfEMuoidmDAnaFC1ECnbPbKttH9cLmbwZrQljLm0SjpSKISpZc747mwQk4wndajtpl5QwoOQaw3gC02pc/1AHf236APZK5biMiORsXho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XX6/NDAw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XX6/NDAw"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C838B1C01;
	Sat, 19 Sep 2026 03:14:03 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92A993F86F;
	Sat, 19 Sep 2026 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789812847; bh=XcLwHk06QSGKe2Ods7V5zqX1zXNtJInI09P5mJmD2K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XX6/NDAwVyJ832z17R+nFbKhiduWP0ByxUEgdxTN+Vg/LKM1CIj8/4sjNw2TvoYKQ
	 zKWgo+2YIL739PlyJlnv2q2ljR6Q4fc30odhFfgmAH5Lblobsw5rzOzjE3C57ItZw/
	 iTEl6j5rsqVfCvX+KXlanFRj4eFY6FIR3fKz/VuU=
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
Subject: [PATCH 3/3] parisc/mm: Drop all pxdp_get()
Date: Sat, 19 Sep 2026 15:43:41 +0530
Message-ID: <20260919101343.1959572-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919101343.1959572-1-anshuman.khandual@arm.com>
References: <20260919101343.1959572-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Current platform specific pxdp_get() helpers are exact same as the default
ones defined in the generic MM header (include/linux/pgtable.h) thus making
them redundant. Move functions that are now depending on generic helpers to
avoid build failure.

Cc: “James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/parisc/include/asm/pgtable.h | 20 +-------------------
 arch/parisc/mm/init.c             | 13 +++++++++++++
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 467b8547ac8bf..975aa283b4c13 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -432,25 +432,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 	return pte;
 }
 
-static inline pte_t ptep_get(pte_t *ptep)
-{
-	return READ_ONCE(*ptep);
-}
-#define ptep_get ptep_get
-
-static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *ptep)
-{
-	pte_t pte;
-
-	pte = ptep_get(ptep);
-	if (!pte_young(pte)) {
-		return false;
-	}
-	set_pte_at(vma->vm_mm, addr, ptep, pte_mkold(pte));
-	return true;
-}
-
+bool ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
 bool ptep_clear_flush_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
 pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
 
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index be3380c9bcdae..3da7d8def9435 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -992,3 +992,16 @@ struct execmem_info __init *execmem_arch_setup(void)
 	return &execmem_info;
 }
 #endif /* CONFIG_EXECMEM */
+
+bool ptep_test_and_clear_young(struct vm_area_struct *vma,
+			       unsigned long addr, pte_t *ptep)
+{
+	pte_t pte;
+
+	pte = ptep_get(ptep);
+	if (!pte_young(pte))
+		return false;
+
+	set_pte_at(vma->vm_mm, addr, ptep, pte_mkold(pte));
+	return true;
+}
-- 
2.43.0

