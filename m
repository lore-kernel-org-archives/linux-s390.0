Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C64BC433B4
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 14:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C48061040
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 14:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhECOMe (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 3 May 2021 10:12:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229900AbhECOMd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 May 2021 10:12:33 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143E3Kdi112610;
        Mon, 3 May 2021 10:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DP0YgCUTXkMqVV2M1X/pE4NoH8W4dTxUalNBePTvvOo=;
 b=F3gwhz67vAPwgP2mUfOERv+DJdhTW1ogO80H3YpwaULxLuGWEfYPLNUT8prW8laNkHXq
 PrIeZVR6fjBxyVAuM/sjiw5ioXb8EXgQe5HLg47OrBGavcxoVH1D38GU6ajLZwe5WXFF
 a3b5JNkK/bPYciBcOFE/UAZIwizso9D5GKqoekNLMYZeADa2d39jeI54Ju8H9kCuvaTO
 PXZMG/rXfx7pbJBru3LoWkZ7lZ+iCGeW+znnq5gesXxSzbIAiQZJrMYGJUq0xxcaRA3t
 n5VxML9TdH1ffVShMwP5A6MNZSbJnLQEvjVwK2gC02sHwLqDYgMIoUEN1JDVqtRO/7tE Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38ah42k480-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 10:11:40 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 143E4IgM122677;
        Mon, 3 May 2021 10:11:40 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38ah42k46x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 10:11:40 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 143E92Lc004339;
        Mon, 3 May 2021 14:11:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 388xm8gdp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 14:11:37 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 143EBYvs17301954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 May 2021 14:11:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B99BDA404D;
        Mon,  3 May 2021 14:11:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4483AA4055;
        Mon,  3 May 2021 14:11:34 +0000 (GMT)
Received: from linux.fritz.box (unknown [9.145.164.58])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 May 2021 14:11:34 +0000 (GMT)
Subject: Re: [PATCH] s390: fix detection of vector enhancements facility 1 vs.
 vector packed decimal facility
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20210503121244.25232-1-david@redhat.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Message-ID: <a9329b60-e912-7600-af00-1ce16d018f92@linux.ibm.com>
Date:   Mon, 3 May 2021 16:11:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210503121244.25232-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y7FU50Z_5Kb0SPYvsIF9jEmU3OOwOqh6
X-Proofpoint-ORIG-GUID: o-dmBm2XUShU1qMYE1TqFsMaXuZnhvzR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_10:2021-05-03,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030096
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 5/3/21 2:12 PM, David Hildenbrand wrote:
> The PoP documents:
> 	134: The vector packed decimal facility is installed in the
> 	     z/Architecture architectural mode. When bit 134 is
> 	     one, bit 129 is also one.
> 	135: The vector enhancements facility 1 is installed in
> 	     the z/Architecture architectural mode. When bit 135
> 	     is one, bit 129 is also one.
> 
> Looks like we confuse the vector enhancements facility 1 ("EXT") with the
> Vector packed decimal facility ("BCD"). Let's fix the facility checks.
> 
> Detected while working on QEMU/tcg z14 support and only unlocking
> the vector enhancements facility 1, but not the vector packed decimal
> facility.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> 
> Fixes: 2583b848cad0 ("s390: report new vector facilities")
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Alexander Egorenkov <egorenar@linux.ibm.com>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kernel/setup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 72134f9f6ff5..5aab59ad5688 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -937,9 +937,9 @@ static int __init setup_hwcaps(void)
>  	if (MACHINE_HAS_VX) {
>  		elf_hwcap |= HWCAP_S390_VXRS;
>  		if (test_facility(134))
> -			elf_hwcap |= HWCAP_S390_VXRS_EXT;
> -		if (test_facility(135))
>  			elf_hwcap |= HWCAP_S390_VXRS_BCD;
> +		if (test_facility(135))
> +			elf_hwcap |= HWCAP_S390_VXRS_EXT;
>  		if (test_facility(148))
>  			elf_hwcap |= HWCAP_S390_VXRS_EXT2;
>  		if (test_facility(152))
> 

