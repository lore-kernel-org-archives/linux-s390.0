Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5446B3655F1
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783617483; cv=none; b=oWtczlfJPmyIYc6Atr1oib4qbZj4C14/WFoCt9z1diYARb9hn8aTX/YlO+X5bIOrlg4MTP/FpmtrayZSpC8yHBgyG7dGhzi88LbyqUjrlzvlZdHwfwmTInLLvTDfiYyj67RY2tpN1DW6UVhv8Rg7i5fKJRKih2fvvsU/rijVLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783617483; c=relaxed/simple;
	bh=HbgxIQVvGQge9wsEV+ID6C+lwO/aq1D+JIJTvYxaVvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjmhqqCCACy0K97sEa5dEbM9tHfCZPk0PZV5PmzHMP+YyVcpBhKQ+bkB1uQkTb2WhXh59x7QtBuhTXVmk/f/S3OU6AZgvTWxjTyFvU1/Od1ganqIMMXmfHAXGGTicB3qlYPF3er94OnFWdzKAlL0x3muFCKyaDPcDdU1XWSM2Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eB8MJsBA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eB8MJsBA"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669GoFnX2880084;
	Thu, 9 Jul 2026 17:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bK4PTm
	VSvQLtKnImQ9CPpDWo785JHDdO2dToUg/S0xg=; b=eB8MJsBAAN+Tcd1sVt3Ns2
	i/mfYpTnl5e/gEMRFyqCOZoObZufeNkD4guCsdzRBOZwMaQiSOhj+ahDH0vAdK9f
	p0vQe3Q9MaIMOd7m7G7YB/Ul04lJNFCoZJJi1QxiZLRBtw84rMQYP6/jKpY5nv0S
	fuTHVkg/mM+VSIK4JgZ6LP/HuuYG12v6AgKgk1an7lCiGcCsL6mrjR/NCghZYG8P
	3YjttFO0Z68TQ8Fu5No7hvtlyLxRb1/hypRIVqgBuyFzsTSJuKap4TKNXq55X3Kp
	SYTt2hacghVx7n5TQljGpyv7SWMxuD3Y+ADqgafP8GKFVXBlTp6VOSg3qkRlzC1Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknt9gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 17:17:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669H4cUE009949;
	Thu, 9 Jul 2026 17:17:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqgdxrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 17:17:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669HHjvb38339016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 17:17:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 789442005A;
	Thu,  9 Jul 2026 17:17:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EEDA2004B;
	Thu,  9 Jul 2026 17:17:45 +0000 (GMT)
Received: from [9.111.160.7] (unknown [9.111.160.7])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 17:17:45 +0000 (GMT)
Message-ID: <b524ae17-9fe5-4270-bb8d-3e411ef683e5@linux.ibm.com>
Date: Thu, 9 Jul 2026 19:17:44 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/iucv: take a reference on the socket found in
 afiucv_hs_rcv()
To: sashiko-reviews@lists.linux.dev, Bryam Vargas <hexlabsecurity@proton.me>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, Hidayath Khan <hidayath@linux.ibm.com>
References: <20260705-b4-disp-fc79c0dc-v1-1-d2cdcb57afa9@proton.me>
 <20260707032441.B1FB31F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260707032441.B1FB31F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4fd7be cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=mpG3tCo3JFPGy_rZ:21 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VwQbUJbxAAAA:8 a=mJcjGnY3pr7I_6ufGOQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VWMUhkT7r8-ws6wl3HKVO9WD32o1xS2R
X-Proofpoint-ORIG-GUID: VWMUhkT7r8-ws6wl3HKVO9WD32o1xS2R
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE2NCBTYWx0ZWRfXyjszKf11lMKo
 eQWU3FVm5puUEDcLJa1i6VkwlbEQ3ve3cggSxOOk44KmzZtGEkiFwrchyn8nNvXhbOyys37M3F3
 ggrV23m9Vbqq5lw37FwKV70h7uNLYu4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE2NCBTYWx0ZWRfXwzBTYai0E8U7
 9X36QJ39dw6A3Tz5ceD9wBd1Nj83dudkntDfZyTWBUSlGoGy7A2UYXPRqYadCD2r7sHlKWrSiEW
 S0NKyt4pOiH9SVahZ6W01FDmeaHnjj/Ud9uzBwKWhof+HJhpKx3K3HQPCVMXwKX3rad5mVcGwxh
 dbDSfqmnZDX3XoOv8gRKFoQVK7TqqvyNG0Z2uDi5izt0TJzE1DNiW0+TA6IPnSUnYi4czdi4QW8
 +Laanu62+/xWl1Co94AFxm0CJhhyCFZBEtwccwcbw0mOOC8iIEo6OWbtsEO67EfOQSIXBAO1Lzc
 X1ubXcAzCBMVhp5Oe6uuVB6a8/+V9j4rhVNukVwv/pNj2GGo7so8H9rgHRF5EimYghPY3WgAqFG
 Qz2AsbPx5jiNehJb0kEZOonYtJHmV2rEHc2/VYPFXnsOxH256voKqUMAKG71wnNbECV10Dql56C
 ddSMgGXkVOM8hKXJDRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090164



On 07.07.26 05:24, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This is a pre-existing issue, but does modifying the socket state from a
> softirq context corrupt the socket state machine?
> 
> Since this handler runs in softirq context when network packets arrive, it
> acquires the socket spinlock and directly mutates sk->sk_state. 
> 
> If a user process is concurrently executing a system call and holds the socket
> mutex via lock_sock(), does bypassing the backlog mechanism by failing to check
> sock_owned_by_user() cause race conditions?
> 
> [ ... ]
> 
>> @@ -2089,6 +2089,8 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
>>  			}
>>  		}
>>  	}
>> +	if (sk)
>> +		sock_hold(sk);
>>  	read_unlock(&iucv_sk_list.lock);
>>  	if (!iucv)
>>  		sk = NULL;
>> @@ -2138,6 +2140,8 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
>>  		kfree_skb(skb);
>>  	}
>>  
>> +	if (sk)
>> +		sock_put(sk);
>>  	return err;
>>  }


I think sashiko is right, this patch does not completely close the gap.
See my commit message for
f558120cd709 ("net/iucv: fix use after free in iucv_sock_close()")
Iiuc the socket locking in AF_IUCV is incomplete in general.

Bryam, would you like to try to update the socket locking in AF_IUCV altogether?
Otherwise Hidayath or I can take that task.
