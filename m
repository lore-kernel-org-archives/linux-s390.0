Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3D1C433ED
	for <linux-s390@archiver.kernel.org>; Wed, 14 Apr 2021 17:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED0A61164
	for <linux-s390@archiver.kernel.org>; Wed, 14 Apr 2021 17:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhDNRYD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 14 Apr 2021 13:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbhDNRYC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 14 Apr 2021 13:24:02 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1947C061574;
        Wed, 14 Apr 2021 10:23:40 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id n8so34573201lfh.1;
        Wed, 14 Apr 2021 10:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+il15X05sw6jfbqyJki/liuLUGbceDaIbQpvsMIJYM=;
        b=qEjVlHZmmX1p5X4E+Ed3peLTi6x8M+c2mIxaHN5mZcydS6W14GqF3OWFGSp+IUatYp
         B+C88ODYHEsCWvXKhU1MIri3xFKsr3wViMbvBs7doZ7Bu7q/bR/wd4RVmjVe6rKxOt1A
         ulJ2Nkwym0mEfKrsSZBK9KT+rhj0VC1C4GeNKEXsikAcB7vMz3tc4k12yUTTGxYQ1uSU
         PApHzhzqT/PiXrPFkHfA8TI7EHbN/kTyOYGIreBb2vKhFAqhZ2mASskTuVvEON5jzWrA
         ZGJjLw8yRqiLidMbagMUTxwF6qbmmaSzGMoT5k2NK2Wzh0wx1OKBpP39P11GWY8FsB/v
         HUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+il15X05sw6jfbqyJki/liuLUGbceDaIbQpvsMIJYM=;
        b=TzNTlAoaM3nz+4HmuUNZ7yShNsxQpHhb4fUuJC2xRkWpcavzLd91ViLo5j7GDZHi5z
         iGWJwZ9HaPtu3Wlby6ngO6hsZeOrxgEROtvqzekAePTXjfJxq4s4U/uGCdrU/O3fbmVT
         VMFLpk96DcizBDGsZWP6FqNZ7NMUIWnSMMb4EyYo1EILzasdyW8mQPg78quxOKfaIr2X
         rUym7kWNoxprlc6gUig+frtl07MFd+zKwhswJqc9q/iqt79V4XEi2Eey9UnSoUYOn9Fo
         YctZv+fP3BmgQ2jIsU7C5ENwKTTu4WEJhVgfC4Ob8rF1tWGkdqEdFuRmV2W4EALiAg7r
         YG2g==
X-Gm-Message-State: AOAM533np2qYQV5mjDmyzHQyQc2iM1Cdi2UzDJDK+8XfzTGYidhbOTGY
        qgor1VMgjuNJ/RR7gEkymuvMCYrbXng2GZrvxjo=
X-Google-Smtp-Source: ABdhPJxdr8TaZk1u62cex6MT9eBDDDqmaoqo9dtOxmaerx/6zsFsDFvIqOt3Qza+lIZPPATtjnVuPZZbKt5DCOZWMsk=
X-Received: by 2002:ac2:4216:: with SMTP id y22mr2929537lfh.422.1618421019526;
 Wed, 14 Apr 2021 10:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210413212416.3273-1-shy828301@gmail.com> <20210413212416.3273-7-shy828301@gmail.com>
 <87k0p5sh7h.fsf@yhuang6-desk1.ccr.corp.intel.com>
In-Reply-To: <87k0p5sh7h.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 14 Apr 2021 10:23:25 -0700
Message-ID: <CAHbLzkoZ_vbw-VcU6x8T=mUBREFPkZg3WHA4cuk9ff8o3i+95Q@mail.gmail.com>
Subject: Re: [v2 PATCH 6/7] mm: migrate: check mapcount for THP instead of ref count
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Apr 13, 2021 at 8:00 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yang Shi <shy828301@gmail.com> writes:
>
> > The generic migration path will check refcount, so no need check refcount here.
> > But the old code actually prevents from migrating shared THP (mapped by multiple
> > processes), so bail out early if mapcount is > 1 to keep the behavior.
>
> What prevents us from migrating shared THP?  If no, why not just remove
> the old refcount checking?

We could migrate shared THP if we don't care about the bounce back and
forth between nodes as Zi Yan described. The other reason is, as I
mentioned in the cover letter,  I'd like to keep the behavior as
consistent as possible between before and after for now. The old
behavior does prevent migrating shared THP, so I did so in this
series. We definitely could optimize the behavior later on.

>
> Best Regards,
> Huang, Ying
>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/migrate.c | 16 ++++------------
> >  1 file changed, 4 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index a72994c68ec6..dc7cc7f3a124 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2067,6 +2067,10 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
> >
> >       VM_BUG_ON_PAGE(compound_order(page) && !PageTransHuge(page), page);
> >
> > +     /* Do not migrate THP mapped by multiple processes */
> > +     if (PageTransHuge(page) && page_mapcount(page) > 1)
> > +             return 0;
> > +
> >       /* Avoid migrating to a node that is nearly full */
> >       if (!migrate_balanced_pgdat(pgdat, compound_nr(page)))
> >               return 0;
> > @@ -2074,18 +2078,6 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
> >       if (isolate_lru_page(page))
> >               return 0;
> >
> > -     /*
> > -      * migrate_misplaced_transhuge_page() skips page migration's usual
> > -      * check on page_count(), so we must do it here, now that the page
> > -      * has been isolated: a GUP pin, or any other pin, prevents migration.
> > -      * The expected page count is 3: 1 for page's mapcount and 1 for the
> > -      * caller's pin and 1 for the reference taken by isolate_lru_page().
> > -      */
> > -     if (PageTransHuge(page) && page_count(page) != 3) {
> > -             putback_lru_page(page);
> > -             return 0;
> > -     }
> > -
> >       page_lru = page_is_file_lru(page);
> >       mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_lru,
> >                               thp_nr_pages(page));
