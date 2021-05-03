Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1D7C43461
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 12:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2817611C2
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 12:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbhECMSz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 3 May 2021 08:18:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62294 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230340AbhECMSy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 May 2021 08:18:54 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143CFaZv042409;
        Mon, 3 May 2021 08:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pFQmPV9XH0Rne5Ff3uz6L63Iq3vjeYY3TDUWEq32c5A=;
 b=I9q4hbEEoDtpwgZb2kZgggLUh/WTuCeZJyajDYmJJOjZK2vfbTTczVsmQJWC2aJOTss8
 lY6KRQQy8ApIBq59eSXMPkyVtdCawfOLPoMRXhWWR1uiHihBpwlo9DsyfV116/SjfAQa
 /B30dXty4M3gsZkz/41g7zayLAuyCSUi4pJ3tVvIUVIPWhDnj14zcYLz66dQtgeQ22Q1
 NWfhEiyP9m2vbn71LU1mmEzHFjxKPmGYYY0UHyTWoqzGaMV4W7XatRcGu5CVME5yzuTV
 P0CpERW5XHzWyOlWpjNxsnULK7WvQu5vPHKP1U+Ad0Q6UV5ZuIhjQAaoM0fJk+x1WuEO cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38ah0y01nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 08:18:01 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 143CGrlY044690;
        Mon, 3 May 2021 08:18:00 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38ah0y01n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 08:18:00 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 143CDkrv031478;
        Mon, 3 May 2021 12:17:59 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 388xm8gpr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 12:17:58 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 143CHUsi29884834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 May 2021 12:17:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC91AA4059;
        Mon,  3 May 2021 12:17:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D3DEA405E;
        Mon,  3 May 2021 12:17:55 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.76.192])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 May 2021 12:17:55 +0000 (GMT)
Subject: Re: [PATCH] s390: fix detection of vector enhancements facility 1 vs.
 vector packed decimal facility
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20210503121244.25232-1-david@redhat.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <429fab49-91a8-92c5-ec81-71e9336f2571@de.ibm.com>
Date:   Mon, 3 May 2021 14:17:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210503121244.25232-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ArPZQOzqXiEN6ROIeQUJpiTIFTKIe0px
X-Proofpoint-GUID: QCjH_NmHQP358m6y-xuK80fXOpDRR8B3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_07:2021-05-03,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105030084
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 03.05.21 14:12, David Hildenbrand wrote:
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

Yes looks correct. This should not be noticable on real machines as you either
have both or none, but of course with virtual machine this could happen.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>   arch/s390/kernel/setup.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 72134f9f6ff5..5aab59ad5688 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -937,9 +937,9 @@ static int __init setup_hwcaps(void)
>   	if (MACHINE_HAS_VX) {
>   		elf_hwcap |= HWCAP_S390_VXRS;
>   		if (test_facility(134))
> -			elf_hwcap |= HWCAP_S390_VXRS_EXT;
> -		if (test_facility(135))
>   			elf_hwcap |= HWCAP_S390_VXRS_BCD;
> +		if (test_facility(135))
> +			elf_hwcap |= HWCAP_S390_VXRS_EXT;
>   		if (test_facility(148))
>   			elf_hwcap |= HWCAP_S390_VXRS_EXT2;
>   		if (test_facility(152))
> 
