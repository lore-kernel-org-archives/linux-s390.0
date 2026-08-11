Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DE02D738F;
	Tue, 11 Aug 2026 04:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786422101; cv=none; b=LaGrzDY2LsLbumD10yMEAkR23xlTsZoPJqzpA6Zvedivifn7+jcExUtZ/Hv0l19hjYSWjeqrSZCp7l+ZQVwOJz5s4zMpOW8yH9BlDbz1G/mJreuGJxmywWww21nF5lOKJ7baN+pHu/lywNOZ5XlRrhK8bJHdc3mHotI+buGEuaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786422101; c=relaxed/simple;
	bh=pfMAQ/GDECbmwo/qWefWNRsbphdRQF7xgYQeIgh1v4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GI1a3sDkww/H9/8ZtaoB2N/zstKKJMOMDXmYTkkO+QUtxV1Yn4FBP8R4rbOTPlrCdj1qpaSc6zY2wVMW7d65w7Lo6hy7ML4cP3frOnHVspydb+2TdC469Xq5olPe/WP7m9QDUauX12Fn9zma1LqADH3vZAfdyw14ZWuYqdRdpXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eWCiC7xg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eWCiC7xg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05D0F1688;
	Mon, 10 Aug 2026 21:21:32 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BCE93F673;
	Mon, 10 Aug 2026 21:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786422095; bh=pfMAQ/GDECbmwo/qWefWNRsbphdRQF7xgYQeIgh1v4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eWCiC7xg6Urch6e/NkyTz2nx1jVxQ2+lXNNVl32VkpGHIvNOZKoKK7OwvEvBfhSEE
	 wJbBJKEACAKzuY3XWRWmEiavQBuGK0AQKUazXEqU1d31lkT1Spev7terS8Toxwdnjv
	 EicAFdP1tvM9H1F3vee9RdSt/Ezcn1ReEpkjAW58=
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
Subject: [RFC V2 3/6] sh/mm: Stop using pte_ERROR()
Date: Tue, 11 Aug 2026 09:51:16 +0530
Message-ID: <20260811042119.3652929-4-anshuman.khandual@arm.com>
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

Directly use pr_err() in set_pte_phys() and drop pte_ERROR() which helps in
eventually dropping pte_ERROR() macro across the tree. In this new printing
__FILE__ and __LINE__ has been dropped because they are always the same and
don't really add any value.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/sh/include/asm/pgtable_32.h |  5 -----
 arch/sh/mm/init.c                | 11 ++++++++++-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index 5f51af18997b..c8eb9a7a4c4c 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -401,14 +401,9 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #define pmd_page(pmd)		(virt_to_page(pmd_val(pmd)))
 
 #ifdef CONFIG_X2TLB
-#define pte_ERROR(e) \
-	printk("%s:%d: bad pte %p(%08lx%08lx).\n", __FILE__, __LINE__, \
-	       &(e), (e).pte_high, (e).pte_low)
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %016llx.\n", __FILE__, __LINE__, pgd_val(e))
 #else
-#define pte_ERROR(e) \
-	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 #endif
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 110308bdef01..b3c7fd84ceb4 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -78,13 +78,22 @@ static pte_t *__get_pte_phys(unsigned long addr)
 	return pte_offset_kernel(pmd, addr);
 }
 
+static void print_bad_pte(pte_t pte)
+{
+#ifdef CONFIG_X2TLB
+	printk("bad pte %p(%08lx%08lx).\n", &pte, pte.pte_high, pte.pte_low);
+#else
+	printk("bad pte %08lx.\n", pte_val(pte));
+#endif
+}
+
 static void set_pte_phys(unsigned long addr, unsigned long phys, pgprot_t prot)
 {
 	pte_t *pte;
 
 	pte = __get_pte_phys(addr);
 	if (!pte_none(*pte)) {
-		pte_ERROR(*pte);
+		print_bad_pte(*pte);
 		return;
 	}
 
-- 
2.43.0

