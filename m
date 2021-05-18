Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B71C433ED
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 07:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E3C76117A
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 07:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242140AbhERHhk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 May 2021 03:37:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:37158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242101AbhERHhj (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 May 2021 03:37:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64836AAFD;
        Tue, 18 May 2021 07:36:21 +0000 (UTC)
Date:   Tue, 18 May 2021 08:36:18 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Yang Shi <shy828301@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH 1/7] mm: memory: add orig_pmd to struct vm_fault
Message-ID: <20210518073618.GA3672@suse.de>
References: <20210413212416.3273-1-shy828301@gmail.com>
 <20210413212416.3273-2-shy828301@gmail.com>
 <20210517150922.GU3672@suse.de>
 <CAHbLzkoj6Vn_jjWrn99oio1Oi+D4CHw9Z+6Wy4Squz-jCh2DKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAHbLzkoj6Vn_jjWrn99oio1Oi+D4CHw9Z+6Wy4Squz-jCh2DKw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 17, 2021 at 12:39:49PM -0700, Yang Shi wrote:
> On Mon, May 17, 2021 at 8:09 AM Mel Gorman <mgorman@suse.de> wrote:
> >
> > On Tue, Apr 13, 2021 at 02:24:10PM -0700, Yang Shi wrote:
> > > Add orig_pmd to struct vm_fault so the "orig_pmd" parameter used by huge page
> > > fault could be removed, just like its PTE counterpart does.
> > >
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > >
> > > <SNIP>
> > >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 25b9041f9925..9c5856f8cc81 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -547,6 +547,9 @@ struct vm_fault {
> > >                                        * the 'address'
> > >                                        */
> > >       pte_t orig_pte;                 /* Value of PTE at the time of fault */
> > > +     pmd_t orig_pmd;                 /* Value of PMD at the time of fault,
> > > +                                      * used by PMD fault only.
> > > +                                      */
> > >
> > >       struct page *cow_page;          /* Page handler may use for COW fault */
> > >       struct page *page;              /* ->fault handlers should return a
> >
> > Could this be a union?
> 
> Do you mean orig_pte and orig_pmd, or cow_page and page?

orig_pte and orig_pmd given that one for PTE faults and one is for PMD
faults and it's very unlikely they would both need to be considered during
a single fault.

-- 
Mel Gorman
SUSE Labs
