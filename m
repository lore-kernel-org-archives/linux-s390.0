Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066C3C64EC4
	for <linux-s390@archiver.kernel.org>; Fri, 10 Mar 2023 13:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjCJNea (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 10 Mar 2023 08:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCJNe0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Mar 2023 08:34:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0FC108C15
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 05:34:18 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AC4x08020849
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jQFJT3Hi2VCScJpLNNrv0n8TLTp30K5yd5Wg/pRM73g=;
 b=IIQprRTzy1yGy1vk9GXQwhFOjnsCyd75o+KRh2Xc40w2R9DjK0rbhAnY/aTOds3pcl1N
 y92XATp10wFe5cNPXER+cEvbHBG78v564QExMmTMJ+oIfctyoSY0xYuVnaeddHzXUN4l
 TBQQNOKYDKG/NfbntLVQefQPX2exCVjA5QFwkULgIwfZhan0SDvcJVrCjVOQZZiJ/wJp
 vuDIET19QSZy3nmZNu32AjtUeo6ctvIw+JDQ0+GllkpOTcosBBIwq9rpB1hr+Orv8gUK
 SAzdbIRbWDL5ooKNObBFZBwFAlCcREj7+8TB5OAUPHlLAQYaGU4sGIjFUGLYxcV/pgZx Pg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p7va7p9sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:34:17 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32A8LY9V019977
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:34:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3p6ftvkwwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:34:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ADYCVB27722348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 13:34:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 294DA20040;
        Fri, 10 Mar 2023 13:34:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDDE820043;
        Fri, 10 Mar 2023 13:34:11 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Mar 2023 13:34:11 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, mhartmay@linux.ibm.com
Subject: [PATCH v3 1/1] s390: ipl: fix physical-virtual confusion for diag308
Date:   Fri, 10 Mar 2023 14:34:11 +0100
Message-Id: <20230310133411.139275-2-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230310133411.139275-1-nrb@linux.ibm.com>
References: <20230310133411.139275-1-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ewI6kFndpa5z7hiYuYhmOnXT9WyqVCii
X-Proofpoint-GUID: ewI6kFndpa5z7hiYuYhmOnXT9WyqVCii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=952
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100109
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Diag 308 subcodes expect a physical address as their parameter.

This currently is not a bug, but in the future physical and virtual
addresses might differ.

Fix the confusion by doing a virtual-to-physical conversion in the
exported diag308() and leave the assembly wrapper __diag308() alone.

Note that several callers pass NULL as addr, so check for the case when
NULL is passed and pass 0 to hardware since virt_to_phys(0) might be
nonzero.

Suggested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
---
 arch/s390/kernel/ipl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 5f0f5c86963a..afac9970ce42 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -176,11 +176,11 @@ static bool reipl_fcp_clear;
 static bool reipl_ccw_clear;
 static bool reipl_eckd_clear;
 
-static inline int __diag308(unsigned long subcode, void *addr)
+static inline int __diag308(unsigned long subcode, unsigned long addr)
 {
 	union register_pair r1;
 
-	r1.even = (unsigned long) addr;
+	r1.even = addr;
 	r1.odd	= 0;
 	asm volatile(
 		"	diag	%[r1],%[subcode],0x308\n"
@@ -195,7 +195,7 @@ static inline int __diag308(unsigned long subcode, void *addr)
 int diag308(unsigned long subcode, void *addr)
 {
 	diag_stat_inc(DIAG_STAT_X308);
-	return __diag308(subcode, addr);
+	return __diag308(subcode, addr ? virt_to_phys(addr) : 0);
 }
 EXPORT_SYMBOL_GPL(diag308);
 
-- 
2.39.1

