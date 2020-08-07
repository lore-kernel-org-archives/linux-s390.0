Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:64918
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727053AbgHGQWa (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 7 Aug 2020 12:22:30 -0400
From: Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH 19/22] crypto: inside-secure - add check for xts input length equal to zero
Date: Fri,  7 Aug 2020 19:20:07 +0300
Message-Id: <20200807162010.18979-20-andrei.botila@oss.nxp.com>
In-Reply-To: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org, linux-arm-kernel@axis.com, Andrei Botila <andrei.botila@nxp.com>, Antoine Tenart <antoine.tenart@bootlin.com>

From: Andrei Botila <andrei.botila@nxp.com>

Standardize the way input lengths equal to 0 are handled in all skcipher
algorithms. All the algorithms return 0 for input lengths equal to zero.

Cc: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
---
 drivers/crypto/inside-secure/safexcel_cipher.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypto/inside-secure/safexcel_cipher.c
index 1ac3253b7903..03d06556ea98 100644
--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -2533,6 +2533,9 @@ static int safexcel_skcipher_aes_xts_cra_init(struct crypto_tfm *tfm)
 
 static int safexcel_encrypt_xts(struct skcipher_request *req)
 {
+	if (!req->cryptlen)
+		return 0;
+
 	if (req->cryptlen < XTS_BLOCK_SIZE)
 		return -EINVAL;
 	return safexcel_queue_req(&req->base, skcipher_request_ctx(req),
@@ -2541,6 +2544,9 @@ static int safexcel_encrypt_xts(struct skcipher_request *req)
 
 static int safexcel_decrypt_xts(struct skcipher_request *req)
 {
+	if (!req->cryptlen)
+		return 0;
+
 	if (req->cryptlen < XTS_BLOCK_SIZE)
 		return -EINVAL;
 	return safexcel_queue_req(&req->base, skcipher_request_ctx(req),
-- 
2.17.1
