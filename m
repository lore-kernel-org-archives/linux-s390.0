Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EF73AFB18;
	Tue, 18 Aug 2026 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787025662; cv=none; b=eUks/wVWECgCt/nk9rE24/YDlBTrYfxK5WwymiI+Y+j16xRK2UgvER4ku0kbGrOsgS147SGaG7RIp8a2fzoszIEd3ShcLZ4JhfRutj2dAi4kpbSR6Dn7X3zT8YmWTMqlhkDUXucckDMyibYcKzuABsJQdWzAkPpe61e9VHCMa9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787025662; c=relaxed/simple;
	bh=jNvZ3ph4tfzqvfYMPDWyq7xHUxNcpHCKh93HJ34Xlag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfMWdoQzT2ZUU6XCPgGE+YDIDNs19joWDLtqae0Xr/VKV9rmvUxXz0GfgHRKj0ajn1A5AqnIRQ2s9aJRiNN/Qr5QQq5RWRuaZhbXoVnj+NcbvHUX0hTgCxzilES929imFK7LPZcwFneAp6ZdJdrTQreWiy69J4Zb6CKJ1ZgMia8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=utTgpugZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="utTgpugZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 552C0176C;
	Mon, 17 Aug 2026 21:00:56 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 439313F66F;
	Mon, 17 Aug 2026 21:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787025660; bh=jNvZ3ph4tfzqvfYMPDWyq7xHUxNcpHCKh93HJ34Xlag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utTgpugZygTuDjhpwxzKPuJMIDZz0EKonCrgJRpvQKS6INxHgHOfXIDFV+nOSQ7jF
	 7Bgl85I45aBhnw6MHWp+5DDIFHvHyFt07H8kgzKVC+zsqZqfrwYRzS13GPJp69yMK5
	 AJqMStMFmVH1+FyJHrLz9sBA+2QOVy632/sBTjjU=
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
Subject: [RFC V3 4/8] parisc/mm: Directly use generic [pmd|pgd]_clear_bad()
Date: Tue, 18 Aug 2026 09:30:37 +0530
Message-ID: <20260818040041.1891769-5-anshuman.khandual@arm.com>
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

Drop [pmd|pgd]_ERROR() followed by [pmd|pgd]_clear() instances. But instead
directly use semantically equivalent generic helpers [pmd|pgd]_clear_bad()
in unmap_uncached_[pte|pmd]() which helps in dropping their corresponding
[pmd|pgd]_ERROR() macros across the tree.

Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/parisc/kernel/pci-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index bf9f192c826e..84e7309a8266 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -160,8 +160,7 @@ static inline void unmap_uncached_pte(pmd_t * pmd, unsigned long vaddr,
 	if (pmd_none(*pmd))
 		return;
 	if (pmd_bad(*pmd)) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
+		pmd_clear_bad(pmd);
 		return;
 	}
 	pte = pte_offset_kernel(pmd, vaddr);
@@ -196,8 +195,7 @@ static inline void unmap_uncached_pmd(pgd_t * dir, unsigned long vaddr,
 	if (pgd_none(*dir))
 		return;
 	if (pgd_bad(*dir)) {
-		pgd_ERROR(*dir);
-		pgd_clear(dir);
+		pgd_clear_bad(dir);
 		return;
 	}
 	pmd = pmd_offset(pud_offset(p4d_offset(dir, vaddr), vaddr), vaddr);
-- 
2.43.0

