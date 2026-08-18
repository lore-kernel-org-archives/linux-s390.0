Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E262237CD53;
	Tue, 18 Aug 2026 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054125; cv=none; b=eqL25WBd0fcqc/kGD3cPx9O6NBptAxBPJ5Zkupzvr8o+uXgKFJgEdILcLHqbMAEkW1acw/mQzt2VpGhJxjEfUB64fcoFkoEhTEQBNgKAtaSR9hz2UUseolK3JD+zCnaAZPc89t7F6W+TZYpg1oEBPoQzCkCoLJFDlFZXAuZq3BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054125; c=relaxed/simple;
	bh=DAcZOgekyBYGUxWvSUAZsquyriuqTLGFM/xGjWhl7wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lv9+yOYXQQ4rmP13UDwSbOty+YAorgfr2JuvI+awHpWoHKG7KtXmAu9meE1IJeclR2gkCUANrCE6ZfLhOHhUx7d7eFpTzfZ7LyscnlX8k4StGYo2FWcRLS1G6L2qjmbp2rYdSwuwoYUzXzlL6X+Fi27Nmn2bUiVOyCJWOmlBoDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VWSmwCg0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VWSmwCg0"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IAVYVJ028643;
	Tue, 18 Aug 2026 11:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BBb1yW
	HOQff7aU5CXi9LTJZf1nzEWWrC8SAD7ji0EUE=; b=VWSmwCg0EeFkJlMCFrTged
	KvjBpzyV9e/Q4R+5bXlF/5az8m3PYy+d3O+m6y3Slj7KL1FZvVhEkqy3UKMCRyKK
	LEGWumwOToY3eMV36R1iOg0pFD6dtt6JQzVDFR70W7eXPdl7KvpCdhEt7FvDETzH
	ibrrwOTerA8IZCIgg1QNXKs60J6agPiqyHets1PvJjhzfkIKka9GW5dgob3xSAhS
	zq/rdcDE2rLbooi86fZrgNm/eKmXq4S+kFSbQRaRqubjOnG3zfuK7uqnp/GWwhM6
	kJHoh6WWKeb5yWPtVxuN6cR/szypedZMUFFXfFzlN5SKjidoVmmTMz6IVY/noLKQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4qy6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 11:55:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IBfM5E024089;
	Tue, 18 Aug 2026 11:55:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh305k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 11:55:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IBt2eA17760592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 11:55:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6F0F2004B;
	Tue, 18 Aug 2026 11:55:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7795E20043;
	Tue, 18 Aug 2026 11:55:02 +0000 (GMT)
Received: from [9.111.161.182] (unknown [9.111.161.182])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 11:55:02 +0000 (GMT)
Message-ID: <5f368349-a417-42b9-9ee3-d9996a949bb2@linux.ibm.com>
Date: Tue, 18 Aug 2026 13:55:02 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net/iucv: take a private, writable frame before
 rewriting it in place
To: hexlabsecurity@proton.me, Thorsten Winkler <twinkler@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ursula Braun <ursula.braun@de.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Hidayath Khan <hidayath@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260815-b4-disp-dc82fde4-v1-0-e83b10b22ce9@proton.me>
 <20260815-b4-disp-dc82fde4-v1-2-e83b10b22ce9@proton.me>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260815-b4-disp-dc82fde4-v1-2-e83b10b22ce9@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: fzNSHg4pHK4rJpOE2pEL6LU-CYQxiMin
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a84481c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8
 a=n0wzrGaTUaOUoIqzI10A:9 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4NSBTYWx0ZWRfX9pYINKpS3LRb
 lC2ml0YF0it6RKpeFI7i9HyDcZvndLfc0kGKjsm+wLWUTb1wtwKQnC9cXJ8P26LNc0LGjsB9Idr
 gcQjXfMbWdaRIza5Gxg4icsx/CsjK1g=
X-Proofpoint-ORIG-GUID: jJn9qDmstb6XYeILrrY4Awdkrhkgm1FK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4NSBTYWx0ZWRfX1aG9ibzWstYm
 8rtmuMZVCyDrUVkah5FMcRSL3AQyLong2miQCr24nwbhUJsZrVDyZUosWArUGA7ZvhmbCz5dcfr
 pHFShO8/1G9bR+G/Gc9mhRi4ZIIZS9XC4Z+5dhojuJ1xe4pDWBA2g5xIATjPpj7bXMo18/hJBE8
 LYO7tnVe+X7nDBP4qQn5BNWQtd9KKDoNjXnjhAjalYzEvVADmf5yE3EljZfrabpiqazWvlkvzW1
 FmQ31yntPbD4/Qkzjq9R/c1L3hbzJfS7OkgCE14xFqW6WodTVplfrMXugFjRW/TtSDR8m6EvO4R
 6bNnIGM9CfkoRiqug1xfxZrMiXu1MXqI+BZKGvkqT70v6seS/CSN2qK842/OWvOUzJVIOgEQOrd
 UZDjwxHJDqlraTlMebuLWXMJtyh7+k+xC4shsEIqCGSt5yHzrSRPFnA3Ykh51METCqPNyiG892L
 oclZoOS0jHO90nn8tCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180085



On 15.08.26 18:07, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> afiucv_hs_rcv() rewrites the frame in place -- EBCASC() converts four name
> fields in the transport header, afiucv_swap_src_dest() swaps them and
> pushes an Ethernet header back on -- without taking a private, writable
> copy. It sits on the global ptype_base[], so a packet socket (tcpdump is
> enough) has packet_rcv() clone every frame first, and net/core/dev.c has
> warned since 1998 that such a handler "is not able to sense, that packet
> is cloned and should be copied-on-write".
> 
> Unshare, then cow the head, in that order: skb_cow_head() can reach
> pskb_expand_head(), which has BUG_ON(skb_shared()). Asking for ETH_HLEN
> also covers the unchecked push in afiucv_swap_src_dest() --
> eth_type_trans() has already pulled that much on the ordinary path, so the
> call compares and returns.
> 
> Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
> Closes: https://sashiko.dev/#/patchset/20260813-b4-disp-60433a46-v1-1-509e1200533e@proton.me?part=1
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---

Thank you for this patch Bryam. Actually Hidayath proposed the same fix to me for the same Sashiko finding
and I asked him to clarify in the description what the consequences of today's problem are.

"My current understanding: You use an AF_PACKET ring reader to analyze the skbs received by HS L3 interface and
complain, that the skb is changed afterwards when af_iucv processes it.
Is that correct?
What could be the bad consequences? (I cannot think of any)"

Excuse my ignorance, if it is obvious to other readers, but is the worst thing that the output of tcpdump
is not correct? Is this really a problem fix then? Or should it go to net-next?




>  net/iucv/af_iucv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index e3ec965d96ca..10cfc5e82f04 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2069,11 +2069,20 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
>  		return NET_RX_SUCCESS;
>  	}
>  
> +	skb = skb_share_check(skb, GFP_ATOMIC);
> +	if (!skb)
> +		return NET_RX_SUCCESS;
> +
>  	if (!pskb_may_pull(skb, sizeof(*trans_hdr))) {
>  		kfree_skb(skb);
>  		return NET_RX_SUCCESS;
>  	}
>  
> +	if (skb_cow_head(skb, ETH_HLEN)) {
> +		kfree_skb(skb);
> +		return NET_RX_SUCCESS;
> +	}
> +
>  	trans_hdr = iucv_trans_hdr(skb);
>  	EBCASC(trans_hdr->destAppName, sizeof(trans_hdr->destAppName));
>  	EBCASC(trans_hdr->destUserID, sizeof(trans_hdr->destUserID));
> 

