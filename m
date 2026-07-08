Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4753441CB39;
	Wed,  8 Jul 2026 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526790; cv=none; b=edsavmJ4yUT13cqv7SpxSK+m2E/fpRLsp1sT15dU6bsvJb2LM9Wq/qzKPKrLNBd+TXbiJi8riGV560zCJPF47i9CVC3CgoSO3bjF3N8x6cSOcsWLgeSQN70iw2IyUO3nXQSCOtTdeIy5BaP/AAp3MzoNBtegK8wdTrGf1w4B2is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526790; c=relaxed/simple;
	bh=IGmxUjKcGHvCltk3cdX1/dRRhVvjRHGlsRHTAzCY8K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsOcyT3cC7e/rU3aJUx6xM1OW/w6c24lSrjQK96VPPiod58bOVG81ot7oCk53bP+Zotke6NproD3J+SsdYClJlz7+dPKW9SHaik/+jtHKwsTrDDzVpxt/57CFurW2HvtgXqF0DNb5QlTEg2BAUagjSkJWfqdmarL/kB8cMaCBQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HoJbOMMr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HoJbOMMr"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668CIItV3748069;
	Wed, 8 Jul 2026 16:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0zuCZE
	eki3ansb6YY9mkJgx5/H+v5C+6HtojVHwftks=; b=HoJbOMMreV61ubRJ+KUXhe
	5eSeCjX4CrqQnynDjwG9+cEzgoKR0yvNiZhDmV7+LESeA+naYu2mTgMyhuewXbdA
	kn/GPp5ePrdeRgymr5ga92Hv13wtpJIgbJCLX6zv7oQP7qlDALPBROV1Ns96oKaV
	Ti1eVNGeGVNAfb+cpG8ONRUMtrk2+kZ751N2hh5z93kk2stL+lOJ4MgnUDTo7s4+
	z5ZPAfoXaoQSYtsB98qVy3YkZlDXhsZwY5XTHtm7E7gA4ua9zxbAnulmgn62o9q1
	VYHIHZPIcXsKRS4MSxnHyU6kIHgbUq0FTS1xRqmDyGtzE4C8lI12gZKOFtaOtwmg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqvyy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 16:06:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668G4dLa022957;
	Wed, 8 Jul 2026 16:06:14 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw8y4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 16:06:14 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668G6D6k32965216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 16:06:13 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C5035803F;
	Wed,  8 Jul 2026 16:06:13 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 192F65805A;
	Wed,  8 Jul 2026 16:06:07 +0000 (GMT)
Received: from [9.39.27.42] (unknown [9.39.27.42])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 16:06:06 +0000 (GMT)
Message-ID: <5585114e-6cef-49a9-8742-87b003129777@linux.ibm.com>
Date: Wed, 8 Jul 2026 21:36:04 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/iucv: take a reference on the socket found in
 afiucv_hs_rcv()
To: hexlabsecurity@proton.me, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>
Cc: Nagamani PV <nagamani@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, pasic@linux.ibm.com, aswin@linux.ibm.com
References: <20260705-b4-disp-fc79c0dc-v1-1-d2cdcb57afa9@proton.me>
Content-Language: en-GB
From: Hidayathulla Khan I <hidayath@linux.ibm.com>
In-Reply-To: <20260705-b4-disp-fc79c0dc-v1-1-d2cdcb57afa9@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1NSBTYWx0ZWRfX3IzDFlKqY9UC
 jWEKcrNdXnG1/Ujua8lE60m5vmA49dQ+CB1f0hxz6qNQj840b8s6s7DOACDJya3EQdZzb7hjfpc
 h8FWGeuelQZPtuVArFQrarchtGBByIw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1NSBTYWx0ZWRfX+Jp+OZx/CRV7
 YGuNUQkPrIgmx736OhcWyxQjigIqEB0SwX7l6neqWAQf95OPYCcabo4if4sI0SwVyNltgoA0PC4
 OGdh/3JIQzjSNDl6NxKK5ALex+/wEesWQf96hmalPrdf7u36bd3+5a3Jb96yHkBMrGeA7St6puy
 VmIcF4CBYSHs7o/moTphKhjS0WjK85tAmRraeMgHLBcYrYO51FuMHIKtMaLrWYYZN1C375a7r0A
 ls1KKs1nm3bGPSbJnVKGoLb+yxx4xEH04p9Rl2Gud5RpzY+NgOzziq60l0GB+LvpTFzUEJtv4cW
 SLWi84Ih5wo4moU8PyLXebwKHww0b9dnSRF+xgpvKSmXab5gMLX/cWpOvQV/eT4GlgFDu6eBmn7
 u4KnaG3cedlKYLGuLd9WdvT1lcWLNhYkA4TSGYOvv4YTjnI95/blaL3xHuicYUhFe6+hYUoMomv
 ekLjFrJmsUxYHiTLJZw==
X-Proofpoint-GUID: 5tV2UOLlPWDaloi1Tz0wMOr-TYAhdKWu
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4e7577 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=mpG3tCo3JFPGy_rZ:21 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=ecR08IUzkcQAMt28NOMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7cC4H9TJJx_GzpKzf-7uhLQL76gs3lVR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080155

Hi Bryam,

Addressing Sashiko's findings on this patch: [High] NULL Pointer Dereference in `afiucv_hs_callback_syn` error path.

This is already fixed by my patch currently under review.

[PATCH net] net/af_iucv: fix NULL deref in afiucv_hs_callback_syn()

The fix guards iucv_sock_kill(nsk) with if (nsk).

Regards,
Hidayath Khan

On 06/07/26 8:54 am, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
>
> afiucv_hs_rcv() looks up the destination socket under iucv_sk_list.lock,
> drops the lock, and then passes the socket to the afiucv_hs_callback_*()
> handlers without holding a reference. AF_IUCV sockets are not
> RCU-protected and are freed synchronously by iucv_sock_kill() ->
> sock_put(), so a concurrent close can free the socket in the window
> between read_unlock() and the handler, which then dereferences freed
> memory (for example sk->sk_data_ready() in afiucv_hs_callback_syn()).
>
> Take a reference with sock_hold() while the socket is still on the list
> and release it with sock_put() once the handler has run.
>
> Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> afiucv_netdev_event() has the same iucv_sk_list use-after-free and is
> being fixed separately by Nagamani PV:
>    https://lore.kernel.org/all/20260508170534.2208812-1-nagamani@linux.ibm.com/
> This patch covers the receive path, afiucv_hs_rcv(), which that fix does
> not touch.
>
> Verified with an LKMM/herd7 litmus (the missing sock_hold() is the only
> delta between a flagged data race and none) and with an in-kernel KASAN
> model that reproduces the afiucv_hs_rcv() lookup-without-hold path (the
> freed socket's sk_data_ready pointer is read after the callback runs);
> adding the reference clears it. af_iucv is s390-only, so this is the
> model rather than the driver. Reproducer available on request.
> ---
>   net/iucv/af_iucv.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index fed240b453bd..b85fb9767dec 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2089,6 +2089,8 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
>   			}
>   		}
>   	}
> +	if (sk)
> +		sock_hold(sk);
>   	read_unlock(&iucv_sk_list.lock);
>   	if (!iucv)
>   		sk = NULL;
> @@ -2138,6 +2140,8 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
>   		kfree_skb(skb);
>   	}
>   
> +	if (sk)
> +		sock_put(sk);
>   	return err;
>   }
>   
>
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260705-b4-disp-fc79c0dc-019670262472
>
> Best regards,
