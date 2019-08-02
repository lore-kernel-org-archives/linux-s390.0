Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39344 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388895AbfHBGsG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Aug 2019 02:48:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so22814044wrt.6
        for <linux-s390@vger.kernel.org>; Thu, 01 Aug 2019 23:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190731163915.3fdfcb14@canb.auug.org.au> <20190731085819.GA3488@osiris>
 <20190731110816.GA20753@gondor.apana.org.au> <20190731111520.GC3488@osiris>
 <20190731113216.GA21068@gondor.apana.org.au> <20190731114453.GD3488@osiris>
 <20190801122849.GB4163@osiris> <CAKv+Gu_1HP2NapMk5O_-XpJdga5zyFJDkVudTRT6CWm+tqPndA@mail.gmail.com>
 <20190802102019.6a789c51@canb.auug.org.au>
In-Reply-To: <20190802102019.6a789c51@canb.auug.org.au>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 2 Aug 2019 09:47:52 +0300
Message-ID: <CAKv+Gu-Tui6+HEOK0Axgn9kWTxOPpenCSefTuxSek0PpNh9HzQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Harald Freudenberger <freude@linux.ibm.com>, Patrick Steuer <steuer@linux.ibm.com>, Ondrej Mosnacek <omosnace@redhat.com>

On Fri, 2 Aug 2019 at 03:20, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Herbert,
>
> On Thu, 1 Aug 2019 20:28:56 +0300 Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Thu, 1 Aug 2019 at 15:28, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> > >
> > > On Wed, Jul 31, 2019 at 01:44:54PM +0200, Heiko Carstens wrote:
> > > > On Wed, Jul 31, 2019 at 09:32:16PM +1000, Herbert Xu wrote:
> > > > > On Wed, Jul 31, 2019 at 01:15:20PM +0200, Heiko Carstens wrote:
> > > > > >
> > > > > > However that doesn't fix the simd.h header file breakage with the
> > > > > > second patch :)
> > > > >
> > > > > That fix should be there now too.
> > > >
> > > > Yes, works now. Thank you!
> > >
> > > Still not... with linux-next as of today I get this (s390 defconfig):
> > >
> > > ERROR: "crypto_aegis128_decrypt_chunk_simd" [crypto/aegis128.ko] undefined!
> > > ERROR: "crypto_aegis128_update_simd" [crypto/aegis128.ko] undefined!
> > > ERROR: "crypto_aegis128_encrypt_chunk_simd" [crypto/aegis128.ko] undefined!
> > > scripts/Makefile.modpost:105: recipe for target 'modules-modpost' failed
> > >
> >
> > Hello Heiko,
> >
> > Apologies for the breakage. The first two fixes addressed obvious
> > shortcomings in my code, but with this issue, I'm a bit puzzled tbh.
> > The calls to these missing functions should be optimized away, since
> > have_simd never gets assigned if CONFIG_CRYPTO_AEGIS128_SIMD is not
> > defined, but for some reason, this isn't working. Which version of GCC
> > are you using?
> >
> > Also, could you please try whether the patch below fixes the problem? Thanks
> >
> > https://lore.kernel.org/linux-crypto/20190729074434.21064-1-ard.biesheuvel@linaro.org/
>
> It might be time to revert all this series and try again.  The
> implementation seems to have not been well thought through from a kernel
> building point of view.  For a start the two commits
>
>   7cdc0ddbf74a ("crypto: aegis128 - add support for SIMD acceleration")
>   ecc8bc81f2fb ("crypto: aegis128 - provide a SIMD implementation based on NEON intrinsics")
>
> seem to be in the wrong order (function used in the first before being
> defined in the second).  There are a series of declarations of external
> functions in crypto/aegis128-core.c that should be in a header file.
> And there was the assumption that asm/simd.h was available everywhere.
>
> Also crypto_aegis128_decrypt_chunk_simd() is referenced in a structure
> initialisation (unprotected by any CONFIG_ variable - and so will be
> referenced even if it does not exist).  The compiler will have a hard
> time knowing that "have_simd" is effectively a constant zero (and
> crypto_simd_usable() is not constant).

The only assignment to have_simd is guarded by a if
(IS_ENABLED(CONFIG_xxx)) conditional, which is optimized away if the
Kconfig symbol is not set. Usually, the compiler uses this information
to infer that have_simd is a compile time constant '0', and optimizes
away all the code that depends on have_simd being true. I haven't
figured out yet why this doesn't work as expected on some versions of
GCC, since it is a very common pattern throughout the kernel.
