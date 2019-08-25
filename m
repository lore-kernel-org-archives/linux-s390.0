Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728727AbfHYSSq (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 25 Aug 2019 14:18:46 -0400
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] crypto: sha256 - Add missing MODULE_LICENSE() to lib/crypto/sha256.c
Date: Sun, 25 Aug 2019 20:18:41 +0200
Message-Id: <20190825181841.2494-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Eric Biggers <ebiggers@kernel.org>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-crypto@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org

lib/crypto/sha256.c / lib/crypto/libsha256.o may end up being a module,
so it needs a MODULE_LICENSE() line, add this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 lib/crypto/sha256.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index 45ad87520769..42d75e490a97 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -13,6 +13,7 @@
 
 #include <linux/bitops.h>
 #include <linux/export.h>
+#include <linux/module.h>
 #include <linux/string.h>
 #include <crypto/sha256.h>
 #include <asm/unaligned.h>
@@ -314,3 +315,5 @@ int sha224_final(struct sha256_state *sctx, u8 *out)
 	return __sha256_final(sctx, out, 7);
 }
 EXPORT_SYMBOL(sha224_final);
+
+MODULE_LICENSE("GPL");
-- 
2.23.0
