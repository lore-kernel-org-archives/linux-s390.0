Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 10 Jun 2015 16:31:44 +0530
From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: [PATCH] s390/zcrypt: Convert use of __constant_cpu_to_le16 to
 cpu_to_le16
Message-ID: <20150610110144.GA3249@vaishali-Ideapad-Z570>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ingo Tuchscherer <ingo.tuchscherer@de.ibm.com>
Cc: linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

In big endian cases, the macro cpu_to_le16 unfolds to __swab16
which provides special case for constants. In little endian cases,
__constant_cpu_to_le16 and cpu_to_le16 expand directly to the
same expression. So, replace __constant_cpu_to_le16 with
cpu_to_le16 with the goal of getting rid of the definition of
__constant_cpu_to_le16 completely.

The semantic patch that performs this transformation is as follows:

@@expression x;@@

- __constant_cpu_to_le16(x)
+ cpu_to_le16(x)

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 drivers/s390/crypto/zcrypt_pcicc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_pcicc.c b/drivers/s390/crypto/zcrypt_pcicc.c
index 4d14c04..9f18876 100644
--- a/drivers/s390/crypto/zcrypt_pcicc.c
+++ b/drivers/s390/crypto/zcrypt_pcicc.c
@@ -98,11 +98,11 @@ static struct ap_driver zcrypt_pcicc_driver = {
  * - VUD block
  */
 static struct CPRB static_cprb = {
-	.cprb_len	= __constant_cpu_to_le16(0x0070),
+	.cprb_len	= cpu_to_le16(0x0070),
 	.cprb_ver_id	=  0x41,
 	.func_id	= {0x54,0x32},
 	.checkpoint_flag=  0x01,
-	.svr_namel	= __constant_cpu_to_le16(0x0008),
+	.svr_namel	= cpu_to_le16(0x0008),
 	.svr_name	= {'I','C','S','F',' ',' ',' ',' '}
 };
 
@@ -164,7 +164,7 @@ static int ICAMEX_msg_to_type6MEX_msg(struct zcrypt_device *zdev,
 	};
 	static struct function_and_rules_block static_pke_function_and_rules ={
 		.function_code	= {'P','K'},
-		.ulen		= __constant_cpu_to_le16(10),
+		.ulen		= cpu_to_le16(10),
 		.only_rule	= {'P','K','C','S','-','1','.','2'}
 	};
 	struct {
@@ -251,7 +251,7 @@ static int ICACRT_msg_to_type6CRT_msg(struct zcrypt_device *zdev,
 	};
 	static struct function_and_rules_block static_pkd_function_and_rules ={
 		.function_code	= {'P','D'},
-		.ulen		= __constant_cpu_to_le16(10),
+		.ulen		= cpu_to_le16(10),
 		.only_rule	= {'P','K','C','S','-','1','.','2'}
 	};
 	struct {
-- 
1.9.1
