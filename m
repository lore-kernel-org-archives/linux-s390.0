Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:59950 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbfJPMfL (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Oct 2019 08:35:11 -0400
Date: Wed, 16 Oct 2019 23:35:07 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [RFT PATCH 0/3] crypto: s390 - convert to skcipher API
Message-ID: <20191016123507.GA16265@gondor.apana.org.au>
References: <20191012201809.160500-1-ebiggers@kernel.org>
 <20191016080103.GA4267@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016080103.GA4267@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>

On Wed, Oct 16, 2019 at 10:01:03AM +0200, Heiko Carstens wrote:
> On Sat, Oct 12, 2019 at 01:18:06PM -0700, Eric Biggers wrote:
> > This series converts the glue code for the S390 CPACF implementations of
> > AES, DES, and 3DES modes from the deprecated "blkcipher" API to the
> > "skcipher" API.  This is needed in order for the blkcipher API to be
> > removed.
> > 
> > I've compiled this patchset, and the conversion is very similar to that
> > which has been done for many other crypto drivers.  But I don't have the
> > hardware to test it, nor is S390 CPACF supported by QEMU.  So I really
> > need someone with the hardware to test it.  You can do so by setting:
> 
> ...
> 
> > Eric Biggers (3):
> >   crypto: s390/aes - convert to skcipher API
> >   crypto: s390/paes - convert to skcipher API
> >   crypto: s390/des - convert to skcipher API
> > 
> >  arch/s390/crypto/aes_s390.c  | 609 ++++++++++++++---------------------
> >  arch/s390/crypto/des_s390.c  | 419 ++++++++++--------------
> >  arch/s390/crypto/paes_s390.c | 414 ++++++++++--------------
> >  3 files changed, 580 insertions(+), 862 deletions(-)
> 
> Herbert, should these go upstream via the s390 or crypto tree?

It would be best to go via the crypto tree since any future patches
to remove blkcipher/ablkcipher would depend on these patches.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
