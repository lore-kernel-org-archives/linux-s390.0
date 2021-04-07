Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E8EC433B4
	for <linux-s390@archiver.kernel.org>; Wed,  7 Apr 2021 08:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B7A61246
	for <linux-s390@archiver.kernel.org>; Wed,  7 Apr 2021 08:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbhDGIcj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 7 Apr 2021 04:32:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:53002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244921AbhDGIci (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 7 Apr 2021 04:32:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3DD8DAFCF;
        Wed,  7 Apr 2021 08:32:19 +0000 (UTC)
Date:   Wed, 7 Apr 2021 09:32:16 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Yang Shi <shy828301@gmail.com>
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
Subject: Re: [RFC PATCH 0/6] mm: thp: use generic THP migration for NUMA
 hinting fault
Message-ID: <20210407083216.GB15768@suse.de>
References: <20210329183312.178266-1-shy828301@gmail.com>
 <20210330164200.01a4b78f@thinkpad>
 <CAHbLzkrYd+5L8Ep+b83PkkFL_QGQe_vSAk=erQ+fvC6dEOsGsw@mail.gmail.com>
 <20210331134727.47bc1e6d@thinkpad>
 <CAHbLzkquYxq_eXoVhUCib9qu_aMS9U2XXjb5pop9JtJ8uco_vg@mail.gmail.com>
 <20210406140251.2779c400@thinkpad>
 <CAHbLzkr2+CnY8+ENB_Hvt7kJPKNq3H2aG=RsOBmBE_dYciqstw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAHbLzkr2+CnY8+ENB_Hvt7kJPKNq3H2aG=RsOBmBE_dYciqstw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Apr 06, 2021 at 09:42:07AM -0700, Yang Shi wrote:
> On Tue, Apr 6, 2021 at 5:03 AM Gerald Schaefer
> <gerald.schaefer@linux.ibm.com> wrote:
> >
> > On Thu, 1 Apr 2021 13:10:49 -0700
> > Yang Shi <shy828301@gmail.com> wrote:
> >
> > [...]
> > > > >
> > > > > Yes, it could be. The old behavior of migration was to return -ENOMEM
> > > > > if THP migration is not supported then split THP. That behavior was
> > > > > not very friendly to some usecases, for example, memory policy and
> > > > > migration lieu of reclaim (the upcoming). But I don't mean we restore
> > > > > the old behavior. We could split THP if it returns -ENOSYS and the
> > > > > page is THP.
> > > >
> > > > OK, as long as we don't get any broken PMD migration entries established
> > > > for s390, some extra THP splitting would be acceptable I guess.
> > >
> > > There will be no migration PMD installed. The current behavior is a
> > > no-op if THP migration is not supported.
> >
> > Ok, just for completeness, since Mel also replied that the split
> > was not done on other architectures "because the loss from splitting
> > exceeded the gain of improved locality":
> >
> > I did not mean to request extra splitting functionality for s390,
> > simply skipping / ignoring large PMDs would also be fine for s390,
> > no need to add extra complexity.
> 
> Thank you. It could make life easier. The current code still converts
> huge PMD to RPOTNONE even though THP migration is not supported. It is
> easy to skip such PMDs hence cycles are saved for pointless NUMA
> hinting page faults.
> 
> Will do so in v2 if no objection from Mel as well.

I did not get a chance to review this in time but if a v2 shows up,
I'll at least run it through a battery of tests to measure the impact
and hopefully find the time to do a proper review. Superficially I'm not
opposed to using generic code for migration because even if it shows up a
problem, it would be better to optimise the generic implementation than
carry two similar implementations. I'm undecided on whether s390 should
split+migrate rather than skip because I do not have a good overview of
"typical workloads on s390 that benefit from NUMA balancing".

-- 
Mel Gorman
SUSE Labs
