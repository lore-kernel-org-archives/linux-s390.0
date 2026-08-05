Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F37F4611C9;
	Wed,  5 Aug 2026 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932972; cv=none; b=iJjUZpAJORt1xsLnc2XmChmCS+MgkToreImXFTgbMMrvxq7D+oQEls9HxPtBdpD7TvPaMUSyh9l4p8OxKMfHiwoLTjPHmEsPLdnPpJrwMPgEmthovkFpBuiFragHANJlFKNi6dnRFUl90rQN7E3IdmZH5IYHizi3Iu0pX7h08T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932972; c=relaxed/simple;
	bh=m9nkzrznWYrZiwVsmx8wxZ+0TETSbkZ/nymGHTBFzvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsO5ho+sZxEiYvd3xxo5mK90jsU20VrMtqLV6JpmmNPB2mDiOAvqGsknxOTBefyDBJ/aJLX2+Y5V111BmRoyJdCqc+9UDzYQttPlwKIsz9BZbcT5XlwrV0WT8cahsvDyblpTBZpZoYU48a69HiJDBHCG5kcXGp5lV4mQTvEVLSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dby89k5x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dby89k5x"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675CHrat3724963;
	Wed, 5 Aug 2026 12:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sySNNJ
	RinZMJGqbiapCuiZAyRgaoBQFaLOLOeb4MFXo=; b=Dby89k5xmERBlQZd8VUBj9
	jTmMnnKeh7cmEE+T/+V6oiJ4n+RAb6V3gmM+53UH59NhzpDN/AeJvcA5/VtcGEii
	/x65ss/SoImCQIMA37V/adwwXDiVSXzlQI1As0IQfOIoqj2CefRTgMIswEaATuDX
	F1j/Aet1ysQOFAhm3/Xn8O2c5ZjsWVukKf3iSi1yG/pXn/j+fwvKLj+ChyR+U2LS
	ZHQqrJqFyYcBD7OHLubM0b61ihKjRwLtyUkukc6VgYb5Bf1K8/oE7whpKweVDWuO
	nWR+3X8XhilrIfHxR8U923D9r3WsFUjYqArP0V+B01OvZfDK3DeAMjSZ2r5Mkg+g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gakbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 12:29:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675CQImD029190;
	Wed, 5 Aug 2026 12:29:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgea99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 12:29:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675CTFjs36176272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 12:29:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 660422004E;
	Wed,  5 Aug 2026 12:29:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A87432004B;
	Wed,  5 Aug 2026 12:29:08 +0000 (GMT)
Received: from [9.39.22.189] (unknown [9.39.22.189])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 12:29:08 +0000 (GMT)
Message-ID: <1f4251f0-0ab6-4f95-9658-d06ddedfae28@linux.ibm.com>
Date: Wed, 5 Aug 2026 17:59:06 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix TOCTOU race between smc_listen_out() and
 listener close
To: dust.li@linux.alibaba.com, Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alibuda@linux.alibaba.com, horms@kernel.org,
        mjambigi@linux.ibm.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, hidayath@linux.ibm.com, pasic@linux.ibm.com,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260803070701.126339-1-sidraya@linux.ibm.com>
 <anCPZl_Rvqj2B7vI@gmail.com>
 <4157b86a-e2cb-470b-a526-137a650b9d5a@linux.ibm.com>
 <anLkl5X2xYedflyt@linux.alibaba.com>
Content-Language: en-US
From: Sidraya Jayagond <sidraya@linux.ibm.com>
In-Reply-To: <anLkl5X2xYedflyt@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5OSBTYWx0ZWRfX4lcO9a+C7+HM
 MPa18xmAeP7coRdVkrf8v6FYg+PxDw/4H0Z/W07IlAhlo7aUScElcIrijcCoNbt28qfg2PDjO7f
 hm5wVwS1zv4sCFPbdpYK505GE7jmk0+I++nfryWRZxadWW5zWvwzCHNRpcVxLzYcEMQRPcTkIWN
 Kps6HnjA1A35dVVRfJRxx9Ic6Qia9ahn/kI8ozY4niyrtmU7u5iIeoReFkwWyOo2RpQiW+7wwNK
 dglmIAmjUP7Vlu2WFsQKWUPBz3Ldmab/VQfT+zuRPN6XqctJAt8rq55EylrAUmk01Zts2ZnChp1
 zkv413j828XviVteWJoQUCUXJt3zLFe33jXtXemAOkYejakv9FeH6dHgo3DCYXWQylSDz9OpWH2
 KKmTn0Ky10b7gYWMBZT/VYgJOHtwqttVWbwfB5mwAKxVEod0Grbqm0FzSLkyTyWRyqTcqmZY0pM
 e7lCdpjH5uG70edj+Kg==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a732ca0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=SRrdq9N9AAAA:8
 a=fLt5QA0OMVFA8XJhKYoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -HHs8ai1tsGuOp9XmR5DLjugnkI_PjwP
X-Proofpoint-ORIG-GUID: 50nqUFLIcOp1fEIaBDb3SLlTb3d1CnF0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5OSBTYWx0ZWRfX8wd60mi0Vfaq
 X48P0jcHh4PIgCrBiGQnhjtY+ohlc+Yc8VtJ/39YZoQCfRWwc4l9D4Jie3PrLKN4rwgTfamcOB4
 XSFeCsFdUAQIutHsWvy7atBHf7AxCKE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050099



On 05/08/26 12:51 pm, Dust Li wrote:
> On 2026-08-04 12:52:12, Sidraya Jayagond wrote:
>>
>>
>> On 03/08/26 6:24 pm, Breno Leitao wrote:
>>>> @@ -1931,11 +1931,12 @@ static void smc_listen_out(struct smc_sock *new_smc)
>>>>  		atomic_dec(&lsmc->queued_smc_hs);
>>>>  
>>>>  	release_sock(newsmcsk); /* lock in smc_listen_work() */
>>>> +	lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
>>>>  	if (lsmc->sk.sk_state == SMC_LISTEN) {
>>>> -		lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
>>>>  		smc_accept_enqueue(&lsmc->sk, newsmcsk);
>>>>  		release_sock(&lsmc->sk);
>>>>  	} else { /* no longer listening */
>>>> +		release_sock(&lsmc->sk);
>>>>  		smc_close_non_accepted(newsmcsk);
>>>>  	}
>>>
>>> Do you need to call smc_close_non_accepted() without the lock? otherwise
>>> you can have the lock around the whole if/else clause.
>>
>> Yes, smc_close_non_accepted() calls __smc_release() in turn calls
>> smc_close_active(), which in the SMC_ACTIVE case hits
>> smc_close_stream_wait() a blocking wait that can sleep up to
>> SMC_MAX_STREAM_WAIT_TIMEOUT (2 minutes). Holding the listener lock
>> across that would stall any concurrent smc_accept(), smc_listen_out(),
>> or smc_release() on the listener for the same duration.
>>
>> The release_sock() is intentionally placed before
>> smc_close_non_accepted() to keep the critical section minimal:
>> lock
>>  check state
>>    enqueue or not
>>      unlock
>>        then do the slow close work without the listener lock held.
> 
> 
> That patch looks good to me.
> 
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> 
> 
> Two corrections to the justification though:
> 
> 1. This newsmcsk sock have never been given to userspace, so
>    smc_close_stream_wait() should return immediately. I think the stronger
>    argument for keeping smc_close_non_accepted() outside the listener
>    lock is what follows in smc_close_active()/__smc_release():
>    smc_close_final() can wait up to SMC_WR_TX_WAIT_FREE_SLOT_TIME (10s)
>    for a WR slot, and smc_clcsock_release() tears down the TCP
>    socket.
> 
> 2. SMC_MAX_STREAM_WAIT_TIMEOUT is 2 * HZ, i.e. 2 seconds, not 2 minutes.
> 

Thank you for the corrections,Dust. Both points are valid.
> 
> Best regards,
> Dust
> 

