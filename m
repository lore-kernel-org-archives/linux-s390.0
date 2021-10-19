Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0860CC433EF
	for <linux-s390@archiver.kernel.org>; Tue, 19 Oct 2021 17:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E716260FE8
	for <linux-s390@archiver.kernel.org>; Tue, 19 Oct 2021 17:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbhJSRlF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 19 Oct 2021 13:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbhJSRlF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Oct 2021 13:41:05 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D342C06161C
        for <linux-s390@vger.kernel.org>; Tue, 19 Oct 2021 10:38:52 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id kk10so521443pjb.1
        for <linux-s390@vger.kernel.org>; Tue, 19 Oct 2021 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RsMDv8TIPEq0+LaeWIxdShx9z/dydzJnIX6quHt9R6Q=;
        b=s8A5QWGcMjyRJK65mcAcZUNPhE3FgzjEkhyzWNoFOZKjRWtXcLPy+3Q94YkAHKuRB9
         eBuGf9HEp0wKvm+4WO+duYxNyMnz2li6YBVJYcGOx0kfACMdsyQAGbli7KTWlA9YshSm
         8KzgLyzDaUXjiBPIcISLnSa7g5t3TE6ekP9tSGfWHdtLb9+fVbQha1gMy9xTPL7kW1mn
         iNKAZ7dkdU5BnIwkSJ2L6X+CA4aJejKaH/YlerIWQceABV2jPT34P3oit9tROvaJv5Ua
         5OPClR1M5B2ZmQJsiVkzA1o+ZknhoZChDFp8OvjdA3Gd3PoTwpJwmeQ/8k2bVMZlu/q/
         LGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RsMDv8TIPEq0+LaeWIxdShx9z/dydzJnIX6quHt9R6Q=;
        b=Nh3sdoQ/TQzkvWqSCrRAejlHi09oMj3geN6cx/Y2/l0OFcNrFAezFQ+ugtiFjMF6FS
         HrCI7NihL2ahfloVj6IZT1js8NM5JdMkE3wN5QQb6V0WiTDW3XndCYEAs2WbHBSt02ya
         YvCF11Lt7zmcfUtB0CGgIR/baVKrag6ccHtsDaJWt45fzv1DvdyDJVW14uMRT9SIZKFl
         XyIJsEmb0Pv6TsPgtjjm6+rX2ItbP2IXsae5DtxkPVbqQsHvxYBjpb+Rmr+mtNWPVaEK
         NZCh7mYixtuZH3wRD956Y/LPTEJy+9Ucs77nJUWzlRVsoVgwbO9ISjhHYLebQUYn1tSB
         oGng==
X-Gm-Message-State: AOAM533+Q4YIzpmkMmsJ7MzNs/1Z13vEE3eY1KDIqIPAGaMAZqlcqT9v
        s1sjVsUCbj396HafyTLWL1rO/4LDdNH46yI2+qDqrg==
X-Google-Smtp-Source: ABdhPJxUtc06lLaLs1F436CM8/A0H7B/JaCfNLeNOv/ulNBrP+vM3Kr8Oj1iEshG6bpmzwRvoZ0e9CSHkabM6Kcibsc=
X-Received: by 2002:a17:902:b213:b0:13e:cd44:b4b5 with SMTP id
 t19-20020a170902b21300b0013ecd44b4b5mr34365056plr.18.1634665131843; Tue, 19
 Oct 2021 10:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210823214708.77979b3f@thinkpad> <CAPcyv4jijqrb1O5OOTd5ftQ2Q-5SVwNRM7XMQ+N3MAFxEfvxpA@mail.gmail.com>
 <e250feab-1873-c91d-5ea9-39ac6ef26458@oracle.com> <CAPcyv4jYXPWmT2EzroTa7RDz1Z68Qz8Uj4MeheQHPbBXdfS4pA@mail.gmail.com>
 <20210824202449.19d524b5@thinkpad> <CAPcyv4iFeVDVPn6uc=aKsyUvkiu3-fK-N16iJVZQ3N8oT00hWA@mail.gmail.com>
 <20211014230439.GA3592864@nvidia.com> <5ca908e3-b4ad-dfef-d75f-75073d4165f7@oracle.com>
 <20211018233045.GQ2744544@nvidia.com> <CAPcyv4i=Rsv3nNTH9LTc2BwCoMyDU639vdd9kVEzZXvuSY+dWA@mail.gmail.com>
 <20211019142032.GT2744544@nvidia.com>
In-Reply-To: <20211019142032.GT2744544@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Oct 2021 10:38:42 -0700
Message-ID: <CAPcyv4jAQVSKB7rts5Mfu0JRtB-b1NGFgu03+8-ja8o11d1vQA@mail.gmail.com>
Subject: Re: can we finally kill off CONFIG_FS_DAX_LIMITED
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Joao Martins <joao.m.martins@oracle.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Sierra <alex.sierra@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Linux MM <linux-mm@kvack.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Oct 19, 2021 at 7:25 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Oct 18, 2021 at 09:26:24PM -0700, Dan Williams wrote:
> > On Mon, Oct 18, 2021 at 4:31 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Fri, Oct 15, 2021 at 01:22:41AM +0100, Joao Martins wrote:
> > >
> > > > dev_pagemap_mapping_shift() does a lookup to figure out
> > > > which order is the page table entry represents. is_zone_device_page()
> > > > is already used to gate usage of dev_pagemap_mapping_shift(). I think
> > > > this might be an artifact of the same issue as 3) in which PMDs/PUDs
> > > > are represented with base pages and hence you can't do what the rest
> > > > of the world does with:
> > >
> > > This code is looks broken as written.
> > >
> > > vma_address() relies on certain properties that I maybe DAX (maybe
> > > even only FSDAX?) sets on its ZONE_DEVICE pages, and
> > > dev_pagemap_mapping_shift() does not handle the -EFAULT return. It
> > > will crash if a memory failure hits any other kind of ZONE_DEVICE
> > > area.
> >
> > That case is gated with a TODO in memory_failure_dev_pagemap(). I
> > never got any response to queries about what to do about memory
> > failure vs HMM.
>
> Unfortunately neither Logan nor Felix noticed that TODO conditional
> when adding new types..
>
> But maybe it is dead code anyhow as it already has this:
>
>         cookie = dax_lock_page(page);
>         if (!cookie)
>                 goto out;
>
> Right before? Doesn't that already always fail for anything that isn't
> a DAX?

Yes, I originally made that ordering mistake in:

6100e34b2526 mm, memory_failure: Teach memory_failure() about dev_pagemap pages

...however, if we complete the move away from page-less DAX it also
allows for the locking to move from the xarray to lock_page(). I.e.
dax_lock_page() is pinning the inode after the fact, but I suspect the
inode should have been pinned when the mapping was established. Which
raises a question for the reflink support whether it is pinning all
involved inodes while the mapping is established?

>
> > > I'm not sure the comment is correct anyhow:
> > >
> > >                 /*
> > >                  * Unmap the largest mapping to avoid breaking up
> > >                  * device-dax mappings which are constant size. The
> > >                  * actual size of the mapping being torn down is
> > >                  * communicated in siginfo, see kill_proc()
> > >                  */
> > >                 unmap_mapping_range(page->mapping, start, size, 0);
> > >
> > > Beacuse for non PageAnon unmap_mapping_range() does either
> > > zap_huge_pud(), __split_huge_pmd(), or zap_huge_pmd().
> > >
> > > Despite it's name __split_huge_pmd() does not actually split, it will
> > > call __split_huge_pmd_locked:
> > >
> > >         } else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
> > >                 goto out;
> > >         __split_huge_pmd_locked(vma, pmd, range.start, freeze);
> > >
> > > Which does
> > >         if (!vma_is_anonymous(vma)) {
> > >                 old_pmd = pmdp_huge_clear_flush_notify(vma, haddr, pmd);
> > >
> > > Which is a zap, not split.
> > >
> > > So I wonder if there is a reason to use anything other than 4k here
> > > for DAX?
> > >
> > > >       tk->size_shift = page_shift(compound_head(p));
> > > >
> > > > ... as page_shift() would just return PAGE_SHIFT (as compound_order() is 0).
> > >
> > > And what would be so wrong with memory failure doing this as a 4k
> > > page?
> >
> > device-dax does not support misaligned mappings. It makes hard
> > guarantees for applications that can not afford the page table
> > allocation overhead of sub-1GB mappings.
>
> memory-failure is the wrong layer to enforce this anyhow - if someday
> unmap_mapping_range() did learn to break up the 1GB pages then we'd
> want to put the condition to preserve device-dax mappings there, not
> way up in memory-failure.
>
> So we can just delete the detection of the page size and rely on the
> zap code to wipe out the entire level, not split it. Which is what we
> have today already.

As Joao points out, userspace wants to know the blast radius of the
unmap for historical reasons. I do think it's worth deprecating that
somehow... providing a better error management interface is part of
the DAX-reflink enabling.
