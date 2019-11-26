Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726101AbfKZOll (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 Nov 2019 09:41:41 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAQEXoFw026352
        for <linux-s390@vger.kernel.org>; Tue, 26 Nov 2019 09:41:40 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wh49u501g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 26 Nov 2019 09:41:39 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <zaslonko@linux.ibm.com>;
        Tue, 26 Nov 2019 14:41:36 -0000
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: [PATCH 4/5] s390/boot: Add dfltcc= kernel command line parameter
Date: Tue, 26 Nov 2019 15:41:29 +0100
In-Reply-To: <20191126144130.75710-1-zaslonko@linux.ibm.com>
References: <20191126144130.75710-1-zaslonko@linux.ibm.com>
Message-Id: <20191126144130.75710-5-zaslonko@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Richard Purdie <rpurdie@rpsys.net>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Add the new kernel command line parameter 'dfltcc=' to configure
s390 zlib hardware support.
Format: { on | off | def_only | inf_only | always }
 on:       s390 zlib hardware support for compression on
           level 1 and decompression (default)
 off:      No s390 zlib hardware support
 def_only: s390 zlib hardware support for deflate
           only (compression on level 1)
 inf_only: s390 zlib hardware support for inflate
           only (decompression)
 always:   Same as 'on' but ignores the selected compression
           level always using hardware support (used for debugging)

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
 arch/s390/boot/ipl_parm.c                       | 14 ++++++++++++++
 arch/s390/include/asm/setup.h                   |  7 +++++++
 arch/s390/kernel/setup.c                        |  1 +
 lib/zlib_dfltcc/dfltcc.c                        |  5 ++++-
 lib/zlib_dfltcc/dfltcc.h                        |  1 +
 lib/zlib_dfltcc/dfltcc_deflate.c                |  6 ++++++
 lib/zlib_dfltcc/dfltcc_inflate.c                |  6 ++++++
 lib/zlib_dfltcc/dfltcc_util.h                   |  5 +++++
 9 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8dee8f68fe15..953376347a3a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -836,6 +836,18 @@
 			dump out devices still on the deferred probe list after
 			retrying.
 
+	dfltcc=		[HW,S390]
+			Format: { on | off | def_only | inf_only | always }
+			on:       s390 zlib hardware support for compression on
+			          level 1 and decompression (default)
+			off:      No s390 zlib hardware support
+			def_only: s390 zlib hardware support for deflate
+			          only (compression on level 1)
+			inf_only: s390 zlib hardware support for inflate
+			          only (decompression)
+			always:   Same as 'on' but ignores the selected compression
+			          level always using hardware support (used for debugging)
+
 	dhash_entries=	[KNL]
 			Set number of hash buckets for dentry cache.
 
diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 24ef67eb1cef..357adad991d2 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -14,6 +14,7 @@
 char __bootdata(early_command_line)[COMMAND_LINE_SIZE];
 struct ipl_parameter_block __bootdata_preserved(ipl_block);
 int __bootdata_preserved(ipl_block_valid);
+unsigned int __bootdata_preserved(zlib_dfltcc_support) = ZLIB_DFLTCC_FULL;
 
 unsigned long __bootdata(vmalloc_size) = VMALLOC_DEFAULT_SIZE;
 unsigned long __bootdata(memory_end);
@@ -229,6 +230,19 @@ void parse_boot_command_line(void)
 		if (!strcmp(param, "vmalloc") && val)
 			vmalloc_size = round_up(memparse(val, NULL), PAGE_SIZE);
 
+		if (!strcmp(param, "dfltcc")) {
+			if (!strcmp(val, "off"))
+				zlib_dfltcc_support = ZLIB_DFLTCC_DISABLED;
+			else if (!strcmp(val, "on"))
+				zlib_dfltcc_support = ZLIB_DFLTCC_FULL;
+			else if (!strcmp(val, "def_only"))
+				zlib_dfltcc_support = ZLIB_DFLTCC_DEFLATE_ONLY;
+			else if (!strcmp(val, "inf_only"))
+				zlib_dfltcc_support = ZLIB_DFLTCC_INFLATE_ONLY;
+			else if (!strcmp(val, "always"))
+				zlib_dfltcc_support = ZLIB_DFLTCC_FULL_DEBUG;
+		}
+
 		if (!strcmp(param, "noexec")) {
 			rc = kstrtobool(val, &enabled);
 			if (!rc && !enabled)
diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index 6dc6c4fbc8e2..bd2cca097421 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -80,6 +80,13 @@ struct parmarea {
 	char command_line[ARCH_COMMAND_LINE_SIZE];	/* 0x10480 */
 };
 
+extern unsigned int zlib_dfltcc_support;
+#define ZLIB_DFLTCC_DISABLED		0
+#define ZLIB_DFLTCC_FULL		1
+#define ZLIB_DFLTCC_DEFLATE_ONLY	2
+#define ZLIB_DFLTCC_INFLATE_ONLY	3
+#define ZLIB_DFLTCC_FULL_DEBUG		4
+
 extern int noexec_disabled;
 extern int memory_end_set;
 extern unsigned long memory_end;
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 3ff291bc63b7..e1a0cf580f6f 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -111,6 +111,7 @@ unsigned long __bootdata_preserved(__etext_dma);
 unsigned long __bootdata_preserved(__sdma);
 unsigned long __bootdata_preserved(__edma);
 unsigned long __bootdata_preserved(__kaslr_offset);
+unsigned int __bootdata_preserved(zlib_dfltcc_support);
 
 unsigned long VMALLOC_START;
 EXPORT_SYMBOL(VMALLOC_START);
diff --git a/lib/zlib_dfltcc/dfltcc.c b/lib/zlib_dfltcc/dfltcc.c
index 7f77e5bb01c6..c30de430b30c 100644
--- a/lib/zlib_dfltcc/dfltcc.c
+++ b/lib/zlib_dfltcc/dfltcc.c
@@ -44,7 +44,10 @@ void dfltcc_reset(
     dfltcc_state->param.nt = 1;
 
     /* Initialize tuning parameters */
-    dfltcc_state->level_mask = DFLTCC_LEVEL_MASK;
+    if (zlib_dfltcc_support == ZLIB_DFLTCC_FULL_DEBUG)
+        dfltcc_state->level_mask = DFLTCC_LEVEL_MASK_DEBUG;
+    else
+        dfltcc_state->level_mask = DFLTCC_LEVEL_MASK;
     dfltcc_state->block_size = DFLTCC_BLOCK_SIZE;
     dfltcc_state->block_threshold = DFLTCC_FIRST_FHT_BLOCK_SIZE;
     dfltcc_state->dht_threshold = DFLTCC_DHT_MIN_SAMPLE_SIZE;
diff --git a/lib/zlib_dfltcc/dfltcc.h b/lib/zlib_dfltcc/dfltcc.h
index 4782c92bb2ff..be70c807b62f 100644
--- a/lib/zlib_dfltcc/dfltcc.h
+++ b/lib/zlib_dfltcc/dfltcc.h
@@ -8,6 +8,7 @@
  * Tuning parameters.
  */
 #define DFLTCC_LEVEL_MASK 0x2 /* DFLTCC compression for level 1 only */
+#define DFLTCC_LEVEL_MASK_DEBUG 0x3fe /* DFLTCC compression for all levels */
 #define DFLTCC_BLOCK_SIZE 1048576
 #define DFLTCC_FIRST_FHT_BLOCK_SIZE 4096
 #define DFLTCC_DHT_MIN_SAMPLE_SIZE 4096
diff --git a/lib/zlib_dfltcc/dfltcc_deflate.c b/lib/zlib_dfltcc/dfltcc_deflate.c
index b9d16917c30a..aa4539f5c071 100644
--- a/lib/zlib_dfltcc/dfltcc_deflate.c
+++ b/lib/zlib_dfltcc/dfltcc_deflate.c
@@ -3,6 +3,7 @@
 #include "../zlib_deflate/defutil.h"
 #include "dfltcc_util.h"
 #include "dfltcc.h"
+#include <asm/setup.h>
 #include <linux/zutil.h>
 
 /*
@@ -15,6 +16,11 @@ int dfltcc_can_deflate(
     deflate_state *state = (deflate_state *)strm->state;
     struct dfltcc_state *dfltcc_state = GET_DFLTCC_STATE(state);
 
+    /* Check for kernel dfltcc command line parameter */
+    if (zlib_dfltcc_support == ZLIB_DFLTCC_DISABLED ||
+            zlib_dfltcc_support == ZLIB_DFLTCC_INFLATE_ONLY)
+        return 0;
+
     /* Unsupported compression settings */
     if (!dfltcc_are_params_ok(state->level, state->w_bits, state->strategy,
                               dfltcc_state->level_mask))
diff --git a/lib/zlib_dfltcc/dfltcc_inflate.c b/lib/zlib_dfltcc/dfltcc_inflate.c
index 12a93a06bd61..aa9ef23474df 100644
--- a/lib/zlib_dfltcc/dfltcc_inflate.c
+++ b/lib/zlib_dfltcc/dfltcc_inflate.c
@@ -3,6 +3,7 @@
 #include "../zlib_inflate/inflate.h"
 #include "dfltcc_util.h"
 #include "dfltcc.h"
+#include <asm/setup.h>
 #include <linux/zutil.h>
 
 /*
@@ -15,6 +16,11 @@ int dfltcc_can_inflate(
     struct inflate_state *state = (struct inflate_state *)strm->state;
     struct dfltcc_state *dfltcc_state = GET_DFLTCC_STATE(state);
 
+    /* Check for kernel dfltcc command line parameter */
+    if (zlib_dfltcc_support == ZLIB_DFLTCC_DISABLED ||
+            zlib_dfltcc_support == ZLIB_DFLTCC_DEFLATE_ONLY)
+        return 0;
+
     /* Unsupported compression settings */
     if (state->wbits != HB_BITS)
         return 0;
diff --git a/lib/zlib_dfltcc/dfltcc_util.h b/lib/zlib_dfltcc/dfltcc_util.h
index 1930b43c1915..43419d7d181b 100644
--- a/lib/zlib_dfltcc/dfltcc_util.h
+++ b/lib/zlib_dfltcc/dfltcc_util.h
@@ -3,6 +3,7 @@
 #define DFLTCC_UTIL_H
 
 #include <linux/zutil.h>
+#include <asm/setup.h>
 
 /*
  * C wrapper for the DEFLATE CONVERSION CALL instruction.
@@ -104,6 +105,10 @@ static inline int is_dfltcc_enabled(void)
     uint64_t facilities[(DFLTCC_FACILITY / 64) + 1];
     register char r0 __asm__("r0");
 
+    /* Check for kernel dfltcc command line parameter */
+    if (zlib_dfltcc_support == ZLIB_DFLTCC_DISABLED)
+        return 0;
+
     memset(facilities, 0, sizeof(facilities));
     r0 = sizeof(facilities) / sizeof(facilities[0]) - 1;
     __asm__ volatile("stfle %[facilities]\n"
-- 
2.17.1
