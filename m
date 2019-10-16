Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41560 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfJPJCu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Oct 2019 05:02:50 -0400
Received: by mail-vs1-f68.google.com with SMTP id l2so15067987vsr.8
        for <linux-s390@vger.kernel.org>; Wed, 16 Oct 2019 02:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191012201809.160500-1-ebiggers@kernel.org>
In-Reply-To: <20191012201809.160500-1-ebiggers@kernel.org>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Wed, 16 Oct 2019 12:02:38 +0300
Message-ID: <CAOtvUMdrrOB4zqe5v6mKDEnnfm4qnSDPW5+at6vhqTdF-wUL+Q@mail.gmail.com>
Subject: Re: [RFT PATCH 0/3] crypto: s390 - convert to skcipher API
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>

On Sat, Oct 12, 2019 at 11:20 PM Eric Biggers <ebiggers@kernel.org> wrote:
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
> CONFIG_CRYPTO_HW=3Dy
> CONFIG_ZCRYPT=3Dy
> CONFIG_PKEY=3Dy
> CONFIG_CRYPTO_AES_S390=3Dy
> CONFIG_CRYPTO_PAES_S390=3Dy
> CONFIG_CRYPTO_DES_S390=3Dy
> # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=3Dy
> CONFIG_CRYPTO_AES=3Dy
> CONFIG_CRYPTO_DES=3Dy
> CONFIG_CRYPTO_CBC=3Dy
> CONFIG_CRYPTO_CTR=3Dy
> CONFIG_CRYPTO_ECB=3Dy
> CONFIG_CRYPTO_XTS=3Dy
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



It is probably  impracticable to test paes algorithms since they rely
on keys which are not accessible to the kernel and are typically tied
to the specific machine you run on.

Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
