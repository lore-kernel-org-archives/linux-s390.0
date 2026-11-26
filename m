Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691826;
	b=3qImchRbS529s0b3S+C5vtNQtNvtfQGjIsSy6i2V8djKOuI75pMlI+ez15BKOvj3GKdd
	 39VXonGP74G63x92bX5sVEzzhgISUzb9y2Aos2LXZv755Dz+C/2L41h4VFlom6bfUloJB
	 66O0hG5+QyShpDt9LNvEyn4XiWlFTZp8B+XIgCcwc+RfnX+RvK31EDWQxgW2Wmr7cMAAs
	 GACOR2ZrDF/ZC9/N+nLLDSgaLwE2IV2QTE9nSZRxHLFoGyg/asUr0EtSdzIz8ZMf8T63H
	 rWaDKDIG24MZZqUjLmFq/NdmXRaGZZrOFVgHSdUrUT+tMEOsUFn5fmpWKKSsU8kfnXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691826;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=1qwpULvuAWXJZ83/2tVfvAzpASrXdkB8r3lEsMJ0zjs=;
	b=DuuQN6o3xrTx6Mb4R+7IhlEJi7XWCNwi5A53e34yjOlnka0/i8VBEpTxW6h0j5RQY0dC
	 dTyJLUP+XdyNZwauCiBnTf48E4chnPhhV3iuSjlAix+Xn1M1D0j3mQb8Yyx5rSUwZ0Zcj
	 b6gwYmTs8TbdMQBragW5Hfp+rAIqmwIOPt2AAu6t+XFcQXHh3KaYYNY78I//MQ5gIzZys
	 1IXaTA1xh12qw3dvOSB/+VsDBqiPjc4GCTyFvNfiwT32HtlpUGnjxJSlnAajcDW51TFYC
	 ELDGgeZIi9TXqWMJt9n6Cahs1gLAkoIEeZsw5joiI6h9gdZq9F4INF783LUcfj8oSRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oLg2Fff7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B572606A31E;
	Thu, 26 Nov 2026 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oLg2Fff7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CDD1F000D2;
	Thu, 26 Nov 2026 11:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691826;
	bh=1qwpULvuAWXJZ83/2tVfvAzpASrXdkB8r3lEsMJ0zjs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oLg2Fff7b+2GZ35KNT50QSRRomdqr8XgASiLEKyHKcac4W/Z1CMbzv01oYlWouSwC
	 GxPtD3s5R8ZiYTXm7tUz7i//000wVVRYmBxIYQ5mRZB6e1yGLe+AMAw6uJOrbnfiQC
	 Q55lylf44P0449CTFHdGj2JrUw8UjP5jyEbE3phSOC1zaT2sYm+q7CCmJtSHfdyVxN
	 AHtzkEI4zwJ57R7nz9tV9R6oWmucQGl/oMN22NQJFfgfwOyAnRykXq5wW/tk6kslhj
	 a1va0BC8LTJjIG7RQ2u718+g+LISZw+RMvuGfzbOzBTBwzwm/MKm72KcheaaCEpTER
	 R/87hS5fS97Zg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:29 +0200
Subject: [PATCH RFC v2 16/54] x86/mm/pat: look up a large page again only
 after dropping cpa_lock
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-16-723f1e33c3d8@kernel.org>
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

should_split_large_page() and __split_large_page() both look up the address
again to check whether another CPU split the large page after the previous
lookup.

In should_split_large_page() this cannot happen, because cpa_lock is held
from the lookup in __change_page_attr() to the check.

split_large_page() drops cpa_lock to allocate a page table, so the check is
needed there.

Drop the lookup from should_split_large_page() and pass it the level that
__change_page_attr() found.

Move the lookup from __split_large_page() to split_large_page(), right
after it retakes cpa_lock, and pass the level down.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 48 ++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 8d481e9edf75..967d691ef1c0 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -973,24 +973,15 @@ static pgprot_t pgprot_clear_protnone_bits(pgprot_t prot)
 }
 
 static int should_split_large_page(pte_t *kpte, unsigned long address,
-				   struct cpa_data *cpa)
+				   enum pg_level level, struct cpa_data *cpa)
 {
 	unsigned long numpages, pmask, psize, lpaddr, pfn, old_pfn;
 	pgprot_t old_prot, new_prot, req_prot, chk_prot;
-	pte_t new_pte, *tmp;
-	enum pg_level level;
+	pte_t new_pte;
 
 	if (cpa->flags & CPA_REQ_SPLIT)
 		return 1;
 
-	/*
-	 * Check for races, another CPU might have split this page
-	 * up already:
-	 */
-	tmp = _lookup_address_cpa(cpa, address, &level);
-	if (tmp != kpte)
-		return 1;
-
 	switch (level) {
 	case PG_LEVEL_2M:
 		old_prot = pmd_pgprot(*(pmd_t *)kpte);
@@ -1159,21 +1150,12 @@ static void split_set_pte(struct cpa_data *cpa, pte_t *pte, unsigned long pfn,
 
 static int
 __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
-		   pte_t *pbase)
+		   unsigned int level, pte_t *pbase)
 {
 	unsigned long lpaddr, lpinc, ref_pfn, pfn, pfninc = 1;
 	struct page *base = virt_to_page(pbase);
-	unsigned int i, level;
 	pgprot_t ref_prot;
-	pte_t *tmp;
-
-	/*
-	 * Check for races, another CPU might have split this page
-	 * up for us already:
-	 */
-	tmp = _lookup_address_cpa(cpa, address, &level);
-	if (tmp != kpte)
-		return 1;
+	unsigned int i;
 
 	paravirt_alloc_pte(&init_mm, page_to_pfn(base));
 
@@ -1257,8 +1239,9 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 			    unsigned long address)
 {
+	unsigned int level;
 	pte_t *pte;
-	int ret;
+	int ret = 0;
 
 	spin_unlock(&cpa_lock);
 	pte = pte_alloc_one_kernel(&init_mm);
@@ -1266,13 +1249,22 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 	if (!pte)
 		return -ENOMEM;
 
-	ret = __split_large_page(cpa, kpte, address, pte);
+	/*
+	 * Check for races, another CPU might have split this page
+	 * up for us already:
+	 */
+	if (_lookup_address_cpa(cpa, address, &level) != kpte)
+		goto out;
+
+	ret = __split_large_page(cpa, kpte, address, level, pte);
 	if (ret)
-		pte_free_kernel(&init_mm, pte);
-	if (ret < 0)
-		return ret;
+		goto out;
 
 	return 0;
+
+out:
+	pte_free_kernel(&init_mm, pte);
+	return ret;
 }
 
 static int collapse_pmd_page(pmd_t *pmd, unsigned long addr,
@@ -1928,7 +1920,7 @@ static int __change_page_attr(struct cpa_data *cpa)
 	 * Check, whether we can keep the large page intact
 	 * and just change the pte:
 	 */
-	do_split = should_split_large_page(kpte, address, cpa);
+	do_split = should_split_large_page(kpte, address, level, cpa);
 	/*
 	 * When the range fits into the existing large page,
 	 * return. cp->numpages and cpa->tlbflush have been updated in

-- 
2.53.0

