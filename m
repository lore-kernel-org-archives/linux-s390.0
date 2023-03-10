Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2415EC6FA99
	for <linux-s390@archiver.kernel.org>; Fri, 10 Mar 2023 13:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCJNCq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 10 Mar 2023 08:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCJNCo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Mar 2023 08:02:44 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B85410E584
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 05:02:43 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AAsWau010016
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IHiFDO5oO8IWqBrpAnOOvZH2VwHqnJTwYOkZxxYfhgM=;
 b=supMXPqzZPLSbdY9eJOc02Q6X0CzGz0XX+XQxDBiTRXGDJt7zwPPtE1r9zpSCgERY1/k
 laXTurPYIFtGoKl06kTAOLFI185BZQIfSHp3oxY3AKCis1aOMluhmOTGDvAynPwgy9oy
 +1LNtDIpHy0ylrlyRBBCFwDHYmwkDYMqDNTuCn/7DcE8ABlYAXWKwwx9iTEVPWV19Jae
 3BkFaZCcu1VSHxTeA2uI4z/oS4G8g5gMF74A9m/bHrRZLBU4r8vIeMVWHaWixeIbimnL
 3QGgwxyALSvFEIQp+2DnZhI415PGzfN+rYBMfd+2UT6leNeB4UEg7IJ7tRuDARUldRX4 og== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p7wxejkd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:02:42 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32A80rbo023054
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:02:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3p6fysuv60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:02:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32AD2be8852558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 13:02:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CBBD2004D;
        Fri, 10 Mar 2023 13:02:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CA702004E;
        Fri, 10 Mar 2023 13:02:37 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Mar 2023 13:02:37 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, mhartmay@linux.ibm.com
Subject: [PATCH v2 1/1] s390: ipl: fix physical-virtual confusion for diag308
Date:   Fri, 10 Mar 2023 14:02:36 +0100
Message-Id: <20230310130236.106661-2-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230310130236.106661-1-nrb@linux.ibm.com>
References: <20230310130236.106661-1-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5egT9FYW7oWQAeDmDLhMHv5wf10F9jgk
X-Proofpoint-ORIG-GUID: 5egT9FYW7oWQAeDmDLhMHv5wf10F9jgk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 phishscore=0 mlxscore=0 mlxlogscore=933
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100100
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Diag 308 subcodes expect a physical address as their parameter.

This currently is not a bug, but in the future physical and virtual
addresses might differ.

Fix the confusion by doing a virtual-to-physical conversion in the
exported diag308() and leave the assembly wrapper __diag308() alone.

Note that several callers pass NULL as addr, this is _currently_ fine since
virt_to_phys(0) == 0. But in the future, lowcore addresses might no
longer be special, so make sure we pass 0 to hardware in case addr is
NULL.

Suggested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
---
 arch/s390/kernel/ipl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 5f0f5c86963a..d8b8a87626f7 100644
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
+	return __diag308(subcode, addr ? virt_to_phys(addr) : 0);
 }
 EXPORT_SYMBOL_GPL(diag308);
 
-- 
2.39.1

