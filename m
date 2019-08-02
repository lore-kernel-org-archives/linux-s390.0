Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36340 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfHBGo5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Aug 2019 02:44:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so61127388wme.1
        for <linux-s390@vger.kernel.org>; Thu, 01 Aug 2019 23:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190731163915.3fdfcb14@canb.auug.org.au> <20190731085819.GA3488@osiris>
 <20190731110816.GA20753@gondor.apana.org.au> <20190731111520.GC3488@osiris>
 <20190731113216.GA21068@gondor.apana.org.au> <20190731114453.GD3488@osiris>
 <20190801122849.GB4163@osiris> <CAKv+Gu_1HP2NapMk5O_-XpJdga5zyFJDkVudTRT6CWm+tqPndA@mail.gmail.com>
 <20190802102019.6a789c51@canb.auug.org.au> <20190802031414.GB14879@gondor.apana.org.au>
In-Reply-To: <20190802031414.GB14879@gondor.apana.org.au>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 2 Aug 2019 09:44:43 +0300
Message-ID: <CAKv+Gu_dohBsU3HN_J8cZBSKakKM61g++K1V0T1CJ6JtkJ8V-A@mail.gmail.com>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Harald Freudenberger <freude@linux.ibm.com>, Patrick Steuer <steuer@linux.ibm.com>, Ondrej Mosnacek <omosnace@redhat.com>

On Fri, 2 Aug 2019 at 06:14, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Hi Stephen:
>
> On Fri, Aug 02, 2019 at 10:20:19AM +1000, Stephen Rothwell wrote:
> >
> > It might be time to revert all this series and try again.  The
> > implementation seems to have not been well thought through from a kernel
> > building point of view.  For a start the two commits
> >
> >   7cdc0ddbf74a ("crypto: aegis128 - add support for SIMD acceleration")
> >   ecc8bc81f2fb ("crypto: aegis128 - provide a SIMD implementation based on NEON intrinsics")
>
> I think the idea was that it would get optimised out if the
> implementation is absent which is why it was meant to work in
> this order.  But oviously as we have found out this didn't work.
>
> Ard, I think relying on the compiler to optimise something out based
> on an assignment within an if statement is just too error-prone.
> We'll need a different mechanism for this.
>

Indeed. This is definitely something I tested, and it appears to be
dependent on the GCC version.

> For now I'm going to back out those two specific patches as the
> rest seem to be valid by themselves.
>

OK. I will adopt this mechanism [0] after all and resubmit, once I get
confirmation from either Voldis or Heiko that this makes the issue go
away (given that my local GCC does not reproduce the issue)

[0] https://lore.kernel.org/linux-crypto/20190729074434.21064-1-ard.biesheuvel@linaro.org/
