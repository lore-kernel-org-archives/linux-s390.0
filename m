Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E799C4338F
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 14:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E115460F4A
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 14:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhG2O2X (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:28:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229750AbhG2O2W (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Jul 2021 10:28:22 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TERnP3017894;
        Thu, 29 Jul 2021 10:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=XRODP8YE+txQpLPc89b48UgaznBirPsnMkB+vT1cawU=;
 b=gwPosHOPwBJo0glzbO3E4JynZW1aud7NCjzHDKhNm8QgX5KzU6huJbW62uKaqvpDHg0C
 dAd68Ts6zAFlV4Dkph9vF/xmFb/9BtrdPhiCmVCNwx0eqJ+RvJi7viKZsSwHJHJea4bF
 7yAl3+qsWIfpiXrp+4TfNlkoGMzAeLFQ+v2Hz2utC2496Y10WI0O9qLNjIDyAo4wlUaf
 KV4Zb4KAG2DXYrBTVZgDBCf767NsXqRciS9ZZjBvA4L9PqxZWnhWaKFwTJ+jkqB12D03
 Hw57b737v5PZhOGoyMA2laB5jdZtc0Y+I+Ja5v/xT1D7eaLy32O4rryBKXwM9iK8uIvB Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3wnehrap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 10:28:18 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16TERoqJ017947;
        Thu, 29 Jul 2021 10:28:18 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3wnehr9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 10:28:18 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16TEE0gj028769;
        Thu, 29 Jul 2021 14:28:15 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3a235yhs7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 14:28:15 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16TEPRr020906300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 14:25:27 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ADD2A4070;
        Thu, 29 Jul 2021 14:28:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FE28A4066;
        Thu, 29 Jul 2021 14:28:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Jul 2021 14:28:12 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Marco Elver <elver@google.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] kcsan: use u64 instead of cycles_t
Date:   Thu, 29 Jul 2021 16:28:11 +0200
Message-Id: <20210729142811.1309391-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9Jgx2r-XZ9TgTC-47AcGHpMtFkUCF5P-
X-Proofpoint-GUID: AlFAIIaxLvX5D_dB6HE9gxXME3G4Fqba
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_10:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290089
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

cycles_t has a different type across architectures: unsigned int,
unsinged long, or unsigned long long. Depending on architecture this
will generate this warning:

kernel/kcsan/debugfs.c: In function ‘microbenchmark’:
./include/linux/kern_levels.h:5:25: warning: format ‘%llu’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘cycles_t’ {aka ‘long unsigned int’} [-Wformat=]

To avoid this simple change the type of cycle to u64 in
microbenchmark(), since u64 is of type unsigned long long for all
architectures.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 kernel/kcsan/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index e65de172ccf7..1d1d1b0e4248 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -64,7 +64,7 @@ static noinline void microbenchmark(unsigned long iters)
 {
 	const struct kcsan_ctx ctx_save = current->kcsan_ctx;
 	const bool was_enabled = READ_ONCE(kcsan_enabled);
-	cycles_t cycles;
+	u64 cycles;
 
 	/* We may have been called from an atomic region; reset context. */
 	memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
-- 
2.25.1

