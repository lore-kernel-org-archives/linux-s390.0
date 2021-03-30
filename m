Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38340C433DB
	for <linux-s390@archiver.kernel.org>; Tue, 30 Mar 2021 16:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2A9619CD
	for <linux-s390@archiver.kernel.org>; Tue, 30 Mar 2021 16:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhC3Q5k (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 30 Mar 2021 12:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhC3Q52 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 30 Mar 2021 12:57:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D508DC061574;
        Tue, 30 Mar 2021 09:57:26 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u5so25884092ejn.8;
        Tue, 30 Mar 2021 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XfVc4bp3tv0baSA+ilwDRzBCXkderlgKxQptH0HURI=;
        b=FXDblg0wNnodckIP6GMY3vTyctrhMiYtey2021Tp4EOt16c88je16Z2zkEouQy9i7C
         YjC8ViVk3IbidZDd4L8UFnw8ivbm3n2yfucm8JelQB9ycBPKMM7zI+pRY1SiuKf2d4Tr
         CE7Og6EYft9PllVA0v0xxmyCkszijaerPrLtzD8ErcTGzpJyETftvIWiRxgN1ontC8h5
         zQwdQ4KnJ7WrBcTi2buhD55a/AzVj1VuQ8kwKypa3gDFWT/ssEfB3cafF4cPQV6z/vIm
         xQ0Do6WwvOdLl1Bf9IKVA/fo/S7KBVIalDxEKHYF02vif6E6MgcI1GkBaMFWTkXDl/b5
         SU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XfVc4bp3tv0baSA+ilwDRzBCXkderlgKxQptH0HURI=;
        b=HCY8PAIBtEsWJw61XD4VQECY8K+2Dcq/sMXAxIXVP9AgvnrBk2yRa50aCvgnDWKOXT
         dsMH8q2wMvmVkDJiLIuvgnd7webDhpb1+7QYyEVS58N6XO5iMdgmNAkRyH8U16b3r/rw
         mobjdcYns0L+bQhcdyKHmtvl4JsxO7mKzWLGJdfNxE0DN48yUQe5x88xLOVZYU43Yt0x
         8nbELWyjdGxdlra1c1B6KXkicyXZiWuhD32TsPsageRy6op2P81JDNJRJ0o9suwHN+Zt
         Wj41GJj1QRODUAhV718NNKJYBdtMzrB0RiQp6KLjVMxf7jAncFtQEs5Y2nbkst5v882J
         cUyw==
X-Gm-Message-State: AOAM5305dHiN5aYZUi8rKgkmugvHkPKM7srJTOtr4hnLLd+6RNOmERyX
        j5GfK9qACBJSzwuc9TI7+fxYqoG717k35rTTaXU=
X-Google-Smtp-Source: ABdhPJzqmI1tqocjFgXr/ivxD3GjusCtTDyrS1vQ7POxVI58Kmtv7oI6yaTYepmOHpzjpz0uwyxOen0NcRHj+/bW5FI=
X-Received: by 2002:a17:906:bcfc:: with SMTP id op28mr33921639ejb.238.1617123445646;
 Tue, 30 Mar 2021 09:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210329183312.178266-1-shy828301@gmail.com> <20210329183312.178266-4-shy828301@gmail.com>
 <87ft0dbif0.fsf@yhuang6-desk1.ccr.corp.intel.com>
In-Reply-To: <87ft0dbif0.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 30 Mar 2021 09:57:13 -0700
Message-ID: <CAHbLzkqQGM-pFv3S1z5nfOK9FZpKNsZsCg62MBKBRKghYCV2Cw@mail.gmail.com>
Subject: Re: [PATCH 3/6] mm: migrate: teach migrate_misplaced_page() about THP
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Mar 29, 2021 at 5:21 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yang Shi <shy828301@gmail.com> writes:
>
> > In the following patch the migrate_misplaced_page() will be used to migrate THP
> > for NUMA faul too.  Prepare to deal with THP.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/migrate.h | 6 ++++--
> >  mm/memory.c             | 2 +-
> >  mm/migrate.c            | 2 +-
> >  3 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> > index 3a389633b68f..6abd34986cc5 100644
> > --- a/include/linux/migrate.h
> > +++ b/include/linux/migrate.h
> > @@ -102,14 +102,16 @@ static inline void __ClearPageMovable(struct page *page)
> >  #ifdef CONFIG_NUMA_BALANCING
> >  extern bool pmd_trans_migrating(pmd_t pmd);
> >  extern int migrate_misplaced_page(struct page *page,
> > -                               struct vm_area_struct *vma, int node);
> > +                               struct vm_area_struct *vma, int node,
> > +                               bool compound);
> >  #else
> >  static inline bool pmd_trans_migrating(pmd_t pmd)
> >  {
> >       return false;
> >  }
> >  static inline int migrate_misplaced_page(struct page *page,
> > -                                      struct vm_area_struct *vma, int node)
> > +                                      struct vm_area_struct *vma, int node,
> > +                                      bool compound)
> >  {
> >       return -EAGAIN; /* can't migrate now */
> >  }
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 003bbf3187d4..7fed578bdc31 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4169,7 +4169,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
> >       }
> >
> >       /* Migrate to the requested node */
> > -     migrated = migrate_misplaced_page(page, vma, target_nid);
> > +     migrated = migrate_misplaced_page(page, vma, target_nid, false);
> >       if (migrated) {
> >               page_nid = target_nid;
> >               flags |= TNF_MIGRATED;
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 62b81d5257aa..9c4ae5132919 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2127,7 +2127,7 @@ static inline bool is_shared_exec_page(struct vm_area_struct *vma,
> >   * the page that will be dropped by this function before returning.
> >   */
> >  int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
> > -                        int node)
> > +                        int node, bool compound)
>
> Can we just use PageCompound(page) instead?

Yes, I think so. The current base page NUMA hinting does bail out
early if PTE mapped THP is met. So the THP just could be PMD mapped as
long as it reaches here.

>
> Best Regards,
> Huang, Ying
>
> >  {
> >       pg_data_t *pgdat = NODE_DATA(node);
> >       int isolated;
>
