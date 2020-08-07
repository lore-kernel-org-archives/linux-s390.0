Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:64918
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726996AbgHGQWW (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 7 Aug 2020 12:22:22 -0400
From: Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH 14/22] crypto: cavium/nitrox - add check for xts input length equal to zero
Date: Fri,  7 Aug 2020 19:20:02 +0300
Message-Id: <20200807162010.18979-15-andrei.botila@oss.nxp.com>
In-Reply-To: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org, linux-arm-kernel@axis.com, Andrei Botila <andrei.botila@nxp.com>, Srikanth Jampala <jsrikanth@marvell.com>, Nagadheeraj Rottela <rnagadheeraj@marvell.com>

From: Andrei Botila <andrei.botila@nxp.com>

Standardize the way input lengths equal to 0 are handled in all skcipher
algorithms. All the algorithms return 0 for input lengths equal to zero.

Cc: Srikanth Jampala <jsrikanth@marvell.com>
Cc: Nagadheeraj Rottela <rnagadheeraj@marvell.com>
Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
---
 drivers/crypto/cavium/nitrox/nitrox_skcipher.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_skcipher.c b/drivers/crypto/cavium/nitrox/nitrox_skcipher.c
index a553ac65f324..d76589ebe354 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_skcipher.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_skcipher.c
@@ -249,10 +249,16 @@ static int nitrox_skcipher_crypt(struct skcipher_request *skreq, bool enc)
 	struct crypto_skcipher *cipher = crypto_skcipher_reqtfm(skreq);
 	struct nitrox_crypto_ctx *nctx = crypto_skcipher_ctx(cipher);
 	struct nitrox_kcrypt_request *nkreq = skcipher_request_ctx(skreq);
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(cipher);
 	int ivsize = crypto_skcipher_ivsize(cipher);
 	struct se_crypto_request *creq;
+	const char *name;
 	int ret;
 
+	name = crypto_tfm_alg_name(tfm);
+	if (!skreq->cryptlen && flexi_cipher_type(name) == CIPHER_AES_XTS)
+		return 0;
+
 	creq = &nkreq->creq;
 	creq->flags = skreq->base.flags;
 	creq->gfp = (skreq->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
-- 
2.17.1
