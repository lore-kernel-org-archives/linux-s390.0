Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692007;
	b=y2wnQuFM4rrfGF7YA9dtKNbpzvoiRxC07isRLP8+RpALUX7Ky+pI8LaY6Nmoj1G84Oby
	 DYgBJOmvXqcCQVbDJqqUfJ69pEDaF8qHR5B2GD+A5iKrMjWREcawyLUe4ej4l612utjcS
	 XBuwS8dAWzx/w944w1TFGZasxcAeRxwmwVOJGhWFZM1vKXBBjjOhesQ0cAUAdm5X/VCpy
	 iCDz8OkDL5uE55huIe60PGUf4uQXxijbp+LUmpk8XzJ4cFujTl+vrvJhMWyxnhR0HDfSu
	 IxZgTTBahuEcnQSprJIRV7ORS2rqlM8dSf8WxhZ4ddEdSXaznTcvFJkuMq91ARjGBfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692007;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=TcovJ7fKpwSIau6n7YhDhlDaqqn2o0CpIonYbQhgs1Q=;
	b=tR7alAcGxMBlCV1rMj2EqtYZPFqpbQnACkWKSxYoqW55fYFnp5aQiCNyVif8i0AvNHdY
	 9O+e59slohaes/RTZ6UqOfEPpDdQnZz+JxJZ0XEZolXitekm8rlFKrKgaTmtZ/vq1E5Za
	 WzIl2kw58KJd0fy8Rfww6kq0JLdbyrkqHLV2zBcFLxhJoZ4iar2OuTP8ZaNDHvtpEfqUE
	 5uU265AnNvYUnZO3/1UtkdgoTPgqE9lhAHdxTeJ69/+Xv/luaEq89l/lN25A6trUmLYVH
	 zcyFd5w+0V+05BYb63H3u6M08F6IZ811QZ4XkbEPKBl7cwfpemD6y1GyKAGS/B1Kgww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQX4Vlfz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D6606A339;
	Thu, 26 Nov 2026 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQX4Vlfz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291EB1F0089E;
	Thu, 26 Nov 2026 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692006;
	bh=TcovJ7fKpwSIau6n7YhDhlDaqqn2o0CpIonYbQhgs1Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YQX4Vlfzncbu4ByMDCKIDOkYYuSMz8GiefAX4fx/EY+K2NBxvpNvsiNjKehGukcK3
	 lYy3m1CGX662GRgnQjDUdbqu7M4DZmesh3UjBMBBpadd+prI19r4f7zsZRkeynMYjI
	 xsqqk0eHRRZvHrMs/B6xCL2yudop9ANQuRk+Uwk6lNeuZmstf+gkjHcxLeG0C07xGd
	 Jso+S6uzBcWs9Srk4u6wHwIrfto5nZZkQZ2G7x16qj3IaMAxz77wxlvKOemicCLn+0
	 HxT7UKA95ELqMw6kAI+RO/k1BXqNlkMdNJ9XqukHBM6bTLzSCsIcXL/BxoHIhzTAYJ
	 imaUFPSKUcSjA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:48 +0200
Subject: [PATCH RFC v2 35/54] LoongArch: drop the huge page handling from
 set_memory()
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-35-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev

set_memory() never finds a huge mapping on LoongArch.

The direct map and the kernel image are in the direct mapping windows,
which have no page tables, and set_memory() skips them.

Everything in the vmalloc area is mapped with base pages, because LoongArch
selects neither HAVE_ARCH_HUGE_VMALLOC nor HAVE_ARCH_HUGE_VMAP.

The only huge kernel mapping is the vmemmap, and nothing changes its
protections.

The PGD, P4D, PUD and PMD handlers of the set_memory() page table walk are
dead code. Drop them.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/loongarch/mm/pageattr.c | 56 --------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
index 7283059d6e1f..11cea93c7415 100644
--- a/arch/loongarch/mm/pageattr.c
+++ b/arch/loongarch/mm/pageattr.c
@@ -24,58 +24,6 @@ static unsigned long set_pageattr_masks(unsigned long val, struct mm_walk *walk)
 	return new_val;
 }
 
-static int pageattr_pgd_entry(pgd_t *pgd, unsigned long addr,
-			      unsigned long next, struct mm_walk *walk)
-{
-	pgd_t val = pgdp_get(pgd);
-
-	if (pgd_leaf(val)) {
-		val = __pgd(set_pageattr_masks(pgd_val(val), walk));
-		set_pgd(pgd, val);
-	}
-
-	return 0;
-}
-
-static int pageattr_p4d_entry(p4d_t *p4d, unsigned long addr,
-			      unsigned long next, struct mm_walk *walk)
-{
-	p4d_t val = p4dp_get(p4d);
-
-	if (p4d_leaf(val)) {
-		val = __p4d(set_pageattr_masks(p4d_val(val), walk));
-		set_p4d(p4d, val);
-	}
-
-	return 0;
-}
-
-static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
-			      unsigned long next, struct mm_walk *walk)
-{
-	pud_t val = pudp_get(pud);
-
-	if (pud_leaf(val)) {
-		val = __pud(set_pageattr_masks(pud_val(val), walk));
-		set_pud(pud, val);
-	}
-
-	return 0;
-}
-
-static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
-			      unsigned long next, struct mm_walk *walk)
-{
-	pmd_t val = pmdp_get(pmd);
-
-	if (pmd_leaf(val)) {
-		val = __pmd(set_pageattr_masks(pmd_val(val), walk));
-		set_pmd(pmd, val);
-	}
-
-	return 0;
-}
-
 static int pageattr_pte_entry(pte_t *pte, unsigned long addr,
 			      unsigned long next, struct mm_walk *walk)
 {
@@ -94,10 +42,6 @@ static int pageattr_pte_hole(unsigned long addr, unsigned long next,
 }
 
 static const struct mm_walk_ops pageattr_ops = {
-	.pgd_entry = pageattr_pgd_entry,
-	.p4d_entry = pageattr_p4d_entry,
-	.pud_entry = pageattr_pud_entry,
-	.pmd_entry = pageattr_pmd_entry,
 	.pte_entry = pageattr_pte_entry,
 	.pte_hole = pageattr_pte_hole,
 	.walk_lock = PGWALK_RDLOCK,

-- 
2.53.0

