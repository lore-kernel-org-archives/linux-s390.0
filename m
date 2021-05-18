Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5864C433B4
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 17:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A7B610A1
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 17:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbhERRFC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 May 2021 13:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239478AbhERRFC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 May 2021 13:05:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB66C061573;
        Tue, 18 May 2021 10:03:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id lz27so15666994ejb.11;
        Tue, 18 May 2021 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+yKT9VRX5m+z9HWCRwmzqc/7Spel7DRB/8tz06yBbSc=;
        b=KgCzmRBnEk+FBeH4IXkbyazMgVuK6l+0wvBjyhuXjhDJ7nDNQ3FI46ylRTNZKU1uZ7
         1kLWFo2614PuTeO9Wrcr7UMS1VoL6RBKw+qpZbR1noDv49O0VpyKVnrWYUHctBOwDWCv
         +4y1Czusp+Q1ifmvdwPID8oTFGKrE/N0y0ex+KFIoQnM257FoW1UhRk3FxEYwoxsPgIX
         0kBXkdHkb62bjTMPfZBF/Enyw4Gxml6pUfjcBMyCosPZXNW4lwWzkxdNV4za7Q2OnppY
         e6ne4A6TO0ZFMKm/ECelG8Oz+JUZSxva4cuqrzgggtjN8+kjV08owqQRsNT+RqeLHefR
         JW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+yKT9VRX5m+z9HWCRwmzqc/7Spel7DRB/8tz06yBbSc=;
        b=B/NPW8kpbJk620ig6m3vbUaluc987NUw/Eu1MrzadMQgVRONKKxasWbZJSywubnyL3
         vWUBAMKdcxfVFney91TyKWmKldXD0ITa8GCVNlRWzSzMB8OcJ5fhot6G8e1gGlypKozR
         vAk9WTYqa3GhR7y/6Y362xJJ8Y7QXxNMG5w8+w/vfVIoyDni8Gwhqg/RHVbFwRmZXg4j
         tft0wWc8mwVAWpuH4gzn4aYLYykpKSYPLrUAcK8zKzC47YpsqYERFY54JGBIAqEmBaKz
         3DpRhnNIFZw4rdGiXVmzYkql8pr95dA6K4PmV21hVFx4/1T3zX8lpmGkeaQTuEdhBG3p
         doHA==
X-Gm-Message-State: AOAM532qL23gsafTEv37jzMSjh7S3+cV+iUjEWJ7Q1uEw/Mt4sZqS273
        B8gtVqH5RcD8/6J5QiRG8WWK4Ntqy2Fo/6nFtx0=
X-Google-Smtp-Source: ABdhPJzvL/IaT6iWafLi67GSHjDYC6UUb2ja6gBkTR6vrY4J/BK5CM3tIxcEchXu/+KE/IPW7IAND/9aPimaLl3YkUw=
X-Received: by 2002:a17:906:b7d6:: with SMTP id fy22mr6849660ejb.383.1621357421618;
 Tue, 18 May 2021 10:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210413212416.3273-1-shy828301@gmail.com> <20210413212416.3273-2-shy828301@gmail.com>
 <20210517150922.GU3672@suse.de> <CAHbLzkoj6Vn_jjWrn99oio1Oi+D4CHw9Z+6Wy4Squz-jCh2DKw@mail.gmail.com>
 <20210518073618.GA3672@suse.de>
In-Reply-To: <20210518073618.GA3672@suse.de>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 18 May 2021 10:03:30 -0700
Message-ID: <CAHbLzkq38xbrgGV_OUK16N6Ezw5YLO8viOeF31owEk6-GTRu-w@mail.gmail.com>
Subject: Re: [v2 PATCH 1/7] mm: memory: add orig_pmd to struct vm_fault
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

On Tue, May 18, 2021 at 12:36 AM Mel Gorman <mgorman@suse.de> wrote:
>
> On Mon, May 17, 2021 at 12:39:49PM -0700, Yang Shi wrote:
> > On Mon, May 17, 2021 at 8:09 AM Mel Gorman <mgorman@suse.de> wrote:
> > >
> > > On Tue, Apr 13, 2021 at 02:24:10PM -0700, Yang Shi wrote:
> > > > Add orig_pmd to struct vm_fault so the "orig_pmd" parameter used by huge page
> > > > fault could be removed, just like its PTE counterpart does.
> > > >
> > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > >
> > > > <SNIP>
> > > >
> > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > index 25b9041f9925..9c5856f8cc81 100644
> > > > --- a/include/linux/mm.h
> > > > +++ b/include/linux/mm.h
> > > > @@ -547,6 +547,9 @@ struct vm_fault {
> > > >                                        * the 'address'
> > > >                                        */
> > > >       pte_t orig_pte;                 /* Value of PTE at the time of fault */
> > > > +     pmd_t orig_pmd;                 /* Value of PMD at the time of fault,
> > > > +                                      * used by PMD fault only.
> > > > +                                      */
> > > >
> > > >       struct page *cow_page;          /* Page handler may use for COW fault */
> > > >       struct page *page;              /* ->fault handlers should return a
> > >
> > > Could this be a union?
> >
> > Do you mean orig_pte and orig_pmd, or cow_page and page?
>
> orig_pte and orig_pmd given that one for PTE faults and one is for PMD
> faults and it's very unlikely they would both need to be considered during
> a single fault.

Yes, agreed.

>
> --
> Mel Gorman
> SUSE Labs
