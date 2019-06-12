Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfFLKWy (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 06:22:54 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 1/4] s390/pkey: Use -ENODEV instead of -EOPNOTSUPP
Date: Wed, 12 Jun 2019 12:22:45 +0200
Message-Id: <20190612102248.18903-2-david@redhat.com>
In-Reply-To: <20190612102248.18903-1-david@redhat.com>
References: <20190612102248.18903-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org, David Hildenbrand <david@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

systemd-modules-load.service automatically tries to load the pkey module
on systems that have MSA.

Pkey also requires the MSA3 facility and a bunch of subfunctions.
Failing with -EOPNOTSUPP makes "systemd-modules-load.service" fail on
any system that does not have all needed subfunctions. For example,
when running under QEMU TCG (but also on systems where protected keys
are disabled via the HMC).

Let's use -ENODEV, so systemd-modules-load.service properly ignores
failing to load the pkey module because of missing HW functionality.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/s390/crypto/pkey_api.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 45eb0c14b880..ddfcefb47284 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1695,15 +1695,15 @@ static int __init pkey_init(void)
 	 * are able to work with protected keys.
 	 */
 	if (!cpacf_query(CPACF_PCKMO, &pckmo_functions))
-		return -EOPNOTSUPP;
+		return -ENODEV;
 
 	/* check for kmc instructions available */
 	if (!cpacf_query(CPACF_KMC, &kmc_functions))
-		return -EOPNOTSUPP;
+		return -ENODEV;
 	if (!cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_128) ||
 	    !cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_192) ||
 	    !cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_256))
-		return -EOPNOTSUPP;
+		return -ENODEV;
 
 	pkey_debug_init();
 
-- 
2.21.0
