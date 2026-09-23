Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8210D49CF3D;
	Wed, 23 Sep 2026 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790163433; cv=none; b=sYL9+UnF9cc7GWnB85JY+vSGTuDvsxVue62gz508LXOh6Ea6XVWvcS4t85nUEeqbAPxY6TF2tPRBwnYVHgPFWlieK///79MA0GO7vLLkyi9oWAMQc0XwpjnCDoQnFamodvtlYvjLNdYCyi4kWMfFfbNac6XRuGKK0/CM4PWqhTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790163433; c=relaxed/simple;
	bh=PWgiHObg3y731Py8fvpc1mNquBfZTfGkFWp27vzEMXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m27eGMPejFMThEOXsGwc+q23/0loMUlDkGcXETV6LRMX0kF3cl++OTABSvBbXiMLzy82x5qzRK2hOYTcFSUzFoKErfTVKP9yCVBuRxT37DPd3E//wcktJgS/WTNeWF1VuoqFoJsOljKZX62bGEoEVxtl0pRKyc2xjE4NTIgUBjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUYdtQ/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUYdtQ/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD421F000FF;
	Wed, 23 Sep 2026 11:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790163421;
	bh=T7sdWnYxMHXupf7TleaKj2/jZn70aUNOMLwBt1Gu25I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MUYdtQ/rOOsFntGNDCU8gVljiX41ZOOjVjIa1/R6mHvqEVrHdCvUW00s158m6Rhfr
	 lrTfdsDZHHM+8coQufhdItKT2U0f3KpSO1bXFVK65E8hdX7jqTg0RCXs6dbA/rOsE3
	 hj+OXHPR25h/T+zpUP1sxEFBKfBfbEPENxxtH4NpPA1FC6zBNzSnYJzOsanm0vWeX8
	 zL3hunrW3+GWyBjkcp7ZV4TlKp8Hz5f+x0SToekr1cuh3sa+lEbvI9mBqvMu2yTtr5
	 AR51Ti0FikS+Z02shyQHn9y3MNOVB+cU717LR/sppvi3rpyZsF2wIvQXXwZp2C/8Bt
	 8Q399dOg4bqJA==
Date: Wed, 23 Sep 2026 12:36:43 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Greg Ungerer <gerg@polyxeno.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Dinh Nguyen <dinguyen@kernel.org>, Simon Schuster <schuster.simon@siemens-energy.com>, 
	Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
	Stafford Horne <shorne@gmail.com>, Rich Felker <dalias@libc.org>, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 07/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 m68k-coldfire
Message-ID: <arO5wY1tLAPhJ721@gremlin>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922-rcu-pagetable-freeing-v4-7-fe1ad1f1e303@kernel.org>
 <3e6740e3-0515-4e29-9627-f554261daddb@polyxeno.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e6740e3-0515-4e29-9627-f554261daddb@polyxeno.com>

On Wed, Sep 23, 2026 at 09:31:47PM +1000, Greg Ungerer wrote:
> Hi Lorenzo,
>
> On 23/9/26 01:35, Lorenzo Stoakes (ARM) wrote:
> > Similar to sun3, the coldfire variant of m68k uses 2-level page tables.
> >
> > Update its __pte_free_tlb() function to use tlb_remove_ptdesc() in order
> > that, with CONFIG_MMU_GATHER_RCU_TABLE_FREE, page tables are freed under
> > RCU.
> >
> > The page tables occupy a page each and have no odd semantics, so this
> > change suffices to allow enabling of CONFIG_MMU_GATHER_RCU_TABLE_FREE for
> > m68k-coldfire, so do so.
> >
> > This forms part of an overall effort to switch every architecture to this
> > mode.
> >
> > Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> Looks good to me for ColdFire, so:
>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
>
> Tested and run with no issues I could see on a M5475 ColdFire system, so:
>
> Tested-by: Greg Ungerer <gerg@linux-m68k.org>

Thanks, much appreciated! :)

>
> Regards
> Greg
>
>
>
> > ---
> >  arch/m68k/Kconfig                   | 2 +-
> >  arch/m68k/include/asm/mcf_pgalloc.h | 5 +----
> >  2 files changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> > index e29610fd1240..6b8ec67c86fd 100644
> > --- a/arch/m68k/Kconfig
> > +++ b/arch/m68k/Kconfig
> > @@ -36,7 +36,7 @@ config M68K
> >  	select HAVE_MOD_ARCH_SPECIFIC
> >  	select HAVE_UID16
> >  	select MMU_GATHER_NO_RANGE if MMU
> > -	select MMU_GATHER_RCU_TABLE_FREE if MMU && SUN3
> > +	select MMU_GATHER_RCU_TABLE_FREE if MMU && (SUN3 || COLDFIRE)
> >  	select MODULES_USE_ELF_REL
> >  	select MODULES_USE_ELF_RELA
> >  	select NO_DMA if !MMU && !COLDFIRE
> > diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
> > index fc5454d37da3..b53ff0950db2 100644
> > --- a/arch/m68k/include/asm/mcf_pgalloc.h
> > +++ b/arch/m68k/include/asm/mcf_pgalloc.h
> > @@ -39,10 +39,7 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
> >  static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
> >  				  unsigned long address)
> >  {
> > -	struct ptdesc *ptdesc = virt_to_ptdesc(pgtable);
> > -
> > -	pagetable_dtor(ptdesc);
> > -	pagetable_free(ptdesc);
> > +	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pgtable));
> >  }
> >
> >  static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
> >
>

--
Cheers, Lorenzo
