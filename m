Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691920;
	b=A4j0T2tRQe8uPyMGOutzfEAPJt3OcVH7GMQ3FyKnspJPYMTyyzMxLx/fRoOmh95S7JkU
	 U0zYs0d6O86cBOqmDwRIJWB6buyJYxuPfI69Y0wGAh0txmdUiimHH6TLMXiK9M7O1pGJz
	 YuAn3WwKU/y1aKb0UGrH58itwUGCslbQCSPkQX1n+IWU8JIQGCEejosk00YhPUTm0YxHs
	 wYZfNdhFIwSnRZRO28r08eRHkbUdCj0uhJC25zyFOpNIUiq9w6WCi17Bqv3qqtasEREzY
	 FRAQp2pq9MsCz2wsJYuRRDfpJHxG1XFcMFSYE/l+17SIGB933AM/z5ZlDlAubQuKfEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691920;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=ktJ4sBRXGqvJMbIXWYsuN6usspS+V4heWNTrcbuxgIc=;
	b=Qq1F7FpjyYM+T/ggXs/7WWx/kfhsCkf2ek58PZyNPmeNWQ6xQhnHA9KXpi7BodLwSjvk
	 xUdPP+ojHKAzLPi63fjZ6+3S8MyxO250xA9vlj8zzfDV0lSapGOabEvkqyPy3XTu2rfxE
	 Vd1ecdJMTnUMEQYSAUuF5SycTcfNpf4ZFCJfyv7jJwaj7QkGX8d7MV05RXCRyeVJwxotX
	 s3s9YKoej9EYcct6rBJTp1qnYHWmpgzV/X4no0ANaPIRQN4Yt7IYYQctVYYDdS0ubT4my
	 5QzXrVe+bqBYurp/YqU2azwExauGKlX4hM01a6eL2t+CEAb1vP/CJ8czR7vHk5txqQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Bn5mKTE/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0215606A31C;
	Thu, 26 Nov 2026 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bn5mKTE/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6DB1F00A3C;
	Thu, 26 Nov 2026 11:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691920;
	bh=ktJ4sBRXGqvJMbIXWYsuN6usspS+V4heWNTrcbuxgIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Bn5mKTE/VKF0HJEEoCN0Lbpnlc3goN5OBDOvDBpKdffqcM+AUpAHhRIM6xAf6UuPq
	 288ZdRDBV8joQHv1fPm2LkZ2YM4GN52DDLnOGbi33khOgCJhf31P39Zk7Br47p2A9f
	 YT8TicuEe2cXONCKMBJbUEy3C6k9jptyndArWLGucL6L+G0fZ585921z2saIBKMJDq
	 v+PQ6T0GU09nZ3Ght95fzc1ZloiDWK/J9zRlxnBRd4gZLdNYL3e0uv1lAsyRFXIo3a
	 RnTkrQeImkHiGHyirJdrhR7AqsaXVb2A0dVsGEMw9fonvAGasUOHAfgurGffcuU10F
	 MfilxsToEh6bQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:39 +0200
Subject: [PATCH RFC v2 26/54] x86/mm/pat: implement set_memory_*() with a
 table of operations
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-26-723f1e33c3d8@kernel.org>
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

Every architecture that implements set_memory_*() and
set_direct_map_*_noflush() has a function for each operation, and the
functions differ only in the masks they pass to the page table walk. s390
and powerpc already translate an operation to masks in one place.

These entry points are going to become generic, with the masks of each
operation provided by the architecture.

Describe the operations of x86 in a table of masks and request flags, and
implement set_memory_*() and set_direct_map_*_noflush() with a single
function that takes the request from the table.

No functional change.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 136 ++++++++++++++++++++++++++++---------------
 1 file changed, 88 insertions(+), 48 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index cbbc51be4de7..08dc69317931 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2392,42 +2392,98 @@ int clear_mce_nospec(unsigned long pfn)
 EXPORT_SYMBOL_GPL(clear_mce_nospec);
 #endif /* CONFIG_X86_64 */
 
-int set_memory_x(unsigned long addr, int numpages)
+enum cpa_op {
+	CPA_OP_RO,
+	CPA_OP_RW,
+	CPA_OP_X,
+	CPA_OP_NX,
+	CPA_OP_ROX,
+	CPA_OP_DIRECT_MAP_INVALID,
+	CPA_OP_DIRECT_MAP_DEFAULT,
+	CPA_OP_NR
+};
+
+struct cpa_op_prot {
+	pgprot_t	set;
+	pgprot_t	clr;
+	unsigned int	req;
+};
+
+static const struct cpa_op_prot cpa_ops[CPA_OP_NR] = {
+	[CPA_OP_RO]	= { .clr = __pgprot(_PAGE_RW | _PAGE_DIRTY) },
+	[CPA_OP_RW]	= { .set = __pgprot(_PAGE_RW) },
+	[CPA_OP_X]	= { .clr = __pgprot(_PAGE_NX) },
+	[CPA_OP_NX]	= { .set = __pgprot(_PAGE_NX) },
+	[CPA_OP_ROX] = {
+		.clr = __pgprot(_PAGE_RW | _PAGE_DIRTY | _PAGE_NX),
+		.req = CPA_REQ_COLLAPSE,
+	},
+	[CPA_OP_DIRECT_MAP_INVALID] = {
+		.clr = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY),
+	},
+	[CPA_OP_DIRECT_MAP_DEFAULT] = {
+		.set = __pgprot(_PAGE_PRESENT | _PAGE_RW),
+	},
+};
+
+static void cpa_init_op(struct cpa_data *cpa, const struct cpa_op_prot *prot)
 {
-	if (!(__supported_pte_mask & _PAGE_NX))
-		return 0;
+	cpa->mask_set = prot->set;
+	cpa->mask_clr = prot->clr;
+	cpa->flags |= prot->req;
+}
+
+static int arch_cpa_prepare(struct cpa_data *cpa, enum cpa_op op)
+{
+	cpa_init_op(cpa, &cpa_ops[op]);
 
-	return change_page_attr_clear(addr, numpages, __pgprot(_PAGE_NX));
+	if (!(__supported_pte_mask & _PAGE_NX)) {
+		pgprot_val(cpa->mask_set) &= ~_PAGE_NX;
+		pgprot_val(cpa->mask_clr) &= ~_PAGE_NX;
+	}
+
+	return 0;
 }
 
-int set_memory_nx(unsigned long addr, int numpages)
+static int set_memory_op(unsigned long addr, int numpages, enum cpa_op op)
 {
-	if (!(__supported_pte_mask & _PAGE_NX))
-		return 0;
+	struct cpa_data cpa = {
+		.addr = addr,
+		.numpages = numpages,
+	};
+	int ret;
+
+	ret = arch_cpa_prepare(&cpa, op);
+	if (ret)
+		return ret;
 
-	return change_page_attr_set(addr, numpages, __pgprot(_PAGE_NX));
+	return change_page_attr_set_clr(addr, numpages, cpa.mask_set,
+					cpa.mask_clr, cpa.flags);
 }
 
-int set_memory_ro(unsigned long addr, int numpages)
+int set_memory_x(unsigned long addr, int numpages)
 {
-	return change_page_attr_clear(addr, numpages,
-				      __pgprot(_PAGE_RW | _PAGE_DIRTY));
+	return set_memory_op(addr, numpages, CPA_OP_X);
 }
 
-int set_memory_rox(unsigned long addr, int numpages)
+int set_memory_nx(unsigned long addr, int numpages)
 {
-	pgprot_t clr = __pgprot(_PAGE_RW | _PAGE_DIRTY);
+	return set_memory_op(addr, numpages, CPA_OP_NX);
+}
 
-	if (__supported_pte_mask & _PAGE_NX)
-		clr.pgprot |= _PAGE_NX;
+int set_memory_ro(unsigned long addr, int numpages)
+{
+	return set_memory_op(addr, numpages, CPA_OP_RO);
+}
 
-	return change_page_attr_set_clr(addr, numpages, __pgprot(0), clr,
-					CPA_REQ_COLLAPSE);
+int set_memory_rox(unsigned long addr, int numpages)
+{
+	return set_memory_op(addr, numpages, CPA_OP_ROX);
 }
 
 int set_memory_rw(unsigned long addr, int numpages)
 {
-	return change_page_attr_set(addr, numpages, __pgprot(_PAGE_RW));
+	return set_memory_op(addr, numpages, CPA_OP_RW);
 }
 
 int set_memory_np(unsigned long addr, int numpages)
@@ -2692,50 +2748,34 @@ int set_pages_rw(struct page *page, int numpages)
 	return set_memory_rw(addr, numpages);
 }
 
-static int __set_pages_p(struct page *page, int numpages)
+static int set_direct_map(struct page *page, unsigned int nr, enum cpa_op op)
 {
-	struct cpa_data cpa = { .addr = (unsigned long)page_address(page),
-				.pgd = NULL,
-				.numpages = numpages,
-				.mask_set = __pgprot(_PAGE_PRESENT | _PAGE_RW),
-				.mask_clr = __pgprot(0),
-				.flags = CPA_REQ_NO_CHECK_ALIAS };
-
-	/*
-	 * No alias checking needed for setting present flag. otherwise,
-	 * we may need to break large pages for 64-bit kernel text
-	 * mappings (this adds to complexity if we want to do this from
-	 * atomic context especially). Let's keep it simple!
-	 */
-	return __change_page_attr_set_clr(&cpa);
-}
+	struct cpa_data cpa = {
+		.addr = (unsigned long)page_address(page),
+		.numpages = nr,
+		.flags = CPA_REQ_NO_CHECK_ALIAS,
+	};
+	int ret;
 
-static int __set_pages_np(struct page *page, int numpages)
-{
-	struct cpa_data cpa = { .addr = (unsigned long)page_address(page),
-				.pgd = NULL,
-				.numpages = numpages,
-				.mask_set = __pgprot(0),
-				.mask_clr = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY),
-				.flags = CPA_REQ_NO_CHECK_ALIAS };
+	ret = arch_cpa_prepare(&cpa, op);
+	if (ret)
+		return ret;
 
 	/*
-	 * No alias checking needed for setting not present flag. otherwise,
-	 * we may need to break large pages for 64-bit kernel text
-	 * mappings (this adds to complexity if we want to do this from
-	 * atomic context especially). Let's keep it simple!
+	 * set_direct_map_*_noflush() change only the direct map, not its
+	 * aliases.
 	 */
 	return __change_page_attr_set_clr(&cpa);
 }
 
 int set_direct_map_invalid_noflush(struct page *page, unsigned int nr)
 {
-	return __set_pages_np(page, nr);
+	return set_direct_map(page, nr, CPA_OP_DIRECT_MAP_INVALID);
 }
 
 int set_direct_map_default_noflush(struct page *page, unsigned int nr)
 {
-	return __set_pages_p(page, nr);
+	return set_direct_map(page, nr, CPA_OP_DIRECT_MAP_DEFAULT);
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC

-- 
2.53.0

