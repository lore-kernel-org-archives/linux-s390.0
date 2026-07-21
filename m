Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9150F377EA5;
	Tue, 21 Jul 2026 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642058; cv=none; b=oPqd44AyPj7A1NM60+0nqe8d4qHs8F2RSKeVVQM27Ulh5Q3mDZH6GyfgZRlyRxZnnw86tNBAlTK6cJIx9Cq58hCG6cLWTkicuTsNiyjVaYHPfRBsUpv3PxTLdPM1mKlGDr0ls+gS9riM3dzQjb4CUowQ6t7xktt0wlLFbw2DsCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642058; c=relaxed/simple;
	bh=veLGk4CcAAcJSmgOuAs5+j7FiC8KGBsfI6txWBX99s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZXdKUaESXkr5JmaGQS827wyVDa1Hu44wMyd7TtRnMUhRdB5oQ5qU3fPyHt8lIITp1Eq2wVH9qdgC/UGzZXp9F43wjUpwbE1DvQa2ZqNjLNTilHz1xxF2ItF+JsH2kPCs4ZH0luBPibf07cNH3FM2D8h2hrcihaR1kChOFKTzwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OL/zFHx1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OL/zFHx1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDgewT1072675;
	Tue, 21 Jul 2026 13:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FeTWme
	EbhBkr4kRlTPXGcf8yx9t/qPxZA1IN/+Jp2ko=; b=OL/zFHx1bzifRSqUKKy8TQ
	Uq1OeVYqXlU78ZU0V0M6oriI86EARsx4+eoQkIwAfPRxbo/X+/KF8XsvNSs4tpbl
	rsOxUjZLs4+Oei3Z50+b8VvSd4mNRJsNvvcCuvy6xQo8M0t1Tsq26Lpj8WFPympx
	rmrokWqq+iPr1osJn5wzM+kVohEREnj3hFYlqsVijcL/RT6f+7ZSB0BFWyJGTt6/
	4X0dD4jaOBwm9nu3dItZbXDCFp5QS/QtP8529sLDd1rbHVuDkIhNe9ta3gr5D6dM
	5slwCsZRTxEzWCQWAy2fm1ca1DRqlJH4Nbg4eG239KM2EfxsGZM2jyL45lOPKHFw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78g4ex7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 13:54:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66LDo58E008560;
	Tue, 21 Jul 2026 13:54:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgya7qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 13:54:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66LDs5NS44892664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 13:54:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EAD520043;
	Tue, 21 Jul 2026 13:54:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4206220040;
	Tue, 21 Jul 2026 13:54:05 +0000 (GMT)
Received: from [9.224.94.95] (unknown [9.224.94.95])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 13:54:05 +0000 (GMT)
Message-ID: <fff72695-88b5-4ba5-b1f4-f70a2b02ed1b@linux.ibm.com>
Date: Tue, 21 Jul 2026 15:54:05 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/af_iucv: fix NULL deref in
 afiucv_hs_callback_syn()
To: Hidayath Khan <hidayath@linux.ibm.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, twinkler@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
References: <20260709191732.124092-1-hidayath@linux.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260709191732.124092-1-hidayath@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE0NSBTYWx0ZWRfX3Id7GbH30hQK
 0rq7EbrBKaXUGRjuQ0cFYF7ddgWV3T2ejmRLRRkCICV0YhZ7vKsquh/pr1gqxsI7cKeeGShAKDH
 pjOzEJRqhtf18DW813GzgkncoT6FYgILk4mEkdFOKBlrZxpR5UMr5AuOFGGPin5Pl6+h04HQqZb
 ju8nbU/p+dE8locA6hr6cOGnYWavN5Ch1AP1dH6x8V39t2j0NYgk6e+KGo1F2h8bqNOfdrCaSAF
 R+QJTtVrf1GWhwexOZoVXkVbiniiemcQ+tDGsszwD2cjck8syRUzeQ7hmPZabY5lSQ9m2CY1SvD
 6fX4hc2GeS6qQo8H5p761PgloxnYqGrv9I30gmi048qMf5LYwhRT0YB7/E5hMMFkONFraKOOl8/
 rM3zKK9ZANjtV8JKefFt3+Zo07dNFZjz8mAuJEYJRq9of5zQVnbmBUb+W0DJ7kgYTI0kL/z9a4f
 PxhJMPBi/3e/LWfMeLg==
X-Proofpoint-GUID: hmV0od4ylTZNIsUsOE6oKtSOssaRWbM_
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5f7a03 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Pk9XwYpVuUtOZicstfYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE0NSBTYWx0ZWRfX1ujsAeykVfZ7
 WpxcQyAHYaR4iXTRBs1Qq+6bhQF9zd6jkJeLUU5fIG89GhhbNIIXzoIurfjql+culcbet4dWx+t
 9MOQIX3A06PlXiFKDt1zhA72cTQbPeI=
X-Proofpoint-ORIG-GUID: Ku8r_xh8Tg1xYe3gED7H1XErBqnQPKLJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210145



On 09.07.26 21:17, Hidayath Khan wrote:
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
>  net/iucv/af_iucv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index fed240b453bd..f5b1ec44b6ae 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -1872,7 +1872,8 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
>  		afiucv_swap_src_dest(skb);
>  		trans_hdr->flags = AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN;
>  		err = dev_queue_xmit(skb);
> -		iucv_sock_kill(nsk);
> +		if (nsk)
> +			iucv_sock_kill(nsk);
>  		bh_unlock_sock(sk);
>  		goto out;
>  	}
> 
> base-commit: 262b2eac463d880a664cf92af1107b4f9d84ad37


Gentle ping to netdev maintainers:
Did this one get lost in the overflow?
It is all green in patchwork. Is there something you need us to do?
Should we re-send it?
I don't see this as urgent or especially dangerous.

Kind regards
Alexandra
