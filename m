Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] s390/zcrypt: make CPRBX const
Date: Fri, 25 Aug 2017 18:40:29 +0530
Message-Id: <1503666629-10646-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: julia.lawall@lip6.fr, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

Make this const as it is only used in a copy operation.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 4fddb43..afd20ce 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -140,7 +140,7 @@ struct function_and_rules_block {
  *   + 0x000A 'MRP     ' (MCL3 'PK' or CEX2C 'PK')
  * - VUD block
  */
-static struct CPRBX static_cprbx = {
+static const struct CPRBX static_cprbx = {
 	.cprb_len	=  0x00DC,
 	.cprb_ver_id	=  0x02,
 	.func_id	= {0x54, 0x32},
-- 
1.9.1
