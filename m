Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr140057.outbound.protection.outlook.com ([40.107.14.57]:4231
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726061AbgHGQVx (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 7 Aug 2020 12:21:53 -0400
From: Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH 04/22] crypto: arm64/aes-neonbs - add check for xts input length equal to zero
Date: Fri,  7 Aug 2020 19:19:52 +0300
Message-Id: <20200807162010.18979-5-andrei.botila@oss.nxp.com>
In-Reply-To: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org, linux-arm-kernel@axis.com, Andrei Botila <andrei.botila@nxp.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>

From: Andrei Botila <andrei.botila@nxp.com>

Standardize the way input lengths equal to 0 are handled in all skcipher
algorithms. All the algorithms return 0 for input lengths equal to zero.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
---
 arch/arm64/crypto/aes-neonbs-glue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/crypto/aes-neonbs-glue.c b/arch/arm64/crypto/aes-neonbs-glue.c
index fb507d569922..197bf24e7dae 100644
--- a/arch/arm64/crypto/aes-neonbs-glue.c
+++ b/arch/arm64/crypto/aes-neonbs-glue.c
@@ -330,6 +330,9 @@ static int __xts_crypt(struct skcipher_request *req, bool encrypt,
 	int first = 1;
 	u8 *out, *in;
 
+	if (!req->cryptlen)
+		return 0;
+
 	if (req->cryptlen < AES_BLOCK_SIZE)
 		return -EINVAL;
 
-- 
2.17.1
