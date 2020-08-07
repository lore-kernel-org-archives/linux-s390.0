Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr140057.outbound.protection.outlook.com ([40.107.14.57]:4231
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726891AbgHGQWZ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 7 Aug 2020 12:22:25 -0400
From: Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH 16/22] crypto: ccree - add check for xts input length equal to zero
Date: Fri,  7 Aug 2020 19:20:04 +0300
Message-Id: <20200807162010.18979-17-andrei.botila@oss.nxp.com>
In-Reply-To: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org, linux-arm-kernel@axis.com, Andrei Botila <andrei.botila@nxp.com>, Gilad Ben-Yossef <gilad@benyossef.com>

From: Andrei Botila <andrei.botila@nxp.com>

Standardize the way input lengths equal to 0 are handled in all skcipher
algorithms. All the algorithms return 0 for input lengths equal to zero.
This change has implications not only for xts(aes) but also for cts(cbc(aes))
and cts(cbc(paes)).

Cc: Gilad Ben-Yossef <gilad@benyossef.com>
Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
---
 drivers/crypto/ccree/cc_cipher.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index 076669dc1035..112bb8b4dce6 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -912,17 +912,18 @@ static int cc_cipher_process(struct skcipher_request *req,
 
 	/* STAT_PHASE_0: Init and sanity checks */
 
-	if (validate_data_size(ctx_p, nbytes)) {
-		dev_dbg(dev, "Unsupported data size %d.\n", nbytes);
-		rc = -EINVAL;
-		goto exit_process;
-	}
 	if (nbytes == 0) {
 		/* No data to process is valid */
 		rc = 0;
 		goto exit_process;
 	}
 
+	if (validate_data_size(ctx_p, nbytes)) {
+		dev_dbg(dev, "Unsupported data size %d.\n", nbytes);
+		rc = -EINVAL;
+		goto exit_process;
+	}
+
 	if (ctx_p->fallback_on) {
 		struct skcipher_request *subreq = skcipher_request_ctx(req);
 
-- 
2.17.1
