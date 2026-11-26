Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691883;
	b=T5UhwVmbXNU/H7Fl7IyNwPHc3hOb1CzHK+0o+WqNKt0MlRpJSE7P1giwXnbxC/6ArSiU
	 msPNa07daHR30+m2cZ+ehKmPHnuwTvzphysWocsOJCckEebMFmrZEL07h4FswpDtoecJD
	 RJs1EFQKDgUXu8Bv9SCoiFo8hJ79xMLENUV58AReATEveOElYPehG3hakhNhQqTaoMR8B
	 KnMpsDoa9IbHJCPmbWT2hXq5iw/9Ub+crVl4SL2yJi2T/ueYsUARBxX4mO2Xq495Ejh4h
	 SWfOKWNjpAZ3uXHK4AkVhO+t9Xm2QlpASPqJbd2aFjqNxrs5sM17FxWfz9vcydo5cnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691883;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=LuNg/+IqwDeUPgc4V4ONbexk5EhrBaEXT2bA4fFnVk0=;
	b=279PqWQRbrl24vmisTL35Nf77zI9Sh7rr7wyegZtLsZxvjl0Kelph7CihYeSYMPeOSUC
	 +jWOYL63UoTME7W0U7xoex6kYdPbS5pdmSkOlZXU3OUr07xsh2TWNCvTlRUOGtdGR8WzV
	 RXyItzRXCuORuFEnOvtP/mgyVuvlmUAr42MzTgXQ58H2qmgSG9wWnzkOHH2oeg3JiOic6
	 IDmEzURb1xNfDAZ7Qc0ArZhr+4QmAA5A2Zf0iGszd2pAr2+lEsh0+zafH1Y/B0+7lIIP7
	 ER84qol0pOblrUqg2oVwTJr7+YGslbctkgD1U9JhBrnYmGsi9Tda5EmPMGRP/uakGsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cDUnZJ4u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3055606A321;
	Thu, 26 Nov 2026 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cDUnZJ4u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72051F000F4;
	Thu, 26 Nov 2026 11:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691883;
	bh=LuNg/+IqwDeUPgc4V4ONbexk5EhrBaEXT2bA4fFnVk0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cDUnZJ4uBXhYX+uCkx+TJWJMvuT4HdvtrIKy9YiOGubEbW2WpKhS7HgZHvOCnBP9n
	 UdLkBCN6aehYkFqrEm4ektZzoNieAkCVohQY0jrHFfUd5fNnqkAQ9UQc8vVBMSFymi
	 aP0MitFMb+lHpiJ/8DQRnNuJ6+YWVKLLF+rOzyKpj2w/hsZfCoJ6EHl2IME8K1iGPZ
	 WIDk+cGgvkbKtKRvs8On0tR4pdUNkEd/M2TmEUWHjsxXBBRjMBBQeSlAk6JqWDPfUP
	 Bd//4zNaBlwKksvSBxOr5bBzuABsGs0npCyMCO4HNgEaoTe0b1igiIjsFbaryo4Uhi
	 bMeTZBhOSNX6Q==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:35 +0200
Subject: [PATCH RFC v2 22/54] x86/mm/pat: consolidate calculation of the
 new protection
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-22-723f1e33c3d8@kernel.org>
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

The large page path and the PTE path of CPA both apply the request masks to
the current protection and then run static_protections() and verify_rwx()
on the result. Each path spells the arguments differently.

The generic core will need this calculation as a hook.

Move it to cpa_req_prot() and cpa_new_prot() and use them in both PTE and
PxD paths.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 54 +++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 304b7ad26c45..cb503e41340b 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1085,6 +1085,38 @@ static pte_t cpa_pte(enum pgtable_level level, unsigned long pfn, pgprot_t prot)
 	return pfn_pte(pfn, prot);
 }
 
+static pgprot_t cpa_req_prot(const struct cpa_data *cpa,
+			     const struct cpa_leaf *leaf)
+{
+	return __pgprot((pgprot_val(leaf->prot) & ~pgprot_val(cpa->mask_clr)) |
+			pgprot_val(cpa->mask_set));
+}
+
+static pgprot_t cpa_new_prot(struct cpa_data *cpa, struct cpa_leaf *leaf)
+{
+	pgprot_t prot = cpa_req_prot(cpa, leaf);
+	enum pgtable_level level = leaf->level;
+	unsigned long size = leaf->size;
+	unsigned long addr = leaf->addr;
+	pgprot_t old_prot = leaf->prot;
+	unsigned long pfn = leaf->pfn;
+	int warnlvl = CPA_PROTECT;
+	unsigned long lpsize = 0;
+	unsigned long numpages;
+
+	numpages = size >> PAGE_SHIFT;
+
+	if (level != PGTABLE_LEVEL_PTE) {
+		warnlvl = CPA_DETECT;
+		lpsize = size;
+	}
+
+	/* A PTE hands in lpsize = 0 to enforce the protection mechanism */
+	prot = static_protections(prot, addr, pfn, numpages, lpsize, warnlvl);
+
+	return verify_rwx(cpa, old_prot, prot, addr, pfn, numpages);
+}
+
 static int should_split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf)
 {
 	unsigned long address = __cpa_addr(cpa, cpa->curpage);
@@ -1114,9 +1146,7 @@ static int should_split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf)
 	if (numpages < cpa->numpages)
 		cpa->numpages = numpages;
 
-	req_prot = old_prot;
-	pgprot_val(req_prot) &= ~pgprot_val(cpa->mask_clr);
-	pgprot_val(req_prot) |= pgprot_val(cpa->mask_set);
+	req_prot = cpa_req_prot(cpa, leaf);
 
 	/*
 	 * old_pfn points to the large page base pfn. So we need to add the
@@ -1148,11 +1178,7 @@ static int should_split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf)
 	 * Check whether the requested pgprot is conflicting with a static
 	 * protection requirement in the large page.
 	 */
-	new_prot = static_protections(req_prot, lpaddr, old_pfn, numpages,
-				      psize, CPA_DETECT);
-
-	new_prot = verify_rwx(cpa, old_prot, new_prot, lpaddr, old_pfn,
-			      numpages);
+	new_prot = cpa_new_prot(cpa, leaf);
 
 	/*
 	 * If there is a conflict, split the large page.
@@ -1873,20 +1899,12 @@ static int __change_page_attr(struct cpa_data *cpa)
 
 	if (leaf.level == PGTABLE_LEVEL_PTE) {
 		pte_t old_pte = *leaf.kpte;
-		pgprot_t old_prot = leaf.prot;
-		pgprot_t new_prot = leaf.prot;
+		pgprot_t new_prot;
 		unsigned long pfn = leaf.pfn;
 		pte_t new_pte;
 
-		pgprot_val(new_prot) &= ~pgprot_val(cpa->mask_clr);
-		pgprot_val(new_prot) |= pgprot_val(cpa->mask_set);
-
 		cpa_inc_pte_install();
-		/* Hand in lpsize = 0 to enforce the protection mechanism */
-		new_prot = static_protections(new_prot, address, pfn, 1, 0,
-					      CPA_PROTECT);
-
-		new_prot = verify_rwx(cpa, old_prot, new_prot, address, pfn, 1);
+		new_prot = cpa_new_prot(cpa, &leaf);
 
 		/*
 		 * We need to keep the pfn from the existing PTE,

-- 
2.53.0

