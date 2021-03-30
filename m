Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2033BC433DB
	for <linux-s390@archiver.kernel.org>; Tue, 30 Mar 2021 18:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9565619E2
	for <linux-s390@archiver.kernel.org>; Tue, 30 Mar 2021 18:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhC3Skg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:40:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15578 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232329AbhC3SkJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 30 Mar 2021 14:40:09 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UIXPkJ074739;
        Tue, 30 Mar 2021 14:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Den44Qg8bM1P7JH18d4vg9lT5dGl5tMZiOvL4llIvew=;
 b=QOUrx7y/pux530JQW0c8NYs96a22l7c4dhBrUHNJC5Rf3TR/UeT7jpcBmxlH8/dVvt2V
 l2eEE4z/eGhFKoz9aFRFQu4+E4sb/ElG/MgEGEtUw36r3FskCIRAIDlnL5UgYzljYNyd
 8PR6lEZZNieoGM5vhYtDAKPQv8gneNhKdulYE+QOu7/a5zL7Yz3bodcaZzJSXrDdVJT3
 uZFFuOtnQjzeFtOgLb/Y+2mtfuWURKGvKalYPdLFwPO276RMwwB1wnx8lZi9ctIR8ngx
 qsGI1lpTllRbvWxE8s7JsN4Lq8dDAgmyL+2wtKMx7wOXy2qRd4UOBnoOEpvbE0cQBfND Gw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37m74b58b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 14:40:04 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12UIW6eT024660;
        Tue, 30 Mar 2021 18:40:03 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 37hvb8jwu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 18:40:02 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12UIe0rJ37552576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 18:40:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07B6F52051;
        Tue, 30 Mar 2021 18:40:00 +0000 (GMT)
Received: from oc6887364776.ibm.com (unknown [9.145.188.64])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 89BF15204E;
        Tue, 30 Mar 2021 18:39:59 +0000 (GMT)
Subject: Re: [PATCH] arch: s390: Remove duplicate struct ccw1 declaration
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
References: <20210330105638.2742356-1-wanjiabing@vivo.com>
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
Message-ID: <23819124-7c34-4c57-5e76-e5b3d2750a73@linux.ibm.com>
Date:   Tue, 30 Mar 2021 20:39:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210330105638.2742356-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LJ5uWFrwsyWxdeh5GiuuB5AY-iTMnBof
X-Proofpoint-ORIG-GUID: LJ5uWFrwsyWxdeh5GiuuB5AY-iTMnBof
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_08:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 suspectscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300134
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Thank you for the patch.
Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Heiko/Vasily will pick this up and will be part of the s390-tree patchset.

On 3/30/21 12:56 PM, Wan Jiabing wrote:
> struct ccw1 is declared twice. One has been declared
> at 21st line. Remove the duplicate.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>   arch/s390/include/asm/ccwdev.h | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/arch/s390/include/asm/ccwdev.h b/arch/s390/include/asm/ccwdev.h
> index 778247bb1d61..d4e90f2ba77e 100644
> --- a/arch/s390/include/asm/ccwdev.h
> +++ b/arch/s390/include/asm/ccwdev.h
> @@ -152,9 +152,6 @@ extern struct ccw_device *get_ccwdev_by_busid(struct ccw_driver *cdrv,
>    * when new devices for its type pop up */
>   extern int  ccw_driver_register   (struct ccw_driver *driver);
>   extern void ccw_driver_unregister (struct ccw_driver *driver);
> -
> -struct ccw1;
> -
>   extern int ccw_device_set_options_mask(struct ccw_device *, unsigned long);
>   extern int ccw_device_set_options(struct ccw_device *, unsigned long);
>   extern void ccw_device_clear_options(struct ccw_device *, unsigned long);
