Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DEA28CF5F;
	Tue, 11 Aug 2026 04:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786422097; cv=none; b=YRoU62xt+Gc1lCoKcKC4tg1jE/U7AT/njBVMICkCXySo8DlVdmT9h3AwsgZzxB5gBmCpfph54iESaiceg8mDX2ojUXso0w8Us6d3UTpzStKWU53FoTQzBx1XblzLLEGRN4Y0kCQLSlEZ4hGK9dmqdXNM5CJlzqMH8Q3lx6Wh8+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786422097; c=relaxed/simple;
	bh=seDKsmiMOMrdwfylVhhzaffw4o0OcF7YTjTN6FBF/F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1x1LTGz7j82n5mZ9UoHRGwYESWbpN7L0J2dVZAN2BdVkW1qrESZ+z9G1hvkZE99kIc6BK6T8tFL7fEiF98aUY/rV3puaHbaohYLv2rhW0FP47w5ILg1QeGT/UjtpUDCT0EA1QgHBc+zvNroABzSQqMcwGqxGhYa5z0u4fP1T6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KC7mBJJ7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KC7mBJJ7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB1921682;
	Mon, 10 Aug 2026 21:21:24 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D93B3F673;
	Mon, 10 Aug 2026 21:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786422088; bh=seDKsmiMOMrdwfylVhhzaffw4o0OcF7YTjTN6FBF/F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KC7mBJJ7KWVH6Grb7zUC3NdpCyV/h1uPp7PTSBIuRmm8PBZZS6xTMV8rQbmBcb0+k
	 CrFwokBxCYlG/gET0eDkNie78MI7Otgx+fDNF63nC3bpTuLMTOYV0FYW/FoKzOsWXt
	 +rPreTXul9plA9OwBjRX3iIHmzyFZ4yyGIp2Yfrw=
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
	linux-kernel@vger.kernel.org
Subject: [RFC V2 1/6] loongarch/mm: Stop using pte_ERROR()
Date: Tue, 11 Aug 2026 09:51:14 +0530
Message-ID: <20260811042119.3652929-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811042119.3652929-1-anshuman.khandual@arm.com>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Directly use pr_err() in __set_fixmap() and drop pte_ERROR() which helps in
eventually dropping pte_ERROR() macro across the tree. In this new printing
__FILE__ and __LINE__ has been dropped because they are always the same and
don't really add any value.

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/loongarch/include/asm/pgtable.h | 2 --
 arch/loongarch/mm/init.c             | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 223528c04d73..a32a8fff70c1 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -128,8 +128,6 @@ struct vm_area_struct;
 #define ptep_get(ptep) READ_ONCE(*(ptep))
 #define pmdp_get(pmdp) READ_ONCE(*(pmdp))
 
-#define pte_ERROR(e) \
-	pr_err("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
 #ifndef __PAGETABLE_PMD_FOLDED
 #define pmd_ERROR(e) \
 	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 3407030f3e7a..be9b127daef2 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -203,7 +203,7 @@ void __init __set_fixmap(enum fixed_addresses idx,
 
 	ptep = populate_kernel_pte(addr);
 	if (!pte_none(ptep_get(ptep))) {
-		pte_ERROR(*ptep);
+		pr_err("bad pte %016lx\n", pte_val(*ptep));
 		return;
 	}
 
-- 
2.43.0

