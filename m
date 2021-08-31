Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11C2C432BE
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 17:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C27096103A
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 17:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhHaRvF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 31 Aug 2021 13:51:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233576AbhHaRvF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 31 Aug 2021 13:51:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17VHXGhu091358;
        Tue, 31 Aug 2021 13:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=waumsmmml88R2izW3SRcXT3V7bQ00oJwTyLQe8u3BfM=;
 b=Gqj4htEq3GO+YfHG0w/NtLA5B0Ib2lLjjFDseT3+oopth3q4z/HTTL3nOXZHTh+p0wUy
 xj9lcdN0XEDf9G5kfToJB2fp6CZmv+oh0UbvINEd4qsAL92AE+FIJO1IlqjDfqyL69k8
 5fqVUW9uliIlwTxE4oX3W1RFknDo23xkohVppk9+TqkoMkyJivgBnZ4X0LwTfZYsqQUJ
 rZ7gswegKLzbZdZwWghcaK1+Jh/qxKJPflXAF2p7fft/qp6QMU9h/ppHzK8idRzZRnXW
 t+Bz9aNUHIP2+qdpQtmzizs+hU5xuY9AQOxU3LvO4Lh1DDiiqfgLURU+yN2hNRmXiJO/ SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3asrwdrdaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 13:49:48 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17VHb1Jj110777;
        Tue, 31 Aug 2021 13:49:47 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3asrwdrda6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 13:49:47 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17VHhbAe010671;
        Tue, 31 Aug 2021 17:49:46 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3aqcdjdw6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 17:49:46 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17VHngD646596364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 17:49:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A05A811C01F;
        Tue, 31 Aug 2021 17:49:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D34E11C054;
        Tue, 31 Aug 2021 17:49:42 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.164.122])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 Aug 2021 17:49:42 +0000 (GMT)
Subject: Re: [GIT PULL] s390 updates for 5.15 merge window
To:     Nathan Chancellor <nathan@kernel.org>,
        Marco Elver <elver@google.com>,
        Richard Henderson <rth@twiddle.net>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        qemu-s390x <qemu-s390x@nongnu.org>
References: <YSzZFgBt6nMvpVgc@osiris>
 <YS2RrUma2oOSYtIc@Ryzen-9-3900X.localdomain>
 <82161448-2770-158c-fdd3-d253b4ae476f@de.ibm.com> <YS4AufXrOCa4rzN0@osiris>
 <CANpmjNPp3dAcr+WfYxM6_uQOmFmDf60aL-LbXF12NCzP6P3-6Q@mail.gmail.com>
 <YS5Ed4Cyf+rOf9MR@elver.google.com> <YS5rVpFXe4w/D7BN@MSI.localdomain>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <4ae5cf63-4f86-5a1c-90b5-73912cfe42b9@de.ibm.com>
Date:   Tue, 31 Aug 2021 19:49:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YS5rVpFXe4w/D7BN@MSI.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tG7oXRuJkBKfSqU52Bb8AcAD2OyC4aAw
X-Proofpoint-GUID: 55j9Z09Cx1rM2uGuJFAy3N3HSgEE0aAd
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_08:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 clxscore=1011 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310096
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 31.08.21 19:48, Nathan Chancellor wrote:
> On Tue, Aug 31, 2021 at 05:02:15PM +0200, Marco Elver wrote:
>> On Tue, Aug 31, 2021 at 12:46PM +0200, Marco Elver wrote:
>>> On Tue, 31 Aug 2021 at 12:13, Heiko Carstens <hca@linux.ibm.com> wrote:
>>> [...]
>>>> I really don't think this is QEMU related. The test fails are sort of
>>>> expected: we've seen KCSAN reports when the kernel boots and wanted to
>>>> fix them later.
>>>> However I have to admit that I wasn't aware of the KCSAN KUNIT tests,
>>>> and wouldn't have sent the s390 KCSAN enablement upstream if I would
>>>> have been aware of failing self tests.
>>>>
>>>> We'll fix them, and I let you know if things are supposed to work.
>>>>
>>>> Thanks a lot for making aware of this!
>>>
>>> Note: Set `CONFIG_KCSAN_REPORT_ONCE_IN_MS=100` (or smaller) instead of
>>> the default to make the test complete faster.
>>>
>>> The pattern I see from what Nathan reported is that all test cases
>>> that expect race reports don't observe them ("not ok" cases), and all
>>> those where no races are meant to be reported are fine ("ok" cases).
>>> Without actually seeing the log, I'm guessing that no races are
>>> reported at all, which is certainly not working as intended.
>>
>> I repro'd, and the problem is part QEMU TCG and a minor problem with
>> stack_trace_save() on s390:
>>
>> 1. QEMU TCG doesn't seem to want to execute threads concurrently,
>>     resulting in no "value changes" being observed. This is probably just
>>     a limitation of TCG, and if run on a real CPU, shouldn't be a problem.
>>     On QEMU, most test cases will pass with CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n
>>     (There's one left that requires value changes to be observable)
> 
> Is this just a limitation of s390's TCG implementation or in general?
> Our CI runs on GitHub Actions, which does not support virtualization so
> I believe that all of our tests are being done with TCG and x86_64
> passes just fine:

Maybe Richard knows?

> 
> https://github.com/ClangBuiltLinux/continuous-integration2/runs/3473222334?check_suite_focus=true
> 
> Good to hear that it is working on bare metal now though, we could still
> enable build testing of it at a minimum but it would be nice to see the
> tests pass even in QEMU :)
> 
> Cheers,
> Nathan
> 
