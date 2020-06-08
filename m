Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726660AbgFHKYW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jun 2020 06:24:22 -0400
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH RESEND2] lib: fix bitmap_parse() on 64-bit big endian archs
Date: Mon,  8 Jun 2020 12:23:49 +0200
Message-Id: <1591611829-23071-1-git-send-email-agordeev@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Amritha Nambiar <amritha.nambiar@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Chris Wilson <chris@chris-wilson.co.uk>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steffen Klassert <steffen.klassert@secunet.com>, "Tobin C . Harding" <tobin@kernel.org>, Vineet Gupta <vineet.gupta1@synopsys.com>, Will Deacon <will.deacon@arm.com>, Willem de Bruijn <willemb@google.com>

Commit 2d6261583be0 ("lib: rework bitmap_parse()") does not
take into account order of halfwords on 64-bit big endian
architectures. As result (at least) Receive Packet Steering,
IRQ affinity masks and runtime kernel test "test_bitmap" get
broken on s390.

Fixes: 2d6261583be0 ("lib: rework bitmap_parse()")
Cc: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: "Tobin C . Harding" <tobin@kernel.org>
Cc: Vineet Gupta <vineet.gupta1@synopsys.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 lib/bitmap.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 89260aa342d6..a725e4612984 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -717,6 +717,19 @@ static const char *bitmap_get_x32_reverse(const char *start,
 	return end;
 }
 
+#if defined(__BIG_ENDIAN) && defined(CONFIG_64BIT)
+static void save_x32_chunk(unsigned long *maskp, u32 chunk, int chunk_idx)
+{
+	maskp += (chunk_idx / 2);
+	((u32 *)maskp)[(chunk_idx & 1) ^ 1] = chunk;
+}
+#else
+static void save_x32_chunk(unsigned long *maskp, u32 chunk, int chunk_idx)
+{
+	((u32 *)maskp)[chunk_idx] = chunk;
+}
+#endif
+
 /**
  * bitmap_parse - convert an ASCII hex string into a bitmap.
  * @start: pointer to buffer containing string.
@@ -738,7 +751,8 @@ int bitmap_parse(const char *start, unsigned int buflen,
 {
 	const char *end = strnchrnul(start, buflen, '\n') - 1;
 	int chunks = BITS_TO_U32(nmaskbits);
-	u32 *bitmap = (u32 *)maskp;
+	int chunk_idx = 0;
+	u32 chunk;
 	int unset_bit;
 
 	while (1) {
@@ -749,9 +763,11 @@ int bitmap_parse(const char *start, unsigned int buflen,
 		if (!chunks--)
 			return -EOVERFLOW;
 
-		end = bitmap_get_x32_reverse(start, end, bitmap++);
+		end = bitmap_get_x32_reverse(start, end, &chunk);
 		if (IS_ERR(end))
 			return PTR_ERR(end);
+
+		save_x32_chunk(maskp, chunk, chunk_idx++);
 	}
 
 	unset_bit = (BITS_TO_U32(nmaskbits) - chunks) * 32;
-- 
2.23.0
