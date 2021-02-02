Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:60779 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230168AbhBBF6i (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Feb 2021 00:58:38 -0500
From: Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] s390/cpum_cf: remove unneeded semicolon
Date: Tue,  2 Feb 2021 13:57:51 +0800
Message-Id: <1612245471-122049-1-git-send-email-yang.lee@linux.alibaba.com>
List-ID: <linux-s390.vger.kernel.org>
To: hca@linux.ibm.com
Cc: gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>

Eliminate the following coccicheck warning:
./arch/s390/kernel/perf_cpum_cf.c:272:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/s390/kernel/perf_cpum_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 0eb1d1c..b3beef6 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -269,7 +269,7 @@ static int __hw_perf_event_init(struct perf_event *event, unsigned int type)
 	case CPUMF_CTR_SET_MAX:
 		/* The counter could not be associated to a counter set */
 		return -EINVAL;
-	};
+	}
 
 	/* Initialize for using the CPU-measurement counter facility */
 	if (!atomic_inc_not_zero(&num_events)) {
-- 
1.8.3.1
