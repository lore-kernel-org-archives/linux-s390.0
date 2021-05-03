Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1251DC433ED
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 06:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C14E760FE3
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 06:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhECGhn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 3 May 2021 02:37:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22556 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229817AbhECGhn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 May 2021 02:37:43 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1436Y47o193476;
        Mon, 3 May 2021 02:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=rU8yXmGVOWJiWBppt7Jns5EqoOqbPkKPwKbBxW4A0mU=;
 b=RHznUPI4ZWRU2SbVDLDN+MuzFxEWlTo+4gzOfE0EXJ+sjPSGrV76jIfNItS7deg8EDsj
 Tbl4MjT805HtWU16D+xwhPXnX5Kx/e190P/9/nqoodBBCbHoZjQDr1z0WWQfU18DnIXO
 yaeq/AZP6U+130yiSf97Ie93V/X1FoB+ITL3ovTqVipWS65E/OiCqOHoodpegYMtUFAo
 AZnlui3OYfzQ2W9yvE4E7ZTrgALzySRuE0Gi5hoOtI8iRw96IMfhPdboJNg1R28TsCDc
 95Hzu7oN+hDBPA9h3arrmFFertK260rSNz+zM69iGc4OHf+lwSodE4rgLfm3JNCKaksm tQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38a8c7m0m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 02:36:38 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1436Qdsb027206;
        Mon, 3 May 2021 06:36:37 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 388xm88ac1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 06:36:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1436aXGi41353700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 May 2021 06:36:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89AE352057;
        Mon,  3 May 2021 06:36:33 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 522445204E;
        Mon,  3 May 2021 06:36:33 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/entry: add support for syscall stack randomization
References: <20210429091451.1062594-1-svens@linux.ibm.com>
        <202104301007.5D0C6F9386@keescook>
Date:   Mon, 03 May 2021 08:36:33 +0200
In-Reply-To: <202104301007.5D0C6F9386@keescook> (Kees Cook's message of "Fri,
        30 Apr 2021 10:10:35 -0700")
Message-ID: <yt9deeeojpce.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pfOxJAJqjQn6KC2MQNc2GrP74UaAOGZx
X-Proofpoint-GUID: pfOxJAJqjQn6KC2MQNc2GrP74UaAOGZx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_03:2021-04-30,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 mlxlogscore=742 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030045
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Kees,

Kees Cook <keescook@chromium.org> writes:

> On Thu, Apr 29, 2021 at 11:14:51AM +0200, Sven Schnelle wrote:
>> enough and has much less performance penalty compared to using
>> get_random_int(). The patch also adds randomization in pgm_check_handler()
>> as the sigreturn/rt_sigreturn system calls might be called from there.
>
> Ah, interesting. Is this path to syscalls unique to s390? (As in, should
> x86 and arm64 gain coverage over a path that got missed?)

Yes, it's unique to s390. So there should be no need to do anything
similar on other architectures.

>> +static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>> +						  unsigned long ti_work)
>> +{
>> +	choose_random_kstack_offset(get_tod_clock_fast() & 0xff);
>
> What's the stack alignment on s390? Or, better question, what's the
> expected number of entropy bits?


The stack alignement on s390 is 8 bytes, so this should give us 5 bits
of entropy.
