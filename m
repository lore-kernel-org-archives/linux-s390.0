Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DE6C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 28 Oct 2021 17:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D6A96103C
	for <linux-s390@archiver.kernel.org>; Thu, 28 Oct 2021 17:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhJ1REZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 28 Oct 2021 13:04:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:39984 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhJ1REZ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Oct 2021 13:04:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="230410405"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="230410405"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 10:01:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="466197543"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 28 Oct 2021 10:01:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8A112107; Thu, 28 Oct 2021 20:01:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v1 1/1] delay.h: fix for removed kernel.h
Date:   Thu, 28 Oct 2021 20:01:43 +0300
Message-Id: <20211028170143.56523-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

To be folded to the commit 0d280a9fbbd9 ("include/linux/delay.h:
replace kernel.h with the necessary inclusions")

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/riscv/lib/delay.c           | 4 ++++
 arch/s390/include/asm/facility.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/riscv/lib/delay.c b/arch/riscv/lib/delay.c
index f51c9a03bca1..49d510ba75fd 100644
--- a/arch/riscv/lib/delay.c
+++ b/arch/riscv/lib/delay.c
@@ -4,10 +4,14 @@
  */
 
 #include <linux/delay.h>
+#include <linux/math.h>
 #include <linux/param.h>
 #include <linux/timex.h>
+#include <linux/types.h>
 #include <linux/export.h>
 
+#include <asm/processor.h>
+
 /*
  * This is copies from arch/arm/include/asm/delay.h
  *
diff --git a/arch/s390/include/asm/facility.h b/arch/s390/include/asm/facility.h
index e3aa354ab9f4..94b6919026df 100644
--- a/arch/s390/include/asm/facility.h
+++ b/arch/s390/include/asm/facility.h
@@ -9,8 +9,12 @@
 #define __ASM_FACILITY_H
 
 #include <asm/facility-defs.h>
+
+#include <linux/minmax.h>
 #include <linux/string.h>
+#include <linux/types.h>
 #include <linux/preempt.h>
+
 #include <asm/lowcore.h>
 
 #define MAX_FACILITY_BIT (sizeof(stfle_fac_list) * 8)
-- 
2.33.0

