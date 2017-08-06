Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] s390/crypto: make cca_public_sec and cca_token_hdr const
Date: Sun,  6 Aug 2017 11:22:27 +0530
Message-Id: <1501998747-4094-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: julia.lawall@lip6.fr, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

Declare cca_public_sec and cca_token_hdr structures as const as they are
only used during copy operations.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/s390/crypto/zcrypt_cca_key.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_cca_key.h b/drivers/s390/crypto/zcrypt_cca_key.h
index 12cff62..7b78ba6 100644
--- a/drivers/s390/crypto/zcrypt_cca_key.h
+++ b/drivers/s390/crypto/zcrypt_cca_key.h
@@ -116,10 +116,10 @@ struct cca_pvt_ext_CRT_sec {
  */
 static inline int zcrypt_type6_mex_key_en(struct ica_rsa_modexpo *mex, void *p)
 {
-	static struct cca_token_hdr static_pub_hdr = {
+	static const struct cca_token_hdr static_pub_hdr = {
 		.token_identifier	=  0x1E,
 	};
-	static struct cca_public_sec static_pub_sec = {
+	static const struct cca_public_sec static_pub_sec = {
 		.section_identifier	=  0x04,
 	};
 	struct {
@@ -176,7 +176,7 @@ static inline int zcrypt_type6_mex_key_en(struct ica_rsa_modexpo *mex, void *p)
  */
 static inline int zcrypt_type6_crt_key(struct ica_rsa_modexpo_crt *crt, void *p)
 {
-	static struct cca_public_sec static_cca_pub_sec = {
+	static const struct cca_public_sec static_cca_pub_sec = {
 		.section_identifier = 4,
 		.section_length = 0x000f,
 		.exponent_len = 0x0003,
-- 
1.9.1
