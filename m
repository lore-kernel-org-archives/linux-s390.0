Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405313AbfJQJAl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Oct 2019 05:00:41 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9H8x9mS059161
        for <linux-s390@vger.kernel.org>; Thu, 17 Oct 2019 05:00:40 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vpkcvm14v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 17 Oct 2019 05:00:40 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 17 Oct 2019 10:00:37 +0100
Date: Thu, 17 Oct 2019 11:00:33 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFT PATCH 0/3] crypto: s390 - convert to skcipher API
References: <20191012201809.160500-1-ebiggers@kernel.org>
 <20191016080103.GA4267@osiris>
 <20191016123507.GA16265@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016123507.GA16265@gondor.apana.org.au>
Message-Id: <20191017090033.GA6087@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>

On Wed, Oct 16, 2019 at 11:35:07PM +1100, Herbert Xu wrote:
> > > Eric Biggers (3):
> > >   crypto: s390/aes - convert to skcipher API
> > >   crypto: s390/paes - convert to skcipher API
> > >   crypto: s390/des - convert to skcipher API
> > > 
> > >  arch/s390/crypto/aes_s390.c  | 609 ++++++++++++++---------------------
> > >  arch/s390/crypto/des_s390.c  | 419 ++++++++++--------------
> > >  arch/s390/crypto/paes_s390.c | 414 ++++++++++--------------
> > >  3 files changed, 580 insertions(+), 862 deletions(-)
> > 
> > Herbert, should these go upstream via the s390 or crypto tree?
> 
> It would be best to go via the crypto tree since any future patches
> to remove blkcipher/ablkcipher would depend on these patches.

Ok, fully agreed. Thanks!
