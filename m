Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487033AE194;
	Tue, 18 Aug 2026 04:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787025657; cv=none; b=e7j/ddaL/47GzUKBGBzE3O+Etc6G2nxf1BM1MbYPcgmzpYgpSvVlxc6vOLJmqxV831Ao6i/XWk6pQk4u5YQ5v/wl9ddKgRIY7QAAobcU9ZfrRh0OaYNj3zPi+myrJlyqP62YBbszJtR0VLVEwbDAhlFzzPvt5kqL4aDdYB/LBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787025657; c=relaxed/simple;
	bh=EW78rNPYlnbPGtLiZHGicUsrFYH/KtTsRTBqboGjipA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyA2Q9HopA3SprfdLI/q9KACqZvgJ4eQr0MjWHnT+sRY+dKCUiHfpE7fZ55MmlaDdAi7n6DQOIvCjUy53DVPbcmXUId7thoANzBVWGV5xTRtJtFC/mLzex9O1XxWQpY7DKAPn1O6gDIdUwyRDEqh55i8a9Kk20Mx1N00E1gNkf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VDNAxtBQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VDNAxtBQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABB77176B;
	Mon, 17 Aug 2026 21:00:48 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99A093F66F;
	Mon, 17 Aug 2026 21:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787025652; bh=EW78rNPYlnbPGtLiZHGicUsrFYH/KtTsRTBqboGjipA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VDNAxtBQQ6wScTg+OmzQo2WjWBv2oQBrkhEacV04Y3s26ulIQqhAxmubkmAsBCt3f
	 w3LPVMcpAj+Ej3fS+wnOSSmNgjfpsYRDC5rFye16er5IS7LSHQbdaBR0hhnKSWgJXq
	 4kIN7sNYMnv4fK6l0sbc5HmTfSTT3PeHiEXsbcH4=
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	david@kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>
Subject: [RFC V3 2/8] mm: Stop using pxd_ERROR()
Date: Tue, 18 Aug 2026 09:30:35 +0530
Message-ID: <20260818040041.1891769-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818040041.1891769-1-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pxd_ERROR() has been used in generic mm just to print the page table entry
in pxd_clear_bad() before clearing those out with pxd_clear() later. These
pxd_ERROR() macros have been provided by all platforms which basically did
the same thing.

Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
page table entries thus completely dropping dependency on platform provided
pxd_ERROR() macros which can then be dropped off later on.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/pgtable-generic.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index b91b1a98029c..f093e2474f4f 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -13,6 +13,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/mm_inline.h>
+#include <linux/mm_types.h>
 #include <linux/iommu.h>
 #include <linux/pgalloc.h>
 
@@ -26,14 +27,20 @@
 
 void pgd_clear_bad(pgd_t *pgd)
 {
-	pgd_ERROR(*pgd);
+	char str[PTVAL_STR_MAX];
+
+	ptval_to_str(str, pgd_val(*pgd));
+	pr_err("bad pgd %s.\n", str);
 	pgd_clear(pgd);
 }
 
 #ifndef __PAGETABLE_P4D_FOLDED
 void p4d_clear_bad(p4d_t *p4d)
 {
-	p4d_ERROR(*p4d);
+	char str[PTVAL_STR_MAX];
+
+	ptval_to_str(str, p4d_val(*p4d));
+	pr_err("bad p4d %s.\n", str);
 	p4d_clear(p4d);
 }
 #endif
@@ -41,7 +48,10 @@ void p4d_clear_bad(p4d_t *p4d)
 #ifndef __PAGETABLE_PUD_FOLDED
 void pud_clear_bad(pud_t *pud)
 {
-	pud_ERROR(*pud);
+	char str[PTVAL_STR_MAX];
+
+	ptval_to_str(str, pud_val(*pud));
+	pr_err("bad pud %s.\n", str);
 	pud_clear(pud);
 }
 #endif
@@ -53,7 +63,10 @@ void pud_clear_bad(pud_t *pud)
  */
 void pmd_clear_bad(pmd_t *pmd)
 {
-	pmd_ERROR(*pmd);
+	char str[PTVAL_STR_MAX];
+
+	ptval_to_str(str, pmd_val(*pmd));
+	pr_err("bad pmd %s.\n", str);
 	pmd_clear(pmd);
 }
 
-- 
2.43.0

