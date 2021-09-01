Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6387EC432BE
	for <linux-s390@archiver.kernel.org>; Wed,  1 Sep 2021 14:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43D8D61053
	for <linux-s390@archiver.kernel.org>; Wed,  1 Sep 2021 14:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244889AbhIAOFU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 1 Sep 2021 10:05:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244850AbhIAOFT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Sep 2021 10:05:19 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 181E3DOj073302;
        Wed, 1 Sep 2021 10:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=TtIJ/iDRD0pdW3QWEMkMJXfThrFgoj8j3h60Ls4dEys=;
 b=GIGm4YHSCWeJRdDMpAVT6lCvZ3p9Zx5yy/ZgzrIPQAOEzC37k475BXsaM3MOCAORgXXr
 7jgjKncD5rVyK4r0tixxBu6bVG43PkSElvtjZeY5ezHmXI8F9Fl/aslS20dAbuFyusuV
 J4ngm2HYrfI+0HBP5XGIH8XRbi5f+upYNf2gjxJQOU6reOHEXq3TvGN5xzJCOkgHdbu4
 fHb+9kCffeMCWoco5BBJHL4t8hZApM1Q1FRNbYlSjvlj10+TRQjaZ4JuceQ8JOcGg07n
 KWBteuAv+/Rw4jq3ZC5kk3vrYOf5GpcaCPqMdvfQuSZAPjz8sENkbpRiuuzCVUz3D+ef pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3at9jvasv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 10:04:07 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 181E3MjE081566;
        Wed, 1 Sep 2021 10:04:06 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3at9jvassr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 10:04:06 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 181E3g5l009639;
        Wed, 1 Sep 2021 14:04:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3aqcs9v4pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 14:04:02 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 181E3wnf52822362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Sep 2021 14:03:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B33342068;
        Wed,  1 Sep 2021 14:03:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EE394204D;
        Wed,  1 Sep 2021 14:03:57 +0000 (GMT)
Received: from localhost (unknown [9.171.90.254])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  1 Sep 2021 14:03:57 +0000 (GMT)
Date:   Wed, 1 Sep 2021 16:03:55 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Marco Elver <elver@google.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: [GIT PULL] s390 updates for 5.15 merge window
Message-ID: <your-ad-here.call-01630505035-ext-2999@work.hours>
References: <YSzZFgBt6nMvpVgc@osiris>
 <YS2RrUma2oOSYtIc@Ryzen-9-3900X.localdomain>
 <82161448-2770-158c-fdd3-d253b4ae476f@de.ibm.com>
 <YS4AufXrOCa4rzN0@osiris>
 <CANpmjNPp3dAcr+WfYxM6_uQOmFmDf60aL-LbXF12NCzP6P3-6Q@mail.gmail.com>
 <YS5Ed4Cyf+rOf9MR@elver.google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YS5Ed4Cyf+rOf9MR@elver.google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1KssbIApeupReSu_e4oN6WGB67spKk13
X-Proofpoint-GUID: tSRKcDxSDA6DLmd5B9vs1d7EVUZms_QF
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-01_04:2021-09-01,2021-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2109010084
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Aug 31, 2021 at 05:02:15PM +0200, Marco Elver wrote:
> 2. stack_trace_save() is subtly broken on s390: it starts the trace in
>    stack_trace_save() itself. This is incorrect, as the trace should
>    start with the caller. We reported something similar to arm64, also
>    because one of our sanitizer tests failed:
>    https://lkml.kernel.org/r/20210319184106.5688-1-mark.rutland@arm.com

Thanks a lot for looking into it and debugging it!

> Fix it by skipping the initial entry in s390's arch_stack_walk().

...

> diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
> index 101477b3e263..47d1841af03e 100644
> --- a/arch/s390/kernel/stacktrace.c
> +++ b/arch/s390/kernel/stacktrace.c
> @@ -16,11 +16,16 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
>  {
>  	struct unwind_state state;
>  	unsigned long addr;
> +	bool init = true;
>  
>  	unwind_for_each_frame(&state, task, regs, 0) {
>  		addr = unwind_get_return_address(&state);
> -		if (!addr || !consume_entry(cookie, addr))
> +		if (!addr)
> +			break;
> +
> +		if (!init && !consume_entry(cookie, addr))
>  			break;
> +		init = false;
>  	}

I believe we don't need to skip the first unwinder result if task != current
or regs != NULL. Same for arch_stack_walk_reliable.

But after you pinpointed the problem I see that the actual difference
with x86 implementation comes from get_stack_pointer(). I'll send a patch
as reply.
