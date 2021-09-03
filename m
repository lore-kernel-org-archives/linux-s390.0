Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6237BC433EF
	for <linux-s390@archiver.kernel.org>; Fri,  3 Sep 2021 09:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF7460EB7
	for <linux-s390@archiver.kernel.org>; Fri,  3 Sep 2021 09:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348880AbhICJlv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Sep 2021 05:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244602AbhICJlv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Sep 2021 05:41:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB13C061575;
        Fri,  3 Sep 2021 02:40:51 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso3355732wmb.2;
        Fri, 03 Sep 2021 02:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVRR6yLxrUrJRA6yVOkPhGLutDZ6djkYgNKCcl1CTEk=;
        b=RYZw9S6z8xsWRI2MZbcwvD2T8FhHCjffWUIfmwfEPR7zfycGVKUxdyKP9fhMW4Uq4J
         BbnYgjd/N2RxF2POyuzcUm0vaikpN7ZlM5SLnKii/DBcr7iK/xtHvlrP88xiCNwF0h3B
         IeKe/meddkFLh5RZse8CQmzXI4mb8w6Ew8gs9mOTGCIJPlwyV/0NeyMHPZI11lJDTtqV
         51aKcNkR/OThTnQbI6mwunEhISUgMB2AXCdIQlBIixN+Guc3BLqaZwZDGzWCec3+5KA4
         qTENu5Se5nFf5HnhKTLzyU7Ewml2wz+OaJ3s4oJo/Xg/kK/IMsgh2SBZVjm8sAQMgkwr
         QnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVRR6yLxrUrJRA6yVOkPhGLutDZ6djkYgNKCcl1CTEk=;
        b=mLkSRpW6zxYbW2rIdRUCS/BDODuAShAXHVCP0yzJP3zMK06IJgwqTvb5zAXjNQVWqV
         u5p+838KZAr893OYDHntsd4y7VeSgoGEpspS7q4qGuS/Aa4DZX21UQ/KTgV1HV3DUkja
         +ha2WxdW81efUYMHRM6Y2uj0Tydr2iBJ/RzFe9uCyq2VJzPltIQ93A4YuuN7uDe7kG9d
         Hb9FSuRHB1BqmcMThH25wRs/QmW86y+DVZxEclmlCkNAanC4Bvv5t3eQns0MTPm53jPx
         J3ThqG4eBg3sF2iWLNOospyN7Hdr+8k/+D4phAottiIM2U5lhOhzIzS0/Ln6pbOT7ibk
         hrTQ==
X-Gm-Message-State: AOAM533Bn9S9fT1kCArqBxKjsZCPw+4cviEC1JI0aRu4zILpNORoILgg
        QeSe2+AoH0C1UotlTAA74p1sMaKhBV72iS4Vu5w=
X-Google-Smtp-Source: ABdhPJzKix+5RqI4Wnv61xruznFN4fEy86baqNhJsNRRjte0O4QnZ2RtkxwUiKDuGYoBW56bZX0eUEy6nPLpxBHOoJ4=
X-Received: by 2002:a05:600c:3ba3:: with SMTP id n35mr2380829wms.166.1630662050191;
 Fri, 03 Sep 2021 02:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210903075641.2807623-1-zhang.lyra@gmail.com>
 <20210903080316.2808017-1-zhang.lyra@gmail.com> <b4a5f322d035d75c97abf2aaa19d033adc68527d.camel@linux.ibm.com>
In-Reply-To: <b4a5f322d035d75c97abf2aaa19d033adc68527d.camel@linux.ibm.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 3 Sep 2021 17:40:13 +0800
Message-ID: <CAAfSe-v0DbOS5p7nF0db4SdTrsy28gJNdW93ds4capVxuUO1xw@mail.gmail.com>
Subject: Re: [PATCH] s390/io: Fix ioremap and iounmap undefinded issue for s390
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 3 Sept 2021 at 16:24, Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>
> On Fri, 2021-09-03 at 16:03 +0800, Chunyan Zhang wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > There would not be ioremap and iounmap implementations if CONFIG_PCI is
> > not set for s390, so add default declarations of these two functions
> > for the case to avoid 'undefined reference' issue.
> >
> > Fixes: 71ba41c9b1d9 ("s390/pci: provide support for MIO instructions")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> > The issue was reported from https://lkml.org/lkml/2021/8/1/18
>
> Thanks for the patch but I'm a little skeptical about adding
> ioremap()/iounmap() stubs that don't do anything useful and on top ofn
> that would do so silently.
>
> In the above discussion you said that TIMER_OF should depend on
> HAS_IOMEM. In arch/s390/Kconfig HAS_IOMEM is set if and only if
> CONFIG_PCI is set so that sounds to me like it would prevent the
> undefined reference without the risk of someone trying to use io*map()
> without CONFIG_PCI.

Humm... you can ignore my reply on that time, I later found that's not
correct :)

TIMER_OF would be selected by other configs and it seems not able to
depends on HAS_IOMEM, unless all configs which select TIMER_OF depend
on HAS_IOMEM, that would be a big change.

Actually HAS_IOMEM is set as default on other architectures, but not
for s390 which redefined it.

>
> At the very least I think the functions should do a WARN_ONCE() but
> then we have the same situation as discussed below with Linus making it
> pretty clear that he prefers these cases to be compile time checked:

Ok, if I understand correctly, if io*map is not implemented for some
case, there should be a *compile-time* error rather than adding a stub
function to make this kind of errors disappeared.

Please correct me if I missed something.

Thanks,
Chunyan

>
> https://lkml.org/lkml/2021/7/2/511
>
>
> > ---
> >  arch/s390/include/asm/io.h | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
> > index e3882b012bfa..9438370c6445 100644
> > --- a/arch/s390/include/asm/io.h
> > +++ b/arch/s390/include/asm/io.h
> > @@ -23,11 +23,8 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
> >  #define IO_SPACE_LIMIT 0
> >
> >
> .. snip ..
>
