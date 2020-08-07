Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:64918
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727059AbgHGQWd (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 7 Aug 2020 12:22:33 -0400
From: Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH 21/22] crypto: qce - add check for xts input length equal to zero
Date: Fri,  7 Aug 2020 19:20:09 +0300
Message-Id: <20200807162010.18979-22-andrei.botila@oss.nxp.com>
In-Reply-To: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org, linux-arm-kernel@axis.com, Andrei Botila <andrei.botila@nxp.com>

From: Andrei Botila <andrei.botila@nxp.com>

Standardize the way input lengths equal to 0 are handled in all skcipher
algorithms. All the algorithms return 0 for input lengths equal to zero.

Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
---
 drivers/crypto/qce/skcipher.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 5630c5addd28..887fd4dc9b43 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -223,6 +223,9 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	int keylen;
 	int ret;
 
+	if (!req->cryptlen && IS_XTS(rctx->flags))
+		return 0;
+
 	rctx->flags = tmpl->alg_flags;
 	rctx->flags |= encrypt ? QCE_ENCRYPT : QCE_DECRYPT;
 	keylen = IS_XTS(rctx->flags) ? ctx->enc_keylen >> 1 : ctx->enc_keylen;
-- 
2.17.1
