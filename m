Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811FAC433ED
	for <linux-s390@archiver.kernel.org>; Mon, 17 May 2021 19:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A69561263
	for <linux-s390@archiver.kernel.org>; Mon, 17 May 2021 19:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhEQTml (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 17 May 2021 15:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbhEQTml (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 May 2021 15:42:41 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552CFC061573;
        Mon, 17 May 2021 12:41:24 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id s22so10716425ejv.12;
        Mon, 17 May 2021 12:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yXa/Lm0suCl/5c57+vWfzuJ0nIP5bhlu8lJSFWkdrv8=;
        b=WSduR54CQpT0eAZStLjK9HbqVDBbUEgAkAjcMlUQCnXWK9SG3yY3qCeDbctPh0+XkC
         rNBCqo5BT/Zk63QGr7nIM3iPsiWMsvqy112Yf/cwtEJwmDY0ipOlxYC1xDX4xfvPNDBZ
         Vdz12P2rUSZiixxROKQZ8OHYprGu32tcE1nwZ6qwiRUo7+wNzZkBRLcjoz18STfK+wZB
         a21zgdq3fEJdrMCBlsdUVdOTc7I+uvwAk+KwXbKtQy4MtRcTHIYN2aKPn8vKDQTh6f/T
         Iuv1ZFYMl6tzXEUt0LS51E3qkpNEBj4BsL11Rway1HWQ/t9UueOsz84zOowmBXTW7AHB
         ACkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXa/Lm0suCl/5c57+vWfzuJ0nIP5bhlu8lJSFWkdrv8=;
        b=O2neYKxQyMmPJ/S0L9C8Q0t9PTY4KndnpUE60p9EU4HIZ7T2NQtZZqoLDWR2rhm1NH
         FQzyv6IWK/Y7iCD1xmugEWR0yCemoHtwMVeAJfYUEvl8Cfgor3SMO8mk74H7md1F6b5g
         wXQhLLT3s4GjWXHERXjN4CrcWvTLZNbkCKjskls/l9eicU69sqGvstvO6GT66ekjiflA
         cPvveBCD9CanTJtP5rp+1pZeJdehzPYli8SWd/yXSRhezWNX33qmgD3+0T6ZWkBGSplp
         XE8wm9ZooOIJfBslXzJwDV18nq3ic/X9Ddg0UbnNAtrjZaIwk/oqBOgMiZ707iR4zJsT
         CoFA==
X-Gm-Message-State: AOAM532NzhhbuFO9McbO5IFU2+nTDjHoC4cZ8bDl67h5DBgP/+u+Mayc
        Vgf4y5lw4QcrY+q88mw+Bl0GnGg+Afm0ZdUjTxE=
X-Google-Smtp-Source: ABdhPJyFcwx+LAv5N1H+8RwcM+ovypSsnjKzeZwOG0slZQVgpScQlcbUgcd70BoSRPNM8YYAa5YW0E4kLCKDe73qm28=
X-Received: by 2002:a17:906:11c8:: with SMTP id o8mr1548021eja.499.1621280483076;
 Mon, 17 May 2021 12:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210413212416.3273-1-shy828301@gmail.com> <20210413212416.3273-4-shy828301@gmail.com>
 <20210517152721.GW3672@suse.de>
In-Reply-To: <20210517152721.GW3672@suse.de>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 17 May 2021 12:41:11 -0700
Message-ID: <CAHbLzko=2TXdx3fivtAvpUMyZAHC_sQ+eVQqf3-nR5Zz838GrQ@mail.gmail.com>
Subject: Re: [v2 PATCH 3/7] mm: thp: refactor NUMA fault handling
To:     Mel Gorman <mgorman@suse.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
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

On Mon, May 17, 2021 at 8:27 AM Mel Gorman <mgorman@suse.de> wrote:
>
> On Tue, Apr 13, 2021 at 02:24:12PM -0700, Yang Shi wrote:
> > When the THP NUMA fault support was added THP migration was not supported yet.
> > So the ad hoc THP migration was implemented in NUMA fault handling.  Since v4.14
> > THP migration has been supported so it doesn't make too much sense to still keep
> > another THP migration implementation rather than using the generic migration
> > code.
> >
> > This patch reworked the NUMA fault handling to use generic migration implementation
> > to migrate misplaced page.  There is no functional change.
> >
> > After the refactor the flow of NUMA fault handling looks just like its
> > PTE counterpart:
> >   Acquire ptl
> >   Prepare for migration (elevate page refcount)
> >   Release ptl
> >   Isolate page from lru and elevate page refcount
> >   Migrate the misplaced THP
> >
> > If migration is failed just restore the old normal PMD.
> >
> > In the old code anon_vma lock was needed to serialize THP migration
> > against THP split, but since then the THP code has been reworked a lot,
> > it seems anon_vma lock is not required anymore to avoid the race.
> >
> > The page refcount elevation when holding ptl should prevent from THP
> > split.
> >
> > Use migrate_misplaced_page() for both base page and THP NUMA hinting
> > fault and remove all the dead and duplicate code.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> I did not spot any big problems and FWIW, the series overall passed a
> series of tests that exercise NUMA balancing migrations so...
>
> Acked-by: Mel Gorman <mgorman@suse.de>

Thanks a lot for testing and reviewing the series.

>
> --
> Mel Gorman
> SUSE Labs
