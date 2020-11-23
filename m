Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730567AbgKWTRU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 23 Nov 2020 14:17:20 -0500
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] zlib: export S390 symbols for zlib modules
Date: Mon, 23 Nov 2020 11:17:12 -0800
Message-Id: <20201123191712.4882-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>, Mikhail Zaslonko <zaslonko@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

Fix build errors when ZLIB_INFLATE=m and ZLIB_DEFLATE=m
and ZLIB_DFLTCC=y by exporting the 2 needed symbols in
dfltcc_inflate.c.

Fixes these build errors:

ERROR: modpost: "dfltcc_inflate" [lib/zlib_inflate/zlib_inflate.ko] undefined!
ERROR: modpost: "dfltcc_can_inflate" [lib/zlib_inflate/zlib_inflate.ko] undefined!

Fixes: 126196100063 ("lib/zlib: add s390 hardware support for kernel zlib_inflate")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 lib/zlib_dfltcc/dfltcc_inflate.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-next-20201120.orig/lib/zlib_dfltcc/dfltcc_inflate.c
+++ linux-next-20201120/lib/zlib_dfltcc/dfltcc_inflate.c
@@ -4,6 +4,7 @@
 #include "dfltcc_util.h"
 #include "dfltcc.h"
 #include <asm/setup.h>
+#include <linux/export.h>
 #include <linux/zutil.h>
 
 /*
@@ -29,6 +30,7 @@ int dfltcc_can_inflate(
     return is_bit_set(dfltcc_state->af.fns, DFLTCC_XPND) &&
                is_bit_set(dfltcc_state->af.fmts, DFLTCC_FMT0);
 }
+EXPORT_SYMBOL(dfltcc_can_inflate);
 
 static int dfltcc_was_inflate_used(
     z_streamp strm
@@ -147,3 +149,4 @@ dfltcc_inflate_action dfltcc_inflate(
     return (cc == DFLTCC_CC_OP1_TOO_SHORT || cc == DFLTCC_CC_OP2_TOO_SHORT) ?
         DFLTCC_INFLATE_BREAK : DFLTCC_INFLATE_CONTINUE;
 }
+EXPORT_SYMBOL(dfltcc_inflate);
