Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH 20/22] crypto: octeontx - add check for xts input length equal to zero
Date: Fri,  7 Aug 2020 19:20:08 +0300
Message-Id: <20200807162010.18979-21-andrei.botila@oss.nxp.com>
In-Reply-To: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org, linux-arm-kernel@axis.com, Andrei Botila <andrei.botila@nxp.com>, Boris Brezillon <bbrezillon@kernel.org>, Arnaud Ebalard <arno@natisbad.org>, Srujana Challa <schalla@marvell.com>

From: Andrei Botila <andrei.botila@nxp.com>

Standardize the way input lengths equal to 0 are handled in all skcipher
algorithms. All the algorithms return 0 for input lengths equal to zero.

Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Arnaud Ebalard <arno@natisbad.org>
Cc: Srujana Challa <schalla@marvell.com>
Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
---
 drivers/crypto/marvell/octeontx/otx_cptvf_algs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
index 90bb31329d4b..ec13bc3f1766 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
@@ -340,11 +340,16 @@ static inline int cpt_enc_dec(struct skcipher_request *req, u32 enc)
 {
 	struct crypto_skcipher *stfm = crypto_skcipher_reqtfm(req);
 	struct otx_cpt_req_ctx *rctx = skcipher_request_ctx(req);
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(stfm);
+	struct otx_cpt_enc_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
 	u32 enc_iv_len = crypto_skcipher_ivsize(stfm);
 	struct pci_dev *pdev;
 	int status, cpu_num;
 
+	if (!req->cryptlen && ctx->cipher_type == OTX_CPT_AES_XTS)
+		return 0;
+
 	/* Validate that request doesn't exceed maximum CPT supported size */
 	if (req->cryptlen > OTX_CPT_MAX_REQ_SIZE)
 		return -E2BIG;
-- 
2.17.1
