Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187D73D6479;
	Tue, 18 Aug 2026 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787025675; cv=none; b=hg1MWyVMP/VBun4EQEcwShnr5EQuLx1JUzdy9QNxvB3W7Cr3uo9Z3XXvJFyt63Q5WaMqs3qC+AbHls0dnkm2ePcNhliivZcbLI4xqTXynjfKYE9LxV61DtO1/tpwolCTyof3DVqRzh0iqeUodgYcmu0k6qxkZ1+If+P3xmLMdqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787025675; c=relaxed/simple;
	bh=bPcYhQD4bzcwPSxJ8xkr0nWAdwCuI4IUaFLUJoGzm0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eC5UYaQ4zABaZsm4R9334D90K/skYyotWkc51/630PmUt+CdQhz1tQyEdNZ6j79U0nmc69P+K1EMgDg2lHfJklp9kCWElUSJgO6n2Axjp5CY7DQ83idX6E36hBvb5YL15AnHk4D0URkKNo4BPBUEkaDMYpotGtIbQGib7slsw4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tc5newTU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tc5newTU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FB111A25;
	Mon, 17 Aug 2026 21:01:07 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 808DB3F66F;
	Mon, 17 Aug 2026 21:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787025671; bh=bPcYhQD4bzcwPSxJ8xkr0nWAdwCuI4IUaFLUJoGzm0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tc5newTUC09VdGP5B76jtkjpI9sci0rMLtuInHFPNr66B6IGS4L8Sm6tk4cwRiJ/b
	 5h9Qek1XhXsg75s765gvhzEXLlsEvx2RUEZ09z5Yy66pdJ94V8xeAxBFwA0Aq2SxNr
	 PoXj1cVq1/8qvOSP1sQSfrCVEOq/UFl8/jpp1jbo=
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
Subject: [RFC V3 7/8] sh/mm: Stop using pgd_ERROR()
Date: Tue, 18 Aug 2026 09:30:40 +0530
Message-ID: <20260818040041.1891769-8-anshuman.khandual@arm.com>
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

Stop using pgd_ERROR() in __get_pte_phys() when page table entry is already
known to be empty.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/sh/mm/init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 8d65e60688dc..93921109f4e6 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -52,10 +52,8 @@ static pte_t *__get_pte_phys(unsigned long addr)
 	pmd_t *pmd;
 
 	pgd = pgd_offset_k(addr);
-	if (pgd_none(*pgd)) {
-		pgd_ERROR(*pgd);
+	if (pgd_none(*pgd))
 		return NULL;
-	}
 
 	p4d = p4d_alloc(NULL, pgd, addr);
 	if (unlikely(!p4d)) {
-- 
2.43.0

