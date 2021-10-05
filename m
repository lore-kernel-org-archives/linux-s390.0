Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0334EC433F5
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 07:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84A961352
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 07:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhJEIAX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 04:00:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232778AbhJEIAW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Oct 2021 04:00:22 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19566hQd007193;
        Tue, 5 Oct 2021 03:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wMF/jAhmWE5c3yGFuczeo5g76zwIPVpZNasSwbDH1UY=;
 b=kkrgCYm5DnHeNcj1XV35gU5neDplixlY5q+e1Td6yuegV4sk9BCVchVb/9WnSDdEl3R8
 bEv/d2+gtGwhevWbDs/+vhIRgp+RKw/r8OTbmIhLeXLfRDGsK1Jfa8Tw8Xsg30sa0ENF
 pzFoSxd31i0xtVPndpdsu14ZAYE/TQ+i0obzEzV6uBxwCfGmDUhR1pjnLvGuCjiy89jr
 pxTghPQDZoLMntvZ5KxGhJ1pJxmbdn1XuC62CgOX76g6TJbLIHOvRoVI+tFGfB63rMVQ
 hv2w2iose6VoXv+hYUbexHgX1UYkzk8b/NO6Up54Q3ewsrAbIr2Xsa1qQJjZpQF7ytlk Xw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bggmtasmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 03:58:27 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1957uYun031428;
        Tue, 5 Oct 2021 07:58:25 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3bef2aqfbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 07:58:24 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1957wIwo45482416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Oct 2021 07:58:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 768C6A406E;
        Tue,  5 Oct 2021 07:58:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6AAEA4051;
        Tue,  5 Oct 2021 07:58:17 +0000 (GMT)
Received: from li-43c5434c-23b8-11b2-a85c-c4958fb47a68.ibm.com (unknown [9.171.73.26])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Oct 2021 07:58:17 +0000 (GMT)
Subject: Re: [PATCH] s390/debug: fix kernel-doc warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>
References: <20211005051657.16714-1-rdunlap@infradead.org>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <1eb273a2-dabe-c885-100f-6d62f09cf308@de.ibm.com>
Date:   Tue, 5 Oct 2021 09:58:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211005051657.16714-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gN9s7LqvqKHka9UymFumrdsJ7rh_zT6V
X-Proofpoint-ORIG-GUID: gN9s7LqvqKHka9UymFumrdsJ7rh_zT6V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_05,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050042
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



Am 05.10.21 um 07:16 schrieb Randy Dunlap:
> Fix kernel-doc warning due to incorrect parameter name in
> kernel-doc function notation:
> 
> ../arch/s390/include/asm/debug.h:484: warning: Function parameter or member 'pages' not described in 'DEFINE_STATIC_DEBUG_INFO'
> ../arch/s390/include/asm/debug.h:484: warning: Excess function parameter 'pages_per_area' description in 'DEFINE_STATIC_DEBUG_INFO'
> 
> Fixes: d72541f94512 ("s390/debug: add early tracing support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>

Thanks applied.

> ---
>   arch/s390/include/asm/debug.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-515-rc4.orig/arch/s390/include/asm/debug.h
> +++ lnx-515-rc4/arch/s390/include/asm/debug.h
> @@ -462,7 +462,7 @@ arch_initcall(VNAME(var, reg))
>    *
>    * @var: Name of debug_info_t variable
>    * @name: Name of debug log (e.g. used for debugfs entry)
> - * @pages_per_area: Number of pages per area
> + * @pages: Number of pages per area
>    * @nr_areas: Number of debug areas
>    * @buf_size: Size of data area in each debug entry
>    * @view: Pointer to debug view struct
> 
