Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89EA17A309;
	Wed, 19 Aug 2026 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151994; cv=none; b=kyHjiZdn2fi7Buqc4uJ53ROj0qkuSdgKTeuFwEvb5ARZdEIvr9rNDeJWaOWMa1tLDyDJlihzJckQLzuSNQ+pMGsOWB1W1mq9N5Mxl7e2jAyK6EHX0qsRvLys5YUtqjYYuIxCK18LTn6rLDdxHyV2z77uoBc9wXQpETA3UdNbqqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151994; c=relaxed/simple;
	bh=5sdPBUaN1lsmf1sKLUWh3QLKgHHuaH8OyINn64kMVQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXAyzTXz5OBoODovdYEAMPxm+qkFRq8tj+YeV1c8SO2fihCNoMaTd3ffXaJf4hhGWJyb8d03+LVNfHODFcHVjFGCt/p+dpx1ZWfhWe+zwgJHIdZmLIPmQ+ST8xfZFcyU0UkwleAUGDaxzP7+5RUXZSMTZv4iN+KJ7J2l4I3Hma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GSXVXgGE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GSXVXgGE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF1qcm3696167;
	Wed, 19 Aug 2026 15:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZM+v+N
	KgZSFOp/186iCKsEpFvluvLPrkSmIr4NoFbv4=; b=GSXVXgGEFpLuuSfYZwvo+F
	myK5alEoUGAAtexvO3jm/g6mehQjgKXwq3oQLF9kHcIzBfnmV5rTbXfXTd04wvC6
	BTCkgvw+fHt+87rse29SBBZTRTjX3+oRqbzpYdEA8wnf2GuFu5beS9Bbo38q2TgZ
	Y6Xplmof7Bh6PMlMnKXXtGcyBxsG4sQZ4pWx1W1w6ew59d1ZnypbXiC+iqsYU6pY
	0OegdaNbrSQTmxnoNoS8jgXwkZOd+WS3tedFEUF0dVbNN9+YVuz8CM80TskX6uC1
	AHO7ciM6V5MpPPlNhKTOcrFPb9bOlr1QB562kiZuXSkzcWQoy5L2QiBcmSYC5bPA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu44ejc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 15:06:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JEuPPO012462;
	Wed, 19 Aug 2026 15:06:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh9g5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 15:06:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JF69Mw50135536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 15:06:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5630820043;
	Wed, 19 Aug 2026 15:06:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26E3120040;
	Wed, 19 Aug 2026 15:06:09 +0000 (GMT)
Received: from [9.224.90.36] (unknown [9.224.90.36])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 15:06:09 +0000 (GMT)
Message-ID: <e42b30ee-f7cc-4f65-8fe6-1bc6888829f2@linux.ibm.com>
Date: Wed, 19 Aug 2026 17:06:08 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net/iucv: drop HiperSockets frames from other
 network namespaces
To: hexlabsecurity@proton.me, Thorsten Winkler <twinkler@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ursula Braun <ursula.braun@de.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Hidayath Khan <hidayath@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260815-b4-disp-dc82fde4-v1-0-e83b10b22ce9@proton.me>
 <20260815-b4-disp-dc82fde4-v1-1-e83b10b22ce9@proton.me>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260815-b4-disp-dc82fde4-v1-1-e83b10b22ce9@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNyBTYWx0ZWRfX1zixpkayPCYS
 1OM2+0fjZkIWVbaaW0FW89w4POLrUnqcsvSVnKRDjIQrTszrTExHNSGmhhCrMoA/UIQbkOSfBx7
 jVr8Czv6M7RV7LhKF3vyUhA4NEdZUHA=
X-Proofpoint-GUID: KknbWgtzUbLtEUql3OzgqyQciCqQJhx3
X-Proofpoint-ORIG-GUID: ftEpIKnhj9ZsyEAOfY4f8FqSLRKmyzSE
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a85c667 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=r-z8vWJoZE4dHoqjCw4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNyBTYWx0ZWRfXw3YUfIHhkXrs
 xXhSe8b73TZ9yeFU6G/yIub9XsGyV2zNUFLZTqNYXVMZTMJ9lvK8BcEyqFw8I8pcNxdrV5uX5J7
 i6JhiBu3Zl3W7K77AYID4QzWXTIpvQn/F04WZ7qeEWCvL7k411t3TmPN8qs3PjBVgHmnyXZ1Viy
 6eHHIACtLpjjkeLLFdT/vj9jeFbuSOTEbbzcrlopLdCaqQjJKAw55Xayzwgn9FoOZiWIlT2wsKA
 VyyvD1Hs295oFGdR7NyWcuG91LArCXZCxI4m1jYA/seTYeW/HSAXZW3Q+30uUTEETotrvaYvhU+
 7bx7xCJCMng/gUnLhN+RJl76wNzCmooD/m1SOMA6DM27zHoy3WLiTyiRBZdmPze21UQSuCJESwj
 GAG8foamSkGRIM/o3Xn4MvLT7B41uUwIoenMwOkcAuBDLa6k9lVUxUJKyb0CRwJDNdAVOqjAJwu
 cKh7AZfDB5BoU1aEKVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190117



On 15.08.26 18:07, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> iucv_packet_type sets neither .dev nor .af_packet_net, so it lands in the
> machine-global ptype_base[] that __netif_receive_skb_core walks for every
> frame in every namespace, and afiucv_hs_rcv() ignores its dev argument.
> An ETH_P_AF_IUCV frame sent from any namespace holding CAP_NET_RAW is
> therefore matched against the global iucv_sk_list and can move a socket
> owned by the initial namespace: afiucv_hs_callback_synfin() and _fin()
> overwrite its sk_state, and _syn() builds an accept-queue child.
> 
> Filter on the namespace. The core does not do it for ptype_base[] --
> net/core/dev.c leaves namespace filtering to the ptype owner -- and
> net/x25/x25_dev.c and net/ieee802154/socket.c both test dev_net(dev) at
> exactly this point.
> 
> Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
>  net/iucv/af_iucv.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index ea047bab65e7..e3ec965d96ca 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2064,6 +2064,11 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
>  	int err = NET_RX_SUCCESS;
>  	char nullstring[8];
>  
> +	if (!net_eq(dev_net(dev), &init_net)) {
> +		kfree_skb(skb);
> +		return NET_RX_SUCCESS;
> +	}
> +
>  	if (!pskb_may_pull(skb, sizeof(*trans_hdr))) {
>  		kfree_skb(skb);
>  		return NET_RX_SUCCESS;
> 

I am wondering whether a check of
+		if (iucv_sk(sk)->hs_dev != dev)
+			continue;

would cover a broader range of issues.
I'll try to send a proper patch proposal.
