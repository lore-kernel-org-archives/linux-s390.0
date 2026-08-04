Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20DA46AF2C;
	Tue,  4 Aug 2026 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855469; cv=none; b=cnVr4xWTxhgFy4BsBIflmfrcp/hv1tkUr+gsZawY3JJnFnR9GlXAJbgi195dLghQTed7kX9BWGJr6xoZHdvr+tcLPf18Qoww5qe3IHXCA2PWMgseNfayHRybgKQZZHr/qe7mcRtQCagBKWkWRJnyjzRsNb1oE8UROmKupvjRIU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855469; c=relaxed/simple;
	bh=xi7crpYKo4DEoaR564EzS9p0d1wDgYcdtg6n0+XqHQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAEa0DFU/LaqjBiLAVmXXI9WZF+2CASx4dUsTuWnLzfTy2RkiGGq2LMu8yurhmug4NGqx9LxyVlyx+nPiMwylQcUfDpCje4ce+dNtBovVRoD5LfBZ7kvnhSd+RW8gnzSYInygkeM+tIgC4N3tb30TOSnCCLlB5svrkjxpCPO31Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FgY5147+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FgY5147+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CpZeR808680;
	Tue, 4 Aug 2026 14:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zodpqP
	9O5jSixHkoV3XlejIcPjYt+MVxFjNf++9EoBU=; b=FgY5147+z9XsfRh0UazuFg
	WIZzujm8F7JP9PQf7v6lCC/Vok0Jeb3YwnufYdgHa8p56C8ekZVKl4MnH9j0wAJ9
	w5l1H1+v28iWS7hko7waiKEn/DtPD+TPxP/fsKYeBl4yFdaJ/Jif7CTsB5jpkHxx
	XBq/gp0oApAgx6xM2ZKW6/FgbO/Roy/J8UzibumMQhJHrvQStv9FgZauvcU//J2I
	ThRV5dKqISBxVfQVxtjwJqAwRs6kfBA7MeBOqa0Salw3Dgh8KahMyB4tevK99eBn
	nXhB6K49f9HCoWN5cU0SCfGcu7m83mm2+VEGKKFN8Kvpk2jCnMt+s7Dw0eZMsl4g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hp8r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 14:57:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674EuGXR031931;
	Tue, 4 Aug 2026 14:57:31 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhab0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 14:57:31 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674EvTrV16908978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 14:57:29 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 881A15804E;
	Tue,  4 Aug 2026 14:57:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 532E358055;
	Tue,  4 Aug 2026 14:57:22 +0000 (GMT)
Received: from [9.39.28.74] (unknown [9.39.28.74])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 14:57:21 +0000 (GMT)
Message-ID: <af5f206a-1fde-4f55-b506-c37cf168ee19@linux.ibm.com>
Date: Tue, 4 Aug 2026 20:27:19 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix socket refcount leak in
 smc_switch_conns()
To: Breno Leitao <leitao@debian.org>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
        sidraya@linux.ibm.com, mjambigi@linux.ibm.com, andrew+netdev@lunn.ch,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, pasic@linux.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
References: <20260804082800.498672-1-hidayath@linux.ibm.com>
 <anGqEX1JOYlTczQ6@gmail.com>
Content-Language: en-GB
From: Hidayathulla Khan I <hidayath@linux.ibm.com>
In-Reply-To: <anGqEX1JOYlTczQ6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEyMCBTYWx0ZWRfX8t1Dj3b8eOZu
 XJbww/V0vZVEwkuR76Xl+k3DiidfiPc8HMuzkXEHMJ0nslTsKf4AEWfePbiD79tPxW1yef+FYPo
 NMFEgQer6fIWdLrm3R6253VSlc7HLtM=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a71fddc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=xNf9USuDAAAA:8 a=EiFVIw_cQAWh6X_5SVoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEyMCBTYWx0ZWRfX6odBNOeOJA3x
 5Lt0LRW13xt1kLXE2tCl3bOsbPX1/uOVWYdhsdp31jujR89nHagIqUuLTpCgyhvQjHfB0jIBjAM
 EbwhjkB0hgMrLCNs3XWXTvsZbJs/4PQdfYWa5g4EMRVmhGJMmxr/N5kdlwj0Vz+pfrrRi1gjsd3
 2czn+Yrb36Ltw2hht4pPK8FGzfrCotTFU5IazjlT15Nb9PDPlX5m2kDiLbriKwPhmpqjY9k2j0R
 nzfhhfdHhR5XgAImvwwvD4HuCj75B3pxb11NkEeHZbwPRG1CtSifSP8JTCOGAwPVUjON0dr5W2p
 eaEvgxeyygl8xea7v6tXyERSKiHJukza4JZuvznX787RR8676Rc7zYnXdlB2DB5Yw6B1Dgyki0k
 IMcGFHxcDmKeR1jXlSV0IMys6EbL1hRUb17tLOIbzu6vCTviBy9Ql9dbAGoz8idGuQ8o4nqBcuh
 1Mm/9BXfczZUgfZOTBQ==
X-Proofpoint-ORIG-GUID: BaxNFLzFRUe70REg1hRANuGxah1NFJNk
X-Proofpoint-GUID: uQHQx0mL7HOYl_fKXiYGDB7_Cse8UaJ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040120


On 04/08/26 2:36 pm, Breno Leitao wrote:
> On Tue, Aug 04, 2026 at 10:28:00AM +0200, Hidayath Khan wrote:
>> smc_switch_conns() takes a reference on the SMC socket before dropping
>> lgr->conns_lock, so the connection stays alive while the CDC slot is
>> fetched:
>>
>>          sock_hold(&smc->sk);
>>          read_unlock_bh(&lgr->conns_lock);
>>          /* pre-fetch buffer outside of send_lock, might sleep */
>>          rc = smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL, &pend);
>>          if (rc)
>>                  goto err_out;
>>
>> The err_out label only drops the wr_tx link reference, so this early exit
>> returns without the matching sock_put().  The second error exit is not
>> affected because sock_put() has already run by then:
>>
>>          rc = smc_switch_cursor(smc, pend, wr_buf);
>>          spin_unlock_bh(&conn->send_lock);
>>          sock_put(&smc->sk);
>>          if (rc)
>>                  goto err_out;
>>
>> A leaked sk_refcnt means the smc_sock is never destroyed.  Its send and
>> receive buffers stay allocated, and for a user socket the reference held
>> on the network namespace is never released, so the netns can no longer be
>> torn down.
>>
>> smc_cdc_get_free_slot() fails when the target link goes down or when the
>> connection has been killed while the switch is in progress.  Both are
>> reachable during the link failover this function implements, so the leak
>> is triggered by the same hardware events that make smc_switch_conns() run
>> in the first place.
>>
>> Drop the reference on the early error path.
>>
>> Fixes: 95f7f3e7dc6b ("net/smc: improved fix wait on already cleared link")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
>> Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
> Reviewed-by: Breno Leitao <leitao@debian.org>
>
>> ---
>>   net/smc/smc_core.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>> index b4208cb186c5..c0027d2fe4e8 100644
>> --- a/net/smc/smc_core.c
>> +++ b/net/smc/smc_core.c
>> @@ -1148,8 +1148,10 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
>>   		read_unlock_bh(&lgr->conns_lock);
>>   		/* pre-fetch buffer outside of send_lock, might sleep */
>>   		rc = smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL, &pend);
> Do you need sock_hold(smc->sk) to call smc_cdc_get_free_slot ? Otherwise
> you can move the sock_hold() after the exit.

Thanks for the review.

Yes.  conns_lock is what pins the socket. The reference is taken in
smc_lgr_register_conn() and dropped in __smc_lgr_unregister_conn(), both
under that lock.  After read_unlock_bh() a concurrent close can free it,
and smc_cdc_get_free_slot() reads conn->killed after a sleeping
wait_event_interruptible_timeout().  Moving the hold later would turn the
leak into a use-after-free.

