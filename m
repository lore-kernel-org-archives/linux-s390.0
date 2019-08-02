Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:49158 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389053AbfHBGvC (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 2 Aug 2019 02:51:02 -0400
Date: Fri, 2 Aug 2019 16:50:50 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
Message-ID: <20190802065050.GC19278@gondor.apana.org.au>
References: <20190731085819.GA3488@osiris>
 <20190731110816.GA20753@gondor.apana.org.au>
 <20190731111520.GC3488@osiris>
 <20190731113216.GA21068@gondor.apana.org.au>
 <20190731114453.GD3488@osiris>
 <20190801122849.GB4163@osiris>
 <CAKv+Gu_1HP2NapMk5O_-XpJdga5zyFJDkVudTRT6CWm+tqPndA@mail.gmail.com>
 <20190802102019.6a789c51@canb.auug.org.au>
 <20190802031414.GB14879@gondor.apana.org.au>
 <CAKv+Gu_dohBsU3HN_J8cZBSKakKM61g++K1V0T1CJ6JtkJ8V-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_dohBsU3HN_J8cZBSKakKM61g++K1V0T1CJ6JtkJ8V-A@mail.gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Harald Freudenberger <freude@linux.ibm.com>, Patrick Steuer <steuer@linux.ibm.com>, Ondrej Mosnacek <omosnace@redhat.com>

On Fri, Aug 02, 2019 at 09:44:43AM +0300, Ard Biesheuvel wrote:
>
> OK. I will adopt this mechanism [0] after all and resubmit, once I get
> confirmation from either Voldis or Heiko that this makes the issue go
> away (given that my local GCC does not reproduce the issue)
> 
> [0] https://lore.kernel.org/linux-crypto/20190729074434.21064-1-ard.biesheuvel@linaro.org/

Please drop the ifdefs around the header files since we've already
fixed that.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
