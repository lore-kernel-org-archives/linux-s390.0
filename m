Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15061FF1B5;
	Tue,  7 Jul 2026 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415968; cv=none; b=aEQSGBBdvRoHXhd0FRCnwAwW0AKXyAziKFXu3hfz6ui4OABYpbR2XOLLC8PD7NaDcppENMtxMzD8kpN1Yz/OpfhTPgRQhJxlbjDT9TzwtMSnWIOlxOwfCl8Q8ktwHpMja6T5fGZUj99k+CFJYbZUAwW47Fl41CIwlXm8QDQJtBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415968; c=relaxed/simple;
	bh=ps+15l81wJGsEMzJv591TFVxAW5y6WEr6+VcVSI4xw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPXGAJedkPbHoVl831B/IkkwrUMJPr4qHg3qOChqcn17Aj0/H0XXir9M2te8R45zFBBxvK43FfWyhyPk/7v+2ZxX3qagMPn85sUkwwtvzGOX4xHsCcTcnsVZD3OQ266ARnHOk9tJ27TX9Iq9MoWm9XYe6zaj9fzAC6yz8PyH620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RuZuQGeI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RuZuQGeI"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678IMPf2273577;
	Tue, 7 Jul 2026 09:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vNmPoi
	n2F7tVL3ejDyfM9Jsm60KLjNUIc8yyRoXK5ec=; b=RuZuQGeIk0i66fe9S4m5er
	ygIG1XKo2w5VhUf5Jcjvkd8rTV/B6xNH1DehZUUsJZ3UonI9TM0jn62FX3rUweZJ
	JPElVW9JeMTrdkLlxeZxwlReQU6aB4H+AHpFJsXLPLU8KaW9v9daHUSlGhKq9CKE
	voRhfb+RwTZ70RKidkrz9JOLAZEf4ao2jbx2baTEnnfjS6oBYQRaNTm5gGY578ve
	IjpeM69rYnpUE3U3TTcjBERjH5oCtfwswdvaRKN+pXxB1uyF9zCxN2PW4v8ZGOsg
	XRpfNXBXaTmC/83bj5+VMJ+MeiBifVfTCy22gJY05rf+I0IW98Yi0FZNE7/Q03Tw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdpuf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:19:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66794jPB014223;
	Tue, 7 Jul 2026 09:19:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq27h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:19:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6679J9uB51446168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 09:19:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A17482004E;
	Tue,  7 Jul 2026 09:19:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71AE82004B;
	Tue,  7 Jul 2026 09:19:09 +0000 (GMT)
Received: from [9.224.68.161] (unknown [9.224.68.161])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 09:19:09 +0000 (GMT)
Message-ID: <bb8e0b63-aca1-46ee-9e44-8e6fa46fb98c@linux.ibm.com>
Date: Tue, 7 Jul 2026 11:19:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] net/iucv: Descend into net/iucv when AFIUCV is
 enabled
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        David Miller
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260625061303.36326-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260625061303.36326-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4cc492 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Svb84iCddaksufn_uqMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5MCBTYWx0ZWRfXz92mD7K74vcN
 qxcexYHQjA29A2BJJRff0pjoqnxkW+wBDO+aNsxIjcB3X0iNmOP0q2e4LnMtpcARU1bPeDMwiFl
 lCibr51hQC5kohsytaNrAqfyodI68h97QOS7XRBMUQXum7tNcr21BG9rUBEwc26vdgOlyoYGsVw
 I35B+vzhCwqiuCwyBl0PLfIbvUcniC9xCN4N+3vJg353P/RFbwnEU6qnwTNlnqQ+2l15wfmRV22
 mvohHidcEKYB6bhzfBdHGYtcHI1trrbk2hdtn/5SEwGpyv4wzD+SJw1vaQYq5W1LbdcgWjEMB8t
 z4K0wpEkYc+NVMD6dY+4obnA1/6uP1Wf/kWiEXkfq3mkjtFPVLWUIQyuCl2mABNWeo28+QzgGsl
 BdwdvyTl0wxNJ7R3i3vUaWC6c2myzz6sH5KwtUQybOdSL2w9aupcFbJp6l2ZCb7aM9FfD8L2+o2
 7oXJLjIY879U6C/ccOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5MCBTYWx0ZWRfX7eXJ69B7kAjb
 MBu258JxDL1rokESlGYMLn3Bab79kUHoqwycZhWPTsgv2CddMD2HsC6FB9selX74x/ETwr42n1c
 KuL/nt5g+0xBV2gnUV7RNyJNgHRwOGI=
X-Proofpoint-GUID: 92y2rcLkPlAhoFC4aWv1aan7wJN1M-yI
X-Proofpoint-ORIG-GUID: ajkoCObpFC3NYSPJq0UW_mX2CPcdvDBK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070090



On 25.06.26 08:13, Pengpeng Hou wrote:
> AFIUCV can be enabled by the QETH_L3/HiperSockets path even when IUCV
> itself is not enabled.  However, the top-level net Makefile only descends
> into net/iucv/ under CONFIG_IUCV.
> 
> That creates a Kconfig/Kbuild carrier mismatch: CONFIG_AFIUCV=m can be
> selected, but af_iucv.o is never considered because the containing
> directory is skipped.
> 
> This RFC uses an always-descend model for net/iucv/.  The subdirectory
> Makefile already gates iucv.o and af_iucv.o on their own Kconfig symbols,
> so entering the directory does not force either provider object on.
> 
> This is intentionally RFC because s390 maintainers should confirm whether
> the QETH_L3-only AF_IUCV configuration is intended to build af_iucv.o
> without the base IUCV object.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  net/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/Makefile b/net/Makefile
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -45,7 +45,7 @@
>  obj-$(CONFIG_MAC80211)		+= mac80211/
>  obj-$(CONFIG_TIPC)		+= tipc/
>  obj-$(CONFIG_NETLABEL)		+= netlabel/
> -obj-$(CONFIG_IUCV)		+= iucv/
> +obj-y				+= iucv/
>  obj-$(CONFIG_SMC)		+= smc/
>  obj-$(CONFIG_RFKILL)		+= rfkill/
>  obj-$(CONFIG_NET_9P)		+= 9p/


I apologize for the late reply, I was on vacation.
I'm looking into this now.

May I ask whether you are using IUCV? Or even AFIUCV over HiperSockets?

