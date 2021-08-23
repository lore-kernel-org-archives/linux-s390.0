Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3628C4338F
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 20:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E5F7610A3
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 20:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhHWUV5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 Aug 2021 16:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhHWUV5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 23 Aug 2021 16:21:57 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAC3C061575
        for <linux-s390@vger.kernel.org>; Mon, 23 Aug 2021 13:21:14 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id c17so17689973pgc.0
        for <linux-s390@vger.kernel.org>; Mon, 23 Aug 2021 13:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRgi7oWfHECsTBz/HOJJYyhwTd/oY8CLDyaMGcnc5IA=;
        b=cT3oI7fsvWd9Kk4N5ASvVpaqvjiKDezL4ogdeKpSwtrBssY3I6QGps+2KtKeN2Sn1J
         ZLr208u/aGZ/u1b0I1PfHUiaX27fLPbIAEkKCaMlLJOi3qIkpIunPLcW0ObMb/pcC3jD
         aD+TM+MjjceBfRowI9i1Uwtf7qTY6ds4BXdTKGPvZ/OJlQIF5hT9mjOWdqse/25Hf2Vo
         IiiuS2tyJ6O5efKMPNzujsYKD7QUG1Ic0XYxqLNI7rzGxaafetGZ6NZ6eCsBAgKe5eyI
         rUG9ANffxeSUN3oBJ2pViDZgUQM1ufIMBTnGZVWVcg0Z/943ziAhLpK7nfk0cFEY5BhH
         m7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRgi7oWfHECsTBz/HOJJYyhwTd/oY8CLDyaMGcnc5IA=;
        b=VnYTcbh96F2zu8aQ1zEnajj+utnpmqVa+yH07lMnD0pQ8d9agOtQmQpN7mIXxCdZOt
         b4ghLGJ2n71OEO/TO2VhmFaFZB0DoroI5AChpV6zsWjcBi44A9kB0pJLwShPO8tXkGCz
         2cq46HMn1TtPOuZm4+I5CIqZjLwBbFyJEmVSRmCPKCuPxO3V5etT/3QGf3H+eUY64qIh
         qAHtyKK7hJqAo8yWnIo7Ed4X69RpKhoMHTVRJWOzs3p8d72bmZjiyvXKsGyRs09Nz7Oi
         oBZr2t8a2/qsHRi3HWC4TVF932l8B37DAm8PwyfLBP1ez+w/+quXAFM407Va8AGAYmwL
         k2Lw==
X-Gm-Message-State: AOAM531CBv/OeIqinnTxFgIrRLT97/sUSyG15LQJInSvfKW7oeD4xa5f
        lYRNX71n7N+4FDArsGFNTqH4OiJ9E+lCR+Dq9Vzljg==
X-Google-Smtp-Source: ABdhPJwo0ftFKtVJku5VlTYKzPAMAn2sKO4dCsEW5FRwAFVeufg7hV8XJ4EkKSmGuFTL4G0VIpsTraKBA0CyHvm5Tjk=
X-Received: by 2002:a65:6642:: with SMTP id z2mr21385344pgv.240.1629750073617;
 Mon, 23 Aug 2021 13:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210820054340.GA28560@lst.de> <20210823160546.0bf243bf@thinkpad> <20210823214708.77979b3f@thinkpad>
In-Reply-To: <20210823214708.77979b3f@thinkpad>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Aug 2021 13:21:03 -0700
Message-ID: <CAPcyv4jijqrb1O5OOTd5ftQ2Q-5SVwNRM7XMQ+N3MAFxEfvxpA@mail.gmail.com>
Subject: Re: can we finally kill off CONFIG_FS_DAX_LIMITED
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Aug 23, 2021 at 12:47 PM Gerald Schaefer
<gerald.schaefer@linux.ibm.com> wrote:
>
> On Mon, 23 Aug 2021 16:05:46 +0200
> Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:
>
> > On Fri, 20 Aug 2021 07:43:40 +0200
> > Christoph Hellwig <hch@lst.de> wrote:
> >
> > > Hi all,
> > >
> > > looking at the recent ZONE_DEVICE related changes we still have a
> > > horrible maze of different code paths.  I already suggested to
> > > depend on ARCH_HAS_PTE_SPECIAL for ZONE_DEVICE there, which all modern
>
> Oh, we do have PTE_SPECIAL, actually that took away the last free bit
> in the pte. So, if there is a chance that ZONE_DEVICE would depend
> on PTE_SPECIAL instead of PTE_DEVMAP, we might be back in the game
> and get rid of that CONFIG_FS_DAX_LIMITED.

So PTE_DEVMAP is primarily there to coordinate the
get_user_pages_fast() path, and even there it's usage can be
eliminated in favor of PTE_SPECIAL. I started that effort [1], but
need to rebase on new notify_failure infrastructure coming from Ruan
[2]. So I think you are not in the critical path until I can get the
PTE_DEVMAP requirement out of your way.

[1]: https://lore.kernel.org/r/161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com

[2]: https://lore.kernel.org/r/20210730085245.3069812-1-ruansy.fnst@fujitsu.com
