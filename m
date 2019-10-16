Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390538AbfJPIBN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Oct 2019 04:01:13 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9G7gNwr072455
        for <linux-s390@vger.kernel.org>; Wed, 16 Oct 2019 04:01:11 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vnxjhspw5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 16 Oct 2019 04:01:11 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 16 Oct 2019 09:01:09 +0100
Date: Wed, 16 Oct 2019 10:01:03 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFT PATCH 0/3] crypto: s390 - convert to skcipher API
References: <20191012201809.160500-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012201809.160500-1-ebiggers@kernel.org>
Message-Id: <20191016080103.GA4267@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Biggers <ebiggers@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>

On Sat, Oct 12, 2019 at 01:18:06PM -0700, Eric Biggers wrote:
> This series converts the glue code for the S390 CPACF implementations of
> AES, DES, and 3DES modes from the deprecated "blkcipher" API to the
> "skcipher" API.  This is needed in order for the blkcipher API to be
> removed.
> 
> I've compiled this patchset, and the conversion is very similar to that
> which has been done for many other crypto drivers.  But I don't have the
> hardware to test it, nor is S390 CPACF supported by QEMU.  So I really
> need someone with the hardware to test it.  You can do so by setting:

...

> Eric Biggers (3):
>   crypto: s390/aes - convert to skcipher API
>   crypto: s390/paes - convert to skcipher API
>   crypto: s390/des - convert to skcipher API
> 
>  arch/s390/crypto/aes_s390.c  | 609 ++++++++++++++---------------------
>  arch/s390/crypto/des_s390.c  | 419 ++++++++++--------------
>  arch/s390/crypto/paes_s390.c | 414 ++++++++++--------------
>  3 files changed, 580 insertions(+), 862 deletions(-)

Herbert, should these go upstream via the s390 or crypto tree?
