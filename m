Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59978 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731086AbfJNJlW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Oct 2019 05:41:22 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9E9awvt000878
        for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2019 05:41:21 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vk9n27whs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2019 05:41:19 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <freude@linux.ibm.com>;
        Mon, 14 Oct 2019 10:41:16 +0100
Subject: Re: [RFT PATCH 0/3] crypto: s390 - convert to skcipher API
References: <20191012201809.160500-1-ebiggers@kernel.org>
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Mon, 14 Oct 2019 11:41:11 +0200
MIME-Version: 1.0
In-Reply-To: <20191012201809.160500-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <3d65a0b0-7590-9150-82dc-06cf3c84d353@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 12.10.19 22:18, Eric Biggers wrote:
> This series converts the glue code for the S390 CPACF implementations of
> AES, DES, and 3DES modes from the deprecated "blkcipher" API to the
> "skcipher" API.  This is needed in order for the blkcipher API to be
> removed.
>
> I've compiled this patchset, and the conversion is very similar to that
> which has been done for many other crypto drivers.  But I don't have the
> hardware to test it, nor is S390 CPACF supported by QEMU.  So I really
> need someone with the hardware to test it.  You can do so by setting:
>
> CONFIG_CRYPTO_HW=y
> CONFIG_ZCRYPT=y
> CONFIG_PKEY=y
> CONFIG_CRYPTO_AES_S390=y
> CONFIG_CRYPTO_PAES_S390=y
> CONFIG_CRYPTO_DES_S390=y
> # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> CONFIG_DEBUG_KERNEL=y
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_DES=y
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_ECB=y
> CONFIG_CRYPTO_XTS=y
>
> Then boot and check for crypto self-test failures by running
> 'dmesg | grep alg'.
>
> If there are test failures, please also check whether they were already
> failing prior to this patchset.
>
> This won't cover the "paes" ("protected key AES") algorithms, however,
> since those don't have self-tests.  If anyone has any way to test those,
> please do so.
>
> Eric Biggers (3):
>   crypto: s390/aes - convert to skcipher API
>   crypto: s390/paes - convert to skcipher API
>   crypto: s390/des - convert to skcipher API
>
>  arch/s390/crypto/aes_s390.c  | 609 ++++++++++++++---------------------
>  arch/s390/crypto/des_s390.c  | 419 ++++++++++--------------
>  arch/s390/crypto/paes_s390.c | 414 ++++++++++--------------
>  3 files changed, 580 insertions(+), 862 deletions(-)
>
Thanks Eric, I'll do these tests and give you feedback.
