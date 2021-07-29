Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AD1C4320A
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 14:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA3B6054E
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 14:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbhG2OKC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbhG2OHG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Jul 2021 10:07:06 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7196C0619E6
        for <linux-s390@vger.kernel.org>; Thu, 29 Jul 2021 06:59:58 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 184so6037058qkh.1
        for <linux-s390@vger.kernel.org>; Thu, 29 Jul 2021 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KUvzSeTHiMYYDqDJxB7rJ4PNsknIyxmHg+DiEVHfwLI=;
        b=iOwiVk+59SLzINH9AVvJnCRQz3piAW2z7tpru53kHm1k8PiIusFJtd0SQ4xDI4FFc3
         bZRCI6YMKhRT2u+U7GBQrmyv91J8yRGOkgseXRyYp7xA0e9h6yRbXixo5JdSxDfEAs4W
         sPxNOOwyfZFAAikVc79dsioyppviL3Wil4CQGo+DfLT7Ue0Gg4uRNRiJvoVSesolCxYI
         r/ec+r0NELHo0Yq/AxQB2kqG6MJ2iDFiU4M6evSHPfKc/MiE8MpoaypA8dItdSXeMmzY
         m1RgqdrArXNTrH/8k9p75lPGfzFckmisE2hIDyzz9R9qUOJcypGIT0WoDmlU3RJ+PCvi
         xp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KUvzSeTHiMYYDqDJxB7rJ4PNsknIyxmHg+DiEVHfwLI=;
        b=VBRNrXYLLwZH8TzPXZ6MsHwhDbf0Zr3V8OuWZnIKomXE/0cEU8aVg8dMCqqDWSDEcm
         c8fBDoLesr3xiV3XDXgrEjKbmQy0gPtI/LEX4Ud77kXz1oJ4NTki0cJC5BG0bZYl9EHn
         uDG6nW58mZJfjkCx5WXJUgePObc81rzyBQzB6gzlx0hVo6VZxhu0pKOkyIsj4g7D36sS
         tLqtHcYLM/C9OtHcuIF2tNLJVtfA3PW9CxM0ncieRtUkDD/hfTJd8YA8BZA4pFHpud0p
         vlaFHHEEutuTsYb/ZE+LfnELPk8iJVACV/udAGesLutaD0CXDqd/ppl2vXdzkylpBZvC
         Orvg==
X-Gm-Message-State: AOAM533j6CULsXXPNPcOhIoJNGDhlnv/aSk6Y/fN3GQyxxwDrGFq26Qj
        2RAJF31UsQ+J6lLG7e8UZoHbgRu6jDzvJJI7Ys5cng==
X-Google-Smtp-Source: ABdhPJxSrKNbOK3NA1s7QIBVfkGMkfAw4PxjPNutIFyYV824DbkgAHKPEK0RIiQ0e7hLN3J7hdZ8bMltngwlkwTbnFk=
X-Received: by 2002:a37:a5ca:: with SMTP id o193mr5414456qke.352.1627567197517;
 Thu, 29 Jul 2021 06:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210728190254.3921642-1-hca@linux.ibm.com> <20210728190254.3921642-3-hca@linux.ibm.com>
 <CAG_fn=VS_WFjL+qjm79Jvq5M0KaNScvX2vCw=aNxPx14Hffa0A@mail.gmail.com> <yt9dtukdteoj.fsf@linux.ibm.com>
In-Reply-To: <yt9dtukdteoj.fsf@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 29 Jul 2021 15:59:21 +0200
Message-ID: <CAG_fn=XHr2j+xVaxjxqSUKU7ddDoekvxVoac9sSJ+Yk3voRUnA@mail.gmail.com>
Subject: Re: [PATCH 2/4] kfence: add function to mask address bits
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>, Marco Elver <elver@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jul 29, 2021 at 3:47 PM Sven Schnelle <svens@linux.ibm.com> wrote:
>
> Alexander Potapenko <glider@google.com> writes:
>
> > On Wed, Jul 28, 2021 at 9:03 PM Heiko Carstens <hca@linux.ibm.com> wrote:
> >>
> >> From: Sven Schnelle <svens@linux.ibm.com>
> >>
> >> s390 only reports the page address during a translation fault.
> >> To make the kfence unit tests pass, add a function that might
> >> be implemented by architectures to mask out address bits.
> >>
> >> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> >> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> >> ---
> >>  mm/kfence/kfence_test.c | 13 ++++++++++++-
> >>  1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> >> index 942cbc16ad26..eb6307c199ea 100644
> >> --- a/mm/kfence/kfence_test.c
> >> +++ b/mm/kfence/kfence_test.c
> >> @@ -23,8 +23,15 @@
> >>  #include <linux/tracepoint.h>
> >>  #include <trace/events/printk.h>
> >>
> >> +#include <asm/kfence.h>
> >> +
> >>  #include "kfence.h"
> >>
> >> +/* May be overridden by <asm/kfence.h>. */
> >> +#ifndef arch_kfence_test_address
> >> +#define arch_kfence_test_address(addr) (addr)
> >> +#endif
> >> +
> >>  /* Report as observed from console. */
> >>  static struct {
> >>         spinlock_t lock;
> >> @@ -82,6 +89,7 @@ static const char *get_access_type(const struct expect_report *r)
> >>  /* Check observed report matches information in @r. */
> >>  static bool report_matches(const struct expect_report *r)
> >>  {
> >> +       unsigned long addr = (unsigned long)r->addr;
> >>         bool ret = false;
> >>         unsigned long flags;
> >>         typeof(observed.lines) expect;
> >> @@ -131,22 +139,25 @@ static bool report_matches(const struct expect_report *r)
> >>         switch (r->type) {
> >>         case KFENCE_ERROR_OOB:
> >>                 cur += scnprintf(cur, end - cur, "Out-of-bounds %s at", get_access_type(r));
> >> +               addr = arch_kfence_test_address(addr);
> >
> > Can we normalize addr once before (or after) this switch?
> >
>

> I don't think so. When reporing corrupted memory or an invalid free the
> address is not generated by hardware but kfence itself, and therefore we
> would strip valid bits.

Ah, sorry, I missed that.
