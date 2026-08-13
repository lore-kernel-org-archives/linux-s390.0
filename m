Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B5C3E44F0;
	Thu, 13 Aug 2026 05:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599071; cv=none; b=rWhqdp0PZW/CaeiE5Vw3NGvdj1Rw40yfxhTP00MzTFGldPg9uMG3XVXYItdkqA2kx9HNaLOuxojGkPt2A+bY8g5xdaoF1ZzNrfl+1tMPsN8LPii7x2ib2MD30PwuONH1WskGhZr6qlCtFLHnDGHxiAKp6uO0LIfMEuKBQUQ9WKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599071; c=relaxed/simple;
	bh=X+NKUVlHUgJ3ufurYsAc3c38TCMI9lTEYh/79PTkQxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szW+r4I5L8xucByldfMCHJlfdNZhasdYown5AVvDwXrFX2zlNURNO/nCRKfnyc37Bztj0aqTLbJjZk7t1xk0ufp7bfbDweWKuvAdFhVhNJMnTmVl+GssIXbDp2d56f6PNTXzrU69YyG2XZlHG6Cg1f5qdDm80A+l9oS4Ev9bQOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SrKE60uI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SrKE60uI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A97B14BF;
	Wed, 12 Aug 2026 22:30:53 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B16D3F673;
	Wed, 12 Aug 2026 22:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786599057; bh=X+NKUVlHUgJ3ufurYsAc3c38TCMI9lTEYh/79PTkQxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SrKE60uIrBnbijwn35bVkTCswfmosJsNxYIwRXmIDvDEYsUPL/XRaOQw4NTWq9+R8
	 HTXCeA7afpFyAnPj1s0kOuibIeMGDLyy/hm/UQgt+OEqxfzPqBuw/BgmcxyZJ97m4P
	 B3v5HjN56UBmNRhdGR3eqCOkRfuHaef7VMgKMqK0=
Date: Thu, 13 Aug 2026 11:00:53 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 3/6] sh/mm: Stop using pte_ERROR()
Message-ID: <azo46amarknescr2uotz77khpt6zakwex7sb52krsvakrzfdlq@qu2t3ahd4m5t>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
 <20260811042119.3652929-4-anshuman.khandual@arm.com>
 <28c24991-590f-4980-a92e-26c89288cae7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28c24991-590f-4980-a92e-26c89288cae7@kernel.org>

On Wed, Aug 12, 2026 at 01:28:23PM +0200, David Hildenbrand (Arm) wrote:
> On 8/11/26 06:21, Anshuman Khandual wrote:
> > Directly use pr_err() in set_pte_phys() and drop pte_ERROR() which helps in
> > eventually dropping pte_ERROR() macro across the tree. In this new printing
> > __FILE__ and __LINE__ has been dropped because they are always the same and
> > don't really add any value.
> > 
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Cc: Rich Felker <dalias@libc.org>
> > Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Cc: linux-sh@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> >  arch/sh/include/asm/pgtable_32.h |  5 -----
> >  arch/sh/mm/init.c                | 11 ++++++++++-
> >  2 files changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
> > index 5f51af18997b..c8eb9a7a4c4c 100644
> > --- a/arch/sh/include/asm/pgtable_32.h
> > +++ b/arch/sh/include/asm/pgtable_32.h
> > @@ -401,14 +401,9 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
> >  #define pmd_page(pmd)		(virt_to_page(pmd_val(pmd)))
> >  
> >  #ifdef CONFIG_X2TLB
> > -#define pte_ERROR(e) \
> > -	printk("%s:%d: bad pte %p(%08lx%08lx).\n", __FILE__, __LINE__, \
> > -	       &(e), (e).pte_high, (e).pte_low)
> >  #define pgd_ERROR(e) \
> >  	printk("%s:%d: bad pgd %016llx.\n", __FILE__, __LINE__, pgd_val(e))
> >  #else
> > -#define pte_ERROR(e) \
> > -	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
> >  #define pgd_ERROR(e) \
> >  	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
> >  #endif
> > diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> > index 110308bdef01..b3c7fd84ceb4 100644
> > --- a/arch/sh/mm/init.c
> > +++ b/arch/sh/mm/init.c
> > @@ -78,13 +78,22 @@ static pte_t *__get_pte_phys(unsigned long addr)
> >  	return pte_offset_kernel(pmd, addr);
> >  }
> >  
> > +static void print_bad_pte(pte_t pte)
> > +{
> > +#ifdef CONFIG_X2TLB
> > +	printk("bad pte %p(%08lx%08lx).\n", &pte, pte.pte_high, pte.pte_low);
> > +#else
> > +	printk("bad pte %08lx.\n", pte_val(pte));
> > +#endif
> 
> I'd avoid that helper if possible, so we don't encourage new users.
> 
> Shouldn't we just switch to pr_err() right away?

Yes we could move from printk() to pr_err(). The above helper
just prevented an ugly #ifdef block inside if(!pte_none(*pte))
conditional block, nothing more. Will just drop it then.

> 
> > +}
> > +
> >  static void set_pte_phys(unsigned long addr, unsigned long phys, pgprot_t prot)
> >  {
> >  	pte_t *pte;
> >  
> >  	pte = __get_pte_phys(addr);
> >  	if (!pte_none(*pte)) {
> > -		pte_ERROR(*pte);
> > +		print_bad_pte(*pte);
> 
> Maybe similar to my reply to patch #1, actually print something more useful than
> just "bad pte" ? And possibly also just use ptval_to_str().

Probably #ifdef could be dropped here as ptval_to_str() should be able to
handle pte with two unsiged long elements in there i.e pte_high, pte_low
along with standard single unsiged long pte_low format.

#ifdef CONFIG_X2TLB
typedef struct { unsigned long pte_low, pte_high; } pte_t;
#define pte_val(x) \
        ((x).pte_low | ((unsigned long long)(x).pte_high << 32))
#define __pte(x) \
        ({ pte_t __pte = {(x), ((unsigned long long)(x)) >> 32}; __pte; })
#else
typedef struct { unsigned long pte_low; } pte_t;
#define pte_val(x)      ((x).pte_low)
#define __pte(x)        ((pte_t) { (x) } )
#endif

static void set_pte_phys(unsigned long addr, unsigned long phys, pgprot_t prot)
{
        pte_t *pte;

        pte = __get_pte_phys(addr);
        if (!pte_none(*pte)) {
                char str[PTVAL_STR_MAX];

                ptval_to_str(str, pte_val(*pte));
                pr_err("unexpected set PTE at %lx in set_pte_phys: bad pte %p(%s).\n",
                        addr, pte, str);
                return;
        }

        set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, prot));
        local_flush_tlb_one(get_asid(), addr);

        if (pgprot_val(prot) & _PAGE_WIRED)
                tlb_wire_entry(NULL, addr, *pte);
}

But if this does not work revert back printing both pte formats separately
like before.

#ifdef CONFIG_X2TLB
               pr_err("unexpected set PTE at %lx in set_pte_phys: bad pte %p(%08lx%08lx).\n",
                       addr, pte, pte->pte_high, pte->pte_low);
#else
               char str[PTVAL_STR_MAX];

               ptval_to_str(str, pte_val(*pte));
               pr_err("unexpected set PTE at %lx in set_pte_phys: bad pte %s.\n", addr, str);
#endif

> 
> -- 
> Cheers,
> 
> David
