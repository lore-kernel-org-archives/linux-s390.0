Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C1CC4332F
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 13:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC6B61050
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 13:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbhJLNk6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:40:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236811AbhJLNk6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Oct 2021 09:40:58 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CC2Po2031417;
        Tue, 12 Oct 2021 09:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Az+o3afXkSr7sysajABcMuGtLHJWmYneXFSGZlUHleU=;
 b=JpVAGy9YEZUae07qABQs6oQv36xhpi1HNkVmuZI7/0BQFIhG8vXpy70cRnNRTvRcFwfe
 Q4Y4HfC1AmWYU1lA2Cu1fdOqrUeZ2uqVRyJGCqzwpKd21n9NtjYRMcO9cNScRqtgJk4j
 9olnWsZCDT+J9LeQ3BZaBWdB8JicijEUuCePu3vZWSReQYhP4/owVO9AVfoBf/gC6UPN
 7f/gAAXSTp8SbJXfF7o5F/ier6QQrTNW+B9oodsron5fwaTbJT+5/EZfcJ858DWEq97V
 7AVMWpHnV4Ss26ZUONBkUlx52oWwqvZk4Q8d3HAwxshl4wJnj63wdR5hYlqQewSNLZev zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn0x2wpan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 09:38:37 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19CDKhDD017078;
        Tue, 12 Oct 2021 09:38:36 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn0x2wp99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 09:38:36 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19CDRQSv011604;
        Tue, 12 Oct 2021 13:38:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3bk2bjfmu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 13:38:33 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19CDWiqC34865554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 13:32:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6765411C05E;
        Tue, 12 Oct 2021 13:38:20 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96B2E11C054;
        Tue, 12 Oct 2021 13:38:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Oct 2021 13:38:15 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 2/4] s390: make STACK_FRAME_OVERHEAD available via asm-offsets.h
Date:   Tue, 12 Oct 2021 15:38:00 +0200
Message-Id: <20211012133802.2460757-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012133802.2460757-1-hca@linux.ibm.com>
References: <20211012133802.2460757-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eqjYFJHfSGtqhee7rBYzgQNRvvVM81Oh
X-Proofpoint-GUID: BOktWF5n6iG3gWCDs3A5i8zvmDYNYkbX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_03,2021-10-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxlogscore=884 adultscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120079
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Make STACK_FRAME_OVERHEAD available via asm-offsets.h. This allows to
add s390 specific asm code to e.g. ftrace samples, without requiring
to add random header files, which might cause all sort of problems on
other architectures. asm-offsets.h can be assumed to be non-problematic.

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/asm-offsets.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index b57da9338588..b6ee3fd7fe0c 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -45,6 +45,7 @@ int main(void)
 	OFFSET(__SF_SIE_SAVEAREA, stack_frame, empty1[2]);
 	OFFSET(__SF_SIE_REASON, stack_frame, empty1[3]);
 	OFFSET(__SF_SIE_FLAGS, stack_frame, empty1[4]);
+	DEFINE(STACK_FRAME_OVERHEAD, sizeof(struct stack_frame));
 	BLANK();
 	/* idle data offsets */
 	OFFSET(__CLOCK_IDLE_ENTER, s390_idle_data, clock_idle_enter);
-- 
2.25.1

