Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFADC433F5
	for <linux-s390@archiver.kernel.org>; Fri,  1 Oct 2021 13:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F1C61A83
	for <linux-s390@archiver.kernel.org>; Fri,  1 Oct 2021 13:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352814AbhJANFJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 1 Oct 2021 09:05:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:51101 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353738AbhJANFI (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 1 Oct 2021 09:05:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="225083923"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="225083923"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 06:02:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="521031519"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 01 Oct 2021 06:02:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DB7DF177; Fri,  1 Oct 2021 16:02:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v1 1/1] s390: Use string_upper() instead of open coded variant
Date:   Fri,  1 Oct 2021 16:02:01 +0300
Message-Id: <20211001130201.72545-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use string_upper() from string helper module instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/s390/mm/cmm.c    | 11 ++++-------
 arch/s390/mm/extmem.c | 21 ++++++++++++---------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 1141c8d5c0d0..2203164b39da 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -14,8 +14,8 @@
 #include <linux/moduleparam.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
+#include <linux/string_helpers.h>
 #include <linux/sysctl.h>
-#include <linux/ctype.h>
 #include <linux/swap.h>
 #include <linux/kthread.h>
 #include <linux/oom.h>
@@ -394,13 +394,10 @@ static int __init cmm_init(void)
 		goto out_sysctl;
 #ifdef CONFIG_CMM_IUCV
 	/* convert sender to uppercase characters */
-	if (sender) {
-		int len = strlen(sender);
-		while (len--)
-			sender[len] = toupper(sender[len]);
-	} else {
+	if (sender)
+		string_upper(sender, sender);
+	else
 		sender = cmm_default_sender;
-	}
 
 	rc = smsg_register_callback(SMSG_PREFIX, cmm_smsg_target);
 	if (rc < 0)
diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index 5060956b8e7d..2c8c5dc52472 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -12,12 +12,12 @@
 
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/memblock.h>
-#include <linux/ctype.h>
 #include <linux/ioport.h>
 #include <linux/refcount.h>
 #include <linux/pgtable.h>
@@ -89,15 +89,18 @@ static int segext_scode = DCSS_SEGEXTX;
 static void
 dcss_mkname(char *name, char *dcss_name)
 {
+	/* Segment name is limited by 8 characters + NUL */
+	char tmp[8 + 1];
 	int i;
 
-	for (i = 0; i < 8; i++) {
-		if (name[i] == '\0')
-			break;
-		dcss_name[i] = toupper(name[i]);
-	}
-	for (; i < 8; i++)
-		dcss_name[i] = ' ';
+	/*
+	 * This snprintf() call does two things:
+	 * - makes a NUL-terminated copy of the input string
+	 * - pads it with spaces
+	 */
+	snprintf(tmp, sizeof(tmp), "%s        ", name);
+	string_upper(dcss_name, tmp);
+
 	ASCEBC(dcss_name, 8);
 }
 
@@ -109,7 +112,7 @@ dcss_mkname(char *name, char *dcss_name)
 static struct dcss_segment *
 segment_by_name (char *name)
 {
-	char dcss_name[9];
+	char dcss_name[8];
 	struct list_head *l;
 	struct dcss_segment *tmp, *retval = NULL;
 
-- 
2.33.0

