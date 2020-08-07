Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr140057.outbound.protection.outlook.com ([40.107.14.57]:4231
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727042AbgHGQW3 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 7 Aug 2020 12:22:29 -0400
From: Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH 18/22] crypto: hisilicon/sec - add check for xts input length equal to zero
Date: Fri,  7 Aug 2020 19:20:06 +0300
Message-Id: <20200807162010.18979-19-andrei.botila@oss.nxp.com>
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
 drivers/crypto/hisilicon/sec/sec_algs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/hisilicon/sec/sec_algs.c b/drivers/crypto/hisilicon/sec/sec_algs.c
index 8ca945ac297e..419ec4f23164 100644
--- a/drivers/crypto/hisilicon/sec/sec_algs.c
+++ b/drivers/crypto/hisilicon/sec/sec_algs.c
@@ -723,6 +723,10 @@ static int sec_alg_skcipher_crypto(struct skcipher_request *skreq,
 	bool split = skreq->src != skreq->dst;
 	gfp_t gfp = skreq->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL : GFP_ATOMIC;
 
+	if (!skreq->cryptlen && (ctx->cipher_alg == SEC_C_AES_XTS_128 ||
+				 ctx->cipher_alg == SEC_C_AES_XTS_256))
+		return 0;
+
 	mutex_init(&sec_req->lock);
 	sec_req->req_base = &skreq->base;
 	sec_req->err = 0;
-- 
2.17.1
