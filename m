Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04363C433C1
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 12:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B362C61930
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 12:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhC2Me5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:34:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231278AbhC2Mem (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 29 Mar 2021 08:34:42 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12TCY7qB150555;
        Mon, 29 Mar 2021 08:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=whcVhMReQHlGlekds3WIWuvrBXxGmQLgC3fPH5ULlHA=;
 b=ARElFuEBI6MNLmZus0HnzbN1BJoUT6jbRcoFMUwPVg2U9qmzseWczE0xF1jLWL4eYPBC
 C6zrks2i1UeCHrQP0xBKq4K4Zf7Qas3yeZCxZB+kA6542VFqNjlW2qHSpjB+3VpxIOdZ
 4lFkZ6JET2iarl1ccGOeua89g4/C3HInIcEm9olrhLxEQNKteFg5JSce8RREG6xwBeYA
 OF+5MleS6IEkyRVLZi5ExlXMu2TlmBRzrG8keOKlBLiUjGNJVcJ092iSogBa2lh6p+Wv
 PAdPxa3Iu41YaY4fc9qmWZqp0PppQoLcA8GeV1AJuOT1b+v5Hl3yq/gFklcej86Vzfpf 9Q== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37jj8adtfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 08:34:34 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12TCLn4C032005;
        Mon, 29 Mar 2021 12:34:33 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 37hvb8hskh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 12:34:32 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12TCYU9l41091408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 12:34:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09FCB11C052;
        Mon, 29 Mar 2021 12:34:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB81611C04C;
        Mon, 29 Mar 2021 12:34:29 +0000 (GMT)
Received: from oc6887364776.ibm.com (unknown [9.152.212.155])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Mar 2021 12:34:29 +0000 (GMT)
Subject: Re: [PATCH -next 2/2] s390/cio: use DECLARE_WAIT_QUEUE_HEAD() for
 wait_queue
To:     Shixin Liu <liushixin2@huawei.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210329094019.67044-1-liushixin2@huawei.com>
 <20210329094019.67044-2-liushixin2@huawei.com>
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
Message-ID: <c8abb27b-2b4c-3484-8859-8b4482a4aa1c@linux.ibm.com>
Date:   Mon, 29 Mar 2021 14:34:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210329094019.67044-2-liushixin2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z_9keyXcNXjkzOlhkTksYZNA5hhQWkx0
X-Proofpoint-ORIG-GUID: Z_9keyXcNXjkzOlhkTksYZNA5hhQWkx0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-29_08:2021-03-26,2021-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103290097
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

For both the patches,

Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>

I will correct the description, and Heiko/Vasily will pick this up and 
will be part of the s390-tree patchset.

On 3/29/21 11:40 AM, Shixin Liu wrote:
> wait_queue_head_t can be initialized automatically with DECLARE_WAIT_QUEUE_HEAD()
> rather than explicitly calling init_waitqueue_head().

A minor checkpatch WARNING. I will modify this.

>
> Signed-off-by: Shixin Liu <liushixin2@huawei.com>
> ---
>   drivers/s390/cio/css.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
> index f01ef6325039..a974943c27da 100644
> --- a/drivers/s390/cio/css.c
> +++ b/drivers/s390/cio/css.c
> @@ -652,13 +652,12 @@ static void css_sch_todo(struct work_struct *work)
>   
>   static struct idset *slow_subchannel_set;
>   static DEFINE_SPINLOCK(slow_subchannel_lock);
> -static wait_queue_head_t css_eval_wq;
> +static DECLARE_WAIT_QUEUE_HEAD(css_eval_wq);
>   static atomic_t css_eval_scheduled;
>   
>   static int __init slow_subchannel_init(void)
>   {
>   	atomic_set(&css_eval_scheduled, 0);
> -	init_waitqueue_head(&css_eval_wq);
>   	slow_subchannel_set = idset_sch_new();
>   	if (!slow_subchannel_set) {
>   		CIO_MSG_EVENT(0, "could not allocate slow subchannel set\n");
