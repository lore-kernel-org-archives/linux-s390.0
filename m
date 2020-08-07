Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr140057.outbound.protection.outlook.com ([40.107.14.57]:4231
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726954AbgHGQWW (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 7 Aug 2020 12:22:22 -0400
From: Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH 13/22] crypto: cavium/cpt - add check for xts input length equal to zero
Date: Fri,  7 Aug 2020 19:20:01 +0300
Message-Id: <20200807162010.18979-14-andrei.botila@oss.nxp.com>
In-Reply-To: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org, linux-arm-kernel@axis.com, Andrei Botila <andrei.botila@nxp.com>, George Cherian <gcherian@marvell.com>

From: Andrei Botila <andrei.botila@nxp.com>

Standardize the way input lengths equal to 0 are handled in all skcipher
algorithms. All the algorithms return 0 for input lengths equal to zero.

Cc: George Cherian <gcherian@marvell.com>
Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
---
 drivers/crypto/cavium/cpt/cptvf_algs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/cavium/cpt/cptvf_algs.c b/drivers/crypto/cavium/cpt/cptvf_algs.c
index 5af0dc2a8909..edc18c8dd571 100644
--- a/drivers/crypto/cavium/cpt/cptvf_algs.c
+++ b/drivers/crypto/cavium/cpt/cptvf_algs.c
@@ -193,6 +193,7 @@ static inline void create_output_list(struct skcipher_request *req,
 static inline int cvm_enc_dec(struct skcipher_request *req, u32 enc)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct cvm_enc_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct cvm_req_ctx *rctx = skcipher_request_ctx(req);
 	u32 enc_iv_len = crypto_skcipher_ivsize(tfm);
 	struct fc_context *fctx = &rctx->fctx;
@@ -200,6 +201,9 @@ static inline int cvm_enc_dec(struct skcipher_request *req, u32 enc)
 	void *cdev = NULL;
 	int status;
 
+	if (!req->cryptlen && ctx->cipher_type == AES_XTS)
+		return 0;
+
 	memset(req_info, 0, sizeof(struct cpt_request_info));
 	req_info->may_sleep = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) != 0;
 	memset(fctx, 0, sizeof(struct fc_context));
-- 
2.17.1
