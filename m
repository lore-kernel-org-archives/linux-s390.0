Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78436545282;
	Wed,  9 Sep 2026 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953456; cv=none; b=ae5u69Vp4E4pWIbAVf4+QSIh9K8iu28bfsIw/konpgia1Lm2bt5BID9urvjX99r4g2YmTXPT3hfDBdLHWmNfxFmOi2EOPvs073Qd68cI9ETmbQBg9mFftMZ+UV/pErcyjwiXQP8eEuXU69OdQVJSGt505wDvr2/u1s6UhKm6mBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953456; c=relaxed/simple;
	bh=uwCTyLsPZFegOhIaDNfbF8agqIRbk8zd7SHqNH79CIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIDorRaGYLmZUQZt9luBmwNBPwjdPxrB1fGRVm2HT/jaYA6FRCDOAWbue6hgHvQQnNR+LPGWDXIHEzwNmacKlqTKwfKjEMsAwA8SJdpwh3YqTAlsl5D/WL8E28j2317LZ8NADM0rpX7L61+6Ft1CU0Pp9MYz6Q5X40VnSYFOHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRybbNra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRybbNra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298341F00A3D;
	Wed,  9 Sep 2026 11:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953455;
	bh=kql9G2zdyt6ZJFywS3ZVlugu5+he5hLWWrL/U7LDx3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RRybbNral0sY22hhcoz6HaIyVeKE2oJFiF6t95RxLBLSdu/Oa4wlNWDh9LmfJ9Eed
	 iXwnxBS8UvyhyyE57jKgXr/6tickVpe3ztp4AHyPlz4bRgvGI9kDAB45C6BDzhdjCJ
	 8DanpZOh1L/5Q8EsGHQgey7kpOgynNjhYAF+g7ykpmkbABGn22U4EdFzyf/dJ5NRAf
	 nLKHz+pBsV8i9UA0K7CWArOItY9MyIUuLYt9vfX8Rwn1o795fOI2TbavG9pep8JZ1d
	 nEnvD1icU25l0X3w9kcBw+Zg5tB344SlJxTioXR+W8Y3BjJw9sSlwXW8OX5rUYPVZy
	 /RQC2Us4m8B+w==
Date: Wed, 9 Sep 2026 12:30:45 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Mark Rutland <mark.rutland@arm.com>, Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Marc Zyngier <maz@kernel.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 27/39] mm: rename is_vm_hugetlb_page() to vma_is_hugetlb()
Message-ID: <aqFDKJlj76O1hR2R@gremlin>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-27-dacf19cce22b@kernel.org>
 <20260909130141.2c5d250d@p-imbrenda>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909130141.2c5d250d@p-imbrenda>

On Wed, Sep 09, 2026 at 01:22:07PM +0200, Claudio Imbrenda wrote:
> On Tue, 08 Sep 2026 21:01:31 +0100
> "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
>
> [please note that I had to prune the CC list quite aggressively because
> my SMTP server was not happy]

Yeah sorry about that, I already pruned the list a LOT from what b4 wanted, and
still ended up with a ton of people (I consider maintainers for stuff I touch
the minimum cc, but also added mm reviewers).

>
> > The is_vm_hugetlb_page() predicate is badly named - the mapping can span
> > more than a page and it is inconsistent with other VMA predicates that
> > typically are prefixed by vma_.
> >
> > Rename to vma_is_hugetlb() for consistency, and while we're here update
> > some VM_BUG_ON_VMA() to VM_WARN_ON_ONCE_VMA() as to avoid unnecessary
> > oopses.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> for s390:
>
> Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Thanks!

>
> but please see the comment below
>
> > ---
> >  arch/arm64/kvm/mmu.c                      |  4 ++--
> >  arch/powerpc/mm/book3s64/radix_tlb.c      |  6 +++---
> >  arch/powerpc/mm/nohash/e500_hugetlbpage.c |  2 +-
> >  arch/powerpc/mm/nohash/tlb.c              |  2 +-
> >  arch/riscv/kvm/mmu.c                      |  2 +-
> >  arch/riscv/mm/tlbflush.c                  |  2 +-
> >  arch/s390/mm/gmap_helpers.c               |  6 +++---
> >  arch/sparc/mm/init_64.c                   |  2 +-
> >  drivers/gpu/drm/drm_gpusvm.c              |  2 +-
> >  fs/coredump.c                             |  2 +-
> >  fs/hugetlbfs/inode.c                      |  2 +-
> >  fs/proc/task_mmu.c                        |  8 ++++----
> >  include/asm-generic/tlb.h                 |  2 +-
> >  include/linux/hugetlb.h                   |  4 ++--
> >  include/linux/mm.h                        | 19 ++++++++++++++++---
> >  include/linux/rmap.h                      |  2 +-
> >  kernel/events/core.c                      |  2 +-
> >  kernel/sched/fair.c                       |  2 +-
> >  mm/gup.c                                  |  4 ++--
> >  mm/huge_memory.c                          |  2 +-
> >  mm/hugetlb.c                              | 14 +++++++-------
> >  mm/internal.h                             |  2 +-
> >  mm/madvise.c                              |  4 ++--
> >  mm/memory.c                               | 12 ++++++------
> >  mm/mempolicy.c                            |  2 +-
> >  mm/migrate_device.c                       |  2 +-
> >  mm/mmap.c                                 |  2 +-
> >  mm/mmu_gather.c                           |  2 +-
> >  mm/mprotect.c                             |  2 +-
> >  mm/mremap.c                               |  6 +++---
> >  mm/page_vma_mapped.c                      |  4 ++--
> >  mm/pagewalk.c                             |  2 +-
> >  mm/swapfile.c                             |  2 +-
> >  mm/userfaultfd.c                          | 26 +++++++++++++-------------
> >  mm/vma.c                                  |  8 ++++----
> >  mm/vmscan.c                               |  2 +-
> >  tools/testing/vma/include/stubs.h         |  2 +-
> >  37 files changed, 92 insertions(+), 79 deletions(-)
>
> [...]
>
> > diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
> > index ff63ffb1dbd2..3f6783b93e67 100644
> > --- a/arch/s390/mm/gmap_helpers.c
> > +++ b/arch/s390/mm/gmap_helpers.c
> > @@ -102,7 +102,7 @@ __context_unsafe(/* pte_unmap_unlock() not instrumented */)
> >
> >  	/* Find the vm address for the guest address */
> >  	vma = vma_lookup(mm, vmaddr);
> > -	if (!vma || is_vm_hugetlb_page(vma))
> > +	if (!vma || vma_is_hugetlb(vma))
> >  		return;
> >
> >  	/* Get pointer to the page table entry */
> > @@ -139,7 +139,7 @@ void gmap_helper_discard(struct mm_struct *mm, unsigned long vmaddr, unsigned lo
> >  		vma = find_vma_intersection(mm, vmaddr, end);
> >  		if (!vma)
> >  			return;
> > -		if (!is_vm_hugetlb_page(vma))
> > +		if (!vma_is_hugetlb(vma))
> >  			zap_vma_range(vma, vmaddr, min(end, vma->vm_end) - vmaddr);
> >  		vmaddr = vma->vm_end;
> >  	}
> > @@ -247,7 +247,7 @@ static int __gmap_helper_unshare_zeropages(struct mm_struct *mm)
> >  		 * proof to catch unexpected zeropages in other mappings and
> >  		 * fail.
> >  		 */
> > -		if ((vma->vm_flags & VM_PFNMAP) || is_vm_hugetlb_page(vma))
> > +		if ((vma->vm_flags & VM_PFNMAP) || vma_is_hugetlb(vma))
>
> Would it be possible to replace this ^ with !vma_can_gup() ?
>
> (obviously not in this patch, since vma_can_gup() is only introduced at
> the end of the series)

Sure, I could squash that into the 'use and apply vma_can_gup()' patch. Will do
on next respin!

>
> >  			continue;
> >  		addr = vma->vm_start;
> >
>
> [...]

--
Cheers, Lorenzo
