Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:40390 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfGaLc1 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 31 Jul 2019 07:32:27 -0400
Date: Wed, 31 Jul 2019 21:32:16 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
Message-ID: <20190731113216.GA21068@gondor.apana.org.au>
References: <20190731163915.3fdfcb14@canb.auug.org.au>
 <20190731085819.GA3488@osiris>
 <20190731110816.GA20753@gondor.apana.org.au>
 <20190731111520.GC3488@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731111520.GC3488@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Harald Freudenberger <freude@linux.ibm.com>, Patrick Steuer <steuer@linux.ibm.com>

On Wed, Jul 31, 2019 at 01:15:20PM +0200, Heiko Carstens wrote:
>
> However that doesn't fix the simd.h header file breakage with the
> second patch :)

That fix should be there now too.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
