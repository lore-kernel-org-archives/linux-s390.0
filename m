Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407254AbfFLKXE (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 06:23:04 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 4/4] s390/crypto: sha: Use -ENODEV instead of -EOPNOTSUPP
Date: Wed, 12 Jun 2019 12:22:48 +0200
Message-Id: <20190612102248.18903-5-david@redhat.com>
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
 arch/s390/crypto/sha1_s390.c   | 2 +-
 arch/s390/crypto/sha256_s390.c | 2 +-
 arch/s390/crypto/sha512_s390.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/crypto/sha1_s390.c b/arch/s390/crypto/sha1_s390.c
index 009572e8276d..7c15542d3685 100644
--- a/arch/s390/crypto/sha1_s390.c
+++ b/arch/s390/crypto/sha1_s390.c
@@ -86,7 +86,7 @@ static struct shash_alg alg = {
 static int __init sha1_s390_init(void)
 {
 	if (!cpacf_query_func(CPACF_KIMD, CPACF_KIMD_SHA_1))
-		return -EOPNOTSUPP;
+		return -ENODEV;
 	return crypto_register_shash(&alg);
 }
 
diff --git a/arch/s390/crypto/sha256_s390.c b/arch/s390/crypto/sha256_s390.c
index 62833a1d8724..af7505148f80 100644
--- a/arch/s390/crypto/sha256_s390.c
+++ b/arch/s390/crypto/sha256_s390.c
@@ -117,7 +117,7 @@ static int __init sha256_s390_init(void)
 	int ret;
 
 	if (!cpacf_query_func(CPACF_KIMD, CPACF_KIMD_SHA_256))
-		return -EOPNOTSUPP;
+		return -ENODEV;
 	ret = crypto_register_shash(&sha256_alg);
 	if (ret < 0)
 		goto out;
diff --git a/arch/s390/crypto/sha512_s390.c b/arch/s390/crypto/sha512_s390.c
index be589c340d15..ad29db085a18 100644
--- a/arch/s390/crypto/sha512_s390.c
+++ b/arch/s390/crypto/sha512_s390.c
@@ -127,7 +127,7 @@ static int __init init(void)
 	int ret;
 
 	if (!cpacf_query_func(CPACF_KIMD, CPACF_KIMD_SHA_512))
-		return -EOPNOTSUPP;
+		return -ENODEV;
 	if ((ret = crypto_register_shash(&sha512_alg)) < 0)
 		goto out;
 	if ((ret = crypto_register_shash(&sha384_alg)) < 0)
-- 
2.21.0
