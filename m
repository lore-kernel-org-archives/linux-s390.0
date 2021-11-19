Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E264C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 14:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B20661057
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 14:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbhKSOPR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:15:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234226AbhKSOPR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Nov 2021 09:15:17 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJEBvYZ011289;
        Fri, 19 Nov 2021 14:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pS0Yy1hic0zPF9YAURlsBeb1gS/RdKDvsx64M/QmQHM=;
 b=ZkjcLjpeQo9LIvc4mlIcGTmnFSPcMaTuLNRJR49ZOt9Iymxf+efROzIo+ZgkS+m8Qho5
 XX1opsWRfphNaRC1IAg2+SSGkNhQUV0UCk2npI+r77etPuqmB7z92zGIRJIwQ/zosrZn
 HIefOJuKxOkZtSwdPuio6I1uHEMUQipq16cw4OAEYTtLCVNjrAYZ3N5qRU6smmmIDU7c
 Jb/rBp+G5LNODHn3kykv9XTPTaOLb3qX6l8fux7pTd/MQBr3EfTLmvQ/UBY3fYPu96BB
 OzieMKl0H/OROgU1j5wWJ1zgjd/WztMZvQwj322Kn63ycN9rUCc8mgiOL/VhNC5LJI1T gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cec681u4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 14:12:12 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AJECC7a012365;
        Fri, 19 Nov 2021 14:12:12 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cec681u3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 14:12:12 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AJE85I1005731;
        Fri, 19 Nov 2021 14:12:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3ca50c1dad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 14:12:09 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AJEC4C233030618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 14:12:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4B68AE05F;
        Fri, 19 Nov 2021 14:12:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E3F5AE055;
        Fri, 19 Nov 2021 14:12:04 +0000 (GMT)
Received: from [9.171.67.41] (unknown [9.171.67.41])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Nov 2021 14:12:04 +0000 (GMT)
Message-ID: <fe1662f9-7cab-5f9f-882b-2b8ffa80992c@de.ibm.com>
Date:   Fri, 19 Nov 2021 15:12:03 +0100
MIME-Version: 1.0
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
 <658a63b5-2d18-2837-9639-75a14c959f73@de.ibm.com> <YZeF4JjWIcTMtaaT@osiris>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <YZeF4JjWIcTMtaaT@osiris>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6QS122JTGoagEZjrRNzdAxGxWI0CPm6H
X-Proofpoint-ORIG-GUID: 0IUlFXRtSpr2nUdYvpzmWMahErC0m3O1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_09,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 phishscore=0 mlxlogscore=928 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111190078
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



Am 19.11.21 um 12:09 schrieb Heiko Carstens:
> On Fri, Nov 19, 2021 at 11:57:05AM +0100, Christian Borntraeger wrote:
>>>>>> -                       "       mvcl    %%r1,%%r1\n"
>>>>>> +                       "       .insn e,0x0e11\n"       /* mvcl %%r1,%%r1" */
>>>
>>> Sorry, I disagree with this. As you said above rr would be the correct
>>> format for this instruction. If we go for the e format then we should
>>> also use an instruction with e format.
>>> Which in this case would simply be an illegal opcode, which would be
>>> sufficient for what this code is good for: ".insn e,0x0000".
>>
>> Why not simply use .short then?
> 
> .short bypasses all sanity checks while .insn does not, so I think
> that should be preferred. But I don't care too much.

Heiko,
I am fine with ".insn e,0x0000" and the a changed comment that changes "specification exception" to "operation exception".
Do you want Ilie to resend or simply fixup?
