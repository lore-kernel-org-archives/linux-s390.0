Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB41A43CE56;
	Tue,  1 Sep 2026 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278149; cv=none; b=byEnhNbaesqahDogHNHELOSYJ6H6ePIzi9cioZNUuqrZlgOWUcthRsRVnS5cfA4j1CYaBoAO/srkN36K+wSgt+mhodny4z+jZRaWu0pjoC/yFE/9s4SpU3jyZUInJv1R+i/l5PBuN0izoOSS/RDbds8DPzqqWapSqqoHxI+O+5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278149; c=relaxed/simple;
	bh=qqNtHA4CTMpPgpg0tTomw2NNo+hq2OSef3C+KNnMj9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHUgSS+toLt1PlP/BX0xG1nWn7hWhwa8GUBPOA9xWc5kMKjtlAERahgr4yuAYi5UJgL5JmBfZuZ0Ln6Qthz5Kk/fyxaqT8uXims26T6MXqF5h6FIWk7slstF061ottvckkgiqXknd22Uobktofh0puduYflpkMj2GX6vtvWoUFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VuetgL2D; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VuetgL2D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QVII+cUuHDdwf9Z3P2TCkoJU717I3TDa444aSejj2Fk=; b=VuetgL2DlX2s22gGISfExiPA9t
	9DR1WYg6YZMiQdCRfQ+bclFFmqJlamray7mTao+UhH5uHuDqMjg0If3EcpdK8CT6uAbV8Evx6e3qN
	9LKEiBOSP64GFOxx0Cep1mNRyBIuVmmcKSTv8HQZQ9qWi8T/h/J5gA+nhMhRR79oe1SuMqDRuJhz9
	pRpKL7TL03xwEzunbCrbhKOYuAtJaLW6NfzQtbWbRGbuZxvcEga7a6JSS4BRz+hheJF51YvaJp+Zr
	D/J641qvz7Z+tlxTfhJCmdiErtoEU9UpGW4Y1LUR3UybIWIjAgSbUj4dMePbLb0JYsVZUKGih4aiC
	1qamG5Tw==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1Qp4-0000000CazZ-3xgl;
	Tue, 01 Sep 2026 15:54:55 +0000
Date: Tue, 1 Sep 2026 11:54:47 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Dinh Nguyen <dinguyen@kernel.org>, Simon Schuster <schuster.simon@siemens-energy.com>, 
	Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
	Stafford Horne <shorne@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
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
Message-ID: <kasi4mkjkt56wxsrmphm5o2qfg2lwsdxf3tlmzx5tq6t7uez74@kozleoavd6r2>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-1-5456a81c8212@kernel.org>
 <apbOlyF77yDCV4cF@thinkstation>
 <apbcoMTVlL42G5tg@gremlin>
 <20260901142408.GA56830@ziepe.ca>
 <apbiB51hjm-9pRzf@gremlin>
 <apbuO_QveZNAz3ns@thinkstation>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apbuO_QveZNAz3ns@thinkstation>

On 26/09/01 04:28PM, Kiryl Shutsemau wrote:
> On Tue, Sep 01, 2026 at 03:41:17PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Sep 01, 2026 at 11:24:08AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Sep 01, 2026 at 03:12:45PM +0100, Lorenzo Stoakes (ARM) wrote:
> > >
> > > > It won't be costly at the time of the calls obviously as its deferred. Maybe
> > > > increase some time spent in softirq but again is 512x that big of a deal?
> > > >
> > > > I'm not sure how you'd both defer the free and somehow utilise mmu_gather here
> > > > either really, certainly not without it becoming extremely messy.
> > >
> > > The less costly version is to thread the page to be freed onto the
> > > mmu_gather through a linked list in the struct page memory. This is
> > > super cheap since it is just a singly linked list operation.
> > >
> > > Then when the mmu_gather is flushed it does a single call_rcu using
> > > the rcu head of the struct page of the head of the list. The callback
> > > clears the entire linked list of pages.

If you are going through the trouble of doing this on your side with a
custom rcu callback, it might be better to pack the pointers in a way
that does not need to pointer chase through a linked list.

> > >
> > > Since you have to tlb flush anyhow, it makes sense to always use the
> > > mmu_gather. For example the design I ended up with for iommupt
> > > accumulates all the invalidations and all the free-able memory into a
> > > gather then invalidates and frees.
> > >
> > > This allows maximizing the tlbi efficiency too. You can't do call_srcu
> > > until you flush the tlb and if you call once per table then you are
> > > also tlb flushing once per table too.
> > >
> > > So if the kernel really does want to clear out 512 leaf tables the
> > > optimal implementation is one range tlbi for 512 entries followed by
> > > one call_rcu to free the memory. Hence the gather..
> > 
> > I think there's some confusion here.
> > 
> > This isn't the path in which a page table is being freed, the _deposited_
> > table is zapped, in zap_deposited_table().
> > 
> > That is, the page table kept in reserve for THP split, that is not
> > currently mapped.
> > 
> > It amounts to a __free_pages() call.
> > 
> > The TLB operations are in e.g. zap_huge_pmd() etc. and nobody has
> > complained about inefficiencies there.
> > 
> > So, unless I'm missing something here, TLB flushes play no role in this
> > whatsoever.
> > 
> > The issue Kiryl raised was that instead of immediately freeing page tables,
> > they are now batched up individually by call_rcu().
> > 
> > I personally find it difficult to imagine the numbers here would be
> > problematic or certainly cause anything observable beyond what is
> > observable now.
> > 
> > So I'm going to have to say, unless it can be clearly demonstrated this is
> > problematic, I don't think there's any reason to add additional complexity
> > here.
> 
> It would be nice to measure munmap() overhead here.
> 
> I am worried about hitting DEFAULT_MAX_RCU_BLIMIT and trigger
> rcu_force_quiescent_state() which can be disruptive to the system.
> 
> DEFAULT_MAX_RCU_BLIMIT is 10K, so it is ~20G of THP unmapped on x86.
> 
> munmap() of 64G worth of THP should be enough to demonstrate the
> problem.

I'm not sure what that would prove besides checking if your number is
correct?  You'll see a slow down once you hit 10K of objects in the rcu
linked list.  And that will depend on what the system is doing as well,
so there will be a slow down since other things are happening on the
system before 20GB of THP is unleashed towards munmap().

One of these does use 5.12% of the RCU items that need to wait for a
grace period to be released, but testing it would be rather tricky and
the numbers won't really show much..?

Form my understanding and experience with rcu and freeing massive
numbers of objects, you gain more from the lower lock contention than
you lose when you hit 10K objects.

The trade off is in the Android setup, where they have restricted RCU to
a slower core.  Combined with another RCU setting, it was causing slow
down when we overwhelmed the queue multiple times.

So this should actually be faster unless you are doing 20GB of THP
unmapping on Android or a device configured the same way.  Considering
the cost of RAM, we should be okay for a few phone iterations.

Do you have munmap() performance dependent workload that you are
concerned about regressing?

Thanks,
Liam



