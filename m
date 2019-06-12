Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728540AbfFLNdX (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 09:33:23 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 3/4] s390/crypto: prng: Use -ENODEV instead of -EOPNOTSUPP
Date: Wed, 12 Jun 2019 15:33:05 +0200
Message-Id: <20190612133306.10231-4-david@redhat.com>
In-Reply-To: <20190612133306.10231-1-david@redhat.com>
References: <20190612133306.10231-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org, David Hildenbrand <david@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

Let's use the error value that is typically used if HW support is not
available when trying to load a module - this is also what systemd's
systemd-modules-load.service expects.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/crypto/prng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/crypto/prng.c b/arch/s390/crypto/prng.c
index 12cca467af7d..d977643fa627 100644
--- a/arch/s390/crypto/prng.c
+++ b/arch/s390/crypto/prng.c
@@ -824,7 +824,7 @@ static int __init prng_init(void)
 
 	/* check if the CPU has a PRNG */
 	if (!cpacf_query_func(CPACF_KMC, CPACF_KMC_PRNG))
-		return -EOPNOTSUPP;
+		return -ENODEV;
 
 	/* check if TRNG subfunction is available */
 	if (cpacf_query_func(CPACF_PRNO, CPACF_PRNO_TRNG))
@@ -837,7 +837,7 @@ static int __init prng_init(void)
 			if (prng_mode == PRNG_MODE_SHA512) {
 				pr_err("The prng module cannot "
 				       "start in SHA-512 mode\n");
-				return -EOPNOTSUPP;
+				return -ENODEV;
 			}
 			prng_mode = PRNG_MODE_TDES;
 		} else
-- 
2.21.0
