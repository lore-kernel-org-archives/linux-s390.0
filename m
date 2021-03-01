Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58C9C433DB
	for <linux-s390@archiver.kernel.org>; Mon,  1 Mar 2021 12:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9222460C3D
	for <linux-s390@archiver.kernel.org>; Mon,  1 Mar 2021 12:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhCAMTU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 1 Mar 2021 07:19:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234139AbhCAMTG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Mar 2021 07:19:06 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 121C4XW0121645;
        Mon, 1 Mar 2021 07:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vnsvBUqg5xQG6q7AEDJKtyaLYYemmZ0hyhGWhSRqm5A=;
 b=TJTD9FCbzim2IfwSGf0yXpONyGpkJ7lX3dYsiJq0gK234Hmt9ajAQdqoQ7poXgAM5QET
 Ig7LPyL2kLkS+f3uHrZ8x+SFr9EU3gKywHFGS1Ci60KAj6rduljJk/ceD+dWE7RztNCb
 lukZ2+p0ehtfiZlzHcq69/xkxxhtxvGOIvSuaKi/H0xd3H6LikEFK4qjaPGiwP0x3AYb
 JIxXwAeQ8VTYJXXX3m/07Dz0R5F0MIPH2km4fOQ6et1MeONk59C3YD1zfkiSAkBYm++1
 Flfudhl5f1HuwyDikbf79VU7gk16V0bn0fRwZ4aIoIHgavcQZ8ljGhLmZjdxFeZtNrbk tw== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 370td0kqck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 07:18:25 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 121C7njt016739;
        Mon, 1 Mar 2021 12:18:23 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 36ydq92gcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 12:18:23 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 121CIL2528901720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Mar 2021 12:18:21 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 581A6AE062;
        Mon,  1 Mar 2021 12:18:21 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEB70AE05C;
        Mon,  1 Mar 2021 12:18:20 +0000 (GMT)
Received: from cpe-66-24-58-13.stny.res.rr.com (unknown [9.85.150.254])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Mar 2021 12:18:20 +0000 (GMT)
Subject: Re: [PATCH] s390: crypto: Return -EFAULT if copy_to_user() fails
To:     Wang Qing <wangqing@vivo.com>, Pierre Morel <pmorel@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1614600502-16714-1-git-send-email-wangqing@vivo.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <ffe84ace-92db-c7f5-7e66-fe3172484ec6@linux.ibm.com>
Date:   Mon, 1 Mar 2021 07:18:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1614600502-16714-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_06:2021-03-01,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103010103
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 3/1/21 7:08 AM, Wang Qing wrote:
> The copy_to_user() function returns the number of bytes remaining to be
> copied, but we want to return -EFAULT if the copy doesn't complete.
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 41fc2e413..1ffdd41
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1286,7 +1286,7 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
>   	info.num_regions = 0;
>   	info.num_irqs = 0;
>   
> -	return copy_to_user((void __user *)arg, &info, minsz);
> +	return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
>   }

LGTM
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>

>   
>   static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,

