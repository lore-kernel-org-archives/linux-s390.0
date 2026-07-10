Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12535B636;
	Fri, 10 Jul 2026 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700455; cv=none; b=MD3ystZhZ9eGyGjuDwYAbydQUGuuX5O7xNqwF4WqoU/JvbbhJhi9OmubzbRKXhPuE98EHM3LNlJLvRauA7Db1NvvZg0xoFZYiZpjQX5w3GgHM9bFEu4qS3GgO1ZpMkfCp1YRC+DBy2t3EN2pIhGRh9rfKryxDzvw6JxWJMuzFxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700455; c=relaxed/simple;
	bh=F/PzMlD439hjs/+LtSmm1Sln4QqVW+3ZxZ3zo5M5s3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEYw/KJHtlhYlfz+KVh+q5rcMVmG7hfKYRAkbPhuvLFxygtzyKYFdPe4UqfuvdrrbmtIT3aFRcb0TYAuLifwV9ZaqMsZkK3AZbon3xPmY8Q1Cwcf/WKeb4W4bEYnxaNlSinuMrRqoRIrzV40pUnszcc4T1lPk8nEXVv5zNafsjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rfBwgqiU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rfBwgqiU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AEmT6S1406421;
	Fri, 10 Jul 2026 16:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rvypab
	OPgFIAwubdsxLV5tUUF/uP6jnR3fbYqNpCAnA=; b=rfBwgqiU7/t/Hb4AqKqZeb
	bw8wCYEnBM9sry6Coq4dDYIZK5r963Ds/1zUyxiQ6EnaI+DMu1QcxrfDb23v87QU
	XFLivW04LY9Majc7wpJasCvnbPhzC+hngUI1fYkNjqwvYVM852KlBIudkxxUgmKI
	neeEfnYdet7/cgElWpOskF5jb5vv0BkxjHJ9PStsNxBmsy/emRFM9rMTyYlYBH+7
	5SeCvGcrVDmRaMtLUbPiyjx07+UulSg/hPRU4OYQxw3ZMiM84cR0NH3aI2vxRD0i
	on0Ovaj4cn5gXn7ZRL4KfJsFQH5K6/6+bWbaHi1tv+SMlkBbdwpUq5rOatki0Urw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fafh0cwhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 16:20:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AGJhIO009610;
	Fri, 10 Jul 2026 16:20:39 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqgjk0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 16:20:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66AGKcDS27591350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 16:20:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 604855805B;
	Fri, 10 Jul 2026 16:20:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38FEE58059;
	Fri, 10 Jul 2026 16:20:31 +0000 (GMT)
Received: from [9.124.217.113] (unknown [9.124.217.113])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 16:20:30 +0000 (GMT)
Message-ID: <ce0f02ed-ec5e-4757-b95c-f8cc2645370b@linux.ibm.com>
Date: Fri, 10 Jul 2026 21:50:28 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/af_iucv: fix NULL deref in
 afiucv_hs_callback_syn()
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Cc: "horms@kernel.org" <horms@kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wintera@linux.ibm.com" <wintera@linux.ibm.com>,
        "twinkler@linux.ibm.com" <twinkler@linux.ibm.com>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "svens@linux.ibm.com" <svens@linux.ibm.com>
References: <20260709191732.124092-1-hidayath@linux.ibm.com>
 <PH0PR11MB590247B1CA37A1E9A4B4FD79F0FD2@PH0PR11MB5902.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Hidayathulla Khan I <hidayath@linux.ibm.com>
In-Reply-To: <PH0PR11MB590247B1CA37A1E9A4B4FD79F0FD2@PH0PR11MB5902.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=VebH+lp9 c=1 sm=1 tr=0 ts=6a511bd9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=EGRZ104ItT1sqjb4XsEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lBZ6gJ55hd8rUgtCX85dNJW8K3ouhM-U
X-Proofpoint-ORIG-GUID: B3MyERg9-DGZMCU4Xf_rkrHGdIZGgevS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE2MyBTYWx0ZWRfX5xaq1VDW1+bK
 p2w9+6fnw01R/AkOyuRuV+gS4yO+p/buEpAOO+73llI27oUECk4DhDdYvmshGckDZgTNKLrOsOf
 V1cwhDNesxbUFzy1VwtvRvFTRBK8OFI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE2MyBTYWx0ZWRfX/MYWQdmsHPNm
 fMe4AknV+6p/DEtKHkDYBH2mulFkHtmXK6CissaCCc1LjDwVHnGA3X8zpRX17jliwKiu1wCDsmV
 IcntUFxANKCghDSGsXSwoelzwJaiC/Ut554KHMuAQBOTbiME9wfR3JkuPKpwd6uQA99STS6DROY
 OLwfDCPxJfyQybTFwJageN5x0CJ8f9kiVQkdUKgj/xdOjo/WOkHtW6SrioHZaxPgDt9slpdS7YU
 vqaCK7mhgDsjKFBZCDMjX6kOWvxs1qoWQDEqDfeWV+lWvoi61RJgk4mk/WVgXOaVo8Hp/S6aaqO
 ijLhDGxyq5fuXoYZX5ss+uUG5qoBDsyKvzR3bVs9xLZpN6h13Yt2yZM3qoispxnwnmJElcBB6LA
 JbFJzYWAQmj3+xoUa84CWl2G0dThomJ05yTnqJhn8SbNbol6sXrBVH2UceYmZ2qmm6IVG1YrQjd
 P4B7/qElAvPRL2g58kQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100163


On 10/07/26 3:04 pm, Jagielski, Jedrzej wrote:
> From: Hidayath Khan <hidayath@linux.ibm.com>
> Sent: Thursday, July 9, 2026 9:18 PM
>
>> afiucv_hs_callback_syn() allocates the child socket with GFP_ATOMIC.
>> If the allocation fails, nsk is NULL.
>>
>> The connection-refused path is entered when the listen state check
>> fails, the accept backlog is full, or nsk is NULL. The code
>> unconditionally calls iucv_sock_kill(nsk) in that path.
>>
>> iucv_sock_kill() does not accept a NULL socket pointer and immediately
>> dereferences sk via sock_flag(sk, SOCK_ZAPPED). When nsk is NULL,
>> calling iucv_sock_kill(nsk) results in a NULL pointer dereference.
>>
>> Only call iucv_sock_kill() when a child socket was successfully
>> allocated.
>>
>> Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
>> Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
>> ---
>> net/iucv/af_iucv.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
>> index fed240b453bd..f5b1ec44b6ae 100644
>> --- a/net/iucv/af_iucv.c
>> +++ b/net/iucv/af_iucv.c
>> @@ -1872,7 +1872,8 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
>> 		afiucv_swap_src_dest(skb);
>> 		trans_hdr->flags = AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN;
>> 		err = dev_queue_xmit(skb);
>> -		iucv_sock_kill(nsk);
>> +		if (nsk)
> Hi Hidayath
>
> why not to move this check into iucv_sock_kill()?
> would prevent from potential similar issues in the future
Hi Jedrzej,

Every other call to iucv_sock_kill() passes a non-NULL socket by 
construction.

If iucv_sock_kill() silently accepted NULL, a future caller wrongly
passing NULL would go unnoticed instead of being caught.

>
>> +			iucv_sock_kill(nsk);
>> 		bh_unlock_sock(sk);
>> 		goto out;
>> 	}
>>
>> base-commit: 262b2eac463d880a664cf92af1107b4f9d84ad37
>> -- 
>> 2.52.0
>
>
