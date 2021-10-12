Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F303C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 13:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0908161040
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 13:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhJLNk5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:40:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236703AbhJLNk5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Oct 2021 09:40:57 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CCaW42025876;
        Tue, 12 Oct 2021 09:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=gnkCxIDCiWjTuLFqxfRl3/npZnPmidafOmwjrr21Ah0=;
 b=X7bF0DErPvs6lAxWSzdBLBUX8hBVlhPLIJGFtDs7KomT8ghyAwUrb5Qh62vmNdIt2R73
 S0IaFSA/1r+InMGBItx7ct2YhajkZE0T1AsvADrWNSswDob134QVCBPnqPkf0WcYQJu3
 rm52pKxYyrP/i215g19RXIdkqDCEhTgtW29DiqMeCL3LDmVW2ME0je19z9fzkKc8iEq5
 n5kTLekFKYP1F8zLciHt3X6JqEMY1qURwL9BWJUrlDOTNbJVXtJppp//F66vEZg1MT5k
 KG1PKJiqVzmB1fJZRW9r/k9N5m3c6T8vBn5R81rJquuX4k4tBZlQtfQJrskRWQjUHhq9 vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn7h0dvuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 09:38:20 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19CDLhsb027604;
        Tue, 12 Oct 2021 09:38:19 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn7h0dvta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 09:38:19 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19CDRPaU023163;
        Tue, 12 Oct 2021 13:38:17 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3bk2q9yg5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 13:38:16 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19CDc8q140305022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 13:38:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B247D11C04C;
        Tue, 12 Oct 2021 13:38:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E129D11C06C;
        Tue, 12 Oct 2021 13:38:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Oct 2021 13:38:04 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] s390: DYNAMIC_FTRACE_WITH_DIRECT_CALL support
Date:   Tue, 12 Oct 2021 15:37:58 +0200
Message-Id: <20211012133802.2460757-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t_66HDLyWxvxcW2Dx00eGk_YHhJ5LGzZ
X-Proofpoint-GUID: EuL1J6fhiSv4klmjwQg5NZWCX5XJfrkz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_03,2021-10-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=907 bulkscore=0 clxscore=1011 spamscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110120079
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This small series adds DYNAMIC_FTRACE_WITH_DIRECT_CALL support for
s390 and is based on linux-next 20211012.

Besides the architecture backend this also adds s390 ftrace direct
call samples, and slightly changes config option handling a bit, so
that options only have to be selected. This way also additional future
architectures can easily add their trampolines to the samples.

If ok, I'd like to get this upstream via the s390 tree with the next
merge window.

Heiko Carstens (4):
  s390/ftrace: add HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALL support
  s390: make STACK_FRAME_OVERHEAD available via asm-offsets.h
  samples: add HAVE_SAMPLE_FTRACE_DIRECT config option
  samples: add s390 support for ftrace direct call samples

 arch/s390/Kconfig                     |  2 ++
 arch/s390/include/asm/ftrace.h        | 12 ++++++++
 arch/s390/kernel/asm-offsets.c        |  1 +
 arch/s390/kernel/mcount.S             | 23 ++++++++++----
 arch/x86/Kconfig                      |  1 +
 samples/Kconfig                       |  5 ++-
 samples/ftrace/ftrace-direct-modify.c | 44 +++++++++++++++++++++++++++
 samples/ftrace/ftrace-direct-too.c    | 28 +++++++++++++++++
 samples/ftrace/ftrace-direct.c        | 28 +++++++++++++++++
 9 files changed, 137 insertions(+), 7 deletions(-)

-- 
2.25.1

