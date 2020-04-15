Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.6 008/129] s390/crypto: explicitly memzero stack key material in aes_s390.c
Date: Wed, 15 Apr 2020 07:32:43 -0400
Message-Id: <20200415113445.11881-8-sashal@kernel.org>
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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
index 1c23d84a9097d..73044634d3427 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -342,6 +342,7 @@ static int cbc_aes_crypt(struct skcipher_request *req, unsigned long modifier)
 		memcpy(walk.iv, param.iv, AES_BLOCK_SIZE);
 		ret = skcipher_walk_done(&walk, nbytes - n);
 	}
+	memzero_explicit(&param, sizeof(param));
 	return ret;
 }
 
@@ -470,6 +471,8 @@ static int xts_aes_crypt(struct skcipher_request *req, unsigned long modifier)
 			 walk.dst.virt.addr, walk.src.virt.addr, n);
 		ret = skcipher_walk_done(&walk, nbytes - n);
 	}
+	memzero_explicit(&pcc_param, sizeof(pcc_param));
+	memzero_explicit(&xts_param, sizeof(xts_param));
 	return ret;
 }
 
-- 
2.20.1
