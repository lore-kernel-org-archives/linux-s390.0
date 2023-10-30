Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD772C4332F
	for <linux-s390@archiver.kernel.org>; Mon, 30 Oct 2023 13:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjJ3NCt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 30 Oct 2023 09:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjJ3NCs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 Oct 2023 09:02:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6576DC2;
        Mon, 30 Oct 2023 06:02:46 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UClkj9020135;
        Mon, 30 Oct 2023 13:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6bkxsOpuQQsxYgtdaVS140hAYebkHhYYfJudtZhhVkY=;
 b=scV0f++6nFUPqeLrT1AXiScjxzDKgeg3epGh29Y6BHJ4r0R+vzle5yIoa7nUD4lwqyI1
 VXwsRjJtL1r3AD6HNpClcOVxvSRCi0qlVgXz8t/Lp7B/OuxAXWl66s3yPZmlalDJil/b
 +5tCnG68nfqfrvLBeq4ncBewIcSY/bPEAAHi5gr+Mr5RmYSuOq42EH0tDLz2B1h+TJyo
 KJimTu5aUGPIBHsWUKZxfg4D0atFeoSOqjhoTUh6lOQDnJDhM+gSyvsz7h1Df4ea/8Nk
 teOuMZHB4tBnvx+bZrX8kqmhs3JeFkbCGXpJzaWy2o1gxHxIfKTvJ9+01f3ngUGrCk3t Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2ct7rf35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 13:02:42 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39UCltqD020452;
        Mon, 30 Oct 2023 13:02:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2ct7rf01-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 13:02:42 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39UB3CAV019880;
        Mon, 30 Oct 2023 12:36:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1d0y95cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 12:36:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39UCa0Oo7013088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 12:36:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9D952004B;
        Mon, 30 Oct 2023 12:36:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4129320043;
        Mon, 30 Oct 2023 12:36:00 +0000 (GMT)
Received: from osiris (unknown [9.171.43.79])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 30 Oct 2023 12:36:00 +0000 (GMT)
Date:   Mon, 30 Oct 2023 13:35:58 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Neal Gompa <ngompa@fedoraproject.org>
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>,
        linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Davide Cavalca <dcavalca@meta.com>
Subject: Re: s390x stack unwinding with perf?
Message-ID: <20231030123558.10816-A-hca@linux.ibm.com>
References: <CAO8sHcn3+_qrnvp0580aK7jN0Wion5F7KYeBAa4MnCY4mqABPA@mail.gmail.com>
 <20231026145659.7063-A-hca@linux.ibm.com>
 <CAO8sHckF_D+SjvGySsGHOpOcdy6y7pwQEF9SfV3sw4Ye4_sCKA@mail.gmail.com>
 <20231027100925.9071-B-hca@linux.ibm.com>
 <CAEg-Je9+UnVsC9e_yDQmXTLNfZy+b42Smj3xobhTE5DiQjk_hA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEg-Je9+UnVsC9e_yDQmXTLNfZy+b42Smj3xobhTE5DiQjk_hA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bCR6g3PzISk0n6mt9jGe9BVCnQlkHUXf
X-Proofpoint-GUID: qtcCdyVT7F8mZ6G-a0V0eG9iG3rMA__b
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=926 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300100
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Oct 27, 2023 at 11:22:42AM -0400, Neal Gompa wrote:
> On Fri, Oct 27, 2023 at 6:10 AM Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> > On Fri, Oct 27, 2023 at 10:00:53AM +0200, Daan De Meyer wrote:
> > >
> > > If the kernel gets support for s390x user space unwinding using the backchain,
> > > we'll propose to enable -mbackchain in the default compilation flags for Fedora
> > > so that s390x on Fedora will have the same profiling experience as x86-64, arm64
> > > and ppc64. For now we'll keep the status quo since compiling with the backchain
> > > doesn't provide any benefit until the kernel unwinder can unwind user
> > > space stacks
> > > using it.
> > >
> > > Thanks for clarifying the current state of user space stack unwinding on s390x!
> >
> > We will implement the missing pieces and let you know when things are
> > supposed to work.
> 
> Do you think we could have an initial patch set for implementing the
> missing pieces in time for the Linux 6.8 merge window? Then we can
> look at enabling this for s390x as a Fedora Linux 40 Change.

This will be very likely the case. Actually the plan is to go with the
patch below. I gave it some testing with Fedora 38 and replaced (only)
glibc with a variant that was compiled with -mbackchain.

It seems to work, including the not avoidable problems described below. So
I guess we will try to bring this upstream with the current merge window.

From 3ba1e255c8af61f172a8b31de2b76d39c7d4c0c7 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Mon, 30 Oct 2023 11:34:07 +0100
Subject: [PATCH] s390/perf: implement perf_callchain_user()

Daan De Meyer and Neal Gompa reported that s390 does not support perf user
stack unwinding.

This was never implemented since this requires user space to be compiled
with the -mbackchain compile option, which until now no distribution
did. However this is going to change with Fedora. Therefore provide a
perf_callchain_user() implementation.

Note that due to the way s390 sets up stack frames the provided call chains
can contain invalid values. This is especially true for the first stack
frame, where it is not possible to tell if the return address has been
written to the stack already or not.

Reported-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Reported-by: Neal Gompa <ngompa@fedoraproject.org>
Closes: https://lore.kernel.org/all/CAO8sHcn3+_qrnvp0580aK7jN0Wion5F7KYeBAa4MnCY4mqABPA@mail.gmail.com/
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/perf_event.c | 47 +++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/s390/kernel/perf_event.c b/arch/s390/kernel/perf_event.c
index c27321cb0969..fdbe7e1d9eea 100644
--- a/arch/s390/kernel/perf_event.c
+++ b/arch/s390/kernel/perf_event.c
@@ -212,6 +212,53 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 	}
 }
 
+struct stack_frame_user {
+	unsigned long back_chain;
+	unsigned long empty1[5];
+	unsigned long gprs[10];
+	unsigned long empty2[4];
+};
+
+void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
+			 struct pt_regs *regs)
+{
+	struct stack_frame_user __user *sf;
+	unsigned long ip, sp;
+	bool first = true;
+
+	if (perf_guest_state())
+		return;
+	if (is_compat_task())
+		return;
+	perf_callchain_store(entry, instruction_pointer(regs));
+	sf = (void *)user_stack_pointer(regs);
+	pagefault_disable();
+	while (entry->nr < entry->max_stack) {
+		if (__get_user(sp, &sf->back_chain))
+			break;
+		if (__get_user(ip, &sf->gprs[8]))
+			break;
+		if (ip & 0x1) {
+			/*
+			 * If the instruction address is invalid, and this
+			 * is the first stack frame, assume r14 has not
+			 * been written to the stack yet. Otherwise exit.
+			 */
+			if (first && !(regs->gprs[14] & 0x1))
+				ip = regs->gprs[14];
+			else
+				break;
+		}
+		perf_callchain_store(entry, ip);
+		/* Sanity check: ABI requires SP to be aligned 8 bytes. */
+		if (!sp || sp & 0x7)
+			break;
+		sf = (void __user *)sp;
+		first = false;
+	}
+	pagefault_enable();
+}
+
 /* Perf definitions for PMU event attributes in sysfs */
 ssize_t cpumf_events_sysfs_show(struct device *dev,
 				struct device_attribute *attr, char *page)
-- 
2.39.2

