Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96B9C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 14:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D169761074
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 14:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbhJLPBg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:01:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3490 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233435AbhJLPBg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Oct 2021 11:01:36 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CDG7Zg026720;
        Tue, 12 Oct 2021 10:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=R+rS5E0a+UCKzHYIeYz/8ah5pNPj+3oLhA/kCUHYsOI=;
 b=plru6mtp7S10/x2HMRTeM9HjNtB490K6NyuUZYgTZ/nYGUe7Bc7k2NuCvjcxAAcfGlzX
 1SIt0DmI9/do5yhUSDGo5IlpPoO2UXg+mCNZUafNoXkXPWoNWcTQXXFoMoPgBEgTHpqo
 0dLOJ5npYvMopJpMvLbGms0r9KWAMoDdHcCA5WwUUJyaLQ06pMqFF6x0DsZOy5wbT1vJ
 0uHxJ3GjyRSkLwAo5wlAtDrc3jdE0Cyw/t9P89mUcfchA5LXu3MaNthfCuXNf90f1RMD
 IabGBce7usPJLzRN+lDoYc0oUSicxWggSxlMluFEjJvZ8ID1yR+JSNlp5OVSn0hVC1BC pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn998wqp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 10:59:13 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19CDMs7X019104;
        Tue, 12 Oct 2021 10:59:13 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn998wqna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 10:59:13 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19CEXq6E004983;
        Tue, 12 Oct 2021 14:59:11 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3bk2bja3nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 14:59:11 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19CErVOr52429068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 14:53:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C90DA4053;
        Tue, 12 Oct 2021 14:59:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18C42A4057;
        Tue, 12 Oct 2021 14:59:04 +0000 (GMT)
Received: from osiris (unknown [9.145.173.66])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Oct 2021 14:59:04 +0000 (GMT)
Date:   Tue, 12 Oct 2021 16:59:02 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 0/4] s390: DYNAMIC_FTRACE_WITH_DIRECT_CALL support
Message-ID: <YWWithSCGThguq7s@osiris>
References: <20211012133802.2460757-1-hca@linux.ibm.com>
 <20211012094852.7f6a59b8@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012094852.7f6a59b8@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zWfDkZwfy5vlWSrJCIgyFToyJot8t9WX
X-Proofpoint-ORIG-GUID: 3mj7V6oufh3m6vvRQSJriiN29wx7Adhv
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_04,2021-10-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120084
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Oct 12, 2021 at 09:48:52AM -0400, Steven Rostedt wrote:
> On Tue, 12 Oct 2021 15:37:58 +0200
> Heiko Carstens <hca@linux.ibm.com> wrote:
> > This small series adds DYNAMIC_FTRACE_WITH_DIRECT_CALL support for
> > s390 and is based on linux-next 20211012.
...
> > Besides the architecture backend this also adds s390 ftrace direct
> > call samples, and slightly changes config option handling a bit, so
> > that options only have to be selected. This way also additional future
> > architectures can easily add their trampolines to the samples.
...
> > If ok, I'd like to get this upstream via the s390 tree with the next
> > merge window.
> 
> A quick look at the patches look fine to me. I'll do a bit more digging
> before adding a Reviewed-by.
> 
> One thing you may want to note, we are working on fixing direct trampolines
> that conflict with the function graph tracer, and have patches that fix it.
> I'm not that familiar on how ftrace works on s390, but you may want to
> investigate this, because if s390 has the issues that x86 has, where you
> can't have both function graph tracing and a direct trampoline on the same
> function.
> 
> See here:
> 
>   https://lore.kernel.org/all/20211008091336.33616-1-jolsa@kernel.org/

I applied Jiri's patch set and the newly added selftest passes.

Note: s390 will also get HAVE_DYNAMIC_FTRACE_WITH_ARGS support, which is
required for the new selftest - this is currently only in linux-next.
See commit 5740a7c71ab6 ("s390/ftrace: add HAVE_DYNAMIC_FTRACE_WITH_ARGS
support") in linux-next.

Also manually testing with loading the ftrace-direct test module and
enabling the function graph tracer seems to work correctly:

  6) + 15.138 us   |            }
  6)               |            wake_up_process() {
  6)               |              my_direct_func [ftrace_direct]() {
  6)               |                /* waking up ksoftirqd/6-44 */
  6)   0.944 us    |              }
  6)               |              try_to_wake_up() {
  6)   0.185 us    |                kthread_is_per_cpu();

One thing to note: Jiri adds a new a sample module, which obviously
will not compile for s390. Not sure if the config mechanism I propose
with this patch set is the best way to address this - it would then
require to add a config option for each new sample module.
