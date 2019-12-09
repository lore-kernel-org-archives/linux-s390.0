Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726646AbfLIP36 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Dec 2019 10:29:58 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9FSGAJ088901
        for <linux-s390@vger.kernel.org>; Mon, 9 Dec 2019 10:29:58 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wrt1ya2t6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Dec 2019 10:29:58 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <zaslonko@linux.ibm.com>;
        Mon, 9 Dec 2019 15:29:55 -0000
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: [PATCH v2 5/6] lib/zlib: Add zlib_deflate_dfltcc_enabled() function
Date: Mon,  9 Dec 2019 16:29:47 +0100
In-Reply-To: <20191209152948.37080-1-zaslonko@linux.ibm.com>
References: <20191209152948.37080-1-zaslonko@linux.ibm.com>
Message-Id: <20191209152948.37080-6-zaslonko@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eduard Shishkin <edward6@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, zaslonko@linux.ibm.com

Add a new function to zlib.h checking if s390 Deflate-Conversion facility
is installed and enabled.

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 include/linux/zlib.h            | 6 ++++++
 lib/zlib_deflate/deflate.c      | 6 ++++++
 lib/zlib_deflate/deflate_syms.c | 1 +
 lib/zlib_dfltcc/dfltcc.h        | 3 +++
 4 files changed, 16 insertions(+)

diff --git a/include/linux/zlib.h b/include/linux/zlib.h
index 92dbbd3f6c75..c757d848a758 100644
--- a/include/linux/zlib.h
+++ b/include/linux/zlib.h
@@ -191,6 +191,12 @@ extern int zlib_deflate_workspacesize (int windowBits, int memLevel);
    exceed those passed here.
 */
 
+extern int zlib_deflate_dfltcc_enabled (void);
+/*
+   Returns 1 if Deflate-Conversion facility is installed and enabled,
+   otherwise 0.
+*/
+
 /* 
 extern int deflateInit (z_streamp strm, int level);
 
diff --git a/lib/zlib_deflate/deflate.c b/lib/zlib_deflate/deflate.c
index 9595b32b944a..52177d8527f9 100644
--- a/lib/zlib_deflate/deflate.c
+++ b/lib/zlib_deflate/deflate.c
@@ -59,6 +59,7 @@
 #define DEFLATE_RESET_HOOK(strm) do {} while (0)
 #define DEFLATE_HOOK(strm, flush, bstate) 0
 #define DEFLATE_NEED_CHECKSUM(strm) 1
+#define DEFLATE_DFLTCC_ENABLED() 0
 #endif
 
 /* ===========================================================================
@@ -1138,3 +1139,8 @@ int zlib_deflate_workspacesize(int windowBits, int memLevel)
         + zlib_deflate_head_memsize(memLevel)
         + zlib_deflate_overlay_memsize(memLevel);
 }
+
+int zlib_deflate_dfltcc_enabled(void)
+{
+	return DEFLATE_DFLTCC_ENABLED();
+}
diff --git a/lib/zlib_deflate/deflate_syms.c b/lib/zlib_deflate/deflate_syms.c
index 72fe4b73be53..24b740b99678 100644
--- a/lib/zlib_deflate/deflate_syms.c
+++ b/lib/zlib_deflate/deflate_syms.c
@@ -12,6 +12,7 @@
 #include <linux/zlib.h>
 
 EXPORT_SYMBOL(zlib_deflate_workspacesize);
+EXPORT_SYMBOL(zlib_deflate_dfltcc_enabled);
 EXPORT_SYMBOL(zlib_deflate);
 EXPORT_SYMBOL(zlib_deflateInit2);
 EXPORT_SYMBOL(zlib_deflateEnd);
diff --git a/lib/zlib_dfltcc/dfltcc.h b/lib/zlib_dfltcc/dfltcc.h
index be70c807b62f..1bd9709416fb 100644
--- a/lib/zlib_dfltcc/dfltcc.h
+++ b/lib/zlib_dfltcc/dfltcc.h
@@ -3,6 +3,7 @@
 #define DFLTCC_H
 
 #include "../zlib_deflate/defutil.h"
+#include "dfltcc_util.h"
 
 /*
  * Tuning parameters.
@@ -121,6 +122,8 @@ dfltcc_inflate_action dfltcc_inflate(z_streamp strm,
 
 #define DEFLATE_NEED_CHECKSUM(strm) (!dfltcc_can_deflate((strm)))
 
+#define DEFLATE_DFLTCC_ENABLED() is_dfltcc_enabled()
+
 #define INFLATE_RESET_HOOK(strm) \
     dfltcc_reset((strm), sizeof(struct inflate_state))
 
-- 
2.17.1
