Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692036;
	b=QkhlZ77H3iwotYsGC3yCBUk4pzSPjmEpzmBTuDv1/6MhuAMhtj8ckXTaFs28rDmCSwyz
	 luxX9YMcxEpSCDH986DwTRT9ANrdECsgYYz6fteyQV8m/C6kUF1D2VWm2mWWpeYNnzpPv
	 3C/5WlgA7nGJTM5KPC/KSG9wcqsJaKRneJz9Nx0qg7wjq+kyY78vga+fWJPVf8CCf6NxV
	 OorkXP/s9KF5/DacfacErAnTct8aRa3TOwRquK7Y9VxcY2pBvRKLeUJZRGblDU4T41xw5
	 M6mlFTOvctVWadyH2vDWJ9oPIfUoa8xVsM1TULAXGuifkcceh5feiw5aH3xsJiyfqzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692036;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=rM4+cSkBP6X510/nTqJRrow0GCDm2EsnlCpLERs/6as=;
	b=x8uAty7UdzsiaeZ6kWLkcIWedOGtQ1pBGpvNabrPStwC9HCtiXPom1mFqxHjO6pm2jFK
	 NyXDIG3r45n5/ga1qQoCaLRfYfflu9yygZhHmcJ2SxFq+ySnsSWN1kiz5q3YV32eMi1Hp
	 rLp5WXzAZ1QmIVBCRIImyY8+rmCR+nZ7rY85WhB5p1+KXwYDnizYeGW+gHRDY2N1Y+Y8n
	 F3aVulUfr/zQDxcyT46/cFLqrDVZ9TsWX5WkbnMaIBGlIjvfl9rQqxkFbM9+axweW6a1+
	 nkABTQ3eV2dmAX3XaJduvMt5yYNJLOYjR+RadSbYL/u2XD7Puw7oNq9bn5BW27DY0aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kx1Ab6qc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AAA606A33E;
	Thu, 26 Nov 2026 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kx1Ab6qc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E567B1F000C4;
	Thu, 26 Nov 2026 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692035;
	bh=rM4+cSkBP6X510/nTqJRrow0GCDm2EsnlCpLERs/6as=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kx1Ab6qcUM54KkRHDXzVtjMBXuOGt7snMFzSHdZ1b+HJhSZECrTxp+suhOQIt05g8
	 ulPmTyAEzO4hD9Ksq3FP/lBfAG0GX3OSIuJUGLtsmT/CJyQNAPUaAFCgsP4m+6oFjR
	 Ji37csI6i2qNNeSvLjaR3D5hcSPiZUbUkK6vvXbTtxl1JjVIa4eHvVFsfTlpvVJCrl
	 tA4ItitFRfmXoZROL1Pe+z85u0flpuI5rw+XvECSxELuxJdBKYYJNObc4IuioomJLf
	 xMxc6AEhf6CPOk0lTAC7OJsOyG9QxzRrmH4CZOpr+pFhI9qGci+fadxeBxhmr+g7Ww
	 yG7EIx3Ocf//A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:51 +0200
Subject: [PATCH RFC v2 38/54] mm/pageattr: let a leaf cover a contiguous
 block of entries
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-38-723f1e33c3d8@kernel.org>
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

Some architectures map a naturally aligned range with a block of adjacent
entries that the TLB may cache as a single translation: the 16K, 512K and
8M pages of powerpc 8xx, Svnapot on riscv and the contiguous bit of arm64.

The entries of such a block have to change together, or the block has to be
broken up first, exactly like a large page.

Let arch_cpa_decode_leaf() extend a leaf to the whole block, so that the
core keeps the block when a request covers it entirely and splits it
otherwise.

Breaking up a block only rewrites its entries and it does not need to
allocate new page table page, so the core can call arch_cpa_split_leaf()
without dropping cpa_lock.

Update the CPA statistics so that they count contiguous blocks separately
from large pages and single PTEs.

The block counters stay at zero on architectures without blocks.

There are no users yet. powerpc 8xx, riscv and arm64 will use it when they
switch to the core.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/pageattr.c | 79 ++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 23 deletions(-)

diff --git a/mm/pageattr.c b/mm/pageattr.c
index 852e0989dac9..2f357a8c24d2 100644
--- a/mm/pageattr.c
+++ b/mm/pageattr.c
@@ -94,39 +94,63 @@ void cpa_report_meminfo(struct seq_file *m, unsigned long levels)
 
 #ifdef CONFIG_CPA_STATISTICS
 
-static unsigned long cpa_checked[PGTABLE_LEVEL_NUM];
-static unsigned long cpa_sameprot[PGTABLE_LEVEL_NUM];
-static unsigned long cpa_preserved[PGTABLE_LEVEL_NUM];
+struct cpa_stats {
+	unsigned long	checked;
+	unsigned long	sameprot;
+	unsigned long	preserved;
+};
+
+/* Large pages and contiguous blocks, by the level of their entries */
+static struct cpa_stats cpa_pages[PGTABLE_LEVEL_NUM];
+static struct cpa_stats cpa_blocks[PGTABLE_LEVEL_NUM];
 
-static inline void cpa_inc_pxd_checked(enum pgtable_level level)
+static struct cpa_stats *cpa_leaf_stats(const struct cpa_leaf *leaf)
 {
-	cpa_checked[level]++;
+	if (leaf->size != pgtable_level_size(leaf->level))
+		return &cpa_blocks[leaf->level];
+
+	return &cpa_pages[leaf->level];
+}
+
+static inline void cpa_inc_checked(const struct cpa_leaf *leaf)
+{
+	cpa_leaf_stats(leaf)->checked++;
 }
 
 static inline void cpa_inc_pte_install(void)
 {
-	cpa_checked[PGTABLE_LEVEL_PTE]++;
+	cpa_pages[PGTABLE_LEVEL_PTE].checked++;
 }
 
-static inline void cpa_inc_pxd_sameprot(enum pgtable_level level)
+static inline void cpa_inc_sameprot(const struct cpa_leaf *leaf)
 {
-	cpa_sameprot[level]++;
+	cpa_leaf_stats(leaf)->sameprot++;
 }
 
-static inline void cpa_inc_pxd_preserved(enum pgtable_level level)
+static inline void cpa_inc_preserved(const struct cpa_leaf *leaf)
 {
-	cpa_preserved[level]++;
+	cpa_leaf_stats(leaf)->preserved++;
 }
 
 static void cpastats_show_level(struct seq_file *m, enum pgtable_level level)
 {
+	struct cpa_stats *s = &cpa_pages[level];
 	char sz[20];
 
 	cpa_size_str(level, sz, sizeof(sz));
-	seq_printf(m, "%s pages checked:     %16lu\n", sz, cpa_checked[level]);
-	seq_printf(m, "%s pages sameprot:    %16lu\n", sz, cpa_sameprot[level]);
-	seq_printf(m, "%s pages preserved:   %16lu\n", sz,
-		   cpa_preserved[level]);
+	seq_printf(m, "%s pages checked:     %16lu\n", sz, s->checked);
+	seq_printf(m, "%s pages sameprot:    %16lu\n", sz, s->sameprot);
+	seq_printf(m, "%s pages preserved:   %16lu\n", sz, s->preserved);
+}
+
+static void cpastats_show_blocks(struct seq_file *m, enum pgtable_level level)
+{
+	const char *name = pgtable_level_to_str(level);
+	struct cpa_stats *s = &cpa_blocks[level];
+
+	seq_printf(m, "%s blocks checked:   %16lu\n", name, s->checked);
+	seq_printf(m, "%s blocks sameprot:  %16lu\n", name, s->sameprot);
+	seq_printf(m, "%s blocks preserved: %16lu\n", name, s->preserved);
 }
 
 static int cpastats_show(struct seq_file *m, void *p)
@@ -137,7 +161,9 @@ static int cpastats_show(struct seq_file *m, void *p)
 	cpastats_show_level(m, PGTABLE_LEVEL_PMD);
 	seq_printf(m, "%s pages set-checked: %16lu\n",
 		   cpa_size_str(PGTABLE_LEVEL_PTE, sz, sizeof(sz)),
-		   cpa_checked[PGTABLE_LEVEL_PTE]);
+		   cpa_pages[PGTABLE_LEVEL_PTE].checked);
+	cpastats_show_blocks(m, PGTABLE_LEVEL_PMD);
+	cpastats_show_blocks(m, PGTABLE_LEVEL_PTE);
 	return 0;
 }
 
@@ -160,10 +186,10 @@ static int __init cpa_stats_init(void)
 }
 late_initcall(cpa_stats_init);
 #else
-static inline void cpa_inc_pxd_checked(enum pgtable_level level) { }
+static inline void cpa_inc_checked(const struct cpa_leaf *leaf) { }
 static inline void cpa_inc_pte_install(void) { }
-static inline void cpa_inc_pxd_sameprot(enum pgtable_level level) { }
-static inline void cpa_inc_pxd_preserved(enum pgtable_level level) { }
+static inline void cpa_inc_sameprot(const struct cpa_leaf *leaf) { }
+static inline void cpa_inc_preserved(const struct cpa_leaf *leaf) { }
 #endif
 
 static pte_t *cpa_lookup_in_pgd(pgd_t *pgdp, unsigned long address,
@@ -253,10 +279,10 @@ static int should_split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf)
 	if (cpa->flags & CPA_REQ_SPLIT)
 		return 1;
 
-	if (level != PGTABLE_LEVEL_PMD && level != PGTABLE_LEVEL_PUD)
+	if (level > PGTABLE_LEVEL_PUD)
 		return -EINVAL;
 
-	cpa_inc_pxd_checked(level);
+	cpa_inc_checked(leaf);
 
 	/*
 	 * Calculate the number of pages, which fit into this large
@@ -284,7 +310,7 @@ static int should_split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf)
 	 * range.
 	 */
 	if (pgprot_val(req_prot) == pgprot_val(old_prot)) {
-		cpa_inc_pxd_sameprot(level);
+		cpa_inc_sameprot(leaf);
 		return 0;
 	}
 
@@ -307,7 +333,7 @@ static int should_split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf)
 	/* All checks passed. Update the large page mapping. */
 	arch_cpa_modify_leaf(leaf, new_prot);
 	cpa->state |= CPA_ST_FLUSHTLB;
-	cpa_inc_pxd_preserved(level);
+	cpa_inc_preserved(leaf);
 	return 0;
 }
 
@@ -319,6 +345,13 @@ static int split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf)
 	void *table;
 	int ret = 0;
 
+	/*
+	 * A block of entries is broken up in place, without a page table and
+	 * without dropping cpa_lock.
+	 */
+	if (leaf->size != pgtable_level_size(leaf->level))
+		return arch_cpa_split_leaf(cpa, leaf, NULL);
+
 	spin_unlock(&cpa_lock);
 	table = arch_cpa_alloc_pgtable(leaf);
 	spin_lock(&cpa_lock);
@@ -389,7 +422,7 @@ static int __change_page_attr(struct cpa_data *cpa)
 	if (!cpa_lookup(cpa, address, &leaf))
 		return arch_cpa_process_fault(cpa);
 
-	if (leaf.level == PGTABLE_LEVEL_PTE) {
+	if (leaf.size == PAGE_SIZE) {
 		pgprot_t new_prot;
 		unsigned long pfn = leaf.pfn;
 

-- 
2.53.0

