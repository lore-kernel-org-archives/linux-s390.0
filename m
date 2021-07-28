Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE80C4338F
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 19:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E94D160BD3
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 19:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhG1TDH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:03:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhG1TDG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jul 2021 15:03:06 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SIxbng108838;
        Wed, 28 Jul 2021 15:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8LezzyXc1E62vmg8wXGBQL0Vz13l7KfGGIMqHe37pm0=;
 b=PJxqM8MuB6HnnU4rzcD9xFwfBAOKsjHfSOMixo51Dhosom+IVaJVSVB6ycVn/0cQx7m2
 kvFVoWc8R68yS40W7CRhEa82v9yQ4RC+jOaZUH6Ym0TAYctu+uRJCihegaFU9S56Cg1C
 pVQq1FKPgami6JP1FgDqjuuO34QyeglxFJzpy63EO99MMiPIvcP04749ftn5kcBhwK50
 3kBWvchK5il+cth+4xMa+7AX5QtHOcb5ovupOhBqnj44AIGQP36bxPHfhNlOnmMQrbOD
 TQkDNOUXV68PFoUGe8OKO9XQzHA027+XhJdRs4Uzql/4ZRMYCLTw0dT3gbS/irj8QeHH Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3b10jwvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 15:03:02 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16SJ0OWS113703;
        Wed, 28 Jul 2021 15:03:02 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3b10jwv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 15:03:02 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16SJ2xMj022888;
        Wed, 28 Jul 2021 19:02:59 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3a235m18fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 19:02:59 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16SJ0DNl33292744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 19:00:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7514AAE051;
        Wed, 28 Jul 2021 19:02:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14145AE045;
        Wed, 28 Jul 2021 19:02:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jul 2021 19:02:56 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/4] kfence: add function to mask address bits
Date:   Wed, 28 Jul 2021 21:02:52 +0200
Message-Id: <20210728190254.3921642-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728190254.3921642-1-hca@linux.ibm.com>
References: <20210728190254.3921642-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PzPFJxJ0ZhUBqUTiUpsv0108PjxM1qJg
X-Proofpoint-GUID: 03zJ3GMQF9vyTBQdUuHj3O3iMZe1d4zM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_09:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107280106
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Sven Schnelle <svens@linux.ibm.com>

s390 only reports the page address during a translation fault.
To make the kfence unit tests pass, add a function that might
be implemented by architectures to mask out address bits.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 mm/kfence/kfence_test.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 942cbc16ad26..eb6307c199ea 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -23,8 +23,15 @@
 #include <linux/tracepoint.h>
 #include <trace/events/printk.h>
 
+#include <asm/kfence.h>
+
 #include "kfence.h"
 
+/* May be overridden by <asm/kfence.h>. */
+#ifndef arch_kfence_test_address
+#define arch_kfence_test_address(addr) (addr)
+#endif
+
 /* Report as observed from console. */
 static struct {
 	spinlock_t lock;
@@ -82,6 +89,7 @@ static const char *get_access_type(const struct expect_report *r)
 /* Check observed report matches information in @r. */
 static bool report_matches(const struct expect_report *r)
 {
+	unsigned long addr = (unsigned long)r->addr;
 	bool ret = false;
 	unsigned long flags;
 	typeof(observed.lines) expect;
@@ -131,22 +139,25 @@ static bool report_matches(const struct expect_report *r)
 	switch (r->type) {
 	case KFENCE_ERROR_OOB:
 		cur += scnprintf(cur, end - cur, "Out-of-bounds %s at", get_access_type(r));
+		addr = arch_kfence_test_address(addr);
 		break;
 	case KFENCE_ERROR_UAF:
 		cur += scnprintf(cur, end - cur, "Use-after-free %s at", get_access_type(r));
+		addr = arch_kfence_test_address(addr);
 		break;
 	case KFENCE_ERROR_CORRUPTION:
 		cur += scnprintf(cur, end - cur, "Corrupted memory at");
 		break;
 	case KFENCE_ERROR_INVALID:
 		cur += scnprintf(cur, end - cur, "Invalid %s at", get_access_type(r));
+		addr = arch_kfence_test_address(addr);
 		break;
 	case KFENCE_ERROR_INVALID_FREE:
 		cur += scnprintf(cur, end - cur, "Invalid free of");
 		break;
 	}
 
-	cur += scnprintf(cur, end - cur, " 0x%p", (void *)r->addr);
+	cur += scnprintf(cur, end - cur, " 0x%p", (void *)addr);
 
 	spin_lock_irqsave(&observed.lock, flags);
 	if (!report_available())
-- 
2.25.1

