Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FEBC4332F
	for <linux-s390@archiver.kernel.org>; Wed, 15 Sep 2021 09:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E74B60F92
	for <linux-s390@archiver.kernel.org>; Wed, 15 Sep 2021 09:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbhIOJDl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Sep 2021 05:03:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237075AbhIOJDl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Sep 2021 05:03:41 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18F6vOUv005236;
        Wed, 15 Sep 2021 05:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kY7u22o2D/gAOS/0sOcaDtO7jseJDvcVmfBYjiEVQFY=;
 b=LmObY5F5sXv6Fdk0wMpkZmkv3FfvA/8WUYdvbpYVCry5jTLYGVpvEVo3jpYoCE4Ufy6s
 d7FckqWx2HhDKo14qW40Uo1bRF0UsUMUeji+o+KBLliqADf1eAZdO9fEB3zNbg4OE/Lz
 tU8RYVsM5jM8PiafQ+yGf2UxOMkHHWnGpFuF3AUdP2nH1W7Th/JLhrzw8VcQM4Ku1k4N
 HhYgDLQ+Ipkb8yrIwRkM+QqADuvGhEtH5BscY+S16EzxHp4ffJvJb4E9nShm9ScMM5mm
 bHT0CkidIwCtNqpFnluimayxhU99hje4cEMOzA6C+zgmFMcmi3xXsotNxJ7HpS/Qy9uE HQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b3c11jmu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 05:02:10 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18F91Q96006056;
        Wed, 15 Sep 2021 09:02:08 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3b0kqjum4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 09:02:08 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18F924FI43188692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 09:02:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 731FD11C076;
        Wed, 15 Sep 2021 09:02:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36EEA11C070;
        Wed, 15 Sep 2021 09:02:04 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.52.190])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Sep 2021 09:02:04 +0000 (GMT)
Subject: Re: [PATCH] s390: Add WARN_DYNAMIC_STACK dependencies
To:     Guenter Roeck <linux@roeck-us.net>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210915044010.640499-1-linux@roeck-us.net>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <80b7dbc9-0c09-197f-0f40-ab92d2e3fe3c@de.ibm.com>
Date:   Wed, 15 Sep 2021 11:02:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210915044010.640499-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KLCGyJ4RqFh8ZKtbYre_uue41pLwe6K4
X-Proofpoint-ORIG-GUID: KLCGyJ4RqFh8ZKtbYre_uue41pLwe6K4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109150040
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 15.09.21 06:40, Guenter Roeck wrote:
> s390:allmodconfig fails to build with the following errors.
> 
> arch/s390/kernel/syscall.c: In function '__do_syscall':
> arch/s390/kernel/syscall.c:168:1: error:
> 	'__do_syscall' uses dynamic stack allocation
> 
> lib/test_kasan.c: In function 'kasan_alloca_oob_right':
> lib/test_kasan.c:782:1: error:
> 	'kasan_alloca_oob_right' uses dynamic stack allocation
> 
> lib/test_kasan.c: In function 'kasan_alloca_oob_left':
> lib/test_kasan.c:767:1: error:
> 	'kasan_alloca_oob_left' uses dynamic stack allocation
> 
> The first error is seen if RANDOMIZE_KSTACK_OFFSET_DEFAULT,
> WARN_DYNAMIC_STACK, and WERROR are enabled. The other problems
> are seen if KASAN_KUNIT_TEST, WARN_DYNAMIC_STACK, and WERROR
> are enabled.
> 
> It does not make sense to abort a build in that situation.
> If either RANDOMIZE_KSTACK_OFFSET_DEFAULT or KASAN_KUNIT_TEST
> is enabled, dynamic stack allocation is on purpose and should
> not fail the build. Add dependencies to reflect that situation.
> 

Thanks for the patch. I think Heiko (on vacation) has a patch to
get rid  of this config alltogether, which is probably the better
solution.


> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   arch/s390/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 2bd90c51efd3..776b730e2d15 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -688,6 +688,7 @@ config STACK_GUARD
>   config WARN_DYNAMIC_STACK
>   	def_bool n
>   	prompt "Emit compiler warnings for function with dynamic stack usage"
> +	depends on !WERROR || (!RANDOMIZE_KSTACK_OFFSET_DEFAULT && !KASAN_KUNIT_TEST)
>   	help
>   	  This option enables the compiler option -mwarn-dynamicstack. If the
>   	  compiler supports this options generates warnings for functions
> 
