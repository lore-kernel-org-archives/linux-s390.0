Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2DDC197A0
	for <linux-s390@archiver.kernel.org>; Fri, 17 Nov 2023 12:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjKQM2X (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 17 Nov 2023 07:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQM2W (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Nov 2023 07:28:22 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7D0D8;
        Fri, 17 Nov 2023 04:28:19 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHBtQa9021504;
        Fri, 17 Nov 2023 12:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=79W9Ejnet1jcKo8Z3Q4GAA3i2uZB1gpHYc7xykvLioM=;
 b=Qpe8IdUDR+jMDzvyBLsViXi9i04doi1yaW/uNa7lyIeKU32qBsU2xoG2wcnbLnIzfHzS
 KIaeh33NAkV4Tg3ZW81+/rEDs+nJW67ff59DtYCTRQVb/dLrHdqcNJjt/zOLTbVcDbEi
 fi3HL074ZdfScv6jQ31Jz0PFMAxRtMQZHxaFf9pNVhrKQLZ5uGxh0a0Mk3X8AEZMoDmB
 Kv+gvISOskq8rLCEG4Mee1cNJBnFeW1GpOs+wPYLFB5tUcrOFNXmvokesB99/UlflQvt
 nZXmggIgMLIU5gjvvHR8xopY1c7cAxy74ov/ELoQ0b/EZExvzTT2yhcvQ7Jegtiwq+cX cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ue7qkh79e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 12:28:02 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AHCKW0K009098;
        Fri, 17 Nov 2023 12:28:01 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ue7qkh78s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 12:28:01 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHAY4lX009953;
        Fri, 17 Nov 2023 12:28:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uapn259yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 12:28:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AHCRwfL18154092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 12:27:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01E0920043;
        Fri, 17 Nov 2023 12:27:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AEFA20040;
        Fri, 17 Nov 2023 12:27:57 +0000 (GMT)
Received: from [9.171.55.244] (unknown [9.171.55.244])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Nov 2023 12:27:57 +0000 (GMT)
Message-ID: <422c5968-8013-4b39-8cdb-07452abbf5fb@linux.ibm.com>
Date:   Fri, 17 Nov 2023 13:27:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net/smc: avoid atomic_set and smp_wmb in the
 tx path when possible
To:     Li RongQing <lirongqing@baidu.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.co,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, dust.li@linux.alibaba.com
References: <20231117111657.16266-1-lirongqing@baidu.com>
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20231117111657.16266-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GygiFs7P9L85WPoq4PTgYURZGCSIn7zC
X-Proofpoint-GUID: HUg1AYg3RxzhFP1_9zVuo1u8vMIcMhxO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_11,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170092
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 17.11.23 12:16, Li RongQing wrote:
> There is rare possibility that conn->tx_pushing is not 1, since
> tx_pushing is just checked with 1, so move the setting tx_pushing
> to 1 after atomic_dec_and_test() return false, to avoid atomic_set
> and smp_wmb in tx path
> 
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> diff v3: improvements in the commit body and comments
> diff v2: fix a typo in commit body and add net-next subject-prefix
>  net/smc/smc_tx.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
> index 3b0ff3b..2c2933f 100644
> --- a/net/smc/smc_tx.c
> +++ b/net/smc/smc_tx.c
> @@ -667,8 +667,6 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
>  		return 0;
>  
>  again:
> -	atomic_set(&conn->tx_pushing, 1);
> -	smp_wmb(); /* Make sure tx_pushing is 1 before real send */
>  	rc = __smc_tx_sndbuf_nonempty(conn);
>  
>  	/* We need to check whether someone else have added some data into
> @@ -677,8 +675,11 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
>  	 * If so, we need to push again to prevent those data hang in the send
>  	 * queue.
>  	 */
> -	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing)))
> +	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing))) {
> +		atomic_set(&conn->tx_pushing, 1);
> +		smp_wmb(); /* Make sure tx_pushing is 1 before send again */
>  		goto again;
> +	}
>  
>  	return rc;
>  }

It seems to me that the purpose of conn->tx_pushing is
a) Serve as a mutex, so only one thread per conn will call __smc_tx_sndbuf_nonempty().
b) Repeat, in case some other thread has added data to sndbuf concurrently.

I agree that this patch does not change the behaviour of this function and removes an
atomic_set() in the likely path.

I wonder however: All callers of smc_tx_sndbuf_nonempty() must hold the socket lock.
So how can we ever run in a concurrency situation?
Is this handling of conn->tx_pushing necessary at all?
