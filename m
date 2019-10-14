Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54498 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbfJNMrK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Oct 2019 08:47:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so17143368wmp.4
        for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2019 05:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191012201809.160500-1-ebiggers@kernel.org>
In-Reply-To: <20191012201809.160500-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 14 Oct 2019 14:46:55 +0200
Message-ID: <CAKv+Gu_HWop7ry=PKMjYrY8EcZN2dmJnqWRE=VPR2ep7OFEBVw@mail.gmail.com>
Subject: Re: [RFT PATCH 0/3] crypto: s390 - convert to skcipher API
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>

On Sat, 12 Oct 2019 at 22:20, Eric Biggers <ebiggers@kernel.org> wrote:
>
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

These look fine to me:

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

but i cannot test them either.
