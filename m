Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6516C439336;
	Wed,  8 Jul 2026 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529183; cv=none; b=f2iMDQbFyUyz7nr/Ck/A1SDiUPFBYAzvURUQvgz5IyftDM0OsEFJ62ASEy36WYISgmynp9PNy/vFudebWDhQYYmz47jXDGMg86d1zto2v/gzwxKWzhKFihx0mKcx78msjRUIRKJtY5mdUOqGrG9aqkHzUGrKURwLvfCiwQCqIIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529183; c=relaxed/simple;
	bh=al/zUXiLhesNUN9/kTzomyBJl8WeG/FOE9t6Sg/cieA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujD+keasn56s1oITXfio9teR2FzwfVMEayvsHMp8MWNag4pYC5DEuQXHnE4ZsR2n0lLlWtVGY8ShnaStfwq7GmhGMy5iVn5aye1RoYo13/zMc3111M2eCj7leE13sWeJdoaXm3QxWAQMxc+dtYfa+JsWAHCX6purb+W1JI4YvBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HLkAVqCV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HLkAVqCV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668GJHBY3971438;
	Wed, 8 Jul 2026 16:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OorGcR
	ptNTrRV2iIx8/DyhI9nn6DgM9umuYga92efm4=; b=HLkAVqCV/B9IY4ZYWjzzCz
	zlQ/RjNjSA6wZjbPYlOVskfn6d130eyi5gLvR2OBY7yjhM9xcc/X5kXuWhxqPRUP
	Fu16NyNwSkaG+e8o3hEwZmF8k04e7ZL5XZ339OHfo3dgLeIZayNRUytg34P7E0cY
	ddbToHzKr7o5giy1fjh9WosyQ5cI7RNgo3T1KLw5eC6LwdXYRXrG/assPmLB+luL
	m+ABXRNPs+xWux0YXnYfY0xU6WFOlemtCEmhm63seoWYoVHKFyDHIPG4ggQEt39+
	xb/NT10tPKGLnNHLur7Zpm9JctMHOg3CVMf82VQ8MmFrihbQY/bpEecOdk40Im0w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknmxy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 16:46:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668GYbIm001432;
	Wed, 8 Jul 2026 16:46:04 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq95f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 16:46:04 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668Gk3aa25428664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 16:46:03 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D8395803F;
	Wed,  8 Jul 2026 16:46:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F83E58056;
	Wed,  8 Jul 2026 16:45:57 +0000 (GMT)
Received: from [9.39.27.42] (unknown [9.39.27.42])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 16:45:57 +0000 (GMT)
Message-ID: <7e5a9ff5-a584-422b-a8d8-67ade59fa4fb@linux.ibm.com>
Date: Wed, 8 Jul 2026 22:15:54 +0530
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
        Alexandra Winter <wintera@linux.ibm.com>, pasic@linux.ibm.com
Cc: Nagamani PV <nagamani@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, aswin@linux.ibm.com
References: <20260705-b4-disp-fc79c0dc-v1-1-d2cdcb57afa9@proton.me>
Content-Language: en-GB
From: Hidayathulla Khan I <hidayath@linux.ibm.com>
In-Reply-To: <20260705-b4-disp-fc79c0dc-v1-1-d2cdcb57afa9@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4e7ecd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=mpG3tCo3JFPGy_rZ:21 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=RTV58wmTnq1ZVL7yGYkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UqWjOzrUF2xZ0mE36cwJQcvu04vg1Fa6
X-Proofpoint-ORIG-GUID: LXU27-XIuX01X7blPqu1A_VmCxXoIAk4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE2MCBTYWx0ZWRfX3JopxISW0yET
 pJVORX6hrWUa+FgHkbTE3pF8T7Dfujf0gNefRuIVJ9wItKHU+7+NkgCM/vuBnpmMSdXqYPy31m+
 B14S0n21YlUY0D81F0Ds1nNLuz9gShI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE2MCBTYWx0ZWRfX4r+BNaHI2HKt
 W1t9f+TgPhEPzJ0+34XjWKYecMlPxZXSqXJeoT/Vluc3e/bZxxYNwvOxDzd83eAs+h6dQlrRSoR
 bqVXwHyaTItXeYbJ8N+3LIEXTQ55LtiGuh5xMrHo42nFwomShzeztd/ETQy2hnLj6zWLiRb9YWo
 Cwix+dueQ4n4mRMjcbFII2YUMxvlZoBR+opvPVcCFbvv1To4X3pto7EoxGjbI72wvF6Xk1wUnod
 W66b4lkKh+PHzRm98sO7EIoWPU29/FQZjz5K18bBUuSFD6H6T+aTdBwoNecKX4mHW72wFKKgjxd
 lF97tBXZB+FTBNSpyIJPGWLTw/HOaMbPzRDqH68z5JBjXiwxNiDJHx0M/5Y+Rn/a3Bi5YeWdodE
 WYdTY7y2mJSzOCHib8MlPJVxnfMwkgxE4lLwji3nAx9508Fx0xh9VgBu1YJgl61sp7XMXpe2HU0
 0WXWiYhvddMcq2v1lYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080160

Hi Bryam,

Patch looks correct. The fix properly pins the socket found in 
afiucv_hs_rcv()
before dropping iucv_sk_list.lock, preventing a concurrent close from 
freeing
it before the handlers run.

The sock_hold() and sock_put() placement and guards are correct.

Reviewed-by: Hidayath Khan <hidayath@linux.ibm.com>

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
