Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE8CC433FE
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 09:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E9F361241
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 09:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhKSJm3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 19 Nov 2021 04:42:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232695AbhKSJm2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Nov 2021 04:42:28 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJ8meiH012400;
        Fri, 19 Nov 2021 09:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=8XPBQzrGf7RAFz/mp4k2ulz1rru9La9OwtwiMhCqD8g=;
 b=mIgM8HMoiCkTx6bkpBtdSQtI709YVuahnqo+er56RadHAmkt9JKcjoQgb8+ks/Nykbjo
 dok7p8rn0dQXWwLxCITsXvKmlm2AG37FM+yfjSSfA+aS0h5+3GvaPYwo4XFqgpIqE7/N
 k9UhTGXiTUbEfDcV0T8uhdwYJqYQn07t8T6i6a+7abywdpXUt1cjW1M4HOPm2tCKXF3W
 XbeYGk8giEj4P4JVCV8ErC2zxuu1qFWy9V1GXUNdr4aa8bTnd6WgmWmJgRXTfSEkTiCn
 JyNnXGtRtR0XW9zRJ9B0yGrDRjzOUeLoXi6i77gL7fBUxQL1vdPgFL3tC8f1A1kb2Xz2 Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ce8r78xaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 09:39:24 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AJ9dO4k024954;
        Fri, 19 Nov 2021 09:39:24 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ce8r78x9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 09:39:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AJ9XgUC017780;
        Fri, 19 Nov 2021 09:39:21 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3ca50axyjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 09:39:21 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AJ9dGCZ3474094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 09:39:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D701DA4060;
        Fri, 19 Nov 2021 09:39:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CDB8A4065;
        Fri, 19 Nov 2021 09:39:16 +0000 (GMT)
Received: from [9.171.67.41] (unknown [9.171.67.41])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Nov 2021 09:39:16 +0000 (GMT)
Message-ID: <d9ec2704-f41c-eafa-1945-ce845d65be8a@de.ibm.com>
Date:   Fri, 19 Nov 2021 10:39:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] s390/test_unwind: use raw opcode instead of invalid
 instruction
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Mete Durlu <meted@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, llvm@lists.linux.dev,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
References: <20211117174822.3632412-1-ilie.halip@gmail.com>
 <CAKwvOd=9tsHHhPBOx2ORZoJP09VsX5dRZn58qj3MzCc2vmVosg@mail.gmail.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <CAKwvOd=9tsHHhPBOx2ORZoJP09VsX5dRZn58qj3MzCc2vmVosg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tagg4k6TQGl81lGEf23XTenlqCHy7oAW
X-Proofpoint-ORIG-GUID: mgS0t17czhPX2hRs0q1efXrGjoI8-t1Q
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_08,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111190052
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



Am 19.11.21 um 02:10 schrieb Nick Desaulniers:
> On Wed, Nov 17, 2021 at 9:48 AM Ilie Halip <ilie.halip@gmail.com> wrote:
>>
>> Building with clang & LLVM_IAS=1 leads to an error:
>>      arch/s390/lib/test_unwind.c:179:4: error: invalid register pair
>>                          "       mvcl    %%r1,%%r1\n"
>>                          ^
>>
>> The test creates an invalid instruction that would trap at runtime, but the
>> LLVM inline assembler tries to validate it at compile time too.
>>
>> Use the raw instruction opcode instead.
>>
>> Link: https://github.com/ClangBuiltLinux/linux/issues/1421
>> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
>> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
> 
> Ilie, thanks for the patch!
> 
> So if I understand
> https://sourceware.org/binutils/docs/as/s390-Directives.html#s390-Directives
> https://sourceware.org/binutils/docs/as/s390-Formats.html
> that `e,` prefix is for 16B opcodes?

e is an instruction format as specified by the architecture.
See http://publibfp.dhe.ibm.com/epubs/pdf/a227832c.pdf
without any parameters.
Normally RR would be the right thing for MVCL, but since
we try to build an invalid opcode without the assembler
noticing (ab)using e seem like a safer approach.

> 
> LGTM, thanks again.
> Suggested-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

added those and added my RB. applied to the s390 tree. Thanks


> 
> I triple checked that GAS, clang, and GNU objdump are in agreement in
> terms of encoding here.
> 
>> ---
>>   arch/s390/lib/test_unwind.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
>> index cfc5f5557c06..d342bc884b94 100644
>> --- a/arch/s390/lib/test_unwind.c
>> +++ b/arch/s390/lib/test_unwind.c
>> @@ -176,7 +176,7 @@ static noinline int unwindme_func4(struct unwindme *u)
>>                   * trigger specification exception
>>                   */
>>                  asm volatile(
>> -                       "       mvcl    %%r1,%%r1\n"
>> +                       "       .insn e,0x0e11\n"       /* mvcl %%r1,%%r1" */
>>                          "0:     nopr    %%r7\n"
>>                          EX_TABLE(0b, 0b)
>>                          :);
>> --
>> 2.25.1
>>
> 
> 
