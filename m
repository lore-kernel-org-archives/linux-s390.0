Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF752FE51;
	Mon, 31 Aug 2026 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188953; cv=none; b=cquJu+8fXs+VZhkEscz0nleRiR50ZtxAUrjituGVteIR9J+b7mkwU62DB8qGLBkcqCO4Ky1CNQFtqlL2G3PiZa9Wu/tzPmSxJoRgMPVDCK9Bx3KmqKoi2j6C77/OMszgNEhO/iMF0ov3mqVg3Q7daBP76Yt1f7tW3I7T3EFnk4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188953; c=relaxed/simple;
	bh=U1BdKm/NMDTInPhooYtluyrw4RoAL46CKCizlGQirV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDFf4Ow8zYedOBpONcg4qhihElMdcg26i1XqVFluTogoAn/U7dhmQiKQ9fauLA9YTOlMbb4ZQrJRUzYJVVC9uS8dqySZX4wNd5EL6FCiXaEGokqYQ3HxhzzuWwZggtVPbA05s5NPf6lp5Ted+Ou2A2o9fHlfzHX0JNDjN0+Fxpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IsCnGOY8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IsCnGOY8"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ92u652842;
	Mon, 31 Aug 2026 15:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WTyn2I
	2drRiWDXCZg2s4U5mZuRXrq9dSPAo41n2k0+M=; b=IsCnGOY8+SUXVumG8UZNjc
	kD9/aQHkIcXO1T0lCZtf8rfVVXCEihZZTsncSC2ncP9Q+dgnWm62J0XOZ0QH/TtX
	NmyxR5B+lFk898ny02636BYkYlU896uPrdRdfPj/i1N5eQU5Jl9sLBs3jclJ1vdV
	4Uz/k6ynxl8qDcbJcjAZtEc6wGEPFUWHSVUfHX2i5U8F7ytvI0rwAZTKhyhJEiUf
	UWCud0CqSUR+3Z27LJNcXrCdIJitkVNNAe22e3xEhWnugu36+3GYY8/UQKQCjWg7
	bFuVvyTJCNXweG553UsR01P2/7yHuBTC7eyTB+QNThpD1mYyVQ5m9TnODeGVtAqA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r239f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:08:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEuJOQ003206;
	Mon, 31 Aug 2026 15:08:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq6qw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:08:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VF8sB840894844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 15:08:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B6D920063;
	Mon, 31 Aug 2026 15:08:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 448302005A;
	Mon, 31 Aug 2026 15:08:54 +0000 (GMT)
Received: from [9.224.85.87] (unknown [9.224.85.87])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 15:08:54 +0000 (GMT)
Message-ID: <e6473c2f-1c17-4dca-90a5-9cac8baf6f90@linux.ibm.com>
Date: Mon, 31 Aug 2026 17:08:54 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net/iucv: fix the recvmsg window update
To: hexlabsecurity@proton.me, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Eric Dumazet <edumazet@google.com>
Cc: Aswin Karuvally <aswin@linux.ibm.com>, netdev@vger.kernel.org,
        Simon Horman <horms@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hidayath Khan <hidayath@linux.ibm.com>
References: <20260828-b4-disp-33fac0ed-v3-1-e6d061880ee0@proton.me>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260828-b4-disp-33fac0ed-v3-1-e6d061880ee0@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a95990b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JO-AmN10dZGJaJYjb2wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX5AowIZA8YVuc
 7evwxSj2eHkCo0qh9DdvTYcNcfwYEH5Cms3JiJYVXLI34zhWwGOxwXQ5G5oiaJhNR9aDkvxhSrE
 qkf7pEPHMa3KvIfnnNScBXVMhU1NsqOhetp6zlt7Ml7esFU/RH91jJwqXHuJHJkGfWLqU0rx24k
 KbZg/yXBYQYCLljmpz4jktna04UFhDDgvscNG+h0lWHO/u4o6vkN8UkmhmWdjDLnUr00BfqDwFL
 NgkkUmC2WSkOpTw+9RKtkxtSvrtZWR2j6eVOumJaJN1uZSx7KQ7rLcQB5p4DCk+I4mWhziBdl31
 taKYlMSZQobAamNdBooMaL/IeLlpm+QPPpDKTf25FRrZV7/7xiurqnZModPnkBzuEs3vXma0/Aq
 vGeSYQnK7U5OgHm2BJ8VsHbTB5nU8R2ZueTLwMJZEEEerB4lHjrvzr+jadnmS6CXQrr2ynh70o4
 /hRIGRJZeTpiKMTQmPA==
X-Proofpoint-GUID: r4pLL5Hl3bBCLBmIwjL_hIJkBSLCymI0
X-Proofpoint-ORIG-GUID: cJXVWG1SjJF2JFsCuqHsCmLYUa51-5vY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfXzVUrWZkM0Bmi
 iXseBm04lMhtqzRIVUTeD3MYkNAqP0u1fCxI8pgkGVfB9U0Zt/yLzQi3TPTUcroGY8KPaV5hw94
 roS58vjLmhWbeeDx2fJ290BnmMUc0xI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310130



On 28.08.26 21:07, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> iucv_sock_recvmsg() sends the HiperSockets-only AF_IUCV_FLAG_WIN without
> testing the transport, so on a classic z/VM socket iucv_send_ctrl() sizes
> the skb through a NULL iucv->hs_dev. SO_MSGLIMIT accepts 1, so msglimit / 2
> is zero and one recvmsg() on its own socket is enough for an unprivileged
> process to take a spurious disconnect.
> 
> It also calls iucv_send_ctrl() under spin_lock_bh(&message_q.lock), which
> allocates GFP_KERNEL inside a section the code treats as atomic. Sending
> outside that lock lets two recvmsg() reach afiucv_hs_send() at once, where
> msg_recv is sampled for the advertised window and subtracted after
> dev_queue_xmit() -- and sendmsg reaches that counter under lock_sock()
> while recvmsg holds no socket lock, so both can subtract the same value,
> the counter goes negative and the credit reaches the peer twice.
> 
> Test the transport, claim the credit with atomic_xchg() after the last
> error exit and hand it back if the transmit fails, and send once the lock
> is dropped.
> 
> Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
^^^ This is the older commit and should be used as Fixes-Tag
(alloc under spin lock and HiperSockets send in a z/VM scenario)> Fixes: 238965b71b96 ("net/af_iucv: build proper skbs for HiperTransport")
^^^
This is a newer commit and add the skb build consequence described above.
I think it needs to be drpped as Fixes tag.

I don't think you can have 2 Fixes tags, can you?


> Cc: stable@vger.kernel.org
> Tested-by: Aswin Karuvally <aswin@linux.ibm.com>
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> v3: squashed the three v2 patches into one, as Alexandra Winter asked -- they
>     are one subject (iucv->msg_recv handling), they had a stated dependency,
>     and one patch is easier to backport. No code change from v2 1-3 combined.
> 
>     The v2 1/3 changelog said the NULL read faults under relocate_lowcore.
>     That is out: Alexandra booted with it and did not hit a page fault. I have
>     no explanation to offer in its place: vmem.c:521-524 skips the first
>     sizeof(struct lowcore) bytes from the identity mapping whether or not the
>     lowcore was relocated. So the changelog now claims only the disconnect,
>     which she reproduced.
> 
>     Tested-by carried from v2: the code is identical to v2 1-3 applied in
>     order.
> 
> v2: https://lore.kernel.org/all/20260821-b4-disp-3a6e8695-v2-0-37597ff723a8@proton.me/
> v1: https://lore.kernel.org/all/20260815-b4-disp-8a791503-v1-0-fbae9a511144@proton.me/
> 
> Not reproduced here: CONFIG_AFIUCV depends on S390 and I have no Z. The
> counter race was checked under LKMM -- the counter reaches -2 before the
> atomic_xchg() and cannot after -- and the tree builds clean for s390.
> ---

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

netdev maintainers, feel free to remove the second Fixes tag.

(Re-tested on s390)


> 

