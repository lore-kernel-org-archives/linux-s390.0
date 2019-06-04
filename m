Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from conuserg-08.nifty.com ([210.131.2.75]:57331 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfFDI37 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Jun 2019 04:29:59 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] s390: fix unrecognized __aligned() in uapi header
Date: Tue,  4 Jun 2019 17:29:47 +0900
Message-Id: <20190604082947.26328-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org

__aligned() is a shorthand that is only available in the kernel space
because it is defined in include/linux/compiler_attributes.h, which is
not exported to the user space.

Detected by compile-testing exported headers.

./usr/include/asm/runtime_instr.h:60:37: error: expected declaration specifiers or ‘...’ before numeric constant
 } __attribute__((packed)) __aligned(8);
                                     ^

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/include/uapi/asm/runtime_instr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/uapi/asm/runtime_instr.h b/arch/s390/include/uapi/asm/runtime_instr.h
index 45c9ec984e6b..455da46e3193 100644
--- a/arch/s390/include/uapi/asm/runtime_instr.h
+++ b/arch/s390/include/uapi/asm/runtime_instr.h
@@ -57,7 +57,7 @@ struct runtime_instr_cb {
 	__u64 sf;
 	__u64 rsic;
 	__u64 reserved8;
-} __packed __aligned(8);
+} __attribute__((__packed__, __aligned__(8)));
 
 static inline void load_runtime_instr_cb(struct runtime_instr_cb *cb)
 {
-- 
2.17.1
