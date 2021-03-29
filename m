Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A96C433DB
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 12:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6860861930
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 12:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhC2Mfa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:35:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231260AbhC2MfB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 29 Mar 2021 08:35:01 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12TCYlIo076619;
        Mon, 29 Mar 2021 08:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=f0wLENhgCKs5NZ8Pb14N12AT2LvU2p9rw10BggHXs3U=;
 b=SYyKhEUvuaHdbL2L7l16h7G2o39Y7g19tABnnHcis48hiQXaPJ8UC5Nmr4jQbw3x5s7X
 6Iq/xHUl1nL1h1ETFv9nGWJvu7jAv3XQy/60LWm3oi30E0FG4isXa+X4+93teJR098M+
 S9hN88VQMyGZMmTEG5KuhWpXShZPGyvGlL5IDlkQIsipr1J0cdVWnapCgxWQA+dVRXyW
 cauXwU/N+vP8XC+Uk8xe6p4nb//rgLmABN13XiKDKhVV2WitoKCFbIaSXf+eTkbyeJiE
 wH83CpIr7Q7yuhxQbuRpe4lQCrgu8OmoEgtxc8lSoQJpyzctOPwtjNUa3s6o5MCIs+FP Kw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37jhm4p693-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 08:34:56 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12TCNFe3012222;
        Mon, 29 Mar 2021 12:34:54 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 37hvb89sus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 12:34:53 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12TCYpIS41287960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 12:34:51 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16DF511C04A;
        Mon, 29 Mar 2021 12:34:51 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3CB611C050;
        Mon, 29 Mar 2021 12:34:50 +0000 (GMT)
Received: from oc6887364776.ibm.com (unknown [9.152.212.155])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Mar 2021 12:34:50 +0000 (GMT)
Subject: Re: [PATCH -next 1/2] s390/cio: use DEFINE_SPINLOCK() for spinlock
To:     Shixin Liu <liushixin2@huawei.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210329094019.67044-1-liushixin2@huawei.com>
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
Message-ID: <6f2f4aa6-de5a-118e-7380-3672129ee3e9@linux.ibm.com>
Date:   Mon, 29 Mar 2021 14:34:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210329094019.67044-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gnkZjr6gY5aw3ajwjyHRxzheqhTprqGK
X-Proofpoint-ORIG-GUID: gnkZjr6gY5aw3ajwjyHRxzheqhTprqGK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-29_08:2021-03-26,2021-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290097
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Thank you.

Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>

On 3/29/21 11:40 AM, Shixin Liu wrote:
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().
static spinlock
>
> Signed-off-by: Shixin Liu <liushixin2@huawei.com>
> ---
>   drivers/s390/cio/css.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
> index 253ab4e7a415..f01ef6325039 100644
> --- a/drivers/s390/cio/css.c
> +++ b/drivers/s390/cio/css.c
> @@ -651,13 +651,12 @@ static void css_sch_todo(struct work_struct *work)
>   }
>   
>   static struct idset *slow_subchannel_set;
> -static spinlock_t slow_subchannel_lock;
> +static DEFINE_SPINLOCK(slow_subchannel_lock);
>   static wait_queue_head_t css_eval_wq;
>   static atomic_t css_eval_scheduled;
>   
>   static int __init slow_subchannel_init(void)
>   {
> -	spin_lock_init(&slow_subchannel_lock);
>   	atomic_set(&css_eval_scheduled, 0);
>   	init_waitqueue_head(&css_eval_wq);
>   	slow_subchannel_set = idset_sch_new();
