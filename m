Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CACE3D1A97;
	Tue, 18 Aug 2026 04:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787025669; cv=none; b=eM3FamlWlmogFh9MBkCMF+TvaXrn7lgKKAu+a1pm2/K4YvDfT00YnICghmAAAGl18pG9z4ejAyelaMdnGokt5GV3VnDEyHxsPrWqrOtCrOm9JinIDIhcWQjRgmrz1BI0ag1imup2F9316rTLgajbuTTG/68PH9K2irUTCeEjzk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787025669; c=relaxed/simple;
	bh=fvWsPm2RhovRhyeQja3vObvDm/dQnZu4xzhWldyViFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCZfPJMvEtPHzzhMEMOr0Mf0F1CSPbOhRTGvvBQI5NF2LG4BdAWQM+7gs5bcCldLif3/SqL4mfiERGDqOJVjV4pT5DJ7qRjlI/mTyLTDRPHTVPrvrilsTAyadVGUHKUGN3PMqwBGuAChyo9iIThcoFjKrpjoEIeOkiai43vffzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Mayvk+7Y; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Mayvk+7Y"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFC681A00;
	Mon, 17 Aug 2026 21:01:03 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3D303F66F;
	Mon, 17 Aug 2026 21:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787025667; bh=fvWsPm2RhovRhyeQja3vObvDm/dQnZu4xzhWldyViFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mayvk+7YyBI2v2eqdqjZoS2Z0dSe2CBNgITCjGmuVovDxkhyBaxSP1dLk5kNH1nez
	 idT86Nq/jZBkUaXw0freV4r8tdOSXnkHA9v9bqHpKf4rUtAsLWC+ksnp8Cx/gdMRyF
	 17IZ3guv1INHQU+zfmWJE2RLFpqbe6NzJqmu5VKg=
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
Subject: [RFC V3 6/8] sh/mm: Stop using [p4d|pud|pmd]_ERROR()
Date: Tue, 18 Aug 2026 09:30:39 +0530
Message-ID: <20260818040041.1891769-7-anshuman.khandual@arm.com>
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

Stop using [p4d|pud|pmd]_ERROR() in __get_pte_phys() as the pgtable entries
are known to be NULL and hence could not really be accessed.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in RFC V3

- Added some pr_error() messages in __get_pte_phys()

 arch/sh/mm/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 9466ae6f9f16..8d65e60688dc 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -59,19 +59,19 @@ static pte_t *__get_pte_phys(unsigned long addr)
 
 	p4d = p4d_alloc(NULL, pgd, addr);
 	if (unlikely(!p4d)) {
-		p4d_ERROR(*p4d);
+		pr_err("allocating p4d table failed\n");
 		return NULL;
 	}
 
 	pud = pud_alloc(NULL, p4d, addr);
 	if (unlikely(!pud)) {
-		pud_ERROR(*pud);
+		pr_err("allocating pud table failed\n");
 		return NULL;
 	}
 
 	pmd = pmd_alloc(NULL, pud, addr);
 	if (unlikely(!pmd)) {
-		pmd_ERROR(*pmd);
+		pr_err("allocating pmd table failed\n");
 		return NULL;
 	}
 
-- 
2.43.0

