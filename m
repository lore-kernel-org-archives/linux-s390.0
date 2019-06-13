Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730772AbfFMHv0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Jun 2019 03:51:26 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5D7mTDV009558
        for <linux-s390@vger.kernel.org>; Thu, 13 Jun 2019 03:51:25 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3je1g3wu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 13 Jun 2019 03:51:25 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 13 Jun 2019 08:51:22 +0100
Date: Thu, 13 Jun 2019 09:51:17 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v3 0/4] s390/crypto: Use -ENODEV instead of -EOPNOTSUPP
References: <20190612133306.10231-1-david@redhat.com>
 <20190612150850.GA4038@osiris>
 <20190613031355.7vya4vwhr3eia5g4@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613031355.7vya4vwhr3eia5g4@gondor.apana.org.au>
Message-Id: <20190613075117.GA4292@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

On Thu, Jun 13, 2019 at 11:13:55AM +0800, Herbert Xu wrote:
> On Wed, Jun 12, 2019 at 05:08:50PM +0200, Heiko Carstens wrote:
> > On Wed, Jun 12, 2019 at 03:33:02PM +0200, David Hildenbrand wrote:
> > > s390x crypto is one of the rare modules that returns -EOPNOTSUPP instead of
> > > -ENODEV in case HW support is not available.
> > > 
> > > Convert to -ENODEV, so e.g., systemd's systemd-modules-load.service
> > > ignores this error properly.
> > > 
> > > v2 -> v3:
> > > - "s390/pkey: Use -ENODEV instead of -EOPNOTSUPP"
> > > -- Also convert pkey_clr2protkey() as requested by Harald
> > > - Add r-b's (thanks!)
> > > 
> > > v1 -> v2:
> > > - Include
> > > -- "s390/crypto: ghash: Use -ENODEV instead of -EOPNOTSUPP"
> > > -- "s390/crypto: prng: Use -ENODEV instead of -EOPNOTSUPP"
> > > -- "s390/crypto: sha: Use -ENODEV instead of -EOPNOTSUPP"
> > > 
> > > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > > Cc: Harald Freudenberger <freude@linux.ibm.com>
> > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > 
> > > David Hildenbrand (4):
> > >   s390/pkey: Use -ENODEV instead of -EOPNOTSUPP
> > >   s390/crypto: ghash: Use -ENODEV instead of -EOPNOTSUPP
> > >   s390/crypto: prng: Use -ENODEV instead of -EOPNOTSUPP
> > >   s390/crypto: sha: Use -ENODEV instead of -EOPNOTSUPP
> > 
> > Should I pick these up so they can go upstream via the s390 tree?
> 
> Sure Heiko.  Thanks!

Ok, all applied. Thanks!
