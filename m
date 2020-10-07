Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgJGTA1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 15:00:27 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2FDC0613D3
        for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2020 12:00:25 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id w5so1771609qvn.12
        for <linux-s390@vger.kernel.org>; Wed, 07 Oct 2020 12:00:25 -0700 (PDT)
Date: Wed, 7 Oct 2020 16:00:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 11/13] mm: add unsafe_follow_pfn
Message-ID: <20201007190023.GA5177@ziepe.ca>
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-12-daniel.vetter@ffwll.ch>
 <20201007173647.GW5177@ziepe.ca>
 <CAKMK7uE9sbK_tGhJbsnHgD9rOnx-dr=2xmpMw7RvvvpPLnjVVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uE9sbK_tGhJbsnHgD9rOnx-dr=2xmpMw7RvvvpPLnjVVA@mail.gmail.com>
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>

On Wed, Oct 07, 2020 at 08:10:34PM +0200, Daniel Vetter wrote:
> On Wed, Oct 7, 2020 at 7:36 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Oct 07, 2020 at 06:44:24PM +0200, Daniel Vetter wrote:
> > > Way back it was a reasonable assumptions that iomem mappings never
> > > change the pfn range they point at. But this has changed:
> > >
> > > - gpu drivers dynamically manage their memory nowadays, invalidating
> > > ptes with unmap_mapping_range when buffers get moved
> > >
> > > - contiguous dma allocations have moved from dedicated carvetouts to
> > > cma regions. This means if we miss the unmap the pfn might contain
> > > pagecache or anon memory (well anything allocated with GFP_MOVEABLE)
> > >
> > > - even /dev/mem now invalidates mappings when the kernel requests that
> > > iomem region when CONFIG_IO_STRICT_DEVMEM is set, see 3234ac664a87
> > > ("/dev/mem: Revoke mappings when a driver claims the region")
> > >
> > > Accessing pfns obtained from ptes without holding all the locks is
> > > therefore no longer a good idea.
> > >
> > > Unfortunately there's some users where this is not fixable (like v4l
> > > userptr of iomem mappings) or involves a pile of work (vfio type1
> > > iommu). For now annotate these as unsafe and splat appropriately.
> > >
> > > This patch adds an unsafe_follow_pfn, which later patches will then
> > > roll out to all appropriate places.
> > >
> > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > Cc: Jérôme Glisse <jglisse@redhat.com>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-samsung-soc@vger.kernel.org
> > > Cc: linux-media@vger.kernel.org
> > > Cc: kvm@vger.kernel.org
> > >  include/linux/mm.h |  2 ++
> > >  mm/memory.c        | 32 +++++++++++++++++++++++++++++++-
> > >  mm/nommu.c         | 17 +++++++++++++++++
> > >  security/Kconfig   | 13 +++++++++++++
> > >  4 files changed, 63 insertions(+), 1 deletion(-)
> >
> > Makes sense to me.
> >
> > I wonder if we could change the original follow_pfn to require the
> > ptep and then lockdep_assert_held() it against the page table lock?
> 
> The safe variant with the pagetable lock is follow_pte_pmd. The only
> way to make follow_pfn safe is if you have an mmu notifier and
> corresponding retry logic. That is not covered by lockdep (it would
> splat if we annotate the retry side), so I'm not sure how you'd check
> for that?

Right OK.

> Checking for ptep lock doesn't work here, since the one leftover safe
> user of this (kvm) doesn't need that at all, because it has the mmu
> notifier.

Ah, so a better name and/or function kdoc for follow_pfn is probably a
good iead in this patch as well.

> So I think we're as good as it gets, since I really have no idea how
> to make sure follow_pfn callers do have an mmu notifier registered.

Yah, can't be done. Most mmu notifier users should be using
hmm_range_fault anyhow, kvm is really very special here.
 
> I've followed the few other CONFIG_STRICT_FOO I've seen, which are all
> explicit enables and default to "do not break uapi, damn the
> (security) bugs". Which is I think how this should be done. It is in
> the security section though, so hopefully competent distros will
> enable this all.

I thought the strict ones were more general and less clear security
worries, not bugs like this.

This is "allow a user triggerable use after free bug to exist in the
kernel"

Jason
