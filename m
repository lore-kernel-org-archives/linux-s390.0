Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:48362 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfHBDh1 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 1 Aug 2019 23:37:27 -0400
Date: Fri, 2 Aug 2019 13:14:14 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
Message-ID: <20190802031414.GB14879@gondor.apana.org.au>
References: <20190731163915.3fdfcb14@canb.auug.org.au>
 <20190731085819.GA3488@osiris>
 <20190731110816.GA20753@gondor.apana.org.au>
 <20190731111520.GC3488@osiris>
 <20190731113216.GA21068@gondor.apana.org.au>
 <20190731114453.GD3488@osiris>
 <20190801122849.GB4163@osiris>
 <CAKv+Gu_1HP2NapMk5O_-XpJdga5zyFJDkVudTRT6CWm+tqPndA@mail.gmail.com>
 <20190802102019.6a789c51@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802102019.6a789c51@canb.auug.org.au>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Harald Freudenberger <freude@linux.ibm.com>, Patrick Steuer <steuer@linux.ibm.com>, Ondrej Mosnacek <omosnace@redhat.com>

Hi Stephen:

On Fri, Aug 02, 2019 at 10:20:19AM +1000, Stephen Rothwell wrote:
>
> It might be time to revert all this series and try again.  The
> implementation seems to have not been well thought through from a kernel
> building point of view.  For a start the two commits
> 
>   7cdc0ddbf74a ("crypto: aegis128 - add support for SIMD acceleration")
>   ecc8bc81f2fb ("crypto: aegis128 - provide a SIMD implementation based on NEON intrinsics")

I think the idea was that it would get optimised out if the
implementation is absent which is why it was meant to work in
this order.  But oviously as we have found out this didn't work.

Ard, I think relying on the compiler to optimise something out based
on an assignment within an if statement is just too error-prone.
We'll need a different mechanism for this.

For now I'm going to back out those two specific patches as the
rest seem to be valid by themselves.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
