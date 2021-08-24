Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB57C4338F
	for <linux-s390@archiver.kernel.org>; Tue, 24 Aug 2021 14:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E359B61214
	for <linux-s390@archiver.kernel.org>; Tue, 24 Aug 2021 14:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbhHXOyS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238068AbhHXOyS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 Aug 2021 10:54:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A58C061757
        for <linux-s390@vger.kernel.org>; Tue, 24 Aug 2021 07:53:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so2521277pjb.2
        for <linux-s390@vger.kernel.org>; Tue, 24 Aug 2021 07:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ylhUTqwJhOuYYwdsmYmo/6iY3LnpW0+y5HqqgED6H8=;
        b=0GqAkBH/nv5mE+SUkUmCtp/Pwe2XyfpfayIPW7xPf4zMALUn+8UVuRqkiU5/doWAyu
         mYltVepwNSNg4jFsmuXbs0v3dQ1BDTt6vaL7/GAiuFiI684L6L+K76lJrONqA9PoUKTZ
         H98GgJ6wpuG4u+VZ+rOGiYpjGy1dIZJbTCiBtcEvQHTBiWGIH4qRplx+5wPBu5PCjIFk
         9OBXbOiNJetFqwHBcvKNPfUwCLj33yaz6uqLopvKR0Re5pPWAQCKgtr4FqCkD/DrGF6i
         S0FWWP6ujBqaO/ixSi1B8Qtm/cvJ9ZpyK5HCj5KknKJqHaLQMCj6+7AskxNfi8waSbKY
         AdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ylhUTqwJhOuYYwdsmYmo/6iY3LnpW0+y5HqqgED6H8=;
        b=NE5eFCq4bR9O/XlLgc3gRa4DpLZipfYxlTiYCxg++ECcAcL7cljAgG3oTOSlvM+XEZ
         +1Gf8S47kiSCFXRmIYm9DWKoi95wxfZFZBmLcmARQifDOmDtrsvLAinDt9ykGip8h5Lk
         vwp9wUYm5lvp2SntUtBzbz9t93qkjLvGFGDC93Cvo2DVDHbFNjZG34onf+xVgc23DoZN
         UdVO2uD5j1NGXY2PqqXixHYsm+iMepVpoQ4/nkzm1okFnD2e6mT0ZFhBjYosMBOB2eYC
         9L0u2EBa0aIg7bL+sAPgoWM2JrTRYFmGq1t2w+XAKuCOP66dtqHkdCFAsp3PlkzEwvTh
         /eJg==
X-Gm-Message-State: AOAM533d4OnDzmehTeL0J/gbVqnzu5ydGcji9oms1zj9biZNEeroJn9T
        JQHIXZCWzS/m189IiRDFupEIOzyWPGmf0mCLxhZVVA==
X-Google-Smtp-Source: ABdhPJxB5qoItv8tPXXCue0hhdumr9yxeciPby/nl24so9ftRlXdHk/l9EUDaI5+k43oB4FfA4dj+mopqnyG/DhwRe8=
X-Received: by 2002:a17:902:9b95:b0:130:6a7b:4570 with SMTP id
 y21-20020a1709029b9500b001306a7b4570mr21771893plp.27.1629816813538; Tue, 24
 Aug 2021 07:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210820054340.GA28560@lst.de> <20210823160546.0bf243bf@thinkpad>
 <20210823214708.77979b3f@thinkpad> <CAPcyv4jijqrb1O5OOTd5ftQ2Q-5SVwNRM7XMQ+N3MAFxEfvxpA@mail.gmail.com>
 <e250feab-1873-c91d-5ea9-39ac6ef26458@oracle.com>
In-Reply-To: <e250feab-1873-c91d-5ea9-39ac6ef26458@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 24 Aug 2021 07:53:22 -0700
Message-ID: <CAPcyv4jYXPWmT2EzroTa7RDz1Z68Qz8Uj4MeheQHPbBXdfS4pA@mail.gmail.com>
Subject: Re: can we finally kill off CONFIG_FS_DAX_LIMITED
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Aug 24, 2021 at 7:10 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
>
>
> On 8/23/21 9:21 PM, Dan Williams wrote:
> > On Mon, Aug 23, 2021 at 12:47 PM Gerald Schaefer
> > <gerald.schaefer@linux.ibm.com> wrote:
> >>
> >> On Mon, 23 Aug 2021 16:05:46 +0200
> >> Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:
> >>
> >>> On Fri, 20 Aug 2021 07:43:40 +0200
> >>> Christoph Hellwig <hch@lst.de> wrote:
> >>>
> >>>> Hi all,
> >>>>
> >>>> looking at the recent ZONE_DEVICE related changes we still have a
> >>>> horrible maze of different code paths.  I already suggested to
> >>>> depend on ARCH_HAS_PTE_SPECIAL for ZONE_DEVICE there, which all modern
> >>
> >> Oh, we do have PTE_SPECIAL, actually that took away the last free bit
> >> in the pte. So, if there is a chance that ZONE_DEVICE would depend
> >> on PTE_SPECIAL instead of PTE_DEVMAP, we might be back in the game
> >> and get rid of that CONFIG_FS_DAX_LIMITED.
> >
> > So PTE_DEVMAP is primarily there to coordinate the
> > get_user_pages_fast() path, and even there it's usage can be
> > eliminated in favor of PTE_SPECIAL. I started that effort [1], but
> > need to rebase on new notify_failure infrastructure coming from Ruan
> > [2]. So I think you are not in the critical path until I can get the
> > PTE_DEVMAP requirement out of your way.
> >
>
> Isn't the implicit case that PTE_SPECIAL means that you
> aren't supposed to get a struct page back? The gup path bails out on
> pte_special() case. And in the fact in this thread that you quote:
>
> > [1]: https://lore.kernel.org/r/161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com
>
> (...) we were speaking about[1.1] using that same special bit to block
> longterm gup for fs-dax (while allowing it device-dax which does support it).
>
> [1.1] https://lore.kernel.org/nvdimm/a8c41028-c7f5-9b93-4721-b8ddcf2427da@oracle.com/
>
> Or maybe that's what you mean for this particular case of FS_DAX_LIMITED. Most _special*()
> cases in mm match _devmap*() as far I've experimented in the past with PMD/PUD and dax
> (prior to [1.1]).
>
> I am just wondering would you differentiate the case where you have metadata for the
> !FS_DAX_LIMITED case in {gup,gup_fast} path in light of removing PTE_DEVMAP. I would have
> thought of checking that a pgmap exists for the pfn (without grabbing a ref to it).

So I should clarify, I'm not proposing removing PTE_DEVMAP, I'm
proposing relaxing its need for architectures that can not afford the
PTE bit. Those architectures would miss out on get_user_pages_fast()
for devmap pages. Then, once PTE_SPECIAL kicks get_user_pages() to the
slow path, get_dev_pagemap() is used to detect devmap pages.
