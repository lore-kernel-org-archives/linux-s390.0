Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A31DC433ED
	for <linux-s390@archiver.kernel.org>; Thu,  1 Apr 2021 20:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 729F2610CB
	for <linux-s390@archiver.kernel.org>; Thu,  1 Apr 2021 20:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbhDAULC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 1 Apr 2021 16:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbhDAULC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Apr 2021 16:11:02 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41964C0613E6;
        Thu,  1 Apr 2021 13:11:02 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b16so3271118eds.7;
        Thu, 01 Apr 2021 13:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhY6AEaLMMkgvg+FYNnHd9fBKmOOgfnIt8T40ozDuzs=;
        b=qhOpzzTG2HENwjAGLhQUT1qBNU1sZlK/ZyWlrgvFX3P9sUtMnlnWdLZp9Uo5cP2Fd6
         Hs/sownsomQPprhLo5myKczvg7bUA/PlLD+9lgatC7q4oPf8x7QJhRFe3PvNDz5iwe9u
         tbCIkWGZUsUSo5SPfrQefDj3XxpFfhs/TaiH0voqbJjPHCDj6hDZBjvvV2Cmj79jXL4Z
         GbV2XIqfwxAEQlIhpGxEvQVWFBFSxFWrA1iq55yN55TZrwu3ZCV6RcOgW+qtlLZYOZEL
         KR1CXcGAdiAAx9oQMNKA3s35SiIJtVQJ2dagGDzrBlZo8kernucRm3cusAPSJHYmDSTZ
         uw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhY6AEaLMMkgvg+FYNnHd9fBKmOOgfnIt8T40ozDuzs=;
        b=D7BfEclPjyOkEPpQJTbCZU97ZYkPvW848zkxFlw2bDb+te5/5zUuIN26UlbF2NPOfD
         6dVJGYmfo7SXx4crBsLmN0OckLtoc2eOLywr2PWUSPzOyc7Vubsqdl9/A3NFRtCe9wWR
         KuXYz7JQ8zPdH1gz99XfQ8oNFs3wo0PVUoaY00vOG8qtBzWdv/4IjeCDVYq+SXlafqMZ
         wGCvCmGOG4URudmdmyynSb1A/ZeWVTSCX3Nsys+4VLuIIwbpW921wn/+Z6R8fupQpNU/
         Fa3zFAvPIS0UjbofkjN+Fx440rZYPngOi+BMKYN+lNJSFCacHdiozRinCUf5K9b/DaTy
         /kQw==
X-Gm-Message-State: AOAM532cA88JfQTrNQ4LJRPDe05UF6wuljSxqCwFJ9KFUkr2mYP4ULDi
        AHnGpwnalfSgRkBnh4uRwUIQdcc/Mdsz6xBUd6Q=
X-Google-Smtp-Source: ABdhPJwmU2K77LdLdfvZWAExOfcct4DvD4TtqfUc5f/ANVMPG2uE3fZfJ2InJ7LexNueZknTnhK3VI3AE41ok9sI92Y=
X-Received: by 2002:aa7:cc03:: with SMTP id q3mr12039422edt.366.1617307861047;
 Thu, 01 Apr 2021 13:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210329183312.178266-1-shy828301@gmail.com> <20210330164200.01a4b78f@thinkpad>
 <CAHbLzkrYd+5L8Ep+b83PkkFL_QGQe_vSAk=erQ+fvC6dEOsGsw@mail.gmail.com> <20210331134727.47bc1e6d@thinkpad>
In-Reply-To: <20210331134727.47bc1e6d@thinkpad>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 1 Apr 2021 13:10:49 -0700
Message-ID: <CAHbLzkquYxq_eXoVhUCib9qu_aMS9U2XXjb5pop9JtJ8uco_vg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] mm: thp: use generic THP migration for NUMA
 hinting fault
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Mar 31, 2021 at 4:47 AM Gerald Schaefer
<gerald.schaefer@linux.ibm.com> wrote:
>
> On Tue, 30 Mar 2021 09:51:46 -0700
> Yang Shi <shy828301@gmail.com> wrote:
>
> > On Tue, Mar 30, 2021 at 7:42 AM Gerald Schaefer
> > <gerald.schaefer@linux.ibm.com> wrote:
> > >
> > > On Mon, 29 Mar 2021 11:33:06 -0700
> > > Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > >
> > > > When the THP NUMA fault support was added THP migration was not supported yet.
> > > > So the ad hoc THP migration was implemented in NUMA fault handling.  Since v4.14
> > > > THP migration has been supported so it doesn't make too much sense to still keep
> > > > another THP migration implementation rather than using the generic migration
> > > > code.  It is definitely a maintenance burden to keep two THP migration
> > > > implementation for different code paths and it is more error prone.  Using the
> > > > generic THP migration implementation allows us remove the duplicate code and
> > > > some hacks needed by the old ad hoc implementation.
> > > >
> > > > A quick grep shows x86_64, PowerPC (book3s), ARM64 ans S390 support both THP
> > > > and NUMA balancing.  The most of them support THP migration except for S390.
> > > > Zi Yan tried to add THP migration support for S390 before but it was not
> > > > accepted due to the design of S390 PMD.  For the discussion, please see:
> > > > https://lkml.org/lkml/2018/4/27/953.
> > > >
> > > > I'm not expert on S390 so not sure if it is feasible to support THP migration
> > > > for S390 or not.  If it is not feasible then the patchset may make THP NUMA
> > > > balancing not be functional on S390.  Not sure if this is a show stopper although
> > > > the patchset does simplify the code a lot.  Anyway it seems worth posting the
> > > > series to the mailing list to get some feedback.
> > >
> > > The reason why THP migration cannot work on s390 is because the migration
> > > code will establish swap ptes in a pmd. The pmd layout is very different from
> > > the pte layout on s390, so you cannot simply write a swap pte into a pmd.
> > > There are no separate swp primitives for swap/migration pmds, IIRC. And even
> > > if there were, we'd still need to find some space for a present bit in the
> > > s390 pmd, and/or possibly move around some other bits.
> > >
> > > A lot of things can go wrong here, even if it could be possible in theory,
> > > by introducing separate swp primitives in common code for pmd entries, along
> > > with separate offset, type, shift, etc. I don't see that happening in the
> > > near future.
> >
> > Thanks a lot for elaboration. IIUC, implementing migration PMD entry
> > is *not* prevented from by hardware, it may be very tricky to
> > implement it, right?
>
> Well, it depends. The HW is preventing proper full-blown swap + migration
> support for PMD, similar to what we have for PTE, because we simply don't
> have enough OS-defined bits in the PMD. A 5-bit swap type for example,
> similar to a PTE, plus the PFN would not be possible.
>
> The HW would not prevent a similar mechanism in principle, i.e. we could
> mark it as invalid to trigger a fault, and have some magic bits that tell
> the fault handler or migration code what it is about.
>
> For handling migration aspects only, w/o any swap device or other support, a
> single type bit could already be enough, to indicate read/write migration,
> plus a "present" bit similar to PTE. But even those 2 bits would be hard to
> find, though I would not entirely rule that out. That would be the tricky
> part.
>
> Then of course, common code would need some changes, to reflect the
> different swap/migration (type) capabilities of PTE and PMD entries.
> Not sure if such an approach would be acceptable for common code.
>
> But this is just some very abstract and optimistic view, I have not
> really properly looked into the details. So it might be even more
> tricky, or not possible at all.

Thanks a lot for the elaboration.

>
> >
> > >
> > > Not sure if this is a show stopper, but I am not familiar enough with
> > > NUMA and migration code to judge. E.g., I do not see any swp entry action
> > > in your patches, but I assume this is implicitly triggered by the switch
> > > to generic THP migration code.
> >
> > Yes, exactly. The migrate_pages() called by migrate_misplaced_page()
> > takes care of everything.
> >
> > >
> > > Could there be a work-around by splitting THP pages instead of marking them
> > > as migrate pmds (via pte swap entries), at least when THP migration is not
> > > supported? I guess it could also be acceptable if THP pages were simply not
> > > migrated for NUMA balancing on s390, but then we might need some extra config
> > > option to make that behavior explicit.
> >
> > Yes, it could be. The old behavior of migration was to return -ENOMEM
> > if THP migration is not supported then split THP. That behavior was
> > not very friendly to some usecases, for example, memory policy and
> > migration lieu of reclaim (the upcoming). But I don't mean we restore
> > the old behavior. We could split THP if it returns -ENOSYS and the
> > page is THP.
>
> OK, as long as we don't get any broken PMD migration entries established
> for s390, some extra THP splitting would be acceptable I guess.

There will be no migration PMD installed. The current behavior is a
no-op if THP migration is not supported.
