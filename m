Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4F5C432BE
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 15:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624616103A
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 15:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbhHaPUD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 31 Aug 2021 11:20:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232559AbhHaPTw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 31 Aug 2021 11:19:52 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17VF4TA3052060;
        Tue, 31 Aug 2021 11:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=zuHAQQs0gmUCQco7aRWvmy11cWZcfnUYpyX3TZ43UXA=;
 b=geLgWUQisEKJDUnurg1sfiX+fo4evxjnzjVzvbXl3ZSDW+94yPKFMECGxf6Gi5ElZh1y
 qejCRqU5g+ZCjZr3uOwxfpzDjjtJ6IvZQOOiYTdqG7yzkeDM3TopRK2l5RVJcxe6MA5q
 FQ5gnfk44T+pDTl+mL/CLJ1y7Q7gmSJWdU/D5Nks+G0Q0dkbfwnud1wV1FfGJ6QiV2AU
 pOXlXIEwazZCOd8Ugb2mopSZ2VvIJpFseHz3qgsuAuriVGpCS2lJc6sQjtoygk60115d
 ukeW9PbHTArw1RB4CTp/Wnm9jMGQhzu86Hc8k09zpbKUHgd6KwYQy0qjmUGGg7v6UGZK 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3asp891pfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 11:18:38 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17VF5hbJ064295;
        Tue, 31 Aug 2021 11:18:38 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3asp891pf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 11:18:38 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17VFGxVV008705;
        Tue, 31 Aug 2021 15:18:36 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3aqcs8uxr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 15:18:36 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17VFIWvG29032706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 15:18:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 240214208A;
        Tue, 31 Aug 2021 15:18:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF60542087;
        Tue, 31 Aug 2021 15:18:31 +0000 (GMT)
Received: from osiris (unknown [9.145.60.147])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 31 Aug 2021 15:18:31 +0000 (GMT)
Date:   Tue, 31 Aug 2021 17:18:30 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Marco Elver <elver@google.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: [GIT PULL] s390 updates for 5.15 merge window
Message-ID: <YS5IRiFO9crNu46y@osiris>
References: <YSzZFgBt6nMvpVgc@osiris>
 <YS2RrUma2oOSYtIc@Ryzen-9-3900X.localdomain>
 <82161448-2770-158c-fdd3-d253b4ae476f@de.ibm.com>
 <YS4AufXrOCa4rzN0@osiris>
 <CANpmjNPp3dAcr+WfYxM6_uQOmFmDf60aL-LbXF12NCzP6P3-6Q@mail.gmail.com>
 <YS5Ed4Cyf+rOf9MR@elver.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS5Ed4Cyf+rOf9MR@elver.google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7xetOQ97Ah06IA0LnvIUpM37fwGRXaQ0
X-Proofpoint-ORIG-GUID: QLg8D5EGsrGv4VqBqEToK6xy605cjhtA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_07:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=682
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310080
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Aug 31, 2021 at 05:02:15PM +0200, Marco Elver wrote:
> On Tue, Aug 31, 2021 at 12:46PM +0200, Marco Elver wrote:
> > On Tue, 31 Aug 2021 at 12:13, Heiko Carstens <hca@linux.ibm.com> wrote:
> I repro'd, and the problem is part QEMU TCG and a minor problem with
> stack_trace_save() on s390:
> 
> 1. QEMU TCG doesn't seem to want to execute threads concurrently,
>    resulting in no "value changes" being observed. This is probably just
>    a limitation of TCG, and if run on a real CPU, shouldn't be a problem.
>    On QEMU, most test cases will pass with CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n
>    (There's one left that requires value changes to be observable)
> 
> 2. stack_trace_save() is subtly broken on s390: it starts the trace in
>    stack_trace_save() itself. This is incorrect, as the trace should
>    start with the caller. We reported something similar to arm64, also
>    because one of our sanitizer tests failed:
>    https://lkml.kernel.org/r/20210319184106.5688-1-mark.rutland@arm.com
...
> I fixed it with the below, and now most tests pass. Note that, other
> debugging tools may also report misleading stack traces without the
> stack_trace_save() fix (e.g. certain KFENCE reports).
> 
> If you have a better solution for how to fix stack_trace_save() on s390,
> please discard my patch.

Ah, with your patch I get the below on a real machine; so it looks
like this really was the only problem for the failing self tests.

Thanks a lot for the patch! Will look into it later and apply if
everything else still works!

[    5.138547]     ok 1 - test_basic
[    7.538799]     ok 2 - test_concurrent_races
[    9.938524]     ok 3 - test_novalue_change
[   11.620063]     ok 4 - test_novalue_change_exception
[   11.952404]     ok 5 - test_unknown_origin
[   14.349852]     ok 6 - test_write_write_assume_atomic
[   14.681937]     ok 7 - test_write_write_struct
[   15.031046]     ok 8 - test_write_write_struct_part
[   17.429869]     ok 9 - test_read_atomic_write_atomic
[   17.760862]     ok 10 - test_read_plain_atomic_write
[   18.093500]     ok 11 - test_read_plain_atomic_rmw
[   20.490570]     ok 12 - test_zero_size_access
[   22.939270]     ok 13 - test_data_race
[   23.271104]     ok 14 - test_assert_exclusive_writer
[   23.601940]     ok 15 - test_assert_exclusive_access
[   26.000281]     ok 16 - test_assert_exclusive_access_writer
[   26.330718]     ok 17 - test_assert_exclusive_bits_change
[   28.739480]     ok 18 - test_assert_exclusive_bits_nochange
[   28.962218]     ok 19 - test_assert_exclusive_writer_scoped
[   29.071385]     ok 20 - test_assert_exclusive_access_scoped
[   31.479706]     ok 21 - test_jiffies_noreport
[   33.879581]     ok 22 - test_seqlock_noreport
[   36.279853]     ok 23 - test_atomic_builtins
[   36.279893] ok 1 - kcsan
