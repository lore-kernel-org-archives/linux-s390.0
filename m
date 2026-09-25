Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723E443D4FD;
	Fri, 25 Sep 2026 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367051; cv=none; b=qqBDxw8d+ee7nyOsOOlVVaUiQnlefUmaEvt+HjO9PvVhKbmXFtpCWD9/b083a9K0fQDHZ3ZsA0GwGCwuUhrmRWZcdbtXd70VrNgahPHhYCRRLaZq1ur3dqE/W9H77+havCn+N7lIFwKYfrbdAoOjiq0YrWn4AZIYo5WHUj9LPYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367051; c=relaxed/simple;
	bh=k+1gLmG1a4EmZBfdZJSsYR9/SRGnTKf86XJLG0Jlsl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W8FvPATPL46cHmhliI9QncItUpvJViq8J1TT95PqLRSpCBm/L/FlCSYBk4nVx8NiMDlZ9ycYVlzS8x2d27E+Jmv7e9K24HOuy4/vpFrSas2jr7mW6U2VpeXS2loMBnQz1+qbmR70e6TUCZztgDNQYwECKrpYYvLJQ+pIc9stDY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glJ1oO03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glJ1oO03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4381F00893;
	Fri, 25 Sep 2026 20:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367026;
	bh=ZZL+kGVACjhjkTWYbS76jfyltYBtpfCujbpQ6jbpX7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=glJ1oO03XaTYx5BUnJ0uxCpIQtEUdWsQp725f4o9J35cE4hItKtr95K4O5iSqoxjh
	 KhnW7NRY2KHVdmcljk6wXCNn+SXEdu8tH3oJeQZY9EGbaT/Y6edK0A5jE5waYvIgcJ
	 L6WbdAgW1V1Rxbp77J7HBZCVIq1Yf6H6NVPya4UATK74M7TnIKeuGrI9/l4vSFKQtq
	 HMN+SX/XwH/ucmTOjV5ylG72vjBVSJ6BIFcPvFoi/PWgrP918+30Z/DY2P1q8OWS21
	 gdguqD0qk6KnupTMiLp73S7P+AsfEgrqv8jLEj/rY7M5sRaSgJ+l7l4mxZGY+emEwd
	 S1Z+vCUxTwMMA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 25 Sep 2026 21:09:36 +0100
Subject: [PATCH v5 01/12] mm/khugepaged: deposit a newly allocated page
 table on collapse
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-rcu-pagetable-freeing-v5-1-31e91065fea4@kernel.org>
References: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
In-Reply-To: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dinh Nguyen <dinguyen@kernel.org>, 
 Simon Schuster <schuster.simon@siemens-energy.com>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>, 
 Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
 Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, 
 linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, 
 Qi Zheng <qi.zheng@linux.dev>, linux-doc@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5012; i=ljs@kernel.org;
 h=from:subject:message-id; bh=k+1gLmG1a4EmZBfdZJSsYR9/SRGnTKf86XJLG0Jlsl8=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK2XWU71zjv/bzmb8JXz7eUT1s658HDTUbB4XU2dxek/
 TwgcWdzXkcpC4MYF4OsmCLL8y/i+4NEwuZ1XvB3g5nDygQyhIGLUwAuosjI0CrgqRwqa/x8xe92
 XZmyMz8+sW7svn7ryETmbaGaOpestzIyzC5qefxJP3uD2uSXFbvntL+bvHn1jFMvVTXnvND+UqX
 /iBcA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

collapse_huge_page() deposits a PTE page table on PMD collapse in order
that it can be utilised for subsequent split operations, meaning that those
operations do not need to perform an allocation (as they are in a context
where it might be unwise).

However the PTE page table which is deposited is the one which is currently
mapped by the PMD entry that is in the process of being collapsed.

Once deposited, the PTE page table may be used in a split of any other
unrelated PMD entry.

This is currently not an issue as this operation is performed with VMA/mmap
write lock + anon rmap locks held, so ordinary page table walkers will
never accidentally end up walking the wrong thing, and GUP-fast is
protected by an IPI via tlb_remove_table_sync_one().

However, the series to which this commit belongs implements RCU-safe page
table traversal, at which point this becomes problematic.

This can be resolved by using pte_offset_map_lock() which gates on a PTE
PTL and a pmd_same() check, but lockless walks are unsafe as things stand.

Resolve this by simply allocating a new, zeroed, PTE page table to deposit
at the point of collapse.

This path is already costly and an allocation has already been performed
for the huge folio, so this allocation is statistical noise in terms of
performance and memory usage at this point.

With this PTE page table deposited, RCU-free the existing PTE page table
so it is safe for page table walkers to traverse within a grace period.

This also brings this deposit case in line with all other page table
deposit logic which deposit a fresh page table.

Additionally, this was the only place in the kernel that displaced a page
table like this, so eliminating it also helps consistency.

Since khugepaged runs as a kernel thread, do a little dance in
alloc_deposit_pte_table() to correctly charge the allocation.

This is already done for the folio allocation via alloc_charge_folio() but
no such wrapper exists for a page table allocation.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/khugepaged.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f49a6710933b..639029cc4f5e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1278,6 +1278,23 @@ static enum scan_result alloc_charge_folio(struct folio **foliop, struct mm_stru
 	return SCAN_SUCCEED;
 }
 
+static pgtable_t alloc_deposit_pte_table(struct mm_struct *mm)
+{
+	/*
+	 * khugepaged is run from a kernel thread, so need to manually set the
+	 * correct memcg so the allocation gets charged correctly.
+	 */
+	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
+	struct mem_cgroup *old_memcg = set_active_memcg(memcg);
+	pgtable_t pgtable;
+
+	pgtable = pte_alloc_one(mm);
+
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+	return pgtable;
+}
+
 /*
  * collapse_huge_page() expects the mmap_lock to be unlocked before entering and
  * will always return with the lock unlocked, to avoid holding the mmap_lock
@@ -1293,7 +1310,7 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
 	LIST_HEAD(compound_pagelist);
 	pmd_t *pmd, _pmd;
 	pte_t *pte = NULL;
-	pgtable_t pgtable;
+	pgtable_t pgtable = NULL;
 	struct folio *folio;
 	spinlock_t *pmd_ptl, *pte_ptl;
 	enum scan_result result = SCAN_FAIL;
@@ -1310,6 +1327,14 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
 		goto out_nolock;
 	}
 
+	if (is_pmd_order(order)) {
+		pgtable = alloc_deposit_pte_table(mm);
+		if (!pgtable) {
+			result = SCAN_ALLOC_HUGE_PAGE_FAIL;
+			goto out_nolock;
+		}
+	}
+
 	mmap_read_lock(mm);
 	result = hugepage_vma_revalidate(mm, pmd_addr, /*expect_anon=*/ true,
 					 &vma, cc, order);
@@ -1433,8 +1458,8 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
 	spin_lock(pmd_ptl);
 	VM_WARN_ON_ONCE(!pmd_none(*pmd));
 	if (is_pmd_order(order)) {
-		pgtable = pmd_pgtable(_pmd);
 		pgtable_trans_huge_deposit(mm, pmd, pgtable);
+		pgtable = NULL;
 		map_anon_folio_pmd_nopf(folio, pmd, vma, pmd_addr);
 	} else {
 		/*
@@ -1453,6 +1478,9 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
 	}
 	spin_unlock(pmd_ptl);
 
+	if (is_pmd_order(order))
+		pte_free_defer(mm, pmd_pgtable(_pmd));
+
 	folio = NULL;
 
 	result = SCAN_SUCCEED;
@@ -1463,6 +1491,8 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
 		anon_vma_unlock_write(vma->anon_vma);
 	mmap_write_unlock(mm);
 out_nolock:
+	if (pgtable)
+		pte_free(mm, pgtable);
 	if (folio)
 		folio_put(folio);
 	trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result, order);

-- 
2.55.0

