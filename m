Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD1C395D86;
	Wed,  9 Sep 2026 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936548; cv=none; b=Mg2XBbsfSYq7jEiapnP+/cuf7Jpqq5xd5TaXQMJRLRWXgONammK5UGPcIo/GNkOnhpSCHOl/ENu8kWMeJ6BaqrLJe82PtkYV0GkyiHDFgc9mqGhVPMSJkmhkqZG/2KcyqyMvNu76OBP7rWJ2RNErZcZ7Qc8+2o/zu7km3BCkAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936548; c=relaxed/simple;
	bh=OBtG8QbcJW8hqevGhCFagjSq4V01XIZ2kJpcKBWj808=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i55FuIcUr+Cx/GVtOPXRVOoGSY3Dy5k3J8zg7auke2tc3Y8j8+xIlVgXIuqljAG+hv/8zKB0ERIr5obxER1VyT4nYADwL9dKNkMiVAqIJDlE7/ZSAvWIUs+GaPeUNtTySQs7BsEQo3p9ucrGdNbVnnYlAQS2qJUrgurDube2TiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b1eN0GtE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b1eN0GtE"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1gd32299394;
	Wed, 9 Sep 2026 06:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XH+VVh
	uwro+MJuDC3rKtOPY+m8c2hCjMO6nFauQd0lY=; b=b1eN0GtE7ew4zGmO16Wo/s
	1XKf4Y8a9UQrBbNu+57hi0/+gCxI1ff7s3bACcrkBOrVDUR/J+iKTVS+bnr83kPV
	4Z1QWWr1crflW9/E5N5VF2Xik76Mh/AKvqH1sKF+b4IoMBMVCX+dSK4pPuVKfu+y
	o1KnTTCiLc8BM6hwhSRFXZGPv1nPyyDaLNEOWafAao9avRYxpSOFaNng4kTX+Doz
	JOj410hhIHgs8Q1GrQriqKnmhWr3qAlI3Of8msnvi/dkH4qASIz8QOMg5k4tmre/
	pJPMxJk5luDoJYc/LMgc1IwWV7NFYsvAi/8Y/Axs3RssoDaP+CMFaUUV2wnq2PoQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhf3u1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:49:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6896fCtB007032;
	Wed, 9 Sep 2026 06:49:01 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03yghj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:49:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6896n0rn29491950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 06:49:00 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EA8B58059;
	Wed,  9 Sep 2026 06:49:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E2A95805F;
	Wed,  9 Sep 2026 06:48:57 +0000 (GMT)
Received: from [9.123.7.228] (unknown [9.123.7.228])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 06:48:57 +0000 (GMT)
Message-ID: <3991782b-7a63-4bc9-94c2-02b3f9173586@linux.ibm.com>
Date: Wed, 9 Sep 2026 12:18:55 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/smc: fix abort_work termination in
 smc_conn_free()
To: sashiko-reviews@lists.linux.dev
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260907114721.1303498-1-hidayath@linux.ibm.com>
 <20260908114743.481841F00A3A@smtp.kernel.org>
Content-Language: en-GB
From: Hidayath Khan <hidayath@linux.ibm.com>
In-Reply-To: <20260908114743.481841F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aIk8z6nDdfstJQ-LeJyEKGBnd-oRlJ8O
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa1015e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=YUeID6y6YfqAmT55ojMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA3MiBTYWx0ZWRfX81tiVD2Fr5oj
 yic1yEWo2CYhf7lC/cUIc9al/0BJ0/U7CsAtSyUZ0T+/TQj1mHO7ibW1A/lGZU4w/EyYOxUTnO5
 SokBCU7I4ghDz454bEchQbwJKQHp1d8=
X-Proofpoint-ORIG-GUID: aIk8z6nDdfstJQ-LeJyEKGBnd-oRlJ8O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA3MiBTYWx0ZWRfX58ZYMAzx8asR
 bMdGSu4mVFM3q1M9Y2bqVNDeDrl26Ps4Rt0m0SlRkLToFlEzfric+kIpbGxYGNJ1DI5dfJrR9M1
 GVPms2xoXHmsrRfwKDHF98fLaLB/lkTAQlEgz4ku04659yMwmsgIN/2KytP2TKrivPSwrpg+l6/
 1cGvNjWzxf2l4VYrh/R/rLhhJqx7htoBxHRyMuHDdsABmz/lN1ETXv2UR5hbZPC/lB14qqc+aAP
 2Iyqe243IJxcZV7NherhB7u8wUlVTr6eQh6CzjzChUaXGuyXIsKgdCLapYXgEPWgmg9DfKGLSz+
 vVUeDXWTfE/t/3U8EHxZ//0QXg0hOw+XFELlx9gcESL4+JboL28M9GBpxMEO4peYcQ8XK3vSMCp
 K6oqaeqzM/bXWWer3wjemdSpwMzj+xK26oMMcY7IiQO7jAGmE95j8r/gSOwnG0CjwC8WuGBFZrn
 z8EnRqihV6caZTxYUUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090072


On 08/09/26 5:17 pm, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [Critical] Late-queued `tx_work` can execute on a freed socket because it does not hold a socket reference, causing a use-after-free.
> --
Thanks for the Sashiko AI review. The finding is correct.

tx_work is the only one of the three connection work items with no socket
reference:

   close_work   sock_hold smc_cdc.c:420   sock_put smc_close.c:444
   abort_work   sock_hold smc_cdc.c:324   sock_put smc_core.c:1754
   tx_work        none                                  none

The link group holds a reference while the connection is registered, which
is what hides this. smc_conn_free() drops it in smc_lgr_unregister_conn()
and never cancels tx_work - it only cancels abort_work - and the link
group usually outlives the socket, so lgr->tx_wq is still there to run an
item that was queued late.

Worth noting the fix in this patch does not transfer. conn->freed works
for abort_work because abort_work holds a reference, so the socket is
alive and the flag is safe to read. tx_work holds nothing, so by the time
it runs there may be no conn to test. It needs the missing reference
rather than a guard: sock_hold() at the three queue sites, sock_put() in
smc_tx_work(), and the reference returned at the cancel sites that report
they removed a pending item.

I will send that separately, since it is a different work item and a
different fix. This patch is unchanged.

Thanks,
Hidayath
>
> commit ea8d2d358addfe3a2e07acf0170476ee1325ff01
> Author: Hidayath Khan <hidayath@linux.ibm.com>
>
> net/smc: fix abort_work termination in smc_conn_free()
>
> This commit addresses deadlocks, reference leaks, and late-queued work races
> related to abort_work in smc_conn_free(). It drops the socket lock around
> cancel_work_sync() and uses a freed flag to prevent late-queued work from
> processing a destroyed connection.
>
> Link: https://lore.kernel.org/netdev/20260806081549.595001-1-hidayath@linux.ibm.com/
>
>> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>> index 04aedd957543a..9a109eae73b92 100644
>> --- a/net/smc/smc_core.c
>> +++ b/net/smc/smc_core.c
> [ ... ]
>> @@ -1276,8 +1295,7 @@ void smc_conn_free(struct smc_connection *conn)
>>   			smcd_buf_detach(conn);
>>   	} else {
>>   		smc_cdc_wait_pend_tx_wr(conn);
>> -		if (current_work() != &conn->abort_work)
>> -			cancel_work_sync(&conn->abort_work);
>> +		smc_conn_cancel_abort_work(conn);
> [Severity: Critical]
> This is a pre-existing issue, but while fixing the exact same design flaw for
> abort_work, does this leave tx_work vulnerable to a similar late-queue race?
>
> If a local user closes an SMC socket, smc_close_cancel_work() cancels tx_work.
> However, before the socket is fully destroyed, a remote peer sending a CDC
> message (or a local user reading spliced data triggering
> smc_rx_pipe_buf_release()) can cause the incoming message handler
> smc_cdc_msg_recv_action() to call smc_tx_pending(). This can re-queue the work
> after it was cancelled:
>
> net/smc/smc_tx.c:smc_tx_consumer_update() {
>      ...
>      queue_delayed_work(conn->lgr->tx_wq, &conn->tx_work, SMC_TX_WORK_DELAY);
>      ...
> }
>
> Because tx_work does not hold a socket reference, it can be queued late and
> outlive the socket. If the socket destruction completes and frees the socket,
> and then tx_work expires and executes, it will dereference the freed socket
> memory:
>
> net/smc/smc_tx.c:smc_tx_work() {
>      ...
>      lock_sock(&smc->sk);
>      ...
> }
>
> Could this lead to a use-after-free if it is reliably reachable by a local
> unprivileged user via splice() or by a remote peer sending timed CDC messages
> during socket teardown?
>
>>   	}
>>   	if (!list_empty(&lgr->list)) {
>>   		smc_buf_unuse(conn, lgr); /* allow buffer reuse */
