Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9CCC433B4
	for <linux-s390@archiver.kernel.org>; Wed,  7 Apr 2021 16:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBDB361279
	for <linux-s390@archiver.kernel.org>; Wed,  7 Apr 2021 16:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354056AbhDGQEe (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 7 Apr 2021 12:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354057AbhDGQEa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Apr 2021 12:04:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C25C061756;
        Wed,  7 Apr 2021 09:04:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f8so17508575edd.11;
        Wed, 07 Apr 2021 09:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=op4TsYb9L+Os+5jr7ylMDYwPLUPBqNqA4fcsqXHq3Wk=;
        b=Tdvg1oYPZp2K1uARDf9y4/9JB2yOZWQlEArFn0261kIgqnoJEk106RXaJeLgve6Z8y
         OQGlWOW2kvxoM5CL5DnLgNgh6uhTLiCLcTHA4jsKqHDioifuRoJKmu/Fbhj8SHnCYU+p
         EpLpcbmV7GFRVk7lPrqsfo2Xz1sqfk2maSU0TxPPmXU4veSxeoyWhkrvsrI3EjkB8oQb
         P/d6FD3tU9r/2FEffrrH/eRAnGURKGC0BB+7DUQMBnf70NjrKkiJ4G/TUPWvtl3kjB5C
         Xysyog/G6wth+TWNUUJtbwDPFtBCFfeh70n6cnp0DYD7rhRCWQU1cabICKona1lAF3V1
         nQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=op4TsYb9L+Os+5jr7ylMDYwPLUPBqNqA4fcsqXHq3Wk=;
        b=gVhBj3ni70bAWO4M9QrfKNCsPPE/7/k8vnaKO6TPZ+5R8ibCXciHTYdWnhk2/+KhbQ
         KOVkFpv36JtPmMyoTYh8BUBBZqehvcXZO3KOA6Iu6QPeYBQ78Cm0d3Gc+ySqQPtN8ITK
         gix49Jw+SJgza2fDwWTGbudVeuxzzreVtbAIIMprfZQSQyI3ka5g0KTUPHKod9Ln4dKW
         sKatT+9owkuV7o+ROn2Q23BWrWPo1oNOmYaP3Mcuen9LdpxG0/9mPWX2Lw3PaxPoYIVs
         ERUGLLbHaqkQL0hZi4xQg6kp2B1LEdceQIyJVWuiH5zm5rgzxnv66zeNGWio2dX4n0gJ
         FYKQ==
X-Gm-Message-State: AOAM531XUmO5eHpUd4OuDI/ZiPmpt36N+ofz5IR3CvUa8dMqBQr0qSe0
        TAER+re2vIBpn9jhGItKDup4tT+MRJ9/0yKVEC0=
X-Google-Smtp-Source: ABdhPJxVgmXNHdO6xt+z/gjM2KguypkKOvh8JrzaaUsE4+0yegAJMtShuAFRzf5bEJN5JFjF+hH7tan31pxH7CyzanM=
X-Received: by 2002:a05:6402:518d:: with SMTP id q13mr5352557edd.313.1617811457825;
 Wed, 07 Apr 2021 09:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210329183312.178266-1-shy828301@gmail.com> <20210330164200.01a4b78f@thinkpad>
 <CAHbLzkrYd+5L8Ep+b83PkkFL_QGQe_vSAk=erQ+fvC6dEOsGsw@mail.gmail.com>
 <20210331134727.47bc1e6d@thinkpad> <CAHbLzkquYxq_eXoVhUCib9qu_aMS9U2XXjb5pop9JtJ8uco_vg@mail.gmail.com>
 <20210406140251.2779c400@thinkpad> <CAHbLzkr2+CnY8+ENB_Hvt7kJPKNq3H2aG=RsOBmBE_dYciqstw@mail.gmail.com>
 <20210407083216.GB15768@suse.de>
In-Reply-To: <20210407083216.GB15768@suse.de>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 7 Apr 2021 09:04:05 -0700
Message-ID: <CAHbLzkqHm5V6KA31wTtgF8kswJ_Cjne72FGgiFk3hLvC9AsHsw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] mm: thp: use generic THP migration for NUMA
 hinting fault
To:     Mel Gorman <mgorman@suse.de>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
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

On Wed, Apr 7, 2021 at 1:32 AM Mel Gorman <mgorman@suse.de> wrote:
>
> On Tue, Apr 06, 2021 at 09:42:07AM -0700, Yang Shi wrote:
> > On Tue, Apr 6, 2021 at 5:03 AM Gerald Schaefer
> > <gerald.schaefer@linux.ibm.com> wrote:
> > >
> > > On Thu, 1 Apr 2021 13:10:49 -0700
> > > Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > [...]
> > > > > >
> > > > > > Yes, it could be. The old behavior of migration was to return -ENOMEM
> > > > > > if THP migration is not supported then split THP. That behavior was
> > > > > > not very friendly to some usecases, for example, memory policy and
> > > > > > migration lieu of reclaim (the upcoming). But I don't mean we restore
> > > > > > the old behavior. We could split THP if it returns -ENOSYS and the
> > > > > > page is THP.
> > > > >
> > > > > OK, as long as we don't get any broken PMD migration entries established
> > > > > for s390, some extra THP splitting would be acceptable I guess.
> > > >
> > > > There will be no migration PMD installed. The current behavior is a
> > > > no-op if THP migration is not supported.
> > >
> > > Ok, just for completeness, since Mel also replied that the split
> > > was not done on other architectures "because the loss from splitting
> > > exceeded the gain of improved locality":
> > >
> > > I did not mean to request extra splitting functionality for s390,
> > > simply skipping / ignoring large PMDs would also be fine for s390,
> > > no need to add extra complexity.
> >
> > Thank you. It could make life easier. The current code still converts
> > huge PMD to RPOTNONE even though THP migration is not supported. It is
> > easy to skip such PMDs hence cycles are saved for pointless NUMA
> > hinting page faults.
> >
> > Will do so in v2 if no objection from Mel as well.
>
> I did not get a chance to review this in time but if a v2 shows up,
> I'll at least run it through a battery of tests to measure the impact
> and hopefully find the time to do a proper review. Superficially I'm not
> opposed to using generic code for migration because even if it shows up a
> problem, it would be better to optimise the generic implementation than
> carry two similar implementations. I'm undecided on whether s390 should
> split+migrate rather than skip because I do not have a good overview of
> "typical workloads on s390 that benefit from NUMA balancing".

Thanks, Mel. I don't have an idea about S390 either. I will just skip
huge PMDs for S390 for now as Gerald suggested.

>
> --
> Mel Gorman
> SUSE Labs
