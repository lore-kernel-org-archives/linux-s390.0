Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8CDC001DE
	for <linux-s390@archiver.kernel.org>; Mon, 31 Jul 2023 18:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjGaSje (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 31 Jul 2023 14:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjGaSjd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 31 Jul 2023 14:39:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C81119BB
        for <linux-s390@vger.kernel.org>; Mon, 31 Jul 2023 11:39:32 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VIbPcA021658
        for <linux-s390@vger.kernel.org>; Mon, 31 Jul 2023 18:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=l6QByBUv+9lMYRKF3tXH2OjdcpnoI+jD+vfzYWfbu2Y=;
 b=bgv57UhKwlu7rmn8sCZdp6Ncb2U8EtlUs8ayJ+oRlSOLwQvc3AoqBcYjhGmHP9cT8USk
 ugC2/Ji8gAC8Nlb1elTzOb0lJQlJ6s5ggT2/NjjLC0/7GyLvmP01Uy+/WoTq0WMj9GHA
 MIr4SaehoVWsuY3B+R6XtjuAE4DMmrYETTa0IQXgphF5QWGkR839EJpv6QaXf2GMQEvr
 eNTh6advwuBmA67Uc80J2rPHxsX4qEM+VFE5kKGp4r1n1+4nK+0L8oQs/qb+dMTTSnfW
 Pq38oA7oIxeHVRXQfQ941Y4X3Cd2b++GiUlUzdIk49jYV3XOfss8KX+ZxrFnRvztkN9K Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s6hk9sm4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 31 Jul 2023 18:39:32 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36VIcQxa028593
        for <linux-s390@vger.kernel.org>; Mon, 31 Jul 2023 18:39:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s6hk9sm26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 18:39:31 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36VHLrdP017005;
        Mon, 31 Jul 2023 18:39:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5dfxwqw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 18:39:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36VIdQoR44565064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 18:39:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80AF72004B;
        Mon, 31 Jul 2023 18:39:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4631320040;
        Mon, 31 Jul 2023 18:39:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 31 Jul 2023 18:39:26 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH] s390/ptrace: add missing linux/const.h include
Date:   Mon, 31 Jul 2023 20:39:26 +0200
Message-Id: <20230731183926.330932-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2icdR1RbyxxtNhlb4oSzOnjZ31Ee9m16
X-Proofpoint-GUID: 9ak6PnwW2xzTsp-7rpxV8WOOiAHEZesN
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_12,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310168
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Adrian Reber reported the following CRIU build bug after
commit b8af5999779d ("s390/ptrace: make all psw related
defines also available for asm"):

compel/arch/s390/src/lib/infect.c: In function 'arch_can_dump_task':
compel/arch/s390/src/lib/infect.c:523:25: error: 'UL' undeclared (first use in this function)
  523 |         if (psw->mask & PSW_MASK_RI) {
      |                         ^~~~~~~~~~~

Add the missing linux/const.h include to fix this.

Reported-by: Adrian Reber <areber@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2225745
Link: https://github.com/checkpoint-restore/criu/pull/2232
Fixes: b8af5999779d ("s390/ptrace: make all psw related defines also available for asm")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/uapi/asm/ptrace.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uapi/asm/ptrace.h
index f0fe3bcc78a8..bb0826024bb9 100644
--- a/arch/s390/include/uapi/asm/ptrace.h
+++ b/arch/s390/include/uapi/asm/ptrace.h
@@ -8,6 +8,8 @@
 #ifndef _UAPI_S390_PTRACE_H
 #define _UAPI_S390_PTRACE_H
 
+#include <linux/const.h>
+
 /*
  * Offsets in the user_regs_struct. They are used for the ptrace
  * system call and in entry.S
-- 
2.39.2

