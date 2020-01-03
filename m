Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728794AbgACWdo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jan 2020 17:33:44 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 003MHS1m050426
        for <linux-s390@vger.kernel.org>; Fri, 3 Jan 2020 17:33:43 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xa2cdkfxy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 03 Jan 2020 17:33:42 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <zaslonko@linux.ibm.com>;
        Fri, 3 Jan 2020 22:33:40 -0000
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: [PATCH v3 2/6] s390/boot: Rename HEAP_SIZE due to name collision
Date: Fri,  3 Jan 2020 23:33:30 +0100
In-Reply-To: <20200103223334.20669-1-zaslonko@linux.ibm.com>
References: <20200103223334.20669-1-zaslonko@linux.ibm.com>
Message-Id: <20200103223334.20669-3-zaslonko@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eduard Shishkin <edward6@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Change the conflicting macro name in preparation for zlib_inflate
hardware support.

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 arch/s390/boot/compressed/decompressor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/boot/compressed/decompressor.c b/arch/s390/boot/compressed/decompressor.c
index 45046630c56a..368fd372c875 100644
--- a/arch/s390/boot/compressed/decompressor.c
+++ b/arch/s390/boot/compressed/decompressor.c
@@ -30,13 +30,13 @@ extern unsigned char _compressed_start[];
 extern unsigned char _compressed_end[];
 
 #ifdef CONFIG_HAVE_KERNEL_BZIP2
-#define HEAP_SIZE	0x400000
+#define BOOT_HEAP_SIZE	0x400000
 #else
-#define HEAP_SIZE	0x10000
+#define BOOT_HEAP_SIZE	0x10000
 #endif
 
 static unsigned long free_mem_ptr = (unsigned long) _end;
-static unsigned long free_mem_end_ptr = (unsigned long) _end + HEAP_SIZE;
+static unsigned long free_mem_end_ptr = (unsigned long) _end + BOOT_HEAP_SIZE;
 
 #ifdef CONFIG_KERNEL_GZIP
 #include "../../../../lib/decompress_inflate.c"
@@ -62,7 +62,7 @@ static unsigned long free_mem_end_ptr = (unsigned long) _end + HEAP_SIZE;
 #include "../../../../lib/decompress_unxz.c"
 #endif
 
-#define decompress_offset ALIGN((unsigned long)_end + HEAP_SIZE, PAGE_SIZE)
+#define decompress_offset ALIGN((unsigned long)_end + BOOT_HEAP_SIZE, PAGE_SIZE)
 
 unsigned long mem_safe_offset(void)
 {
-- 
2.17.1
