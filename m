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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9E4C433DB
	for <linux-s390@archiver.kernel.org>; Tue, 30 Mar 2021 16:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F9061954
	for <linux-s390@archiver.kernel.org>; Tue, 30 Mar 2021 16:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhC3QxU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 30 Mar 2021 12:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbhC3QxO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 30 Mar 2021 12:53:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B60C061574;
        Tue, 30 Mar 2021 09:53:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id w3so25886222ejc.4;
        Tue, 30 Mar 2021 09:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDPKwOgaNtuLy8HADDzZv+0fyVoW5LtAh6tAlz9JJjQ=;
        b=nynAqfNbY+ydK0ogMiiI0jzRpX/AiFs4naJXjQphpjQx10oPU1+TffpOooeafTP5D4
         sEsnBKV/6dwiuUVpwvvJst2dzTCy9UI6/Qyu8YxRDIRSlbc554Rx/Bv9ySa7cx41TGeC
         FCkP+gKIRz9A+D0RNB07Acf9R8ys+fp/bQ1D7FBwHC7lg6ozrXnQrnDYEw1OslzwqC58
         tOYCneB2EPe08mHVrJw2PH10m60SjNwm4kycCwdELq7UMY23i3288fa9auTLLe0cc/W7
         Uk51QsGO/dZi5qI/tfyaMswZoeoidMgmEY0SqyUVpCASC5j4uYKAizx7HLU88wHWipqv
         tBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDPKwOgaNtuLy8HADDzZv+0fyVoW5LtAh6tAlz9JJjQ=;
        b=VWv9c5OCYfjBNWE/zfkO3iJW2addz9j92S5q0VY8uPfboKJ0/EyijkXhi52bJ4T+aF
         xb6IJnxXThoaJzAzRQRAod9FXAXT5yx+wsVpBNsnTz4nj1Kn+JaXZR49Nbb3rVbRUiR0
         9RWxqrCwfHn8sKyErOi/2C+Zt3Xp/KK9+v4xxa1sMy5S/fbWyC/nd5NhpFAMPWcrNPTd
         i36TeRdd2sgj0HiJUXmcgPk1+yn9BE/LEcPLB6uF3U9sWNnBcM/qeYAtvcfygYnUwmA4
         vV8hr9AUq2yKj6uKG1XkGK1pURFJ9LfJ8IidXiCxMJMVZZF749WvABZaDuo/HxcyXw0a
         l8gQ==
X-Gm-Message-State: AOAM531VL2NbHGKZhkUucolLlD/ab8U0+qLmz21JbLtZ9X8wJ+s5BhVh
        hnO2ZFlpCi3HV+3Ognfg7mlpOOsWmAtvzSVTvq8=
X-Google-Smtp-Source: ABdhPJzQkqtXRjQQNfasrAxhS2Owc15KpQZWsJrOKpu8LvK9Sx0DLVUo1W1FyJoFcqPE/GEuSGSdAG+tBq2YywViR10=
X-Received: by 2002:a17:906:4bce:: with SMTP id x14mr33384490ejv.383.1617123192815;
 Tue, 30 Mar 2021 09:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210329183312.178266-1-shy828301@gmail.com> <20210329183312.178266-6-shy828301@gmail.com>
 <20210330164207.3a2826f7@thinkpad>
In-Reply-To: <20210330164207.3a2826f7@thinkpad>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 30 Mar 2021 09:53:01 -0700
Message-ID: <CAHbLzkpQQpvaq=PTCC7+ML8LSan=x9CyB7y9wpO3_7NFJA3tsw@mail.gmail.com>
Subject: Re: [PATCH 5/6] mm: migrate: don't split THP for misplaced NUMA page
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

On Tue, Mar 30, 2021 at 7:42 AM Gerald Schaefer
<gerald.schaefer@linux.ibm.com> wrote:
>
> On Mon, 29 Mar 2021 11:33:11 -0700
> Yang Shi <shy828301@gmail.com> wrote:
>
> > The old behavior didn't split THP if migration is failed due to lack of
> > memory on the target node.  But the THP migration does split THP, so keep
> > the old behavior for misplaced NUMA page migration.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/migrate.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 86325c750c14..1c0c873375ab 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1444,6 +1444,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
> >       int swapwrite = current->flags & PF_SWAPWRITE;
> >       int rc, nr_subpages;
> >       LIST_HEAD(ret_pages);
> > +     bool nosplit = (reason == MR_NUMA_MISPLACED);
> >
> >       if (!swapwrite)
> >               current->flags |= PF_SWAPWRITE;
> > @@ -1495,7 +1496,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
> >                        */
> >                       case -ENOSYS:
> >                               /* THP migration is unsupported */
> > -                             if (is_thp) {
> > +                             if (is_thp && !nosplit) {
>
> This is the "THP migration is unsupported" case, but according to your
> description you rather want to change the -ENOMEM case?
>
> Could this be the correct place to trigger THP split for NUMA balancing,
> for architectures not supporting THP migration, like s390?

Yes, I think it could be as I mentioned in the previous email.

>
> Do I understand it correctly that this change (for -ENOSYS) would
> result in always failed THP migrations during NUMA balancing, if THP
> migration was not supported?

Yes.
