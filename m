Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7403B14CE;
	Mon, 31 Aug 2026 05:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155043; cv=none; b=B9AFwL5F+FBbgHWK/G71xUtIk0WpwF/pTk/9ZzpHW/SpSeH7uuTVyZ1Zwnlo83pxEkIURAuFtxUdjjjOgYeN1674aP4aU5SyMvduNfuOf+N1dLFhR2wBPju/pn0uUFwdV+k8GKxHWF3ykmE+Gl3jjOtpGIZaEGjsA7lf7XpFo6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155043; c=relaxed/simple;
	bh=19JNL2aQ1m2bgjsQFbzvNHwUtw8tQlkca/Xxp7GPwo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuVFcXBYf8SkDnte2mFAmJM8sBosp1h9dLeBejifQYDnk860Z4V91auQw7537Jj/M4TPjx8qUCUN401OltsveWRP09qpKrOZfQhFn43LWNQdHld5rbgR3T36LS5m7MIYrLinlIRathohfXfuYh7q+Ju/zIUqvmdYG7wZPXL0GPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=U0L19rtb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="U0L19rtb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CF061A32;
	Sun, 30 Aug 2026 22:43:56 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6785C3F85F;
	Sun, 30 Aug 2026 22:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788155040; bh=19JNL2aQ1m2bgjsQFbzvNHwUtw8tQlkca/Xxp7GPwo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U0L19rtbEHy9Bp2X2iUVLKKtbExFWVCCT5piVe9NpoUB1AFhA8YHZQbH1wlPAPfX4
	 Ay2S64IR505XEPoJ0IN4Oh6nslmTu7PwulMz8Lw7NqgU8iCXl/uxnUPMxcESRtkCpw
	 mWcDca7zBkcW4qfWA9izm/4P351I4KVkwzyARqd8=
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: samuel.holland@sifive.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
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
Subject: [PATCH 7/8] sh/mm: Stop using pgd_ERROR()
Date: Mon, 31 Aug 2026 11:13:29 +0530
Message-ID: <20260831054331.625505-8-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831054331.625505-1-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
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
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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

