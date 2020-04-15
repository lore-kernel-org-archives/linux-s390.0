Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897472AbgDOLmf (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Apr 2020 07:42:35 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 007/106] s390/crypto: explicitly memzero stack key material in aes_s390.c
Date: Wed, 15 Apr 2020 07:40:47 -0400
Message-Id: <20200415114226.13103-7-sashal@kernel.org>
In-Reply-To: <20200415114226.13103-1-sashal@kernel.org>
References: <20200415114226.13103-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Torsten Duwe <duwe@suse.de>, Harald Freudenberger <freude@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org

From: Torsten Duwe <duwe@suse.de>

[ Upstream commit 4a559cd15dbc79958fa9b18ad4e8afe4a0bf4744 ]

aes_s390.c has several functions which allocate space for key material on
the stack and leave the used keys there. It is considered good practice
to clean these locations before the function returns.

Link: https://lkml.kernel.org/r/20200221165511.GB6928@lst.de
Signed-off-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/crypto/aes_s390.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index ead0b2c9881d1..14d006b424eb1 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -354,6 +354,7 @@ static int cbc_aes_crypt(struct skcipher_request *req, unsigned long modifier)
 		memcpy(walk.iv, param.iv, AES_BLOCK_SIZE);
 		ret = skcipher_walk_done(&walk, nbytes - n);
 	}
+	memzero_explicit(&param, sizeof(param));
 	return ret;
 }
 
@@ -489,6 +490,8 @@ static int xts_aes_crypt(struct skcipher_request *req, unsigned long modifier)
 			 walk.dst.virt.addr, walk.src.virt.addr, n);
 		ret = skcipher_walk_done(&walk, nbytes - n);
 	}
+	memzero_explicit(&pcc_param, sizeof(pcc_param));
+	memzero_explicit(&xts_param, sizeof(xts_param));
 	return ret;
 }
 
-- 
2.20.1
