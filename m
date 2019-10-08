Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:47870 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbfJHLdt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Oct 2019 07:33:49 -0400
Date: Tue, 08 Oct 2019 11:33:29 -0000
From: "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: x86/urgent] lib/string: Make memzero_explicit() inline instead
 of external
In-Reply-To: <20191007220000.GA408752@rani.riverdale.lan>
References: <20191007220000.GA408752@rani.riverdale.lan>
MIME-Version: 1.0
Message-ID: <157053440989.9978.4332514722028447332.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Arvind Sankar <nivedita@alum.mit.edu>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Herbert Xu <herbert@gondor.apana.org.au>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Stephan Mueller <smueller@chronox.de>, Thomas Gleixner <tglx@linutronix.de>, linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     bec500777089b3c96c53681fc0aa6fee59711d4a
Gitweb:        https://git.kernel.org/tip/bec500777089b3c96c53681fc0aa6fee59711d4a
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Mon, 07 Oct 2019 18:00:02 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Oct 2019 13:27:05 +02:00

lib/string: Make memzero_explicit() inline instead of external

With the use of the barrier implied by barrier_data(), there is no need
for memzero_explicit() to be extern. Making it inline saves the overhead
of a function call, and allows the code to be reused in arch/*/purgatory
without having to duplicate the implementation.

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephan Mueller <smueller@chronox.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-crypto@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Fixes: 906a4bb97f5d ("crypto: sha256 - Use get/put_unaligned_be32 to get input, memzero_explicit")
Link: https://lkml.kernel.org/r/20191007220000.GA408752@rani.riverdale.lan
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/string.h | 21 ++++++++++++++++++++-
 lib/string.c           | 21 ---------------------
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index b2f9df7..b6ccdc2 100644
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
index cd7a10c..08ec58c 100644
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
