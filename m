Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFAEC433DB
	for <linux-s390@archiver.kernel.org>; Tue, 30 Mar 2021 16:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0646761994
	for <linux-s390@archiver.kernel.org>; Tue, 30 Mar 2021 16:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhC3QwQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 30 Mar 2021 12:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbhC3QwA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 30 Mar 2021 12:52:00 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C074CC061574;
        Tue, 30 Mar 2021 09:51:59 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l4so25838956ejc.10;
        Tue, 30 Mar 2021 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHYeB0nnI6v6P0Q2VG5Mm28e6mrALqMkMyegkWOwiqk=;
        b=kGJmMRBzcADUj4PBwV6ce2pTpWYreP0vdr0R/+o6Mk3bwh3JjUTnV1mwN+aBTDqACg
         NjqoAQn6WyqUIAcWIbtJLQoPA4jxG/baST+8P6IplHfk3UNcnTEVamzs5uJNK+rWLAIj
         04bNS9hxYXVaZQ1rOCdTC4OVWa5ZEAMYgy0yE2srmI9/GhDYtS8utBzwLA5oE3l0UGBy
         Tu3ZDVizHWEgfsETi/mPfPDV93rpLDs8OjBQUi0sN2fsGAUOEQrtazjCY+ohgxPH42rI
         2phdDmXtg81Akx9vv30xSdksoKpssSAyukxRlsNP5kV7ydTZwyQQKADSefZgI+Kzumrx
         UfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHYeB0nnI6v6P0Q2VG5Mm28e6mrALqMkMyegkWOwiqk=;
        b=US5DBgEZQCCqFX61Dz4R0dFPmONMsMfZjAN7vmVx2yAdzLW44kAaJYSJJon13HkuUK
         4kKwPenP2NbPZZsXhLl5gbcAMCUigxG6V0hVbWw3iPhiT9liVMd+7LYj6O/hFTi09Xj8
         qexiaZjgavh+CDwf3Q9OA9rZl+LLegvca8cdRJDj3nJuCy6rlK3CYfHw7KvIzQNBV/2v
         W/vo+50ids5cIL7Fl9JxjCVzWWTcAbs6N+HT6HFUIdBCR7XmiDo9u6SP+0taAaZvQD4B
         qyrcap8fDN/XjyyjESKVmd+jyt7BFU2bwEcPTWSCFtmzoqAYkiFz5sZXt26vRm9Y+OUY
         poIQ==
X-Gm-Message-State: AOAM531bk0rmB0KO5A6XcI8ZZQx5B1ojPxmL0jXB2qI83Me6YtYMEMpF
        TuciHEkGgIqJK4WllJqgmnYJldcLKOifFbjAWhQ=
X-Google-Smtp-Source: ABdhPJxEI1+v19DIodf61jZ+12dr7yL8rq3NEl9EcGbLLNAyqpcCMi7wpKL3zN7y1TecKLE/gx0b6U9qK0FSgMcZuGs=
X-Received: by 2002:a17:906:4055:: with SMTP id y21mr33697021ejj.507.1617123118539;
 Tue, 30 Mar 2021 09:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210329183312.178266-1-shy828301@gmail.com> <20210330164200.01a4b78f@thinkpad>
In-Reply-To: <20210330164200.01a4b78f@thinkpad>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 30 Mar 2021 09:51:46 -0700
Message-ID: <CAHbLzkrYd+5L8Ep+b83PkkFL_QGQe_vSAk=erQ+fvC6dEOsGsw@mail.gmail.com>
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

On Tue, Mar 30, 2021 at 7:42 AM Gerald Schaefer
<gerald.schaefer@linux.ibm.com> wrote:
>
> On Mon, 29 Mar 2021 11:33:06 -0700
> Yang Shi <shy828301@gmail.com> wrote:
>
> >
> > When the THP NUMA fault support was added THP migration was not supported yet.
> > So the ad hoc THP migration was implemented in NUMA fault handling.  Since v4.14
> > THP migration has been supported so it doesn't make too much sense to still keep
> > another THP migration implementation rather than using the generic migration
> > code.  It is definitely a maintenance burden to keep two THP migration
> > implementation for different code paths and it is more error prone.  Using the
> > generic THP migration implementation allows us remove the duplicate code and
> > some hacks needed by the old ad hoc implementation.
> >
> > A quick grep shows x86_64, PowerPC (book3s), ARM64 ans S390 support both THP
> > and NUMA balancing.  The most of them support THP migration except for S390.
> > Zi Yan tried to add THP migration support for S390 before but it was not
> > accepted due to the design of S390 PMD.  For the discussion, please see:
> > https://lkml.org/lkml/2018/4/27/953.
> >
> > I'm not expert on S390 so not sure if it is feasible to support THP migration
> > for S390 or not.  If it is not feasible then the patchset may make THP NUMA
> > balancing not be functional on S390.  Not sure if this is a show stopper although
> > the patchset does simplify the code a lot.  Anyway it seems worth posting the
> > series to the mailing list to get some feedback.
>
> The reason why THP migration cannot work on s390 is because the migration
> code will establish swap ptes in a pmd. The pmd layout is very different from
> the pte layout on s390, so you cannot simply write a swap pte into a pmd.
> There are no separate swp primitives for swap/migration pmds, IIRC. And even
> if there were, we'd still need to find some space for a present bit in the
> s390 pmd, and/or possibly move around some other bits.
>
> A lot of things can go wrong here, even if it could be possible in theory,
> by introducing separate swp primitives in common code for pmd entries, along
> with separate offset, type, shift, etc. I don't see that happening in the
> near future.

Thanks a lot for elaboration. IIUC, implementing migration PMD entry
is *not* prevented from by hardware, it may be very tricky to
implement it, right?

>
> Not sure if this is a show stopper, but I am not familiar enough with
> NUMA and migration code to judge. E.g., I do not see any swp entry action
> in your patches, but I assume this is implicitly triggered by the switch
> to generic THP migration code.

Yes, exactly. The migrate_pages() called by migrate_misplaced_page()
takes care of everything.

>
> Could there be a work-around by splitting THP pages instead of marking them
> as migrate pmds (via pte swap entries), at least when THP migration is not
> supported? I guess it could also be acceptable if THP pages were simply not
> migrated for NUMA balancing on s390, but then we might need some extra config
> option to make that behavior explicit.

Yes, it could be. The old behavior of migration was to return -ENOMEM
if THP migration is not supported then split THP. That behavior was
not very friendly to some usecases, for example, memory policy and
migration lieu of reclaim (the upcoming). But I don't mean we restore
the old behavior. We could split THP if it returns -ENOSYS and the
page is THP.

>
> See also my comment on patch #5 of this series.
>
> Regards,
> Gerald
