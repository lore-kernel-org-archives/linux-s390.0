Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321CA183098;
	Fri,  6 Dec 2024 05:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462855; cv=none; b=EaSjLPM9jKLmQHNeZnoJKHFlt53nM0SWKI6pKBzwzkNnQbZLNxaqBD/bstZ0P2qc02qNxsDhFGxi9+7MOfJt+d8/ldjC/B/dgQoVSoKxzGT49JymtvdHUHWftoRXgEw2mPZlEHe+xWB0tQslRoof2l1BhGV96GpKJouKl6wwY30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462855; c=relaxed/simple;
	bh=WSBGtj1x2wG7U0MI87fGKxHhdmlZVe1+cNXDaG4YCrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kg08mDTq71hwLkvbD9J+a2wrZN7EIjInuTVtceN+GCUWgqUUtn05gGqWKCNZU/S8+pPujdw47lMN68p2mnk5VKm4zGsfVHTrcejcSVMKDWfbWOl5H7v83vHKzBbZRd1Fqifu2dYo+DJ1j1Sy8BSoc+SWcWGMwAtR3EqH3p1x0H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=KRXj+3xq; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="KRXj+3xq"
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 99DE52003D0;
	Fri,  6 Dec 2024 06:27:10 +0100 (CET)
Authentication-Results: smtp2-g21.free.fr;
	dkim=pass (1024-bit key; unprotected) header.d=morinfr.org header.i=@morinfr.org header.a=rsa-sha256 header.s=20170427 header.b=KRXj+3xq;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=a0TgCH2F8hu00svqIVZfVT8cAOELTuTicrL+FYqAIPk=; b=KRXj+3xqZV/R9PSaEBPaTBjVsv
	v5gZWN+LgGPDwI/aN5JnBeUm+IqDEkUmLjsW2JpU0nH0q42K5aBkPp99JWped4q3e6DsKjec2PFNb
	8o9vTHFyTboE4c5bzTVAtXzV9i9le38vqkBUb69q3Wyi8shreSMYvRrB1GUjntOs2hjI=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1tJQrt-0022hx-2b;
	Fri, 06 Dec 2024 06:27:09 +0100
Date: Fri, 6 Dec 2024 06:27:09 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Guillaume Morin <guillaume@morinfr.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
	Eric Hagberg <ehagberg@janestreet.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3] mm/hugetlb: support FOLL_FORCE|FOLL_WRITE
Message-ID: <Z1KLLXpzrDac-oqF@bender.morinfr.org>
References: <Z1EJssqd93w2erMZ@bender.morinfr.org>
 <20241206045019.GA2215843@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206045019.GA2215843@thelio-3990X>

On 05 Dec 21:50, Nathan Chancellor wrote:
>
> Hi Guillaume and s390 folks,
> 
> On Thu, Dec 05, 2024 at 03:02:26AM +0100, Guillaume Morin wrote:
> > 
> > Eric reported that PTRACE_POKETEXT fails when applications use hugetlb
> > for mapping text using huge pages. Before commit 1d8d14641fd9
> > ("mm/hugetlb: support write-faults in shared mappings"), PTRACE_POKETEXT
> > worked by accident, but it was buggy and silently ended up mapping pages
> > writable into the page tables even though VM_WRITE was not set.
> > 
> > In general, FOLL_FORCE|FOLL_WRITE does currently not work with hugetlb.
> > Let's implement FOLL_FORCE|FOLL_WRITE properly for hugetlb, such that
> > what used to work in the past by accident now properly works, allowing
> > applications using hugetlb for text etc. to get properly debugged.
> > 
> > This change might also be required to implement uprobes support for
> > hugetlb [1].
> > 
> > [1] https://lore.kernel.org/lkml/ZiK50qob9yl5e0Xz@bender.morinfr.org/
> > 
> > Cc: Muchun Song <muchun.song@linux.dev>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Eric Hagberg <ehagberg@janestreet.com>
> > Signed-off-by: Guillaume Morin <guillaume@morinfr.org>
> > ---
> >  Changes in v2:
> >   - Improved commit message
> >  Changes in v3:
> >   - Fix potential unitialized mem access in follow_huge_pud
> >   - define pud_soft_dirty when soft dirty is not enabled
> > 
> >  include/linux/pgtable.h |  5 +++
> >  mm/gup.c                | 99 +++++++++++++++++++++--------------------
> >  mm/hugetlb.c            | 20 +++++----
> >  3 files changed, 66 insertions(+), 58 deletions(-)
> > 
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index adef9d6e9b1b..9335d7c82d20 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -1422,6 +1422,11 @@ static inline int pmd_soft_dirty(pmd_t pmd)
> >  	return 0;
> >  }
> >  
> > +static inline int pud_soft_dirty(pud_t pud)
> > +{
> > +	return 0;
> > +}
> > +
> >  static inline pte_t pte_mksoft_dirty(pte_t pte)
> >  {
> >  	return pte;
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 746070a1d8bf..cc3eae458013 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -587,6 +587,33 @@ static struct folio *try_grab_folio_fast(struct page *page, int refs,
> >  }
> >  #endif	/* CONFIG_HAVE_GUP_FAST */
> >  
> > +/* Common code for can_follow_write_* */
> > +static inline bool can_follow_write_common(struct page *page,
> > +		struct vm_area_struct *vma, unsigned int flags)
> > +{
> > +	/* Maybe FOLL_FORCE is set to override it? */
> > +	if (!(flags & FOLL_FORCE))
> > +		return false;
> > +
> > +	/* But FOLL_FORCE has no effect on shared mappings */
> > +	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
> > +		return false;
> > +
> > +	/* ... or read-only private ones */
> > +	if (!(vma->vm_flags & VM_MAYWRITE))
> > +		return false;
> > +
> > +	/* ... or already writable ones that just need to take a write fault */
> > +	if (vma->vm_flags & VM_WRITE)
> > +		return false;
> > +
> > +	/*
> > +	 * See can_change_pte_writable(): we broke COW and could map the page
> > +	 * writable if we have an exclusive anonymous page ...
> > +	 */
> > +	return page && PageAnon(page) && PageAnonExclusive(page);
> > +}
> > +
> >  static struct page *no_page_table(struct vm_area_struct *vma,
> >  				  unsigned int flags, unsigned long address)
> >  {
> > @@ -613,6 +640,22 @@ static struct page *no_page_table(struct vm_area_struct *vma,
> >  }
> >  
> >  #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
> > +/* FOLL_FORCE can write to even unwritable PUDs in COW mappings. */
> > +static inline bool can_follow_write_pud(pud_t pud, struct page *page,
> > +					struct vm_area_struct *vma,
> > +					unsigned int flags)
> > +{
> > +	/* If the pud is writable, we can write to the page. */
> > +	if (pud_write(pud))
> > +		return true;
> > +
> > +	if (!can_follow_write_common(page, vma, flags))
> > +		return false;
> > +
> > +	/* ... and a write-fault isn't required for other reasons. */
> > +	return !vma_soft_dirty_enabled(vma) || pud_soft_dirty(pud);
> 
> This looks to be one of the first uses of pud_soft_dirty() in a generic
> part of the tree from what I can tell, which shows that s390 is lacking
> it despite setting CONFIG_HAVE_ARCH_SOFT_DIRTY:
> 
>   $ make -skj"$(nproc)" ARCH=s390 CROSS_COMPILE=s390-linux- mrproper defconfig mm/gup.o
>   mm/gup.c: In function 'can_follow_write_pud':
>   mm/gup.c:665:48: error: implicit declaration of function 'pud_soft_dirty'; did you mean 'pmd_soft_dirty'? [-Wimplicit-function-declaration]
>     665 |         return !vma_soft_dirty_enabled(vma) || pud_soft_dirty(pud);
>         |                                                ^~~~~~~~~~~~~~
>         |                                                pmd_soft_dirty
> 
> Is this expected?

Yikes! It does look like an oversight in the s390 code since as you said
it has CONFIG_HAVE_ARCH_SOFT_DIRTY and pud_mkdirty seems to be setting
_REGION3_ENTRY_SOFT_DIRTY. But I'll let the s390 folks opine.

I don't mind dropping the pud part of the change (even if that's a bit
of a shame) if it's causing too many issues.

-- 
Guillaume Morin <guillaume@morinfr.org>
