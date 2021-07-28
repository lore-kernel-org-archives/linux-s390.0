Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A16C4338F
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 21:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5740860527
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 21:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhG1V03 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jul 2021 17:26:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62746 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231350AbhG1V03 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jul 2021 17:26:29 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SKgYV5063231;
        Wed, 28 Jul 2021 17:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=pLS2lErT2fxR1TK7pQpFYdPd5+XswloO6NK1p3OTW8Q=;
 b=SBjOxqKjzoMEYRPul7KP6RtvKDVCn+vusEFvW8QfnrnxFXTHZ6cSHxB8o8bORxXbqDT8
 8sCBRvOCwU9QHWSEMcsZ0Ou1oAd1fcYRwRSBBOaJsLKN0oCoL8bOSYPBsCJwyjjIOV35
 tg8qJ/qoXKjbDPCzCGcZ1S4ozcBwyN5lVzB68UsLqnfaouTfBKL6rqqCFFndEyDHu+Wl
 Kz2EkDEPFE2ZAuqPGC81SO+ru8m3tpkj8BrkdZXuoOYSwMnNVdZjKKp1LOF4ajk1S3ug
 9gukEbVr2sR0jWdLBpPyDkXE49vfIUOU4V4B0ujEno/USUeOlPHSrNlhWyX89iSG2qWY DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3egv97dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 17:26:00 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16SL6koB182723;
        Wed, 28 Jul 2021 17:26:00 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3egv97de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 17:25:59 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16SJlli9018273;
        Wed, 28 Jul 2021 21:25:58 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3a235yhae8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 21:25:58 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16SLPskF33292662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 21:25:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93D32AE045;
        Wed, 28 Jul 2021 21:25:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BE10AE051;
        Wed, 28 Jul 2021 21:25:54 +0000 (GMT)
Received: from vm.lan (unknown [9.145.77.113])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jul 2021 21:25:54 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/2] s390/ftrace: implement hotpatching
Date:   Wed, 28 Jul 2021 23:25:44 +0200
Message-Id: <20210728212546.128248-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FBz1S0ZvsguIaGDOHcrie7qMaI5yFGge
X-Proofpoint-ORIG-GUID: ZyivTSG0XhVJmD_oZdYPkfdjGJ_uWsLN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_10:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=614 phishscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280113
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello,

This series implements the stop_machine()-less ftrace code patching
for s390. It's trickier than that of e.g. Intel, because the only
on-the-fly code patching allowed by s390 is changing a mask of a
conditional branch instruction. Patch 1 contains a new common code hook
that we need for that, patch 2 contains the actual implementation as
well as explanation of all the small details.

We would like to take this series through the s390 tree, and we need a
review on the patch 1 for that. Could you please take a look?

Best regards,
Ilya

Ilya Leoshkevich (2):
  ftrace: Introduce ftrace_need_init_nop()
  s390/ftrace: implement hotpatching

 arch/s390/include/asm/ftrace.h     |  46 +------
 arch/s390/include/asm/ftrace.lds.h |  21 +++
 arch/s390/include/asm/module.h     |   8 ++
 arch/s390/kernel/ftrace.c          | 207 ++++++++++++++++++++++++++---
 arch/s390/kernel/ftrace.h          |  24 ++++
 arch/s390/kernel/module.c          |  45 +++++++
 arch/s390/kernel/vmlinux.lds.S     |   2 +
 include/linux/ftrace.h             |  16 +++
 kernel/trace/ftrace.c              |   4 +-
 9 files changed, 314 insertions(+), 59 deletions(-)
 create mode 100644 arch/s390/include/asm/ftrace.lds.h
 create mode 100644 arch/s390/kernel/ftrace.h

-- 
2.31.1

