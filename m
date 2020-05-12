Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH] lib: fix bitmap_parse() on 64-bit big endian archs
Date: Tue, 12 May 2020 17:21:30 +0200
Message-Id: <1589296890-13064-1-git-send-email-agordeev@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, Yury Norov <yury.norov@gmail.com>

Commit 2d626158 ("lib: rework bitmap_parse()") does
not take into account order of halfwords on 64-bit
big endian architectures.

Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 lib/bitmap.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 89260aa..a725e46 100644
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
1.8.3.1
