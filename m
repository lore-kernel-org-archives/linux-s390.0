Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:64918
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726954AbgHGQWM (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 7 Aug 2020 12:22:12 -0400
From: Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH 09/22] crypto: xts - add check for block length equal to zero
Date: Fri,  7 Aug 2020 19:19:57 +0300
Message-Id: <20200807162010.18979-10-andrei.botila@oss.nxp.com>
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
 crypto/xts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/crypto/xts.c b/crypto/xts.c
index 3c3ed02c7663..7df68f52fddc 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -263,6 +263,9 @@ static int xts_encrypt(struct skcipher_request *req)
 	struct skcipher_request *subreq = &rctx->subreq;
 	int err;
 
+	if (!req->cryptlen)
+		return 0;
+
 	err = xts_init_crypt(req, xts_encrypt_done) ?:
 	      xts_xor_tweak_pre(req, true) ?:
 	      crypto_skcipher_encrypt(subreq) ?:
@@ -280,6 +283,9 @@ static int xts_decrypt(struct skcipher_request *req)
 	struct skcipher_request *subreq = &rctx->subreq;
 	int err;
 
+	if (!req->cryptlen)
+		return 0;
+
 	err = xts_init_crypt(req, xts_decrypt_done) ?:
 	      xts_xor_tweak_pre(req, false) ?:
 	      crypto_skcipher_decrypt(subreq) ?:
-- 
2.17.1
