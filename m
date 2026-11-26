Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691817;
	b=4qhBJTvZ5t3ZM5NMqdPU3dN9umcvg/InNWN1fqEIyVTzWmxuqvHprIJrHYi9SX22CKaO
	 R66rbkINBpZYxe1rw/MrFvhKLXgXhqdRpm9V2Kr6NdYalqY0HynbukTrBOHUMOqDPw1RC
	 6g3ChYNunrBN8HAhb78nyMXadd7THlbaPr+VfBuv/mX7YGLDJK+SZnVuKbPorSEk6rd7D
	 +s3XtHCaxGLUpYrOFB1v9WCZ2fMmz114piAGU96EwL1nxRuvI9v2kQcc1xOdKgisK6JLB
	 LMUzphmkaktDXg9DNfqiQzN5l2eiNa7/GX5X0zl0FyZeFNaaAWXyfKuTCFwzSYgZt2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691817;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=/joh9LYYtFAk508MPTeDmWNF1bv5NoqV23DPZyaFhMw=;
	b=0m/NO+Dwpywd8wZk2fxKz61WqnVUd1Tm6gnjbEvSDo237FDrdQ9hjlZ/OUSdYEIHwtQY
	 tdNrBuXg1TPs3pmngQctSHLWBP2fEtnJCj+sFZfhi5fAEpE+a7iEixEAhK0/ArKKvOchq
	 82xvBZutFkCbUma9HmHTZX4Jg7V7ke/1nj3eWn1TBpwGZzWSB+229BJgqWsE51i2SM0Te
	 lJdaTFU4DJ5TQ1vEOc2Sj630Kubdy+bDGH0YnZkZPT4dEuAb1KahQa2LeaiVR/2M3aeOA
	 OnW67gRPhBDMuWuQ4jmjPFbdF3s63aHYFFkFQS780SjoQ6A3oInOY7ddcll9ZaqZ3Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0F1dvXo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4FE606A31E;
	Thu, 26 Nov 2026 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0F1dvXo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446AF1F00A03;
	Thu, 26 Nov 2026 11:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691816;
	bh=/joh9LYYtFAk508MPTeDmWNF1bv5NoqV23DPZyaFhMw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=M0F1dvXoUExr4F9nBSfhMX1FI+ggjPL2FV636MxhU5/uw+s8CVJmcZrapiJ08aojR
	 A9p9cNfVVScZf3tX+EhfPkX69q9GEC7HAXM7a2jKMPL4gxPJeDexttYgMtp5wVOCpH
	 Ee+FNPGtArX7IUdZBaHnkcwkVuiqbwKol7/gqk7wdWS9iRplveTGVe0Ek+QZx3P3I6
	 QEilAO3kIEM3eKXEve6hi0oSYd/CyS938BDYh2HoedWMWjDCUhOE31ZFcyaV/jMfMT
	 OV5FKVPdeZmXAygPKHVm+bGAD2WJxWCsWEjnXUGYRfqg0WhmqZmsG9jQZrhlBDHHWe
	 rFoUqe6s11ckQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:28 +0200
Subject: [PATCH RFC v2 15/54] x86/mm/pat: look up the effective NX/RW bits
 in verify_rwx()
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-15-723f1e33c3d8@kernel.org>
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

Every CPA lookup collects the effective NX and RW bits of the upper page
table levels. Only verify_rwx() needs them, and only when a mapping is
about to become both writable and executable.

Walk the page tables in verify_rwx() after its early exits and let the CPA
lookups return just the entry and its level. Add cpa_pgd() that picks the
page table of the request, to avoid code duplication.

Such a lookup does not depend on the x86 page table format. It will move to
the generic code together with the rest of CPA core logic.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 51 ++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 9dfe69d608b8..8d481e9edf75 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -307,6 +307,14 @@ static inline unsigned long fix_addr(unsigned long addr)
 #endif
 }
 
+static pgd_t *cpa_pgd(struct cpa_data *cpa, unsigned long address)
+{
+	if (!cpa->pgd)
+		return pgd_offset_k(address);
+
+	return cpa->pgd + pgd_index(address);
+}
+
 static unsigned long __cpa_addr(struct cpa_data *cpa, unsigned long idx)
 {
 	return cpa->addr + idx * PAGE_SIZE;
@@ -688,11 +696,14 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
 /*
  * Validate strict W^X semantics.
  */
-static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long start,
-				  unsigned long pfn, unsigned long npg,
-				  bool nx, bool rw)
+static inline pgprot_t verify_rwx(struct cpa_data *cpa, pgprot_t old,
+				  pgprot_t new, unsigned long start,
+				  unsigned long pfn, unsigned long npg)
 {
+	unsigned int level;
 	unsigned long end;
+	bool nx, rw;
+	pgd_t *pgd;
 
 	/*
 	 * 32-bit has some unfixable W+X issues, like EFI code
@@ -712,6 +723,13 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 	if ((pgprot_val(new) & (_PAGE_RW | _PAGE_NX)) != _PAGE_RW)
 		return new;
 
+	/*
+	 * Only a mapping about to become W+X pays for the second walk that
+	 * collects the effective NX and RW bits of the upper levels.
+	 */
+	pgd = cpa_pgd(cpa, start);
+	lookup_address_in_pgd_attr(pgd, start, &level, &nx, &rw);
+
 	/* Non-leaf translation entries can disable writing or execution. */
 	if (!rw || nx)
 		return new;
@@ -825,16 +843,11 @@ pte_t *lookup_address(unsigned long address, unsigned int *level)
 EXPORT_SYMBOL_GPL(lookup_address);
 
 static pte_t *_lookup_address_cpa(struct cpa_data *cpa, unsigned long address,
-				  unsigned int *level, bool *nx, bool *rw)
+				  unsigned int *level)
 {
-	pgd_t *pgd;
+	pgd_t *pgd = cpa_pgd(cpa, address);
 
-	if (!cpa->pgd)
-		pgd = pgd_offset_k(address);
-	else
-		pgd = cpa->pgd + pgd_index(address);
-
-	return lookup_address_in_pgd_attr(pgd, address, level, nx, rw);
+	return lookup_address_in_pgd(pgd, address, level);
 }
 
 /*
@@ -966,7 +979,6 @@ static int should_split_large_page(pte_t *kpte, unsigned long address,
 	pgprot_t old_prot, new_prot, req_prot, chk_prot;
 	pte_t new_pte, *tmp;
 	enum pg_level level;
-	bool nx, rw;
 
 	if (cpa->flags & CPA_REQ_SPLIT)
 		return 1;
@@ -975,7 +987,7 @@ static int should_split_large_page(pte_t *kpte, unsigned long address,
 	 * Check for races, another CPU might have split this page
 	 * up already:
 	 */
-	tmp = _lookup_address_cpa(cpa, address, &level, &nx, &rw);
+	tmp = _lookup_address_cpa(cpa, address, &level);
 	if (tmp != kpte)
 		return 1;
 
@@ -1086,8 +1098,8 @@ static int should_split_large_page(pte_t *kpte, unsigned long address,
 	new_prot = static_protections(req_prot, lpaddr, old_pfn, numpages,
 				      psize, CPA_DETECT);
 
-	new_prot = verify_rwx(old_prot, new_prot, lpaddr, old_pfn, numpages,
-			      nx, rw);
+	new_prot = verify_rwx(cpa, old_prot, new_prot, lpaddr, old_pfn,
+			      numpages);
 
 	/*
 	 * If there is a conflict, split the large page.
@@ -1153,14 +1165,13 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	struct page *base = virt_to_page(pbase);
 	unsigned int i, level;
 	pgprot_t ref_prot;
-	bool nx, rw;
 	pte_t *tmp;
 
 	/*
 	 * Check for races, another CPU might have split this page
 	 * up for us already:
 	 */
-	tmp = _lookup_address_cpa(cpa, address, &level, &nx, &rw);
+	tmp = _lookup_address_cpa(cpa, address, &level);
 	if (tmp != kpte)
 		return 1;
 
@@ -1866,11 +1877,10 @@ static int __change_page_attr(struct cpa_data *cpa)
 	int do_split, err;
 	unsigned int level;
 	pte_t *kpte, old_pte;
-	bool nx, rw;
 
 	address = __cpa_addr(cpa, cpa->curpage);
 repeat:
-	kpte = _lookup_address_cpa(cpa, address, &level, &nx, &rw);
+	kpte = _lookup_address_cpa(cpa, address, &level);
 	if (!kpte)
 		return __cpa_process_fault(cpa, address);
 
@@ -1892,8 +1902,7 @@ static int __change_page_attr(struct cpa_data *cpa)
 		new_prot = static_protections(new_prot, address, pfn, 1, 0,
 					      CPA_PROTECT);
 
-		new_prot = verify_rwx(old_prot, new_prot, address, pfn, 1,
-				      nx, rw);
+		new_prot = verify_rwx(cpa, old_prot, new_prot, address, pfn, 1);
 
 		new_prot = pgprot_clear_protnone_bits(new_prot);
 

-- 
2.53.0

