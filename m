Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF89427F8E;
	Tue,  4 Aug 2026 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828163; cv=none; b=M9W2Smm3dJ64wSKj6qFL/BKJ/rSCvjfk2HDopqzJPlW67tqymYNZelcg1YitRqn6+9MAoqVPo2sMdv7v2sX6XMSiQDflVpBnOTwXfR9G3ovI064IQtHjj566715zfNJN5H9sBpaVBvMepC9S3ehZMoVOa/txGbpkK4pQthkUpc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828163; c=relaxed/simple;
	bh=4eZ1ChsdZfuADYUBMXIjeELYu0ookRGAdOy86Tqj7Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAzqVxjfyJPs3I/UPwD5iLc8msDWC1xIltF7Q7ly5of8Bukt/wwzLvL7+mTuDz/l6EshD4bMdw4vKb3QREd5/DzXsSUfU6o5rmpxh5QYApEsYBadXU9n5xCNBCDijhI5bn56mdzmATTZHhN+vEfkSB6QVGFY3693Z6zyhy4Vfck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b9YQZgVp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b9YQZgVp"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741HZEV3631240;
	Tue, 4 Aug 2026 07:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7GYmKx
	fnRL53jg9ypz5OQKOxFf1+h4cNAuNN/sI9npM=; b=b9YQZgVpm+w7tnYdkWpm/7
	tJk3LmjtKCv1J3VBodfQzryhYSk/G3ty2U3ULsnC87wjwwoF/9If7rMhzfxSavwk
	m2Pp3ww2fXBoL0ZZwDcXAe33cB60ClkNvk9ANXJPk6/3dqt3mJ6RsK2JkKiCnYqo
	66Xi8CeRMAacOCuzzX5oywomgLU8TVxVrl+vZyidOgp66HpybENw4FDQHGAbhLUy
	mCzQa7LA/45xrRAQpodpUkBSs7ml7GXzxqGWlQ8g2k3OryusMpcUCwR0WsMV0ZI7
	RysRosmVgtsuJdaoRBgUuFpxL5MAfNXopWRiMBMPv9N0TmJtBqOWJO//oCNvf+pQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3vn7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:22:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6747BH9I003945;
	Tue, 4 Aug 2026 07:22:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh8uy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:22:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6747MJMM49873168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 07:22:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49B682006A;
	Tue,  4 Aug 2026 07:22:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08A8A2004E;
	Tue,  4 Aug 2026 07:22:14 +0000 (GMT)
Received: from [9.124.213.112] (unknown [9.124.213.112])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 07:22:13 +0000 (GMT)
Message-ID: <4157b86a-e2cb-470b-a526-137a650b9d5a@linux.ibm.com>
Date: Tue, 4 Aug 2026 12:52:12 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix TOCTOU race between smc_listen_out() and
 listener close
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, horms@kernel.org, mjambigi@linux.ibm.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
        hidayath@linux.ibm.com, pasic@linux.ibm.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20260803070701.126339-1-sidraya@linux.ibm.com>
 <anCPZl_Rvqj2B7vI@gmail.com>
Content-Language: en-US
From: Sidraya Jayagond <sidraya@linux.ibm.com>
In-Reply-To: <anCPZl_Rvqj2B7vI@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a719331 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=0c7JSOZnUW73pauj2eQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UT3RS2yl8Cfv-RKicFDjqZnTW3Selw8g
X-Proofpoint-GUID: f-HNfwTnAgcWqMgmecLoJ9V4KzeZHNrH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfX+yatZfjGd9Lt
 Dus/VqTm4cVmUhoyqKhfb9dEl7kJjIhGCrfJrrhbgTqf30UlzNd7WWQg7knpFHkBBmzAicVnzWj
 nlBQl5JexgH2/TRTbHLRJqbSWCnBUco=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfX8a1gMdrV0lRt
 nVMshS3RvXe+YS3CUu5x7mvxLA5naRW9bFoxETMY/XKFG9Xc34IRdUsCf0LW0J3RQAxvlX3gkbX
 87//bwKGoLt479lvSqQlREBCBjoAQPOpEit3q1uG3Vlv+fhHxuFhlUHQhO6QzbP48F5RZK45lsB
 pHi6od0ufmloIk90/USZtngDtk7xgM0/TaQgk15oqCxBvBLLGqwqAzST5byXOMG6IQKm4FaaAZ8
 1s7IHLn7AmVcfadP7S2KovJ6TZkyIeH53U8TuPkt4DktVV7CXNdewkkGaG5D0GudV0m7pGC+/p8
 b1C1nJ7Cl7zx7GbIT1pwF2QXTSz6NHp9CUastfbUK2175rAKFpN+ovFiGeLxOHfYbTMfbg8QXZK
 OQ1nkEIU3VjKsq7XrWZKNbakxZEvb1upSqtkm01HAcPTy+zJ2bj08yKManuUH6ckyFjAjGmRVCA
 MF4SI2+Xd+C0cOKbIDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040057



On 03/08/26 6:24 pm, Breno Leitao wrote:
>> @@ -1931,11 +1931,12 @@ static void smc_listen_out(struct smc_sock *new_smc)
>>  		atomic_dec(&lsmc->queued_smc_hs);
>>  
>>  	release_sock(newsmcsk); /* lock in smc_listen_work() */
>> +	lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
>>  	if (lsmc->sk.sk_state == SMC_LISTEN) {
>> -		lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
>>  		smc_accept_enqueue(&lsmc->sk, newsmcsk);
>>  		release_sock(&lsmc->sk);
>>  	} else { /* no longer listening */
>> +		release_sock(&lsmc->sk);
>>  		smc_close_non_accepted(newsmcsk);
>>  	}
> 
> Do you need to call smc_close_non_accepted() without the lock? otherwise
> you can have the lock around the whole if/else clause.

Yes, smc_close_non_accepted() calls __smc_release() in turn calls
smc_close_active(), which in the SMC_ACTIVE case hits
smc_close_stream_wait() a blocking wait that can sleep up to
SMC_MAX_STREAM_WAIT_TIMEOUT (2 minutes). Holding the listener lock
across that would stall any concurrent smc_accept(), smc_listen_out(),
or smc_release() on the listener for the same duration.

The release_sock() is intentionally placed before
smc_close_non_accepted() to keep the critical section minimal:
lock
  check state
    enqueue or not
      unlock
        then do the slow close work without the listener lock held.
