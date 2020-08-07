Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr140057.outbound.protection.outlook.com ([40.107.14.57]:4231
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726891AbgHGQWQ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 7 Aug 2020 12:22:16 -0400
From: Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH 11/22] crypto: artpec6 - add check for xts input length equal to zero
Date: Fri,  7 Aug 2020 19:19:59 +0300
Message-Id: <20200807162010.18979-12-andrei.botila@oss.nxp.com>
In-Reply-To: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org, linux-arm-kernel@axis.com, Andrei Botila <andrei.botila@nxp.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson <lars.persson@axis.com>

From: Andrei Botila <andrei.botila@nxp.com>

Standardize the way input lengths equal to 0 are handled in all skcipher
algorithms. All the algorithms return 0 for input lengths equal to zero.

Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Lars Persson <lars.persson@axis.com>
Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
---
 drivers/crypto/axis/artpec6_crypto.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 1a46eeddf082..243880c97629 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -1090,6 +1090,9 @@ static int artpec6_crypto_encrypt(struct skcipher_request *req)
 	void (*complete)(struct crypto_async_request *req);
 	int ret;
 
+	if (!req->cryptlen)
+		return 0;
+
 	req_ctx = skcipher_request_ctx(req);
 
 	switch (ctx->crypto_type) {
@@ -1135,6 +1138,9 @@ static int artpec6_crypto_decrypt(struct skcipher_request *req)
 	struct artpec6_crypto_request_context *req_ctx = NULL;
 	void (*complete)(struct crypto_async_request *req);
 
+	if (!req->cryptlen)
+		return 0;
+
 	req_ctx = skcipher_request_ctx(req);
 
 	switch (ctx->crypto_type) {
-- 
2.17.1
