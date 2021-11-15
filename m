Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC22C433F5
	for <linux-s390@archiver.kernel.org>; Mon, 15 Nov 2021 21:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C5761B3A
	for <linux-s390@archiver.kernel.org>; Mon, 15 Nov 2021 21:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347872AbhKOVGf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 15 Nov 2021 16:06:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348798AbhKOUAG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Nov 2021 15:00:06 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFJjPSr020810;
        Mon, 15 Nov 2021 19:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=lF2FjzaL/eQDywHndLismvKoxO6/MuGZAWElSCWPbaM=;
 b=d9SQyKeS2AkAJm+XhTUlYudZFlD8PYHciUGFARuOdMxBxhmcImqBbL+yRxLBNvGerCHc
 OhN157tWZafp9w6znPkvZ1tDqjTgnt3pAJfyhx0mxtLY3SQRQMVc5/32LzexU+ouEhR4
 ImtB5yuVNLDFMplaTt14vXjabIz5pIEMkEy5Hc89s5SxioyDQmpXOcKq7MVgeavmrwit
 OUzLUMyZzBYlxlpkAqxYFQZg9pAKnBLvERPxXbKTG/qN2UBUzul+raKdOt4BWjzsZKsw
 MsazrKKJQwuZtOtxt6V9U4kQj826HNGSRO6P88ro0htnvPtn/x3lfQMyN3YXysKGgqsE bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cbuasbu5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 19:56:53 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AFJtRPG009884;
        Mon, 15 Nov 2021 19:56:53 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cbuasbu4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 19:56:53 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AFJrjOX008002;
        Mon, 15 Nov 2021 19:56:51 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3ca509s6n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 19:56:50 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AFJnsqO64422334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 19:49:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B93C24C04E;
        Mon, 15 Nov 2021 19:56:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 857364C046;
        Mon, 15 Nov 2021 19:56:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Nov 2021 19:56:48 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 1/2] ftrace/samples: add missing Kconfig option for ftrace direct multi sample
Date:   Mon, 15 Nov 2021 20:56:13 +0100
Message-Id: <20211115195614.3173346-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211115195614.3173346-1-hca@linux.ibm.com>
References: <20211115195614.3173346-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vha2cAvRuP4XV12jo1OiZN_vFNQ5Ap5s
X-Proofpoint-GUID: G3N4r_6bl9ZEAQZvwLHWUj-4WjeHoEsY
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_15,2021-11-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111150098
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Currently it is not possible to build the ftrace direct multi example
anymore due to broken config dependencies. Fix this by adding
SAMPLE_FTRACE_DIRECT_MULTI config option.

This broke when merging s390-5.16-1 due to an incorrect merge conflict
resolution proposed by me.

Also rename SAMPLE_FTRACE_MULTI_DIRECT to SAMPLE_FTRACE_DIRECT_MULTI
so it matches the module name.

Fixes: 0b707e572a19 ("Merge tag 's390-5.16-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/x86/Kconfig        |  2 +-
 samples/Kconfig         | 11 ++++++++++-
 samples/Makefile        |  2 +-
 samples/ftrace/Makefile |  2 +-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 95dd1ee01546..7399327d1eff 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -193,7 +193,7 @@ config X86
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
-	select HAVE_SAMPLE_FTRACE_MULTI_DIRECT	if X86_64
+	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_EISA
diff --git a/samples/Kconfig b/samples/Kconfig
index bec3528aa2de..43d2e9aa557f 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -31,6 +31,15 @@ config SAMPLE_FTRACE_DIRECT
 	  This builds an ftrace direct function example
 	  that hooks to wake_up_process and prints the parameters.
 
+config SAMPLE_FTRACE_DIRECT_MULTI
+	tristate "Build register_ftrace_direct_multi() example"
+	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS && m
+	depends on HAVE_SAMPLE_FTRACE_DIRECT_MULTI
+	help
+	  This builds an ftrace direct function example
+	  that hooks to wake_up_process and schedule, and prints
+	  the function addresses.
+
 config SAMPLE_TRACE_ARRAY
         tristate "Build sample module for kernel access to Ftrace instancess"
 	depends on EVENT_TRACING && m
@@ -237,5 +246,5 @@ endif # SAMPLES
 config HAVE_SAMPLE_FTRACE_DIRECT
 	bool
 
-config HAVE_SAMPLE_FTRACE_MULTI_DIRECT
+config HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	bool
diff --git a/samples/Makefile b/samples/Makefile
index b7b98307c2b4..4bcd6b93bffa 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -22,7 +22,7 @@ subdir-$(CONFIG_SAMPLE_TIMER)		+= timers
 obj-$(CONFIG_SAMPLE_TRACE_EVENTS)	+= trace_events/
 obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT)	+= ftrace/
-obj-$(CONFIG_SAMPLE_FTRACE_MULTI_DIRECT) += ftrace/
+obj-$(CONFIG_SAMPLE_FTRACE_DIRECT_MULTI) += ftrace/
 obj-$(CONFIG_SAMPLE_TRACE_ARRAY)	+= ftrace/
 subdir-$(CONFIG_SAMPLE_UHID)		+= uhid
 obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
diff --git a/samples/ftrace/Makefile b/samples/ftrace/Makefile
index e8a3f8520a44..b9198e2eef28 100644
--- a/samples/ftrace/Makefile
+++ b/samples/ftrace/Makefile
@@ -3,7 +3,7 @@
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-too.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-modify.o
-obj-$(CONFIG_SAMPLE_FTRACE_MULTI_DIRECT) += ftrace-direct-multi.o
+obj-$(CONFIG_SAMPLE_FTRACE_DIRECT_MULTI) += ftrace-direct-multi.o
 
 CFLAGS_sample-trace-array.o := -I$(src)
 obj-$(CONFIG_SAMPLE_TRACE_ARRAY) += sample-trace-array.o
-- 
2.25.1

