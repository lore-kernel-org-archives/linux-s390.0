Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691807;
	b=LbtwuMSuxfnZ8vUNoC+HPJwRwHIcxWkUbP0f7/6lx6sMhm8aBRPzyyBhgCLgCwlzp+tA
	 E8sK6MVV87d4Sf+QMHeTg2vJALB1R15DPIpDnGfm6mjkvkGAq8RKieoai07FoT6T9hqq0
	 QTdTg/6iyeOp10qoB4skmsF6zoLEo/EQWpgUkTSVmVZTtxclzpSF4+4CZZRx7uchRoxDT
	 oOXdcyS8IEQPqB0KnczVUu7ahy90aFFR188Tawo0qKc9CWfhiPj2AFkJNv4N5g4ntQ7N9
	 hqFRQ5wiEmBfcS7t15fs6WgiHx6D1jYvX5v+4QH7YggBI4LPFWbKDCY/8yfqxWz7PdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691807;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=ia0IpFMuZ2KgIGlhSeCcR6ahLTVFLFvimBCAHBa8K7A=;
	b=jRmBicVDNaBy7AU/jNciSnNUXRPzAKEKZCWzCXRuEScWmhRahaWi2t50bf+52rFPxz+t
	 jbPBaPq7SWhCh2qm2v1L/peVB9PYnwULeW3CgaLFaoD2/dMZYjw+97QPbSp7uV3aT2AJF
	 Nsy6dtXzGp4nQ8PGIKnJ6L7gmG88I9eETSbTWyB+B5m6cmfpStKhKifNAwGnHsYT8ao8d
	 dsyZcOrI7TqP489FLcK4zph3KMdRmfc1oyyG4B4RPPyuzj/vNH6pkaIpLsM1vH3RUQdxP
	 qiZZrnxmobzxyY01JIUfq7/6HHZpaQwoK9xK404x4mBt6Ndovn6o34I06PIlzxXSPQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6JaML8N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD53B606A323;
	Thu, 26 Nov 2026 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6JaML8N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB7F1F000C0;
	Thu, 26 Nov 2026 11:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691807;
	bh=ia0IpFMuZ2KgIGlhSeCcR6ahLTVFLFvimBCAHBa8K7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=C6JaML8N2aNTeIzENf2nvr8+aQgkt9RA0b/lUdY93mcchmhUi11+e2a0tScZ3CniC
	 QcRTPjB5Vvm2IKDrI4w2dr9YP7aKd6XiEFEQSWgHsN3oqfBPSbyJh4msiz7bJhFJnY
	 iHdEmk5VqDZ48vtOq9/cNB+6cQtOxm6d8cwlsfOe1vf3GC7TxG6ITRc00G6AjGH+kS
	 B1xDuZEPBtfEFIxDXf4DYfMJfU9pqQnNKwdDbA+opSwvI0DnVrHPn5m+cXAEC5semk
	 KHjBJ98o8aoZmxj2R6CX3JQmkDMDMQuLboY0NzWq2S7adY5QVhdyX0S7Rlpx6YLmpG
	 3SAUQuPMNGeGg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:27 +0200
Subject: [PATCH RFC v2 14/54] x86/mm/pat: take pgd_lock only around the
 pgd_list walks
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-14-723f1e33c3d8@kernel.org>
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

CPA takes pgd_lock around the split decision, the update of a large page,
the split and the collapse of large pages.

Everywhere else pgd_lock protects pgd_list. CPA needs it only on 32-bit, to
update the per-pgd copies of the kernel PMD entries when it changes them.

Updates of large pages are serialized by cpa_lock anyway, and the direct
map counters are atomic.

Take pgd_lock only around the pgd_list walks.

Without pgd_lock, should_split_large_page() only checks CPA_REQ_SPLIT
before it calls __should_split_large_page(). Fold it into
__should_split_large_page() and keep the shorter name.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 56 +++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 8076d29a2931..9dfe69d608b8 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -916,24 +916,29 @@ EXPORT_SYMBOL_GPL(slow_virt_to_phys);
  */
 static void __set_pmd_pte(pte_t *kpte, unsigned long address, pte_t pte)
 {
+	struct ptdesc *ptdesc;
+
+	if (!IS_ENABLED(CONFIG_X86_32)) {
+		set_pte_atomic(kpte, pte);
+		return;
+	}
+
+	guard(spinlock)(&pgd_lock);
+
 	/* change init_mm */
 	set_pte_atomic(kpte, pte);
 
-	if (IS_ENABLED(CONFIG_X86_32)) {
-		struct ptdesc *ptdesc;
-
-		list_for_each_entry(ptdesc, &pgd_list, pt_list) {
-			pgd_t *pgd;
-			p4d_t *p4d;
-			pud_t *pud;
-			pmd_t *pmd;
-
-			pgd = (pgd_t *)ptdesc_address(ptdesc) + pgd_index(address);
-			p4d = p4d_offset(pgd, address);
-			pud = pud_offset(p4d, address);
-			pmd = pmd_offset(pud, address);
-			set_pte_atomic((pte_t *)pmd, pte);
-		}
+	list_for_each_entry(ptdesc, &pgd_list, pt_list) {
+		pgd_t *pgd;
+		p4d_t *p4d;
+		pud_t *pud;
+		pmd_t *pmd;
+
+		pgd = (pgd_t *)ptdesc_address(ptdesc) + pgd_index(address);
+		p4d = p4d_offset(pgd, address);
+		pud = pud_offset(p4d, address);
+		pmd = pmd_offset(pud, address);
+		set_pte_atomic((pte_t *)pmd, pte);
 	}
 }
 
@@ -954,8 +959,8 @@ static pgprot_t pgprot_clear_protnone_bits(pgprot_t prot)
 	return prot;
 }
 
-static int __should_split_large_page(pte_t *kpte, unsigned long address,
-				     struct cpa_data *cpa)
+static int should_split_large_page(pte_t *kpte, unsigned long address,
+				   struct cpa_data *cpa)
 {
 	unsigned long numpages, pmask, psize, lpaddr, pfn, old_pfn;
 	pgprot_t old_prot, new_prot, req_prot, chk_prot;
@@ -963,6 +968,9 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	enum pg_level level;
 	bool nx, rw;
 
+	if (cpa->flags & CPA_REQ_SPLIT)
+		return 1;
+
 	/*
 	 * Check for races, another CPU might have split this page
 	 * up already:
@@ -1101,16 +1109,6 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	return 0;
 }
 
-static int should_split_large_page(pte_t *kpte, unsigned long address,
-				   struct cpa_data *cpa)
-{
-	if (cpa->flags & CPA_REQ_SPLIT)
-		return 1;
-
-	guard(spinlock)(&pgd_lock);
-	return __should_split_large_page(kpte, address, cpa);
-}
-
 static void split_set_pte(struct cpa_data *cpa, pte_t *pte, unsigned long pfn,
 			  pgprot_t ref_prot, unsigned long address,
 			  unsigned long size)
@@ -1158,7 +1156,6 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	bool nx, rw;
 	pte_t *tmp;
 
-	guard(spinlock)(&pgd_lock);
 	/*
 	 * Check for races, another CPU might have split this page
 	 * up for us already:
@@ -1304,6 +1301,8 @@ static int collapse_pmd_page(pmd_t *pmd, unsigned long addr,
 			return 0;
 	}
 
+	guard(spinlock)(&pgd_lock);
+
 	old_pmd = *pmd;
 
 	/* Success: set up a large page */
@@ -1404,7 +1403,6 @@ static int collapse_large_pages(unsigned long addr, struct list_head *pgtables)
 
 	addr &= PMD_MASK;
 
-	guard(spinlock)(&pgd_lock);
 	pgd = pgd_offset_k(addr);
 	if (pgd_none(*pgd))
 		return 0;

-- 
2.53.0

