Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FCEC4320E
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 12:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFDF60F0F
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 12:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbhG2Mod (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Jul 2021 08:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbhG2Moc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Jul 2021 08:44:32 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF92FC061765
        for <linux-s390@vger.kernel.org>; Thu, 29 Jul 2021 05:44:28 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id m11so3795707qtx.7
        for <linux-s390@vger.kernel.org>; Thu, 29 Jul 2021 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=REukLMYHB9mfVFO1/bdDCKtlszA1rKroqNl1QPX1pLU=;
        b=BDIdGkUehfGKUuxsy+fvkDkr2GBCODc7I8zNcJ8SRMTrosiAzd9wV8k4ho+9DmoVTN
         ZgZpaPFz7rYUXgm3Bnd50vGzEYEK+sYhEMHsoUgf3j65MNdadi6mEO5UCXCGxYCi7qgX
         WFQcsZIJ2Fu8s/P9vhc/OdXyMBvqwLC7WP0Iwa+/QtOk7YrcQNVx6G9CqL2RRUSlnYx+
         k+NmAzUBe1pYR9aFm77nsezouOeWql6Zc5QqwXSsoTfMq7LS2fboyKrpB9zlkED9oWMI
         qlKDmSAP2MAK0Brfbz6z46cmYAxkk12/imrm0s0s2JWDb0U311Dnmemk3PmuxKxEui7s
         sudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=REukLMYHB9mfVFO1/bdDCKtlszA1rKroqNl1QPX1pLU=;
        b=kVdXW1yVfoYANDfL3bwR7w4nFV4GRBJz+NXsM/Z8CALFYmnkcSDXLnzOWMooxsl7e6
         z4l2m0AmNVtJGAyjkMx6Cm9aGLPOGY4ofOYkwLinFXoMR7kDFcY8UYNDDlvCMShCIXXz
         C/SOghrBL+XnMuq68xIF/YoILD5MId+TldTm1jyvwinto4lKTXLWsC4L/z7rUjY6AvjN
         5yGrlUKnRWg1Bid6v0tOv3iH1sNeFDnuaBG5RaZtWjkjkcll65KnZnCD4iODPsXt9hK1
         082umk0uCQQq16B1627Z1mnr/ToB2ZUzX+JoXyba1TQv6zwriASsW3Kl/cl5EfDMMJmm
         pSMA==
X-Gm-Message-State: AOAM532VqR/E5lw1RwrYHypMf/oYC4KNni+hhqs3q0xC0mJX1rOA08re
        ddwaETpAF2cicCwveYE80US37IhwfHVTfLyE0BAU3Q==
X-Google-Smtp-Source: ABdhPJx8p5Gioov6LW3dMuKZCxQ7H3nKyaoIEb0t3AIauct+JwrIEuRpWs9dp5K8G8EOr4CSz9yHAnha7BrG6YV+cpk=
X-Received: by 2002:a05:622a:10d:: with SMTP id u13mr4063224qtw.369.1627562667841;
 Thu, 29 Jul 2021 05:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210728190254.3921642-1-hca@linux.ibm.com> <20210728190254.3921642-3-hca@linux.ibm.com>
In-Reply-To: <20210728190254.3921642-3-hca@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 29 Jul 2021 14:43:51 +0200
Message-ID: <CAG_fn=VS_WFjL+qjm79Jvq5M0KaNScvX2vCw=aNxPx14Hffa0A@mail.gmail.com>
Subject: Re: [PATCH 2/4] kfence: add function to mask address bits
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Marco Elver <elver@google.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jul 28, 2021 at 9:03 PM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> From: Sven Schnelle <svens@linux.ibm.com>
>
> s390 only reports the page address during a translation fault.
> To make the kfence unit tests pass, add a function that might
> be implemented by architectures to mask out address bits.
>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  mm/kfence/kfence_test.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index 942cbc16ad26..eb6307c199ea 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -23,8 +23,15 @@
>  #include <linux/tracepoint.h>
>  #include <trace/events/printk.h>
>
> +#include <asm/kfence.h>
> +
>  #include "kfence.h"
>
> +/* May be overridden by <asm/kfence.h>. */
> +#ifndef arch_kfence_test_address
> +#define arch_kfence_test_address(addr) (addr)
> +#endif
> +
>  /* Report as observed from console. */
>  static struct {
>         spinlock_t lock;
> @@ -82,6 +89,7 @@ static const char *get_access_type(const struct expect_=
report *r)
>  /* Check observed report matches information in @r. */
>  static bool report_matches(const struct expect_report *r)
>  {
> +       unsigned long addr =3D (unsigned long)r->addr;
>         bool ret =3D false;
>         unsigned long flags;
>         typeof(observed.lines) expect;
> @@ -131,22 +139,25 @@ static bool report_matches(const struct expect_repo=
rt *r)
>         switch (r->type) {
>         case KFENCE_ERROR_OOB:
>                 cur +=3D scnprintf(cur, end - cur, "Out-of-bounds %s at",=
 get_access_type(r));
> +               addr =3D arch_kfence_test_address(addr);

Can we normalize addr once before (or after) this switch?

>                 break;
>         case KFENCE_ERROR_UAF:
>                 cur +=3D scnprintf(cur, end - cur, "Use-after-free %s at"=
, get_access_type(r));
> +               addr =3D arch_kfence_test_address(addr);
>                 break;
>         case KFENCE_ERROR_CORRUPTION:
>                 cur +=3D scnprintf(cur, end - cur, "Corrupted memory at")=
;
>                 break;
>         case KFENCE_ERROR_INVALID:
>                 cur +=3D scnprintf(cur, end - cur, "Invalid %s at", get_a=
ccess_type(r));
> +               addr =3D arch_kfence_test_address(addr);
>                 break;
>         case KFENCE_ERROR_INVALID_FREE:
>                 cur +=3D scnprintf(cur, end - cur, "Invalid free of");
>                 break;
>         }
>
> -       cur +=3D scnprintf(cur, end - cur, " 0x%p", (void *)r->addr);
> +       cur +=3D scnprintf(cur, end - cur, " 0x%p", (void *)addr);
>
>         spin_lock_irqsave(&observed.lock, flags);
>         if (!report_available())
> --
> 2.25.1
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
