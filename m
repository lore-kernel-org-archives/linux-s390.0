Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 5.4 regression fix] x86/boot: Provide memzero_explicit
Date: Mon,  7 Oct 2019 15:47:24 +0200
Message-Id: <20191007134724.4019-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>

The purgatory code now uses the shared lib/crypto/sha256.c sha256
implementation. This needs memzero_explicit, implement this.

Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
Fixes: 906a4bb97f5d ("crypto: sha256 - Use get/put_unaligned_be32 to get input, memzero_explicit")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Add barrier_data() call after the memset, making the function really
  explicit. Using barrier_data() works fine in the purgatory (build)
  environment.
---
 arch/x86/boot/compressed/string.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/boot/compressed/string.c b/arch/x86/boot/compressed/string.c
index 81fc1eaa3229..654a7164a702 100644
--- a/arch/x86/boot/compressed/string.c
+++ b/arch/x86/boot/compressed/string.c
@@ -50,6 +50,12 @@ void *memset(void *s, int c, size_t n)
 	return s;
 }
 
+void memzero_explicit(void *s, size_t count)
+{
+	memset(s, 0, count);
+	barrier_data(s);
+}
+
 void *memmove(void *dest, const void *src, size_t n)
 {
 	unsigned char *d = dest;
-- 
2.23.0
