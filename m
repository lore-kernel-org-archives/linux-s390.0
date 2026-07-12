Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71B52D6E58;
	Sun, 12 Jul 2026 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783842993; cv=none; b=p8VzhXEqngidMzxG2SEXsU9Wgq2gZ1UXKb78ftQBz4CD8RLByoIKpcR4gBn2iLqTJb2C57s/kvg6jF9r+hW/1jbIyrT/asp1ufqkhNHUHvIr5zlymXYcqScc9r+Xm/6Iswk7g5MJzWJsWe42a2tjODsQTOrm+N64jz3aMzwJwnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783842993; c=relaxed/simple;
	bh=E76YgbBqphZJxoUlTTDhX/IVFLNpuvLmJmgSb/GsMKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gtm6zJxxUZ8g7QCK6V2AmIcUQZuYY6YkWoQksv6+XXTiT7VLymKbGQWZnUuEbs8n2C7vdj6n39cCS6a9QoWiipnMo9kuSE5p/94EueQOKGfp7oWgvIkvSxs5zwI/XVuOeGjNx2d9wrOvCtNPTHy+LTQR+bEqdCGjO1wu8Ky4IbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=algb8nrN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="algb8nrN"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66C7g4TO3223788;
	Sun, 12 Jul 2026 07:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fOgQYH
	Ssc9X+0RUE+IcOk6pdTZOJpa3YnaBn0GjQnN4=; b=algb8nrNtYcBaZDo4bGUb6
	KjRG6wrtd+rAa+CEqxYywQisZshxWmzAv97TtrzWe5rWV4jldnQkBiVN71qhVL+9
	2Nq2erM860YPNeRvfrn9D/lmumKvZnUBudV6h+njeRKs/xg4bGy4W33bshgHnLtI
	oDPTXaZ2XjxziUgh+FcDLq3uyQ+3w9/AOKB0vne3ZzBj7JFjLRJCGAIsTOG8Le+f
	0619+OEJ4teiv9kVJoOz65pkDVvp5MfNN0fiCKygjL2zfGoTPt0PVuhkmIK2XPxn
	OnUxFnCQyWm2KGYZOEWnTJEJ7sjTMLcmqEfeh77TGiJFb4RWiQnjLOVDfpbDmm+w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbbpqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jul 2026 07:56:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66C7ncZE024732;
	Sun, 12 Jul 2026 07:56:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05ps50d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jul 2026 07:56:21 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66C7tiXr30868068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Jul 2026 07:55:44 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 890A758052;
	Sun, 12 Jul 2026 07:56:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 897CB58050;
	Sun, 12 Jul 2026 07:56:12 +0000 (GMT)
Received: from [9.39.28.197] (unknown [9.39.28.197])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 12 Jul 2026 07:56:12 +0000 (GMT)
Message-ID: <d2b41ff7-03f1-4a5c-adbe-df914cac120c@linux.ibm.com>
Date: Sun, 12 Jul 2026 13:26:10 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/af_iucv: fix NULL deref in
 afiucv_hs_callback_syn()
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: horms@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com
References: <20260709191732.124092-1-hidayath@linux.ibm.com>
Content-Language: en-GB
From: Hidayathulla Khan I <hidayath@linux.ibm.com>
In-Reply-To: <20260709191732.124092-1-hidayath@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a5348a6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1I7zOhcRGFiCedo4MywA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDA3NyBTYWx0ZWRfX9+iZhVdEp4+/
 llwX4nDIEydF0oSxoQfImQkzBDiy+j/07nhIFwVlwIpkcnSc1EsWOz7LKWb2j2Q/mvRnQaXJJR0
 wNuRtS9X0EwPuqv6Ae224sOPKYvrGL6WM4FjfyBG4BA1thf3zyu+cxo5rmbEwgBrWtdmP5lNQ2I
 FFnzuigsDX2UCC8jIP5ThHhQbhMtgDFB1aagaVOSfnIEJZq4qBsvwjRyxuPTj1S7KFzoEBiN7Wl
 mCfNoW/ZMdzzkYvmfcTQHZD9N7fSWiGis+sDyNkjhRLCHBPgX4mhJuz8ShzEEbKQdgNefhKDm9t
 +yFZN5+Bwc5i+Z9KWIsnnNA2+OLc0vQVcdRJ3TideZgKh8nwW5fjBFqIJ98y11XwZp/MUSTyfZg
 hH3YJK0tHfENv/h0YJeIZCZsHJTYU6BdXIcbmKh5v2tS7bnbsHRqLUC2RpCmktqTRhqHf9wLKxF
 V3uiv2XfucGk3YSSpbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDA3NyBTYWx0ZWRfXw8NikXafU82e
 grtXBJnvNFYXGgH5AOx0vjYHB8zmJPNxVppdPe/4jvqbl0XgtvVn/JqLZUyPfbz3GOYoF+4smiu
 P7JjLF2160qba5puAjLWePRCm7yalnA=
X-Proofpoint-GUID: NO_vM1gfMgxl5pQ5YPSh9ulVJ1kLbrC9
X-Proofpoint-ORIG-GUID: om4YAekFuSA48d2Ccu-GtKCXduJRQy0G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607120077

Thanks for the Sashiko AI review: On the findings it raised.

Finding 1: iucv_sock_kill() returns early unless SOCK_ZAPPED is set,
and the flag is never set on a freshly allocated child socket, so the
child socket and its pinned net_device leak on the error paths. I had 
already
spotted this leak (in afiucv_hs_callback_syn() and iucv_callback_connreq())
and Alexandra Winter and I are looking into it.

Both NULL deref and child sock leak come from the same root cause,
the child socket is allocated before the listen-state and accept-queue 
checks.
I will address them together in v2 by allocating the child socket only 
after the
listen-state and accept-queue checks, so the refused path has nothing to
release (no NULL to guard and no child socket to free).

And on the transmit-failure path release the already-constructed
child socket directly (dev_put, unlink, put the last reference) instead of
relying on iucv_sock_kill().

Finding 2: missing sock_hold on the afiucv_hs_rcv() lookup. Agreed.
Bryam Vargas has already submitted a patch for this.

The other findings look valid too. I will follow up on them separately.

Thanks,
Hidayath Khan

On 10/07/26 12:47 am, Hidayath Khan wrote:
> afiucv_hs_callback_syn() allocates the child socket with GFP_ATOMIC.
> If the allocation fails, nsk is NULL.
>
> The connection-refused path is entered when the listen state check
> fails, the accept backlog is full, or nsk is NULL. The code
> unconditionally calls iucv_sock_kill(nsk) in that path.
>
> iucv_sock_kill() does not accept a NULL socket pointer and immediately
> dereferences sk via sock_flag(sk, SOCK_ZAPPED). When nsk is NULL,
> calling iucv_sock_kill(nsk) results in a NULL pointer dereference.
>
> Only call iucv_sock_kill() when a child socket was successfully
> allocated.
>
> Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
> Cc: stable@vger.kernel.org
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
> ---
>   net/iucv/af_iucv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index fed240b453bd..f5b1ec44b6ae 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -1872,7 +1872,8 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
>   		afiucv_swap_src_dest(skb);
>   		trans_hdr->flags = AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN;
>   		err = dev_queue_xmit(skb);
> -		iucv_sock_kill(nsk);
> +		if (nsk)
> +			iucv_sock_kill(nsk);
>   		bh_unlock_sock(sk);
>   		goto out;
>   	}
>
> base-commit: 262b2eac463d880a664cf92af1107b4f9d84ad37
