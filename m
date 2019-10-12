Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbfJLUUO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 12 Oct 2019 16:20:14 -0400
From: Eric Biggers <ebiggers@kernel.org>
Subject: [RFT PATCH 0/3] crypto: s390 - convert to skcipher API
Date: Sat, 12 Oct 2019 13:18:06 -0700
Message-Id: <20191012201809.160500-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>

This series converts the glue code for the S390 CPACF implementations of
AES, DES, and 3DES modes from the deprecated "blkcipher" API to the
"skcipher" API.  This is needed in order for the blkcipher API to be
removed.

I've compiled this patchset, and the conversion is very similar to that
which has been done for many other crypto drivers.  But I don't have the
hardware to test it, nor is S390 CPACF supported by QEMU.  So I really
need someone with the hardware to test it.  You can do so by setting:

CONFIG_CRYPTO_HW=y
CONFIG_ZCRYPT=y
CONFIG_PKEY=y
CONFIG_CRYPTO_AES_S390=y
CONFIG_CRYPTO_PAES_S390=y
CONFIG_CRYPTO_DES_S390=y
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_XTS=y

Then boot and check for crypto self-test failures by running
'dmesg | grep alg'.

If there are test failures, please also check whether they were already
failing prior to this patchset.

This won't cover the "paes" ("protected key AES") algorithms, however,
since those don't have self-tests.  If anyone has any way to test those,
please do so.

Eric Biggers (3):
  crypto: s390/aes - convert to skcipher API
  crypto: s390/paes - convert to skcipher API
  crypto: s390/des - convert to skcipher API

 arch/s390/crypto/aes_s390.c  | 609 ++++++++++++++---------------------
 arch/s390/crypto/des_s390.c  | 419 ++++++++++--------------
 arch/s390/crypto/paes_s390.c | 414 ++++++++++--------------
 3 files changed, 580 insertions(+), 862 deletions(-)

-- 
2.23.0
