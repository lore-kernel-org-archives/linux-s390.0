Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B61C4332F
	for <linux-s390@archiver.kernel.org>; Thu,  2 Nov 2023 20:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjKBUml (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 2 Nov 2023 16:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBUmk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Nov 2023 16:42:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80633181;
        Thu,  2 Nov 2023 13:42:38 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2K7Our019191;
        Thu, 2 Nov 2023 20:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : cc : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6T2zyMbjK1cZjAPB5KZIio/2H5h9yh3osA1ZwvHqBNM=;
 b=DI5kpa0wjyCc0khDQO4v0u1cZcRthGGEGzZFbN8kVu+viRJ1ww/eg33jYcTiniUpm567
 7phin9+dsCDkfzlFHJizPJ4kLUh616zczkUxhKwkV9Sp0iAHc8IRHawcl9d/KCu06gO6
 eLbF5ALvmMRb174ADnxCnpt4Z6/jkp3gKZytsb38CP60KskVDANoAom4IijqBiN0pGSt
 Kj29yDNT/Rjj8+2UzURm/auVNkDV6HEfyR1gjZ/JPqyWggMpf2bsIO+id4uWWrzKbRt9
 MN8FhitNR3d5f90MUXgIIK9Gr5XDLqOk6WYgwMDzyiE1QGUa96/kX3b2PxPWpANLMPyN 6A== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4jhb9088-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 20:42:30 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2J3w6M011286;
        Thu, 2 Nov 2023 20:42:29 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1eukgy4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 20:42:29 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A2KgSKa46072402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Nov 2023 20:42:29 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA54A58058;
        Thu,  2 Nov 2023 20:42:28 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B33D5805D;
        Thu,  2 Nov 2023 20:42:28 +0000 (GMT)
Received: from [9.171.80.36] (unknown [9.171.80.36])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Nov 2023 20:42:27 +0000 (GMT)
Message-ID: <4b1c9303-9ad1-42f3-a1a2-b9ccfcafd022@linux.ibm.com>
Date:   Thu, 2 Nov 2023 21:42:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/smc: avoid atomic_set and smp_wmb in the tx path when
 possible
Content-Language: en-GB
To:     Li RongQing <lirongqing@baidu.com>
References: <20231102092712.30793-1-lirongqing@baidu.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20231102092712.30793-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vQOBN3Z0hfpzgLBfQlDo9MBCzKCLGO83
X-Proofpoint-ORIG-GUID: vQOBN3Z0hfpzgLBfQlDo9MBCzKCLGO83
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=687 malwarescore=0
 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0 impostorscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020168
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 02.11.23 10:27, Li RongQing wrote:
> these is less opportunity that conn->tx_pushing is not 1, since
> tx_pushing is just checked with 1, so move the setting tx_pushing
> to 1 after atomic_dec_and_test() return false, to avoid atomic_set
> and smp_wmb in tx path when possible
> 
I think we should avoid to use argument like "less opportunity" in 
commit message. Because "less opportunity" does not mean "no 
opportunity". Once it occurs, does it mean that what the patch changes 
is useless or wrong?

> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   net/smc/smc_tx.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
> index 3b0ff3b..72dbdee 100644
> --- a/net/smc/smc_tx.c
> +++ b/net/smc/smc_tx.c
> @@ -667,8 +667,6 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
>   		return 0;
>   
>   again:
> -	atomic_set(&conn->tx_pushing, 1);
> -	smp_wmb(); /* Make sure tx_pushing is 1 before real send */
>   	rc = __smc_tx_sndbuf_nonempty(conn);
>   
>   	/* We need to check whether someone else have added some data into
> @@ -677,8 +675,11 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
>   	 * If so, we need to push again to prevent those data hang in the send
>   	 * queue.
>   	 */
> -	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing)))
> +	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing))) {
> +		atomic_set(&conn->tx_pushing, 1);
> +		smp_wmb(); /* Make sure tx_pushing is 1 before real send */
>   		goto again;
> +	}
>   
>   	return rc;
>   }
I'm afraid that the *if* statement would never be true, without setting 
the value of &conn->tx_pushing firstly.
