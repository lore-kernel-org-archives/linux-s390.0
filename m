Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8890DC433C1
	for <linux-s390@archiver.kernel.org>; Tue, 23 Mar 2021 21:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465F2619B4
	for <linux-s390@archiver.kernel.org>; Tue, 23 Mar 2021 21:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhCWV6t (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 23 Mar 2021 17:58:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233740AbhCWV6m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 23 Mar 2021 17:58:42 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NLXHVD073751;
        Tue, 23 Mar 2021 17:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EtbSF82nywAJvvjSOmKo9Y+Z6a20g9T57CWHIK7oBa4=;
 b=KanM9pBnWOq1d5/A6LtJoSEVTQ1B5aPKhBX5ozS63auMl4+N11bfuF2WVyV45+2Fbj9K
 boH3GMGLUrfYave98OB/yJq+NduV7/DMFqcFg1WqFpBA4w/IFdNGoWVb1pAotzoYR77w
 rmBHYHS6AoZi3HmnYh4fMiI8ZE2O5qqLbpugAaSAKm1uwECIi464ziFHdBwFfRn3mYhg
 df5Q2+MQgdAYMzUq0eVJUcvbByTp5aYrF541bo6PGZCFmP4gxJsYkFucQUA1fmTPZFqH
 sTrbU6Kqp+k0xgUnDpNDy/rGaSn7DZn1lDOlsTpJSocxHe2DLznM5YHzctG8Fj/sGZu7 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37fkx8r9gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 17:58:26 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12NLZx7D083405;
        Tue, 23 Mar 2021 17:58:26 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37fkx8r9fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 17:58:26 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12NLuqrn025345;
        Tue, 23 Mar 2021 21:58:24 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 37d99rbr0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 21:58:23 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12NLw3ST32768334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 21:58:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AE3D4C044;
        Tue, 23 Mar 2021 21:58:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4AB24C04A;
        Tue, 23 Mar 2021 21:58:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Mar 2021 21:58:20 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Li Wang <liwang@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     ltp@lists.linux.it, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 3/3] lib/vdso: remove struct arch_vdso_data from vdso data struct
Date:   Tue, 23 Mar 2021 22:58:19 +0100
Message-Id: <20210323215819.4161164-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323215819.4161164-1-hca@linux.ibm.com>
References: <YFmUrVOyX4q+8Dy9@osiris>
 <20210323215819.4161164-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_11:2021-03-23,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230159
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Since commit d60d7de3e16d ("lib/vdso: Allow to add architecture-specific
vdso data") it is possible to provide arch specific VDSO data.

This was only added for s390, which doesn't make use this anymore.
Therefore remove it again.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/Kconfig            |  3 ---
 include/vdso/datapage.h | 10 ----------
 2 files changed, 13 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index ecfd3520b676..35c7114f7ea3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1147,9 +1147,6 @@ config HAVE_SPARSE_SYSCALL_NR
 	  entries at 4000, 5000 and 6000 locations. This option turns on syscall
 	  related optimizations for a given architecture.
 
-config ARCH_HAS_VDSO_DATA
-	bool
-
 config HAVE_STATIC_CALL
 	bool
 
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 73eb622e7663..ee810cae4e1e 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,12 +19,6 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
-#ifdef CONFIG_ARCH_HAS_VDSO_DATA
-#include <asm/vdso/data.h>
-#else
-struct arch_vdso_data {};
-#endif
-
 #define VDSO_BASES	(CLOCK_TAI + 1)
 #define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
 			 BIT(CLOCK_MONOTONIC)		| \
@@ -70,8 +64,6 @@ struct vdso_timestamp {
  * @tz_dsttime:		type of DST correction
  * @hrtimer_res:	hrtimer resolution
  * @__unused:		unused
- * @arch_data:		architecture specific data (optional, defaults
- *			to an empty struct)
  *
  * vdso_data will be accessed by 64 bit and compat code at the same time
  * so we should be careful before modifying this structure.
@@ -105,8 +97,6 @@ struct vdso_data {
 	s32			tz_dsttime;
 	u32			hrtimer_res;
 	u32			__unused;
-
-	struct arch_vdso_data	arch_data;
 };
 
 /*
-- 
2.25.1

