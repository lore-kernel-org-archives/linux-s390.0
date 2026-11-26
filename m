Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691911;
	b=e9+nRVB0K5LK6OVkSfyyPKqsY4ThhZ6Kc41TFYtD77MPJUxFwjt5ORWGFkB4JobS58Ak
	 ny605AqXB2rVMOzI9F2FBtVZaks4gQzCNCrGszgu2E3rn4Dl1ObCJn18C/0Ov9KP1YObR
	 sCvDv9qsL3nAQvCD90kR8fEKp9vxlPS8MzXxMe9DAYxwg33OoruwgoMqKBOu2fwqmUjj+
	 cK0OHUPm6qtASU0kVyqDbyDO6RJLMcQ/VvSaV1j38L9BibH/AyCwlhfAmIBG8RU9l4jpz
	 tUsPNKAuO/88ZnqzOBGQCmxc7ulET8C9DnylkQKJ+eglr5Qv2b56iMvCTzzBiwNa/XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691911;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=kg22a2UjYNlx3KcEJrs5W+VCDk/0O6wvkANb+XJaCbg=;
	b=AJAXKOKigd54XbZhyBbR3M+tQMPcK08kGswU4qLy1p8DurEM2yue6CAwwk5Vzw11NI2D
	 GsD+qqUj2jtQK4go1x1KKsyvAY8UYunH9xJlbEnONi7LGc9vlv8qJentl4C7O27qK6r89
	 BEXS1jLmfI9B9JwQVpCLF5WppRJxpKAccmVTlBvsuyc0WBYajYBkWU88tx6Yvixx6ZEb+
	 heoVeh8KnXlm8WRaQIa54bKCYHaL0BLsGa/KR4G5lUx+P0xNPakOpOUypnaNz9ANqu3kg
	 VNR+IE0/839SsQRndNp9D2eCvufj68OSTdwolxIsFlyapdyvgIR2CdHlhLnSth5rQxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1VVpJka;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F94E606A31E;
	Thu, 26 Nov 2026 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1VVpJka
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CEE1F000C6;
	Thu, 26 Nov 2026 11:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691911;
	bh=kg22a2UjYNlx3KcEJrs5W+VCDk/0O6wvkANb+XJaCbg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=U1VVpJka7QLxUE4YaYREp3+OZWOG8ko4HiNqynewu4AeFyUfHQhn7brmfvorU4jMj
	 o0uUS0QKMHz7GfMKQUvJ//XlEAtzumhJGgjIerOXA4rAWfrjf94Lowsrzo2OyspNRk
	 DVyvxbUGMXY0K3/SOKAXMB1cBBC2Z/1CexvNi+4DB8g4a3/OjW2gS8R85cVmvy+69O
	 qZUhYEGVTvL2AxEnooJqUb6ERwdNe/eEjnNDxMWp5QYBqFBgbBXumoo1jNxHCpRuXl
	 WfdpzZtlXFLcqOaW/kvqMfWLQkJEJileeskY9GGqfARZEurJKKDSbEPqrmKJnQ8b4h
	 uPm1ZG1WRQisA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:38 +0200
Subject: [PATCH RFC v2 25/54] x86/mm/pat: add cpa_is_direct_map()
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-25-723f1e33c3d8@kernel.org>
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

CPA open codes the direct map range check in five places, and the generic
CPA core will need the same check.

Move the check to cpa_is_direct_map().

No functional change.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index f4d3e2d9c3c9..cbbc51be4de7 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -245,6 +245,12 @@ within(unsigned long addr, unsigned long start, unsigned long end)
 	return addr >= start && addr < end;
 }
 
+static inline bool cpa_is_direct_map(unsigned long addr)
+{
+	return within(addr, PAGE_OFFSET,
+		      PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT));
+}
+
 #ifdef CONFIG_X86_64
 
 static inline int
@@ -1224,8 +1230,7 @@ __split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf, pte_t *pbase)
 	for (i = 0; i < PTRS_PER_PTE; i++, pfn += pfninc)
 		set_pte(pbase + i, cpa_pte(level - 1, pfn, prot));
 
-	if (within(address, PAGE_OFFSET,
-		   PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT)))
+	if (cpa_is_direct_map(address))
 		split_page_count(level);
 
 	/*
@@ -1375,8 +1380,7 @@ static int collapse_pmd_page(pmd_t *pmd, unsigned long addr,
 		}
 	}
 
-	if (within(addr, PAGE_OFFSET,
-		   PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT)))
+	if (cpa_is_direct_map(addr))
 		collapse_page_count(PGTABLE_LEVEL_PMD);
 
 	return 1;
@@ -1423,8 +1427,7 @@ static int collapse_pud_page(pud_t *pud, unsigned long addr,
 	list_add(&page_ptdesc(pud_page(*pud))->pt_list, pgtables);
 	set_pud(pud, pfn_pud(pfn, pmd_pgprot(first)));
 
-	if (within(addr, PAGE_OFFSET,
-		   PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT)))
+	if (cpa_is_direct_map(addr))
 		collapse_page_count(PGTABLE_LEVEL_PUD);
 
 	return 1;
@@ -1887,8 +1890,7 @@ static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr)
 	 * one virtual address page and its pfn. TBD: numpages can be set based
 	 * on the initial value and the level returned by lookup_address().
 	 */
-	if (within(vaddr, PAGE_OFFSET,
-		   PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT))) {
+	if (cpa_is_direct_map(vaddr)) {
 		cpa->numpages = 1;
 		cpa->pfn = __pa(vaddr) >> PAGE_SHIFT;
 		return 0;
@@ -1977,8 +1979,7 @@ static int cpa_process_alias(struct cpa_data *cpa)
 	 * mapping already:
 	 */
 	vaddr = __cpa_addr(cpa, cpa->curpage);
-	if (!(within(vaddr, PAGE_OFFSET,
-		    PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT)))) {
+	if (!cpa_is_direct_map(vaddr)) {
 
 		alias_cpa = *cpa;
 		alias_cpa.addr = (unsigned long)__va(cpa->pfn << PAGE_SHIFT);

-- 
2.53.0

