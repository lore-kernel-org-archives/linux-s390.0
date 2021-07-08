Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E72BC07E96
	for <linux-s390@archiver.kernel.org>; Thu,  8 Jul 2021 14:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A7561441
	for <linux-s390@archiver.kernel.org>; Thu,  8 Jul 2021 14:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhGHOWS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 8 Jul 2021 10:22:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49876 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229592AbhGHOWS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Jul 2021 10:22:18 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168E3E8x106215;
        Thu, 8 Jul 2021 10:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=yG5M2Svt3PiyFLv9+HYb6BhSHC4U9BWAtuNV31oNFLA=;
 b=KHos7KKRRuheuVg+LXaQuKxBnxQzR407xBu0LfDxyqLitqwiIGuz4d3tjSTDIBilGvoB
 VoMVaaX7j2dmoYjhHN84w9Yf+XffimwaDKKyI16Y/pTMcVzRNtXNMSqjnjM7PQ/RwLEU
 OE3HyB73Xqe02TS+qsEkVKzjxzREqdSorGrJ0zJ4evlHSDGyjifzLrOXXO+Cdvcr+Yig
 5oT+S5q/HNHtbYn2z2IGeOos1iHaFpy8DP5dXndLcaZ0VIaUkVtBp5r4Cd8ExPFmP+yZ
 8LXSO60HjFtyie4BTuSSo1S9v83NLu1ya6SSxLJAV6+VNqAgKxROMTzxqzD3TTQAhRUh Jw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39p1ybk1k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 10:19:13 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 168E3Vaw016576;
        Thu, 8 Jul 2021 14:19:11 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 39jfh8t8pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 14:19:11 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 168EJ8JT33816962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jul 2021 14:19:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1385A405F;
        Thu,  8 Jul 2021 14:19:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93D2CA4059;
        Thu,  8 Jul 2021 14:19:07 +0000 (GMT)
Received: from localhost (unknown [9.145.63.161])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Jul 2021 14:19:07 +0000 (GMT)
Date:   Thu, 8 Jul 2021 16:19:01 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] s390: preempt: Fix preempt_count initialization
Message-ID: <your-ad-here.call-01625753941-ext-9306@work.hours>
References: <20210707163338.1623014-1-valentin.schneider@arm.com>
 <YOcI5iAZnHS9rtRT@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YOcI5iAZnHS9rtRT@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KHMZ-n4bjk9_5UtBMnmJMnfquCidElZR
X-Proofpoint-ORIG-GUID: KHMZ-n4bjk9_5UtBMnmJMnfquCidElZR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_06:2021-07-08,2021-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 mlxlogscore=893
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107080077
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jul 08, 2021 at 04:17:10PM +0200, Heiko Carstens wrote:
> On Wed, Jul 07, 2021 at 05:33:38PM +0100, Valentin Schneider wrote:
> > S390's init_idle_preempt_count(p, cpu) doesn't actually let us initialize the
> > preempt_count of the requested CPU's idle task: it unconditionally writes
> > to the current CPU's. This clearly conflicts with idle_threads_init(),
> > which intends to initialize *all* the idle tasks, including their
> > preempt_count (or their CPU's, if the arch uses a per-CPU preempt_count).
> > 
> > Unfortunately, it seems the way s390 does things doesn't let us initialize
> > every possible CPU's preempt_count early on, as the pages where this
> > resides are only allocated when a CPU is brought up and are freed when it
> > is brought down.
> > 
> > Let the arch-specific code set a CPU's preempt_count when its lowcore is
> > allocated, and turn init_idle_preempt_count() into an empty stub.
> > 
> > Fixes: f1a0a376ca0c ("sched/core: Initialize the idle task with preemption disabled")
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> > ---
> >  arch/s390/include/asm/preempt.h | 16 ++++------------
> >  arch/s390/kernel/setup.c        |  1 +
> >  arch/s390/kernel/smp.c          |  1 +
> >  3 files changed, 6 insertions(+), 12 deletions(-)
> 
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> 
> Vasily, can you pick this one up, please?

Will pick it up right away for rc1, thanks!
