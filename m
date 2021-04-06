Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9E1C433ED
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 16:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972D0613DF
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 16:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhDFQm3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Apr 2021 12:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhDFQm3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Apr 2021 12:42:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BD6C06174A;
        Tue,  6 Apr 2021 09:42:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id qo10so12622790ejb.6;
        Tue, 06 Apr 2021 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5FhGpD+W2qCTNTtz8r16NI+eTTgYQsJqj2294KSTYfg=;
        b=O4mar5EJsHEnN3WGZVxrUQ0F0XF3kFlnGht20zddufgJZ7os++IvA0hgydkU4xbSDQ
         +XOriaf9ISSqRf2vVB6revLl0hdy3av+65Kpxdkm41s2St9tXkPlSkBFkXx9bD1szhiU
         wAspPAqPqAJsB9yRyIdy2/wZiflyFFxX0hzQPBIYIeGygO1XSMRBIJgwswmMKiS+sWFG
         yF4ii2tYVlWWmwTVszEJK+vomRUD+tgLYq/KTzKtdalo8kPxU43JfVp4wmAfvaAddN+C
         sP1K3RjL47NtXKKgky14aXscPq4mLN4XpNnLldlxuVStWnpAAoFPreeXMyNLUzYcz+6T
         ntYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5FhGpD+W2qCTNTtz8r16NI+eTTgYQsJqj2294KSTYfg=;
        b=X20lmT+QpMpBh04RFGTxQkVcfNb2gildPq2H9WhXkdyai50MEJM30MW67EJY/6fN89
         HgLP16EnTczfzGsKjv0roD+pPrVIhL7iWjNI5uAHoHRnMJRGM+hRsBNtdW/qERM2JKKj
         xddP4gJDRqpQZGBbATYQU7J4sUQBMd6YUUrHdPCWq/2X+2XjkZRFuA2PoD0k971SMahb
         3U74rf5NVUWzYnSAycbi4urSxMo8vsoZGJvKbXd7/bqPLSXz4NEVTy19ZbeXduHn6+df
         sQfB5VuGbuuKL7hzZtskywYuuTnP4y8y1wknhUEpApaaQiB/OOg3LghGdqaW7+GQDS5x
         iMeQ==
X-Gm-Message-State: AOAM532adqM6Km7Dp0bsJKc2iIQcRSBZkG55ZAnBLwJdVJtg81tvsb7U
        3XkkiwUR5uMPLtfcn+OhI/79YWL+SlTILoffdok=
X-Google-Smtp-Source: ABdhPJzGmpH9vtOSzDZ4/Y4obgIO+geB2MftQxr3dsbqxdiL5KplV4MIvAmDjQLurBc4ZwCpMsr6uQPYr8rBQRgCd0g=
X-Received: by 2002:a17:906:b296:: with SMTP id q22mr13134681ejz.161.1617727339539;
 Tue, 06 Apr 2021 09:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210329183312.178266-1-shy828301@gmail.com> <20210330164200.01a4b78f@thinkpad>
 <CAHbLzkrYd+5L8Ep+b83PkkFL_QGQe_vSAk=erQ+fvC6dEOsGsw@mail.gmail.com>
 <20210331134727.47bc1e6d@thinkpad> <CAHbLzkquYxq_eXoVhUCib9qu_aMS9U2XXjb5pop9JtJ8uco_vg@mail.gmail.com>
 <20210406140251.2779c400@thinkpad>
In-Reply-To: <20210406140251.2779c400@thinkpad>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 6 Apr 2021 09:42:07 -0700
Message-ID: <CAHbLzkr2+CnY8+ENB_Hvt7kJPKNq3H2aG=RsOBmBE_dYciqstw@mail.gmail.com>
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

On Tue, Apr 6, 2021 at 5:03 AM Gerald Schaefer
<gerald.schaefer@linux.ibm.com> wrote:
>
> On Thu, 1 Apr 2021 13:10:49 -0700
> Yang Shi <shy828301@gmail.com> wrote:
>
> [...]
> > > >
> > > > Yes, it could be. The old behavior of migration was to return -ENOMEM
> > > > if THP migration is not supported then split THP. That behavior was
> > > > not very friendly to some usecases, for example, memory policy and
> > > > migration lieu of reclaim (the upcoming). But I don't mean we restore
> > > > the old behavior. We could split THP if it returns -ENOSYS and the
> > > > page is THP.
> > >
> > > OK, as long as we don't get any broken PMD migration entries established
> > > for s390, some extra THP splitting would be acceptable I guess.
> >
> > There will be no migration PMD installed. The current behavior is a
> > no-op if THP migration is not supported.
>
> Ok, just for completeness, since Mel also replied that the split
> was not done on other architectures "because the loss from splitting
> exceeded the gain of improved locality":
>
> I did not mean to request extra splitting functionality for s390,
> simply skipping / ignoring large PMDs would also be fine for s390,
> no need to add extra complexity.

Thank you. It could make life easier. The current code still converts
huge PMD to RPOTNONE even though THP migration is not supported. It is
easy to skip such PMDs hence cycles are saved for pointless NUMA
hinting page faults.

Will do so in v2 if no objection from Mel as well.
