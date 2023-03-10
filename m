Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EFBC6FA99
	for <linux-s390@archiver.kernel.org>; Fri, 10 Mar 2023 12:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCJMWQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 10 Mar 2023 07:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjCJMWP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Mar 2023 07:22:15 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD9F112593
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 04:22:11 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AAwDxC010079
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 12:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=YJYNe91iSiRdLscqLV4oaRgI1p5jQlCzUyRpk4sZQGA=;
 b=Ed7nuSlxci1rGrUk7p88EcJ7aR4YfdhLUwwSKl/AQyrAVHeeklVhFtNpWfNvjucGQKWU
 TG+GrAcYalBWMWSUTC7LR/JBLngJJ5J8QAi5jkrqtHrt/o/a7g3JjQCTAZMoLqoLXgzk
 vz4q9mc81Tpo0Zocc1QRzAyfA8GF19zGsWhHxfWUIi9646xVIyYsWS44AIt7myFZz8Fs
 ImybV6RfoEr/+2VsuBUBmbhg8LZ2VscaMQrZKoh+KVz1n+ckmxCb6vewtI64KLT0uTc6
 jLM12agUsXDsVk38gF3Yi9MARfvdYxNX2Ht9oNtbMmQO7PqUvnFJ3+3YVC0wEluI1eIO 2g== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p7wxehkvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 12:22:10 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32A8NlQ0032275
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 12:22:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3p6g03autb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 12:22:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ACM5DI33030786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 12:22:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E38192004B;
        Fri, 10 Mar 2023 12:22:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90D1F20040;
        Fri, 10 Mar 2023 12:22:04 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Mar 2023 12:22:04 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, mhartmay@linux.ibm.com
Subject: [PATCH v1] s390: ipl: fix physical-virtual confusion for diag308
Date:   Fri, 10 Mar 2023 13:22:04 +0100
Message-Id: <20230310122204.1898-1-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xOmIkVGQPhVa_fcpERbn_IYXx3JRnFLy
X-Proofpoint-ORIG-GUID: xOmIkVGQPhVa_fcpERbn_IYXx3JRnFLy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 phishscore=0 mlxscore=0 mlxlogscore=901
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100096
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Diag 308 subcodes expect a physical address as their parameter.

This currently is not a bug, but in the future physical and virtual
addresses might differ.

Fix the confusion by doing a virtual-to-physical conversion in the
exported diag308() and leave the assembly wrapper __diag308() alone.

Note that several callers pass NULL as addr, this is fine since
virt_to_phys(0) == 0.

Suggested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
---
 arch/s390/kernel/ipl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 5f0f5c86963a..5611ba8f68b9 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -176,7 +176,7 @@ static bool reipl_fcp_clear;
 static bool reipl_ccw_clear;
 static bool reipl_eckd_clear;
 
-static inline int __diag308(unsigned long subcode, void *addr)
+static inline int __diag308(unsigned long subcode, u64 addr)
 {
 	union register_pair r1;
 
@@ -195,7 +195,7 @@ static inline int __diag308(unsigned long subcode, void *addr)
 int diag308(unsigned long subcode, void *addr)
 {
 	diag_stat_inc(DIAG_STAT_X308);
-	return __diag308(subcode, addr);
+	return __diag308(subcode, virt_to_phys(addr));
 }
 EXPORT_SYMBOL_GPL(diag308);
 
-- 
2.39.1

