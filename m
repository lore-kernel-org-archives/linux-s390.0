Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BC0C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 13:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1CD16101D
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 13:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbhJLNlE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:41:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236996AbhJLNlB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Oct 2021 09:41:01 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CDa53N006633;
        Tue, 12 Oct 2021 09:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VtTsVsYu3D0rSCj5f4JxLRdxWQKUnrAh/tP9egdafg0=;
 b=Nl+OgdRFfv6E6GPARlKPiIwg4msBezQNkhfJGJ/p2NXSmHl5vWpB+wOhGUiWpMpbtOSG
 bGMNUKYsc+X5DzW0tHJM0yFWae9906zTEshg92xsXAkpeGcs6rx2fl9UMECj9yMxUHrk
 1zpzcbKwgnhkav6JhV88xqIcXTNpGHF7Ak7e2r/veHfw782cERNbAgDMEvbVbTE6lmHl
 yMmfzZaBt+D3cput8YPodxUUXimVhVmw3DrSbfN06OS6hhCTmt9D12yqAWLQ+PsjMi3K
 cQxZqjhxTegVEsyBamS0GsZ0qfTu/d3153TROECqj+jHCPvf49oDDAXIUZsyRli3Qmpw Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn999bbnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 09:38:41 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19CCTvRH008941;
        Tue, 12 Oct 2021 09:38:41 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn999bbmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 09:38:41 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19CDRNYk011072;
        Tue, 12 Oct 2021 13:38:38 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3bk2qa1501-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 13:38:37 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19CDcPCu25952758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 13:38:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B73BA11C07F;
        Tue, 12 Oct 2021 13:38:25 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B68311C04C;
        Tue, 12 Oct 2021 13:38:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Oct 2021 13:38:20 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 3/4] samples: add HAVE_SAMPLE_FTRACE_DIRECT config option
Date:   Tue, 12 Oct 2021 15:38:01 +0200
Message-Id: <20211012133802.2460757-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012133802.2460757-1-hca@linux.ibm.com>
References: <20211012133802.2460757-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3t04jHJ0xzmV_GsmM3K_iU1sektmc8E2
X-Proofpoint-ORIG-GUID: gsr3iRgw1hEvkbWOjYzT4eW_dcKMsK04
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_03,2021-10-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=986 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120079
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add HAVE_SAMPLE_FTRACE_DIRECT config option which can be selected by
architectures which have support for ftrace direct call samples.

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/x86/Kconfig | 1 +
 samples/Kconfig  | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a52e81cb256e..917391003c7a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -189,6 +189,7 @@ config X86
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_EISA
diff --git a/samples/Kconfig b/samples/Kconfig
index 8cbd6490823f..0823b97d8546 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -26,7 +26,7 @@ config SAMPLE_TRACE_PRINTK
 config SAMPLE_FTRACE_DIRECT
 	tristate "Build register_ftrace_direct() example"
 	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS && m
-	depends on X86_64 # has x86_64 inlined asm
+	depends on HAVE_SAMPLE_FTRACE_DIRECT
 	help
 	  This builds an ftrace direct function example
 	  that hooks to wake_up_process and prints the parameters.
@@ -226,3 +226,6 @@ config SAMPLE_WATCH_QUEUE
 source "samples/rust/Kconfig"
 
 endif # SAMPLES
+
+config HAVE_SAMPLE_FTRACE_DIRECT
+	bool
-- 
2.25.1

