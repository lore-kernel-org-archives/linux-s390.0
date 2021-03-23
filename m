Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C284FC433E0
	for <linux-s390@archiver.kernel.org>; Tue, 23 Mar 2021 21:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C836619D7
	for <linux-s390@archiver.kernel.org>; Tue, 23 Mar 2021 21:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhCWV6v (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 23 Mar 2021 17:58:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233721AbhCWV6m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 23 Mar 2021 17:58:42 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NLWqfw067533;
        Tue, 23 Mar 2021 17:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=K1qTK2OAnhSAf8kk7ogA9wk4wQAgNUyp5AtQIoHEIv4=;
 b=n2jyPYNcJO89ZZ8bqtchs4h3UNf+eUEVTaJIyGMK24XsiHJvvVVDeZw8/LEGiuwQgvWk
 xfQi1f+CtUUisrDzBEoWeGCKjG02jEFOeuwYgXazYmX7hnbl/OaY0AuzNiMxcLAXUuHW
 lLBxwzWdIeQ6+mmwXlEdiOrB59d/tFegYCuUqZ4J/rgJ/lLJOrPIlRwp3K4MgpTBnrDl
 a//TvK2mGYpoMoWMi0YDXddq6TSVZU6SOw56BDCQR2jO+gKof8N67fx+fib725AWA206
 MM+KMjta7hT7xVJ9N4624vN70q3trHNVBBpDLHay7DFSqujIjxQQpT67gIbeg0+1Hl3j dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37fmaq7q7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 17:58:26 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12NLY3QV070532;
        Tue, 23 Mar 2021 17:58:26 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37fmaq7q72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 17:58:26 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12NLwNUY024561;
        Tue, 23 Mar 2021 21:58:23 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 37d9d8sxq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 21:58:23 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12NLwKo635651872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 21:58:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 364C34C044;
        Tue, 23 Mar 2021 21:58:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D267B4C04A;
        Tue, 23 Mar 2021 21:58:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Mar 2021 21:58:19 +0000 (GMT)
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
Subject: [PATCH 1/3] s390/vdso: fix tod clock steering
Date:   Tue, 23 Mar 2021 22:58:17 +0100
Message-Id: <20210323215819.4161164-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323215819.4161164-1-hca@linux.ibm.com>
References: <YFmUrVOyX4q+8Dy9@osiris>
 <20210323215819.4161164-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_11:2021-03-23,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230159
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The s390 specific vdso function __arch_get_hw_counter() is supposed to
consider tod clock steering.

If a tod clock steering event happens and the tod clock is set to a
new value __arch_get_hw_counter() will not return the real tod clock
value but slowly drift it from the old delta until the returned value
finally matches the real tod clock value again.

When converting the assembler code to C it was forgotten to tell user
space in which direction the clock has to be adjusted.

Worst case is now that instead of drifting the clock slowly it will
jump into the opposite direction by a factor of two.

Fix this by simply providing the missing value to user space.

Fixes: 4bff8cb54502 ("s390: convert to GENERIC_VDSO")
Cc: <stable@vger.kernel.org> # 5.10
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 165da961f901..e37285a5101b 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -382,6 +382,7 @@ static void clock_sync_global(unsigned long delta)
 		      tod_steering_delta);
 	tod_steering_end = now + (abs(tod_steering_delta) << 15);
 	vdso_data->arch_data.tod_steering_end = tod_steering_end;
+	vdso_data->arch_data.tod_steering_delta = tod_steering_delta;
 
 	/* Update LPAR offset. */
 	if (ptff_query(PTFF_QTO) && ptff(&qto, sizeof(qto), PTFF_QTO) == 0)
-- 
2.25.1

