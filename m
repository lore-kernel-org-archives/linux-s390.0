Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E897262A
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576341; cv=none; b=nwt8cXFsvwSJmJmwHJtZbAAzXnPWY1Gap+2H0BXjVTJkNTd6D9GBu/JZxM4bcB7lFyd/IV2ftXpqehibQyK9FVh2+iFp4YmI6vtoxCmd9zoGrmC5fty+v6LbuuXZYh4ttUQMR+1R71mUwCvuISfFKOc1EPrWzxiiRWrMMC7vOPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576341; c=relaxed/simple;
	bh=OfUCBHpV4KCJ5FY/vsm6RRGjTZCfCaE3wh7fqAjmDEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5u3hSMyPOP63oAcmlkpvKv1Y4IDV72dA0h/gNdlnRlck46vsEZz3JND3ri0zOqH+QTwfBrkROI1wVcr5Hbvtje/eS7U55D9nNae3GMiU7PC40aFCuADRM0RQq+4+YwBnKku+M2/tDrrW55vWKrB/gObjYeo0/rcHopnIoDOIlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NxHMhYzT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NxHMhYzT"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBVdwl1753046;
	Mon, 24 Aug 2026 12:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Rl9UDe
	uKmNise3hWbdcqR+XkfRMVwu2m6cIX4b1aLeo=; b=NxHMhYzT5K07GDUyGDPvid
	KYXeesaIMlnqZKYO+6ZZim07pngaTjbiMfCE2MoBRvvse12mhtYuOqOfgygrbrZ+
	SFsHj5+XbiIMa1utc0ROzJLYJhhkRt77UkB6jkgx/W+nMRiLiUJe4DFScjsA9N/N
	dXDSzFCaHktfiS1h6bmwJZyHq5tzM8cGLoe/b4AeiG5gYe3p7FSN8cXVIalMPOcB
	SML4RRAss+JGHUwcOTpj5TIydumssMmfG1gtVtXF1Dz/b2C+F1T2G5AKaPfoCVyJ
	H9SupXHOIN5R4EZLJz1WrCAisUiBqkwEpTdNscYpNHWdatbNoZceam8p6WJkGczg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4hc66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 12:58:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OCvIcs004112;
	Mon, 24 Aug 2026 12:58:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jnxxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 12:58:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OCwfcG21627564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 12:58:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F15B320043;
	Mon, 24 Aug 2026 12:58:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC2BC20040;
	Mon, 24 Aug 2026 12:58:40 +0000 (GMT)
Received: from [9.224.90.36] (unknown [9.224.90.36])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 12:58:40 +0000 (GMT)
Message-ID: <732e3384-34a6-4309-b3ae-a8f3eccc7dad@linux.ibm.com>
Date: Mon, 24 Aug 2026 14:58:40 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] net/iucv: send the window update outside
 message_q.lock
To: sashiko-reviews@lists.linux.dev, Bryam Vargas <hexlabsecurity@proton.me>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260821-b4-disp-3a6e8695-v2-0-37597ff723a8@proton.me>
 <20260821-b4-disp-3a6e8695-v2-3-37597ff723a8@proton.me>
 <20260822111737.8DB721F000E9@smtp.kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260822111737.8DB721F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3vD741B9jDb-JhKtm3kEK5dH6uvXLQTQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEwNSBTYWx0ZWRfX/71rpmWQdB40
 sWMC6CbmMEHWIWO3gHUv5Nwr+2cAKsEuovRFA2nlLsKyaUamdJ/IbU5JB9xq2cSnpgJ0+P/cYPs
 RKUJtv9dhUoX355rR3gj9HTq4QbPbqw=
X-Proofpoint-GUID: 3vD741B9jDb-JhKtm3kEK5dH6uvXLQTQ
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8c4007 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=UJCqotb1N0z-pNp_86gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEwNSBTYWx0ZWRfXwhax+VZfa/vW
 4RHdZYrYixLYxL0Ve6z9+7Z0fwEoZztBIEi22A5gTog6SC1snNm7vrZIOwIjx6rMNBw9McVWcAj
 ptHRWgBQ87s3jd5NEwHrPnCLUsNftAi2AZaSStu428i4yHBpkCWIxa97I78E9I1I94MoY2GRPzp
 A1bDcebs7Boch1mijudFUJa8U7eEa88yxW0MripkDvyebmp8d2MEBcml6hnKbr5mmYcfnc6TXgm
 dQCJrenUxrKOFhhYFeuUHLshgjZi9fAErFhDWG+CeTay6iXbQLzf7lwiUE3iZ9Homxy9z6pvrf3
 UCN/3sR55PmZABL2U9KasVwWPu8f0KN9qdL83GBCUKwb3CFEQQPMh7KUuxTGbGkOYW2EPuzNjiz
 VyZlp+h8o+J58V8IkmhcKxc6z3wSNTdl5MwwwK6r1+TV+OKRP1KHq5R5ztWIktqDiwmfKffGdXI
 w3kIfgBf//nh9dt4Nzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240105



On 22.08.26 13:17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] Redundant concurrent window updates cause spurious socket disconnections due to transient errors.
> - [High] Lockless modification of `sk->sk_state` to `IUCV_DISCONN` in error path corrupts the socket state machine.
> 
> Pre-existing issues:
> - [Critical] Concurrent execution of `iucv_sock_recvmsg` and `iucv_sock_close` can lead to a NULL pointer dereference of `iucv->hs_dev`.
> - [High] Lockless read-modify-write sequence on `sk->sk_shutdown` in `iucv_send_ctrl` permanently loses concurrent state updates.
> --
> 
> --- Patch [3]: [PATCH net v2 3/3] net/iucv: send the window update outside message_q.lock ---
> commit 38dc50c2f4dfcebf699da12476bf1a5fb529484e
> Author: Bryam Vargas <hexlabsecurity@proton.me>
> 
> net/iucv: send the window update outside message_q.lock
> 
> This patch moves the window update control message dispatch outside the
> message_q.lock in iucv_sock_recvmsg(). It avoids sleeping in atomic context
> since iucv_send_ctrl() performs a GFP_KERNEL allocation. A boolean flag is
> used to defer the send until after the lock is released.
> 
>> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
>> --- a/net/iucv/af_iucv.c
>> +++ b/net/iucv/af_iucv.c
> [ ... ]
>> @@ -1336,15 +1337,18 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>>  				iucv_process_message_q(sk);
>>  			if (iucv->transport == AF_IUCV_TRANS_HIPER &&
>>  			    atomic_read(&iucv->msg_recv) >=
>> -							iucv->msglimit / 2) {
>> -				err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
>> -				if (err) {
>> -					sk->sk_state = IUCV_DISCONN;
>> -					sk->sk_state_change(sk);
>> -				}
>> -			}
>> +							iucv->msglimit / 2)
>> +				send_win = true;
>>  		}
>>  		spin_unlock_bh(&iucv->message_q.lock);
>> +
>> +		if (send_win) {
>> +			err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
> 
> [Severity: High]
> Because atomic_read(&iucv->msg_recv) is checked inside the lock, but the
> counter is reset later inside afiucv_hs_send() without holding
> message_q.lock, can multiple concurrent calls to iucv_sock_recvmsg() set
> send_win to true and trigger redundant window updates?
> 

No, because of the previous patch that is mentioned as a precondition.


> If redundant updates are sent, could transient send buffer exhaustion cause
> the socket to unintentionally hit the error path below and disconnect?

I'm not sure I understand the question. But I think this works as designed.



