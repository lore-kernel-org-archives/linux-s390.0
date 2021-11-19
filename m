Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C99C433EF
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 10:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF05615E2
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 10:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbhKSLAV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 19 Nov 2021 06:00:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46354 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231796AbhKSLAU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Nov 2021 06:00:20 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJ9g7Y7022038;
        Fri, 19 Nov 2021 10:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=FTkd37bvrsQwuREjHlKhv+jlCN5TaReeRhqz+EmL6dI=;
 b=OscwhZ0RCEEi1Yzg0MqPbHPGLyiUuTmNa7p6dVQ0py/a5awtFcp5BMf07JTiOF5hKDxN
 xNiX5/vUr6ka2oYFPsvPF4uoU30ggZkkQRtYLDArzsDgVVEa4Or8SUkds8Knmaf5nQa/
 3GUoejxR6Ho9twmK1c54n/Y7E5MN4Le1zM4ZF2kkfdEv+WfaYRFokIXCO95a/H3kjPez
 4HVyF4BlA9g/YhhxrYe52GmxP2nkPkFAPl39c3KtqQ8hqfiPROAOkkrdjPAI27G796Nt
 xkZl1KFe+KQVtMqlKMynRDvXNBKTFuWRyBl9FN1mNqEttDaOyi8pSCKEOR5YRiAMNX+b 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ce9h4h9u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 10:57:15 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AJAo5go004692;
        Fri, 19 Nov 2021 10:57:14 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ce9h4h9tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 10:57:14 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AJAs2Cb003588;
        Fri, 19 Nov 2021 10:57:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3ca50byn0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 10:57:12 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AJAo4WG65208630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 10:50:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CAB5A4062;
        Fri, 19 Nov 2021 10:57:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC8B2A405C;
        Fri, 19 Nov 2021 10:57:05 +0000 (GMT)
Received: from [9.171.67.41] (unknown [9.171.67.41])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Nov 2021 10:57:05 +0000 (GMT)
Message-ID: <658a63b5-2d18-2837-9639-75a14c959f73@de.ibm.com>
Date:   Fri, 19 Nov 2021 11:57:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] s390/test_unwind: use raw opcode instead of invalid
 instruction
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Mete Durlu <meted@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, llvm@lists.linux.dev,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
References: <20211117174822.3632412-1-ilie.halip@gmail.com>
 <CAKwvOd=9tsHHhPBOx2ORZoJP09VsX5dRZn58qj3MzCc2vmVosg@mail.gmail.com>
 <d9ec2704-f41c-eafa-1945-ce845d65be8a@de.ibm.com> <YZeCcSjh4yCzzDcH@osiris>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <YZeCcSjh4yCzzDcH@osiris>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: si2gEz0Uu3-awDu1havmlS3Zs0WP9m6O
X-Proofpoint-ORIG-GUID: KkwuKmdECFZeAMrA2NMS7BKZYO6qoMvS
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_08,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111190058
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



Am 19.11.21 um 11:54 schrieb Heiko Carstens:
> On Fri, Nov 19, 2021 at 10:39:15AM +0100, Christian Borntraeger wrote:
>>> So if I understand
>>> https://sourceware.org/binutils/docs/as/s390-Directives.html#s390-Directives
>>> https://sourceware.org/binutils/docs/as/s390-Formats.html
>>> that `e,` prefix is for 16B opcodes?
>>
>> e is an instruction format as specified by the architecture.
>> See http://publibfp.dhe.ibm.com/epubs/pdf/a227832c.pdf
>> without any parameters.
>> Normally RR would be the right thing for MVCL, but since
>> we try to build an invalid opcode without the assembler
>> noticing (ab)using e seem like a safer approach.
>>>
>>> LGTM, thanks again.
>>> Suggested-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
>>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>>
>> added those and added my RB. applied to the s390 tree. Thanks
> ..
>>>> diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
>>>> index cfc5f5557c06..d342bc884b94 100644
>>>> --- a/arch/s390/lib/test_unwind.c
>>>> +++ b/arch/s390/lib/test_unwind.c
>>>> @@ -176,7 +176,7 @@ static noinline int unwindme_func4(struct unwindme *u)
>>>>                    * trigger specification exception
>>>>                    */
>>>>                   asm volatile(
>>>> -                       "       mvcl    %%r1,%%r1\n"
>>>> +                       "       .insn e,0x0e11\n"       /* mvcl %%r1,%%r1" */
> 
> Sorry, I disagree with this. As you said above rr would be the correct
> format for this instruction. If we go for the e format then we should
> also use an instruction with e format.
> Which in this case would simply be an illegal opcode, which would be
> sufficient for what this code is good for: ".insn e,0x0000".

Why not simply use .short then?
