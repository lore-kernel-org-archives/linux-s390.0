Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5914A56853F;
	Wed, 23 Sep 2026 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790193588; cv=none; b=gCnTRfn/3gOTCJUwRvO5zyxIUefnX+iB6V/K0mk95MNk1dLc8dgqw72mHGmzJtm/VIl59rEKDJEj8WKg843OPOHZED2JgHU0KfeZQwgN/be2IdGUqdx1tLKzrubvbo3ZRRke+l6ro9yae84fkOlQV6OtplQSqj24pMK1mH/WtiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790193588; c=relaxed/simple;
	bh=OI8KuuU8c6+cbhWAp7Don6xKpY0y06h5UEwIzhDdU7c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DpVEyDIQQLJm1/8tC1ZGQCcZXcElzaoGjvx/g9FG90haWXRMKWwp7o4LGFt67yLf+mVwFJXZy5Ka27tj6JsQMS7mmHhXjV/9tb4XfNvQ32sB0Hu0l+cJxMCUm4kfaZSsObITun01HFbmz3K03TWWR25fz9AE4nuB25By+0ceEaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kno41qWF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kno41qWF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B16C1F000FF;
	Wed, 23 Sep 2026 19:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790193568;
	bh=6Vw00INHTiJj7/4QiQUDB/NHC+AlawfaZqFc89mI3Uo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kno41qWFahoXgz8d+ShejJCZHoWEcJVL1leHlRD1kffko8g8JqMF0swHQKAX1HqpM
	 oSFWcsNfwRPPZPiT8oiRGQWKzrdI0TLKeP9oQtYbei92ILkPB3/p1L+hKq6td77JFF
	 LtG5ONUzFTYy73cWN7de/JfRwIjTq8OlV8hOUlho=
Date: Wed, 23 Sep 2026 12:59:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin
 Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Usama Arif
 <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Guo Ren
 <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Dinh Nguyen <dinguyen@kernel.org>, Simon Schuster
 <schuster.simon@siemens-energy.com>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne
 <shorne@gmail.com>, Rich Felker <dalias@libc.org>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Russell King <linux@armlinux.org.uk>,
 Vineet Gupta <vgupta@kernel.org>, Michal Simek <monstr@monstr.eu>, Chris
 Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Will Deacon
 <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick
 Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 "David S. Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland
 <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge
 Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Shakeel
 Butt <shakeel.butt@linux.dev>, Jonathan Corbet <corbet@lwn.net>, Randy
 Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, Hugh Dickins
 <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 00/12] mm: make userland page table freeing RCU-safe
Message-Id: <20260923125925.105d7575838c3a154a258a4c@linux-foundation.org>
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 16:35:31 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> The majority of architectures in the kernel defer page table freeing until
> an RCU grace period has elapsed, this series converts all remaining
> architectures to do so too and eliminates CONFIG_MMU_GATHER_RCU_TABLE_FREE
> altogether.
> 
> This is important because it enables safe lockless page table walking under
> RCU alone.
> 
> Doing so allows for reduced lock contention, avoids lock ordering concerns
> and enables fast, efficient and correct page table walking as a result.
> 
> Additionally it removes a bunch of code and architecture-specific behaviour
> which is always a beneficial thing to do.
> 
> There has been much recent work on this:

Thanks, I've updated mm.git's mm-unstable branch to this version.  Plus
one -fix for [01/12].

> v4:
> * Updated the 1st patch to allocate a new page table on PTE deposit rather
>   than deposit a page table that might currently be being walked by an
>   RCU-only page table walker, as per David.

Here's how v4 altered mm.git:


 mm/huge_memory.c |    2 +-
 mm/khugepaged.c  |   34 ++++++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 3 deletions(-)

--- a/mm/huge_memory.c~b
+++ a/mm/huge_memory.c
@@ -2478,7 +2478,7 @@ static inline void zap_deposited_table(s
 	pgtable_t pgtable;
 
 	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
-	pte_free_defer(mm, pgtable);
+	pte_free(mm, pgtable);
 	mm_dec_nr_ptes(mm);
 }
 
--- a/mm/khugepaged.c~b
+++ a/mm/khugepaged.c
@@ -1278,6 +1278,23 @@ static enum scan_result alloc_charge_fol
 	return SCAN_SUCCEED;
 }
 
+static pgtable_t alloc_deposit_pte(struct mm_struct *mm)
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
@@ -1293,7 +1310,7 @@ static enum scan_result collapse_huge_pa
 	LIST_HEAD(compound_pagelist);
 	pmd_t *pmd, _pmd;
 	pte_t *pte = NULL;
-	pgtable_t pgtable;
+	pgtable_t pgtable = NULL;
 	struct folio *folio;
 	spinlock_t *pmd_ptl, *pte_ptl;
 	enum scan_result result = SCAN_FAIL;
@@ -1310,6 +1327,14 @@ static enum scan_result collapse_huge_pa
 		goto out_nolock;
 	}
 
+	if (is_pmd_order(order)) {
+		pgtable = alloc_deposit_pte(mm);
+		if (!pgtable) {
+			result = SCAN_ALLOC_HUGE_PAGE_FAIL;
+			goto out_nolock;
+		}
+	}
+
 	mmap_read_lock(mm);
 	result = hugepage_vma_revalidate(mm, pmd_addr, /*expect_anon=*/ true,
 					 &vma, cc, order);
@@ -1433,8 +1458,8 @@ static enum scan_result collapse_huge_pa
 	spin_lock(pmd_ptl);
 	VM_WARN_ON_ONCE(!pmd_none(*pmd));
 	if (is_pmd_order(order)) {
-		pgtable = pmd_pgtable(_pmd);
 		pgtable_trans_huge_deposit(mm, pmd, pgtable);
+		pgtable = NULL;
 		map_anon_folio_pmd_nopf(folio, pmd, vma, pmd_addr);
 	} else {
 		/*
@@ -1453,6 +1478,9 @@ static enum scan_result collapse_huge_pa
 	}
 	spin_unlock(pmd_ptl);
 
+	if (is_pmd_order(order))
+		pte_free_defer(mm, pmd_pgtable(_pmd));
+
 	folio = NULL;
 
 	result = SCAN_SUCCEED;
@@ -1463,6 +1491,8 @@ out_up_write:
 		anon_vma_unlock_write(vma->anon_vma);
 	mmap_write_unlock(mm);
 out_nolock:
+	if (pgtable)
+		pte_free(mm, pgtable);
 	if (folio)
 		folio_put(folio);
 	trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result, order);
_

