Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfFLKW5 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 06:22:57 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 2/4] s390/crypto: ghash: Use -ENODEV instead of -EOPNOTSUPP
Date: Wed, 12 Jun 2019 12:22:46 +0200
Message-Id: <20190612102248.18903-3-david@redhat.com>
In-Reply-To: <20190612102248.18903-1-david@redhat.com>
References: <20190612102248.18903-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org, David Hildenbrand <david@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

Let's use the error value that is typically used if HW support is not
available when trying to load a module - this is also what systemd's
systemd-modules-load.service expects.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/crypto/ghash_s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/crypto/ghash_s390.c b/arch/s390/crypto/ghash_s390.c
index 86aed30fad3a..eeeb6a7737a4 100644
--- a/arch/s390/crypto/ghash_s390.c
+++ b/arch/s390/crypto/ghash_s390.c
@@ -137,7 +137,7 @@ static struct shash_alg ghash_alg = {
 static int __init ghash_mod_init(void)
 {
 	if (!cpacf_query_func(CPACF_KIMD, CPACF_KIMD_GHASH))
-		return -EOPNOTSUPP;
+		return -ENODEV;
 
 	return crypto_register_shash(&ghash_alg);
 }
-- 
2.21.0
