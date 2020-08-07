Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr140057.outbound.protection.outlook.com ([40.107.14.57]:4231
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbgHGQV4 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 7 Aug 2020 12:21:56 -0400
From: Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH 05/22] crypto: powerpc/aes-spe - add check for xts input length equal to zero
Date: Fri,  7 Aug 2020 19:19:53 +0300
Message-Id: <20200807162010.18979-6-andrei.botila@oss.nxp.com>
In-Reply-To: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org, linux-arm-kernel@axis.com, Andrei Botila <andrei.botila@nxp.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>

From: Andrei Botila <andrei.botila@nxp.com>

Standardize the way input lengths equal to 0 are handled in all skcipher
algorithms. All the algorithms return 0 for input lengths equal to zero.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
---
 arch/powerpc/crypto/aes-spe-glue.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/crypto/aes-spe-glue.c b/arch/powerpc/crypto/aes-spe-glue.c
index c2b23b69d7b1..f37d8bef322b 100644
--- a/arch/powerpc/crypto/aes-spe-glue.c
+++ b/arch/powerpc/crypto/aes-spe-glue.c
@@ -327,6 +327,9 @@ static int ppc_xts_encrypt(struct skcipher_request *req)
 	u8 b[2][AES_BLOCK_SIZE];
 	int err;
 
+	if (!req->cryptlen)
+		return 0;
+
 	if (req->cryptlen < AES_BLOCK_SIZE)
 		return -EINVAL;
 
@@ -366,6 +369,9 @@ static int ppc_xts_decrypt(struct skcipher_request *req)
 	le128 twk;
 	int err;
 
+	if (!req->cryptlen)
+		return 0;
+
 	if (req->cryptlen < AES_BLOCK_SIZE)
 		return -EINVAL;
 
-- 
2.17.1
