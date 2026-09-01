Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14FC3B05A3;
	Tue,  1 Sep 2026 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271990; cv=none; b=stplvCYIyqcfGEvRXVyv9kLt4VQchXNtmoqA9E03KOes+BnyzcnohTyw3sMs5gn7x0vTXtzW1/14arL8uuBr9NqD+57YwNNVo1C8eZSK2q9DlEC8fN88pzDvqU6YW1xSC02yBC/p5vCKRkHNbXCS5SAAyDKQemu9PgEqaFiU8/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271990; c=relaxed/simple;
	bh=a2b+xv6S/sQj7cWLxXIth8VJz3Q7Xf04YGK8+l/yPro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wop2UBMjjbMu9KITmfvKtSNbmFQOgjklHqq8OVVPAWb6xXumquB/3c37ecigu9v27a9ptkVoh5/TxbFyU06TiqO50XqmTD03ZvNM+6COsLjl2fGbNFWFwfNpWb6ta3/n3gy9WUs07UKBECUuDP6SZ2aJ9Lptzyc3DvHJ0Lqzicc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojh3C4HD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojh3C4HD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C071F00A3E;
	Tue,  1 Sep 2026 14:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788271988;
	bh=zIFNccvs+atFhWftoJEJD5wmod58xIW+qFgefX0BOCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ojh3C4HDmqZjOi1pkhDSDGdV7SfRfNfWGZdomRJtqMccy2x0v2yndUbLTlFfoma31
	 dXPCD/3iuiFmrOyTzvDFsi3JMSQci44mXNjMW5aZrX1wksJI6YrjjSO9AmUv57cBYV
	 9z8GlCwH5Lcq8HdHGJ0PhyaJV91X1hhmLlTYoLDJyqV5tpAA3OmuNtzuupyJ9NgXA9
	 UJ1DFYAPUuZI2d/93NYxQqW7uJLFNFyZWGMt5ve018yg00i9qrJwXbMtHXQVNemoe6
	 vmWZlNLESArFUgZ4rroUvf022k6zvA9BUurkwbyrW+S7uSnPMqBoCZlDQJvO6b3uMa
	 s/wAJaE9PbDug==
Date: Tue, 1 Sep 2026 15:12:45 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon@siemens-energy.com>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Russell King <linux@armlinux.org.uk>, 
	Vineet Gupta <vgupta@kernel.org>, Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 01/12] mm/huge_memory: zap deposited page tables after an
 RCU grace period
Message-ID: <apbcoMTVlL42G5tg@gremlin>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-1-5456a81c8212@kernel.org>
 <apbOlyF77yDCV4cF@thinkstation>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apbOlyF77yDCV4cF@thinkstation>

On Tue, Sep 01, 2026 at 02:19:36PM +0100, Kiryl Shutsemau wrote:
> On Tue, Sep 01, 2026 at 12:01:21PM +0100, Lorenzo Stoakes (ARM) wrote:
> > When an anonymous mapping is collapsed for THP, a PTE page table is
> > 'deposited' with the installed PMD entry.
> >
> > This is done in order that a split can be performed without needing to
> > allocate additional memory.
> >
> > The freeing occurs in zap_deposited_table() and is done directly without
> > any delay via pte_free().
> >
> > This is currently not a problem as existing page table walks are protected
> > by the mmap or anon rmap lock.
> >
> > However this becomes problematic in a future where RCU-only page table
> > walkers exist, as there is nothing to prevent a page table walker that
> > started the walk prior to collapse having its PTE table freed underneath
> > it.
> >
> > Commit 13cf577e6b66 ("mm/pgtable: add pte_free_defer() for pgtable as
> > page") already provides us the mechanism by which to solve this -
> > pte_free_defer().
> >
> > Therefore, as a prerequisite to a future commit which will permit fully RCU
> > page table walks, update zap_deposited_table() to use pte_free_defer()
> > rather than pte_free().
> >
> > Note that the IPI sync in collapse_huge_page() is still required to ensure
> > refcount correctness against a GUP-fast operation.
> >
> > This is because GUP-fast might increment refcount, but
> > __collapse_huge_page_isolate() determines whether it is safe to proceed by
> > checking folio_ref_count() against folio_expected_ref_count(), so the two
> > must be mutually excluded.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  mm/huge_memory.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 54494c3fa983..505f7b62ff28 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2476,7 +2476,7 @@ static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
> >  	pgtable_t pgtable;
> >
> >  	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
> > -	pte_free(mm, pgtable);
> > +	pte_free_defer(mm, pgtable);
>
> Hm. So it is call_rcu() on each PMD. It might be costly, especially for
> zap_huge_pmd() path: 512 call_rcu() per-GB of unmapped THPs.
>
> Do we want leverage mmu_gather if caller has it?

I mean, I'm not sure in which respect that'd be costly, 512 is not a big number
to a computer, and repeated call_rcu() invocations should just queue more
operations no?

It won't be costly at the time of the calls obviously as its deferred. Maybe
increase some time spent in softirq but again is 512x that big of a deal?

I'm not sure how you'd both defer the free and somehow utilise mmu_gather here
either really, certainly not without it becoming extremely messy.

But yeah I'd want to see hard data on that before I really believe that's a
problem :)

>
> >  	mm_dec_nr_ptes(mm);
> >  }
> >
> >
> > --
> > 2.55.0
> >
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

--
Cheers, Lorenzo
