Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFFE3BBFDA;
	Tue,  1 Sep 2026 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273702; cv=none; b=j7d5mKratwVzEq/OGC8y21dKnVzxoOUUUKRpDqH8VyPjLcW9oofQE3doS+hSPzwhncnPE8WiIenFRMg6X3yZWTmB6a7BKBhju7gv84xmu1/LFrz3TWYH4G/DcUfaZyxYP3BIxCDqP51fpkPxBGcFf37AXk6q+sS8EanU79zPYnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273702; c=relaxed/simple;
	bh=aD1aeCXoZUTVkYkw8DYLgpTcX29H0YL7tFV55GqLOUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZArFDMpeCLNyy02GpxCgLiogx3cjDtoblwVMWgkBKaVM0G7BNltSQfZ3ujscIQ2XqysON0dOmBkxESSRxW0Sfi6StvyNaUb5AF8yweiNO6bp6uo1Dmg1/uD28NEp7SL5bT9QZZPlp1kl6pzDtDfdbGUMkkef86OwCXp93eAxMqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCkYCgJH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCkYCgJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A26C1F000E9;
	Tue,  1 Sep 2026 14:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788273700;
	bh=aD1aeCXoZUTVkYkw8DYLgpTcX29H0YL7tFV55GqLOUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DCkYCgJHTMeXpcfI011IFyZWluRGgMafgbwW8u29qgQBVZ9Dxsno0gDXnl7hHZ0m+
	 lkqnWV4wHDwKSWKnoQda11OIQ06fvWLfa32Ye05qYmX1Z7boJPT6aJZEl4EVv8r+G6
	 Q8c5h5Eq9o8u4IVkNkDvCB17dlRL52JTqjsLsbOVCb03G2bti6Yh9u4sRvw0rWJ1Ca
	 qwHtYbfIXyVj5uLcNFlMoaGF0xHllKs6NACCcVCPrJufvl5Fed3xFkkaUWs7j7W7ZV
	 siJKVu6dFavxSGvLfYUXvuVBZcE7zllPLV8WeZFb1IHv1rO4zZ/Mqb/Gua1p6L6cXY
	 pVvsocfBPnW+w==
Date: Tue, 1 Sep 2026 15:41:17 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kiryl Shutsemau <kas@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
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
	Michal Hocko <mhocko@suse.com>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, 
	Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 01/12] mm/huge_memory: zap deposited page tables after an
 RCU grace period
Message-ID: <apbiB51hjm-9pRzf@gremlin>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-1-5456a81c8212@kernel.org>
 <apbOlyF77yDCV4cF@thinkstation>
 <apbcoMTVlL42G5tg@gremlin>
 <20260901142408.GA56830@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901142408.GA56830@ziepe.ca>

On Tue, Sep 01, 2026 at 11:24:08AM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 01, 2026 at 03:12:45PM +0100, Lorenzo Stoakes (ARM) wrote:
>
> > It won't be costly at the time of the calls obviously as its deferred. Maybe
> > increase some time spent in softirq but again is 512x that big of a deal?
> >
> > I'm not sure how you'd both defer the free and somehow utilise mmu_gather here
> > either really, certainly not without it becoming extremely messy.
>
> The less costly version is to thread the page to be freed onto the
> mmu_gather through a linked list in the struct page memory. This is
> super cheap since it is just a singly linked list operation.
>
> Then when the mmu_gather is flushed it does a single call_rcu using
> the rcu head of the struct page of the head of the list. The callback
> clears the entire linked list of pages.
>
> Since you have to tlb flush anyhow, it makes sense to always use the
> mmu_gather. For example the design I ended up with for iommupt
> accumulates all the invalidations and all the free-able memory into a
> gather then invalidates and frees.
>
> This allows maximizing the tlbi efficiency too. You can't do call_srcu
> until you flush the tlb and if you call once per table then you are
> also tlb flushing once per table too.
>
> So if the kernel really does want to clear out 512 leaf tables the
> optimal implementation is one range tlbi for 512 entries followed by
> one call_rcu to free the memory. Hence the gather..

I think there's some confusion here.

This isn't the path in which a page table is being freed, the _deposited_
table is zapped, in zap_deposited_table().

That is, the page table kept in reserve for THP split, that is not
currently mapped.

It amounts to a __free_pages() call.

The TLB operations are in e.g. zap_huge_pmd() etc. and nobody has
complained about inefficiencies there.

So, unless I'm missing something here, TLB flushes play no role in this
whatsoever.

The issue Kiryl raised was that instead of immediately freeing page tables,
they are now batched up individually by call_rcu().

I personally find it difficult to imagine the numbers here would be
problematic or certainly cause anything observable beyond what is
observable now.

So I'm going to have to say, unless it can be clearly demonstrated this is
problematic, I don't think there's any reason to add additional complexity
here.

>
> Jason

--
Cheers, Lorenzo
