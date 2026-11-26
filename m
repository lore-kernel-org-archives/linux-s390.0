Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691902;
	b=WeL7GjDOZk4hHbaiY7ioc7ot31XOL3ePmFLar8aiv0ZT15Fq+VkCyGuy3/a2fzPwx1pk
	 K0Xim92KsnKsf6LubqOIfqoHbVAKdsz2HDaZqPebC9097zCBTIwEcK9Yto5QAC1Q5Bpwc
	 kbuX4bZALv7juyvFxfkgf79GBnF3TAvDUiQ7t7GtxGxEmh+yZ27MX/aJMj89QwL25zsZl
	 iQ3XIDjgLq+reSxEc7T9YZOUDb78kqhy7JYSgIvsyjxgaBeQgFIzW5kEoN2wWZWAFmpDW
	 P0H+2YcRqz6h3QFRH8xfqkgU+PqqRsesTE8nJm6MnSUmlqTAqRO5wzytLqaSjb7Wbbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691902;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=ZILZfKisda6VydMd2eX+gp7jxSdYsZR8fHOcYz6Cqew=;
	b=CtFjbY6vYJagFovDTPxcBrZCNxwWNDThtYIMRuAGcfyXJOfg/oQ3UAaQi7+org1HvoqB
	 LiRPjMi7C0IjM8VlBNhlmagdTq0aExghHMopIFTtqonhdzjgNStCwD5Pmw8qkcWFS93e0
	 Prr62PypP/n4zcOvHvoSoUaY9SviykmLTkZag5b6pE6UC+FW9Kmks5ge+RTVwadEp6ZK/
	 wpCdzLuwE2Jf7PzJNoQ172SvXGTV0cpbTH4j/l1kG9gSTdCCMBor+8fhmnWuBCrpUSyPg
	 oVnk8K54z5emPHUIfCoDD3MMuuH89MyBUImHBN7tUuqugC2zjZ6lnBfANQH1L41fIVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dcA/LQZJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E806606A331;
	Thu, 26 Nov 2026 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcA/LQZJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612A11F000EB;
	Thu, 26 Nov 2026 11:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691901;
	bh=ZILZfKisda6VydMd2eX+gp7jxSdYsZR8fHOcYz6Cqew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dcA/LQZJNTRxAXYiSO3ecetRk8UeUJ6G6eowyblPb3SceghWJPlB47dy81dO3ekpo
	 8zDVpbCPPwxS+gP2aWUtngwOLnVGrkWp3lbRZc00nMGGvENyrC+LUZsSkDTGn2a/Df
	 Ykat0AJi7F5ysyrmoP735e9b3JtJOJkyBZb/r31kMWVXdrscOhgdsETzfdXnYLy3Oa
	 9MLDBL0FuPwbh5GLhPshgP2x2ZO3LV6BIDUNOwy6XdbqpNWoRFGlguk+SsxHNgl76s
	 ing/lUECgznOONlhV/K97ITTVUhM1RAQes1Mo/It0ScWnHTtRza5jJ7IGIDCXcwDNm
	 NDSCBoaFdVjlw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:37 +0200
Subject: [PATCH RFC v2 24/54] x86/mm/pat: detect unchanged mappings by
 comparing protections
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-24-723f1e33c3d8@kernel.org>
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

CPA decides whether a mapping changes by encoding the new page table entry
and comparing it with the existing one.

It would be suboptimal to encode actual entries in the generic code for
every comparison of the existing, requested and new protections, as every
architecture would need one more out-of-line hook for it.

cpa_leaf by definition has the decoded protection which can be used in
comparisons.

Compare the new protection with the decoded one and encode only the page
table entries that are written, as the last step.

Encoding masks out the bits the CPU does not support and _PAGE_GLOBAL bit
of a non-present entry, comparing protections does not. set_memory_global()
on a CPU without PGE or on a non-present page now rewrites the PTEs with
the same value and flushes the TLB. Its only caller changes the kernel
text, which is always present, once at boot.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 0a2d19064f23..f4d3e2d9c3c9 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1917,26 +1917,18 @@ static int __change_page_attr(struct cpa_data *cpa)
 		return __cpa_process_fault(cpa, address);
 
 	if (leaf.level == PGTABLE_LEVEL_PTE) {
-		pte_t old_pte = *leaf.kpte;
 		pgprot_t new_prot;
 		unsigned long pfn = leaf.pfn;
-		pte_t new_pte;
 
 		cpa_inc_pte_install();
 		new_prot = cpa_new_prot(cpa, &leaf);
-
-		/*
-		 * We need to keep the pfn from the existing PTE,
-		 * after all we're only going to change its attributes
-		 * not the memory it points to
-		 */
-		new_pte = cpa_pte(leaf.level, pfn, new_prot);
 		cpa->pfn = pfn;
 		/*
 		 * Do we really change anything ?
 		 */
-		if (pte_val(old_pte) != pte_val(new_pte)) {
-			set_pte_atomic(leaf.kpte, new_pte);
+		if (pgprot_val(new_prot) != pgprot_val(leaf.prot)) {
+			set_pte_atomic(leaf.kpte,
+				       cpa_pte(leaf.level, pfn, new_prot));
 			cpa->state |= CPA_ST_FLUSHTLB;
 		}
 		cpa->numpages = 1;

-- 
2.53.0

