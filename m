Received: from mta1.migadu.com (out-5.mta1.migadu.com [95.215.58.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807EA37DEB6
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 02:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130290; cv=none; b=Glpov6jjHvzsx73Odcl4o7obqTkwvr3ZyqCBAe9zs/nV33CbQ8YpTxh0LVLMWPR6g4MZY+Ho1Ip1d+KB5L7lnBfTX8sVW0OdfPDxCAF91n5208vt+qpoJ1G5S3Gquwxcz6nR1tPBrVusliSX9JlPZotwH3hKT/knBu4H/EqqV1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130290; c=relaxed/simple;
	bh=d3FVAdMqEDWFoCMHxuxCTxk+fOdRBfvFdCrMB1cIOo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlIOtB5/MnUH1VWOfgGnK8gsdZVHBYn2UrvEp+n9ixT/PEAodRsUlwtdMg4ok9QHM0Uqv932Sz1VpRrfxUjgeDa4Ro9wDpZAbLZs94XGa0g01VlmLf1yvpbszaFeZrcFcF6PlmV0nk51odHPdR2HTx4MZQeAytKlGfEdkDR6PUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BiZViKgO; arc=none smtp.client-ip=95.215.58.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BiZViKgO"
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=d3FVAdMqEDWFoCMHxuxCTxk+fOdRBfvFdCrMB1cIOo0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790130286; v=1; x=1790735086;
 b=BiZViKgOqfLCi9r/STZxIsy9QdEL+7VEbPv6NZGrSyqe9tgn/hLshPFroTTCz4wHbji52niw
 c5OK+CR/k1qlTQQboX1rIBJ1ifulf7xryuZD4W7X+er1MlE3pjMMuJDNqtCE9tSQM3zlc14D8zt
 PnVwT4mYgbRY2d61PKAr5dSM=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b86f8e4163d69484;
	Wed, 23 Sep 2026 02:24:43 +0000
X-Mizu-Trace-ID: b86f8e4163d69484
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	guoren@kernel.org,
	bcain@kernel.org,
	geert@linux-m68k.org,
	dinguyen@kernel.org,
	schuster.simon@siemens-energy.com,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux@armlinux.org.uk,
	vgupta@kernel.org,
	monstr@monstr.eu,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	ysato@users.sourceforge.jp,
	shakeel.butt@linux.dev,
	corbet@lwn.net,
	rdunlap@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org,
	linux-arch@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	hughd@google.com,
	qi.zheng@linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 01/12] mm/khugepaged: deposit a newly allocated page table on collapse
Date: Wed, 23 Sep 2026 10:24:36 +0800
Message-ID: <20260923022436.61930-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-1-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-1-fe1ad1f1e303@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Sep 22, 2026 at 04:35:32PM +0100, Lorenzo Stoakes (ARM) wrote:
>collapse_huge_page() deposits a PTE page table on PMD collapse in order
>that it can be utilised for subsequent split operations, meaning that those
>operations do not need to perform an allocation (as they are in a context
>where it might be unwise).
>
>However the PTE page table which is deposited is the one which is currently
>mapped by the PMD entry that is in the process of being collapsed.
>
>Once deposited, the PTE page table may be used in a split of any other
>unrelated PMD entry.
>
>This is currently not an issue as this operation is performed with VMA/mmap
>write lock + anon rmap locks held, so ordinary page table walkers will
>never accidentally end up walking the wrong thing, and GUP-fast is
>protected by an IPI via tlb_remove_table_sync_one().
>
>However, the series to which this commit belongs implements RCU-safe page
>table traversal, at which point this becomes problematic.
>
>This can be resolved by using pte_offset_map_lock() which gates on a PTE
>PTL and a pmd_same() check, but lockless walks are unsafe as things stand.
>
>Resolve this by simply allocating a new, zeroed, PTE page table to deposit
>at the point of collapse.
>
>This path is already costly and an allocation has already been performed
>for the huge folio, so this allocation is statistical noise in terms of
>performance and memory usage at this point.
>
>With this PTE page table deposited, RCU-free the existing PTE page table
>so it is safe for page table walkers to traverse within a grace period.
>
>This also brings this deposit case in line with all other page table
>deposit logic which deposit a fresh page table.
>
>Additionally, this was the only place in the kernel that displaced a page
>table like this, so eliminating it also helps consistency.
>
>An edge case for deposit exists for powerpc and its hash-based MMU - it
>stores hash slot data in deposited page tables and zeroes them on withdraw,
>so a zeroed deposited page table works correctly for it.
>
>Since khugepaged runs as a kernel thread, do a little dance in
>alloc_deposit_pte() to correctly charge the allocation.
>
>This is already done for the folio allocation via alloc_charge_folio() but
>no such wrapper exists for a page table allocation.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---
> mm/khugepaged.c | 32 ++++++++++++++++++++++++++++++--
> 1 file changed, 30 insertions(+), 2 deletions(-)
>
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index f49a6710933b..dab421f8233e 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -1278,6 +1278,23 @@ static enum scan_result alloc_charge_folio(struct folio **foliop, struct mm_stru
> 	return SCAN_SUCCEED;
> }
> 
>+static pgtable_t alloc_deposit_pte(struct mm_struct *mm)
>+{
>+	/*
>+	 * khugepaged is run from a kernel thread, so need to manually set the
>+	 * correct memcg so the allocation gets charged correctly.
>+	 */
>+	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
>+	struct mem_cgroup *old_memcg = set_active_memcg(memcg);
>+	pgtable_t pgtable;
>+
>+	pgtable = pte_alloc_one(mm);
>+
>+	set_active_memcg(old_memcg);
>+	mem_cgroup_put(memcg);
>+	return pgtable;
>+}
>+
> /*
>  * collapse_huge_page() expects the mmap_lock to be unlocked before entering and
>  * will always return with the lock unlocked, to avoid holding the mmap_lock
>@@ -1293,7 +1310,7 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
> 	LIST_HEAD(compound_pagelist);
> 	pmd_t *pmd, _pmd;
> 	pte_t *pte = NULL;
>-	pgtable_t pgtable;
>+	pgtable_t pgtable = NULL;
> 	struct folio *folio;
> 	spinlock_t *pmd_ptl, *pte_ptl;
> 	enum scan_result result = SCAN_FAIL;
>@@ -1310,6 +1327,12 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
> 		goto out_nolock;
> 	}
> 
>+	if (is_pmd_order(order)) {
>+		pgtable = alloc_deposit_pte(mm);
>+		if (!pgtable)
>+			goto out_nolock;

One small thing: result is still SCAN_SUCCEED after alloc_charge_folio(),

	result = alloc_charge_folio(&folio, mm, cc, order);
	if (result != SCAN_SUCCEED)
		goto out_nolock;

	if (folio_memcg_alloc_deferred(folio)) {
		result = SCAN_ALLOC_HUGE_PAGE_FAIL;
		goto out_nolock;
	}

	if (is_pmd_order(order)) {
		pgtable = alloc_deposit_pte(mm);
		if (!pgtable)
			goto out_nolock;
	}

so if alloc_deposit_pte() fails, collapse_huge_page() returns success
without installing a PMD.

I see sashiko pointed that out too :)

Cheers, Lance
