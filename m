Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43756 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbfJGWAG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Oct 2019 18:00:06 -0400
Date: Mon, 7 Oct 2019 18:00:02 -0400
From: Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH] lib/string: make memzero_explicit inline instead of external
Message-ID: <20191007220000.GA408752@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d17349e-98ab-b582-6981-b484b0e970b6@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Herbert Xu <herbert@gondor.apana.org.au>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Stephan Mueller <smueller@chronox.de>

With the use of the barrier implied by barrier_data(), there is no need
for memzero_explicit to be extern. Making it inline saves the overhead
of a function call, and allows the code to be reused in arch/*/purgatory
without having to duplicate the implementation.

Fixes: 906a4bb97f5d ("crypto: sha256 - Use get/put_unaligned_be32 to get input, memzero_explicit")
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 include/linux/string.h | 21 ++++++++++++++++++++-
 lib/string.c           | 21 ---------------------
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index b2f9df7f0761..b6ccdc2c7f02 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -227,7 +227,26 @@ static inline bool strstarts(const char *str, const char *prefix)
 }
 
 size_t memweight(const void *ptr, size_t bytes);
-void memzero_explicit(void *s, size_t count);
+
+/**
+ * memzero_explicit - Fill a region of memory (e.g. sensitive
+ *		      keying data) with 0s.
+ * @s: Pointer to the start of the area.
+ * @count: The size of the area.
+ *
+ * Note: usually using memset() is just fine (!), but in cases
+ * where clearing out _local_ data at the end of a scope is
+ * necessary, memzero_explicit() should be used instead in
+ * order to prevent the compiler from optimising away zeroing.
+ *
+ * memzero_explicit() doesn't need an arch-specific version as
+ * it just invokes the one of memset() implicitly.
+ */
+static inline void memzero_explicit(void *s, size_t count)
+{
+	memset(s, 0, count);
+	barrier_data(s);
+}
 
 /**
  * kbasename - return the last part of a pathname.
diff --git a/lib/string.c b/lib/string.c
index cd7a10c19210..08ec58cc673b 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -748,27 +748,6 @@ void *memset(void *s, int c, size_t count)
 EXPORT_SYMBOL(memset);
 #endif
 
-/**
- * memzero_explicit - Fill a region of memory (e.g. sensitive
- *		      keying data) with 0s.
- * @s: Pointer to the start of the area.
- * @count: The size of the area.
- *
- * Note: usually using memset() is just fine (!), but in cases
- * where clearing out _local_ data at the end of a scope is
- * necessary, memzero_explicit() should be used instead in
- * order to prevent the compiler from optimising away zeroing.
- *
- * memzero_explicit() doesn't need an arch-specific version as
- * it just invokes the one of memset() implicitly.
- */
-void memzero_explicit(void *s, size_t count)
-{
-	memset(s, 0, count);
-	barrier_data(s);
-}
-EXPORT_SYMBOL(memzero_explicit);
-
 #ifndef __HAVE_ARCH_MEMSET16
 /**
  * memset16() - Fill a memory area with a uint16_t
-- 
2.21.0
