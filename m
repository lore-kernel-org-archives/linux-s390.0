Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:56480 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730117AbfFMDOA (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 23:14:00 -0400
Date: Thu, 13 Jun 2019 11:13:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v3 0/4] s390/crypto: Use -ENODEV instead of -EOPNOTSUPP
Message-ID: <20190613031355.7vya4vwhr3eia5g4@gondor.apana.org.au>
References: <20190612133306.10231-1-david@redhat.com>
 <20190612150850.GA4038@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612150850.GA4038@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

On Wed, Jun 12, 2019 at 05:08:50PM +0200, Heiko Carstens wrote:
> On Wed, Jun 12, 2019 at 03:33:02PM +0200, David Hildenbrand wrote:
> > s390x crypto is one of the rare modules that returns -EOPNOTSUPP instead of
> > -ENODEV in case HW support is not available.
> > 
> > Convert to -ENODEV, so e.g., systemd's systemd-modules-load.service
> > ignores this error properly.
> > 
> > v2 -> v3:
> > - "s390/pkey: Use -ENODEV instead of -EOPNOTSUPP"
> > -- Also convert pkey_clr2protkey() as requested by Harald
> > - Add r-b's (thanks!)
> > 
> > v1 -> v2:
> > - Include
> > -- "s390/crypto: ghash: Use -ENODEV instead of -EOPNOTSUPP"
> > -- "s390/crypto: prng: Use -ENODEV instead of -EOPNOTSUPP"
> > -- "s390/crypto: sha: Use -ENODEV instead of -EOPNOTSUPP"
> > 
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: Harald Freudenberger <freude@linux.ibm.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > 
> > David Hildenbrand (4):
> >   s390/pkey: Use -ENODEV instead of -EOPNOTSUPP
> >   s390/crypto: ghash: Use -ENODEV instead of -EOPNOTSUPP
> >   s390/crypto: prng: Use -ENODEV instead of -EOPNOTSUPP
> >   s390/crypto: sha: Use -ENODEV instead of -EOPNOTSUPP
> 
> Should I pick these up so they can go upstream via the s390 tree?

Sure Heiko.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
