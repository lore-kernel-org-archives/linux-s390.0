Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A0CC433B4
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 09:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA3F6121D
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 09:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhECJOD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 3 May 2021 05:14:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229817AbhECJOC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 May 2021 05:14:02 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14394Abq158756;
        Mon, 3 May 2021 05:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=TisN4PFySuATOG+7Vso8rsvhe75CaNMvMCiUKp6EzYY=;
 b=gAz4HYwsHhW6ZCS1l5YSS6/yfekslwuSyLLwhR6Ap4SWpv/7KsV+NIXle0WOlQhjNVBP
 opWMe5X4DkhEwUZLpt2a8JadQb0g17J82YkLmyyUdr1pMxnt9prC+4FDIYj1zoiCrwjg
 8FWIht9jv0h/7Yrn1IR9RLSS6VL3CV5O9XhrpizYRHFoADqIMjmdzf4CkaimW3mTBasB
 gCtNY+wZwvppTxsi2UMuUUhembrVcRMU5NwEZlbYeVMl0cRwZdbiEc/EEnVs986pqlCo
 mTxtDoPZDUa/avwSsLAzMVr6LO78Ty3oFokOQuoBSV4/w6unPykSu5aYDhbCTEc0dwgn 5g== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38aauxcr51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 05:13:06 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1438rVGJ004783;
        Mon, 3 May 2021 09:13:04 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 388x8h8bjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 09:13:04 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1439Caaj34537946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 May 2021 09:12:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B60104D724;
        Mon,  3 May 2021 09:13:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F01E4D721;
        Mon,  3 May 2021 09:13:01 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  3 May 2021 09:13:01 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/entry: add support for syscall stack randomization
References: <20210429091451.1062594-1-svens@linux.ibm.com>
        <202104301007.5D0C6F9386@keescook> <yt9deeeojpce.fsf@linux.ibm.com>
Date:   Mon, 03 May 2021 11:13:01 +0200
In-Reply-To: <yt9deeeojpce.fsf@linux.ibm.com> (Sven Schnelle's message of
        "Mon, 03 May 2021 08:36:33 +0200")
Message-ID: <yt9dk0ogi3j6.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LqqASLzpRZm0AGosHvRPO9FqYP2f3498
X-Proofpoint-ORIG-GUID: LqqASLzpRZm0AGosHvRPO9FqYP2f3498
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_04:2021-04-30,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0
 mlxlogscore=826 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105030061
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Kees,

Sven Schnelle <svens@linux.ibm.com> writes:

> Kees Cook <keescook@chromium.org> writes:
>
>> On Thu, Apr 29, 2021 at 11:14:51AM +0200, Sven Schnelle wrote:
>>> enough and has much less performance penalty compared to using
>>> get_random_int(). The patch also adds randomization in pgm_check_handler()
>>> as the sigreturn/rt_sigreturn system calls might be called from there.
>>
>> Ah, interesting. Is this path to syscalls unique to s390? (As in, should
>> x86 and arm64 gain coverage over a path that got missed?)
>
> Yes, it's unique to s390. So there should be no need to do anything
> similar on other architectures.

I was a bit short with my reponse, so let me explain this a bit
further. On s390, when a signal handler needs to be called, we put a
'svc (system call) instruction on the Stack and set the address in the
register holding the return address (r14) to that address. That worked
fine until non-executable stacks where introduced. With non-executable
stacks, we get a program check instead when trying to execute the svc.
The kernel than checks whether the instruction that caused the fault
is the svc instruction, and if yes, it will redirect to the systemm call
code to execute the {rt_}sigreturn syscall. So we need to do the stack
offset randomization also in the program check handler to cover that path.

>
>>> +static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>>> +						  unsigned long ti_work)
>>> +{
>>> +	choose_random_kstack_offset(get_tod_clock_fast() & 0xff);
>>
>> What's the stack alignment on s390? Or, better question, what's the
>> expected number of entropy bits?
>
>
> The stack alignement on s390 is 8 bytes, so this should give us 5 bits
> of entropy.
