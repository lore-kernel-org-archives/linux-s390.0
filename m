Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:64918
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726970AbgHGQWR (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 7 Aug 2020 12:22:17 -0400
From: Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH 12/22] crypto: bcm - add check for xts input length equal to zero
Date: Fri,  7 Aug 2020 19:20:00 +0300
Message-Id: <20200807162010.18979-13-andrei.botila@oss.nxp.com>
In-Reply-To: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org, linux-arm-kernel@axis.com, Andrei Botila <andrei.botila@nxp.com>, Zhang Shengju <zhangshengju@cmss.chinamobile.com>, Tang Bin <tangbin@cmss.chinamobile.com>

From: Andrei Botila <andrei.botila@nxp.com>

Standardize the way input lengths equal to 0 are handled in all skcipher
algorithms. All the algorithms return 0 for input lengths equal to zero.

Cc: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Cc: Tang Bin <tangbin@cmss.chinamobile.com>
Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
---
 drivers/crypto/bcm/cipher.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
index 8a7fa1ae1ade..8a6f225f4db7 100644
--- a/drivers/crypto/bcm/cipher.c
+++ b/drivers/crypto/bcm/cipher.c
@@ -1754,6 +1754,9 @@ static int skcipher_enqueue(struct skcipher_request *req, bool encrypt)
 	    crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
 	int err;
 
+	if (!req->cryptlen && ctx->cipher.mode == CIPHER_MODE_XTS)
+		return 0;
+
 	flow_log("%s() enc:%u\n", __func__, encrypt);
 
 	rctx->gfp = (req->base.flags & (CRYPTO_TFM_REQ_MAY_BACKLOG |
-- 
2.17.1
