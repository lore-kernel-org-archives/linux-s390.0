Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] s390: use __u{16,32,64} instead of uint{16,32,64}_t in uapi header
Date: Sun, 21 Jul 2019 23:20:08 +0900
Message-Id: <20190721142008.30093-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, Harald Freudenberger <freude@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org

When CONFIG_UAPI_HEADER_TEST=y, exported headers are compile-tested to
make sure they can be included from user-space.

Currently, zcrypt.h is excluded from the test coverage. To make it
join the compile-test, we need to fix the build errors attached below.

For a case like this, we decided to use __u{8,16,32,64} variable types
in this discussion:

  https://lkml.org/lkml/2019/6/5/18

Build log:

  CC      usr/include/asm/zcrypt.h.s
In file included from <command-line>:32:0:
./usr/include/asm/zcrypt.h:163:2: error: unknown type name ‘uint16_t’
  uint16_t cprb_len;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:168:2: error: unknown type name ‘uint32_t’
  uint32_t source_id;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:169:2: error: unknown type name ‘uint32_t’
  uint32_t target_id;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:170:2: error: unknown type name ‘uint32_t’
  uint32_t ret_code;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:171:2: error: unknown type name ‘uint32_t’
  uint32_t reserved1;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:172:2: error: unknown type name ‘uint32_t’
  uint32_t reserved2;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:173:2: error: unknown type name ‘uint32_t’
  uint32_t payload_len;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:182:2: error: unknown type name ‘uint16_t’
  uint16_t ap_id;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:183:2: error: unknown type name ‘uint16_t’
  uint16_t dom_id;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:198:2: error: unknown type name ‘uint16_t’
  uint16_t  targets_num;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:199:2: error: unknown type name ‘uint64_t’
  uint64_t  targets;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:200:2: error: unknown type name ‘uint64_t’
  uint64_t  weight;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:201:2: error: unknown type name ‘uint64_t’
  uint64_t  req_no;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:202:2: error: unknown type name ‘uint64_t’
  uint64_t  req_len;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:203:2: error: unknown type name ‘uint64_t’
  uint64_t  req;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:204:2: error: unknown type name ‘uint64_t’
  uint64_t  resp_len;
  ^~~~~~~~
./usr/include/asm/zcrypt.h:205:2: error: unknown type name ‘uint64_t’
  uint64_t  resp;
  ^~~~~~~~

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/include/uapi/asm/zcrypt.h | 35 +++++++++++++++--------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/s390/include/uapi/asm/zcrypt.h b/arch/s390/include/uapi/asm/zcrypt.h
index 494c34c50716..8c5755f41dde 100644
--- a/arch/s390/include/uapi/asm/zcrypt.h
+++ b/arch/s390/include/uapi/asm/zcrypt.h
@@ -20,6 +20,7 @@
 
 #include <linux/ioctl.h>
 #include <linux/compiler.h>
+#include <linux/types.h>
 
 /* Name of the zcrypt device driver. */
 #define ZCRYPT_NAME "zcrypt"
@@ -160,17 +161,17 @@ struct ica_xcRB {
  * @payload_len:	Payload length
  */
 struct ep11_cprb {
-	uint16_t	cprb_len;
+	__u16		cprb_len;
 	unsigned char	cprb_ver_id;
 	unsigned char	pad_000[2];
 	unsigned char	flags;
 	unsigned char	func_id[2];
-	uint32_t	source_id;
-	uint32_t	target_id;
-	uint32_t	ret_code;
-	uint32_t	reserved1;
-	uint32_t	reserved2;
-	uint32_t	payload_len;
+	__u32		source_id;
+	__u32		target_id;
+	__u32		ret_code;
+	__u32		reserved1;
+	__u32		reserved2;
+	__u32		payload_len;
 } __attribute__((packed));
 
 /**
@@ -179,8 +180,8 @@ struct ep11_cprb {
  * @dom_id:	Usage domain id
  */
 struct ep11_target_dev {
-	uint16_t ap_id;
-	uint16_t dom_id;
+	__u16 ap_id;
+	__u16 dom_id;
 };
 
 /**
@@ -195,14 +196,14 @@ struct ep11_target_dev {
  * @resp:		Addr to response block
  */
 struct ep11_urb {
-	uint16_t		targets_num;
-	uint64_t		targets;
-	uint64_t		weight;
-	uint64_t		req_no;
-	uint64_t		req_len;
-	uint64_t		req;
-	uint64_t		resp_len;
-	uint64_t		resp;
+	__u16		targets_num;
+	__u64		targets;
+	__u64		weight;
+	__u64		req_no;
+	__u64		req_len;
+	__u64		req;
+	__u64		resp_len;
+	__u64		resp;
 } __attribute__((packed));
 
 /**
-- 
2.17.1
