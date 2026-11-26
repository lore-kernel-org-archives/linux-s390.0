Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795673998;
	b=wdHFBR5juRCK4UhvBHyDOH1riP2bfe0vHBUiuZmWSJsV5cpk1z/p7qqMa6AQrwwKOEle
	 ghYwZuCcZDnApXhUz+6y2nSzp7W/pqgAiL4U1UFqi+nphjxQsrzMW8r3pZlE6NqNEDTbS
	 fhAeFlx0fQfvx0X6FSGFj8A3wx4YyuiFCCQG+tiurxn/h9XF/m0Yhuib5lr9eyhhDkapg
	 glzYhl06BePDeNRHPKEeKCfdKZ8FL/yEqPCvr80XZEbMqURapQ/P6TfttuENlKNTQ4Auk
	 GI1PVLXVIS6EtDg83LxDJ4coU+9ur+inNMocOidomHRyxajDVnGRVgXFmgrJtc0PSYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673998;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FKs1FwAWSO2Z+pkZGpy8ERmP1gFS+dAPOLCS0ak19ts=;
	b=NvfF1SM490k6gJr0lpgYEFH8inody3ebXIt1yvzrR6yShkfy/ypdBGVl5135rsw+1Lb+
	 6ZXtCLNK6AJOrSUumMePSMrNIQYkv+YR0rNgCJPIBvZ1DI9eUbynPUJFE3vKD4nfKqMUU
	 M10Zbz5DDNvgnV3C6HVtY9z1qO2yPnMFuhmzbQE5pqythVJZkhVJnbR3ouCN2sy8hAWlk
	 gPlDsM/Tu61q9jecpzSgqyf2ezQT6SYkFTXKA9ORunQ5U8ddpULrvS6GjFIfPBB/Fr+sD
	 kqnsVS0b0BAl3IK8Yj6SO9wI+j3ff/5sdBY9KGa6KB1L8TQFNiHHHnCGufhmBf8IuLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=F8aJU1RH;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC043606A323;
	Thu, 26 Nov 2026 06:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC043606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=F8aJU1RH
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ352HY1865049;
	Thu, 26 Nov 2026 06:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FKs1Fw
	AWSO2Z+pkZGpy8ERmP1gFS+dAPOLCS0ak19ts=; b=F8aJU1RH5/R44cZXuz9cZk
	Dwkij5AQ1h6AgVqQf9pDTOwLBCTqPkcMkaYeA6768LlJeAbTtd83fvS5+nyzufqC
	CYyUX95WSrVWy58X412yRzgqxt2GvSIi7z7CpW9B4TBk9BOb8eo3pHKtv/xyPOny
	yJxtUQhEV0pynu5zkzgjg3amBc/ALDonFfPTyAU1K7dWVBpYdAHrDXiFQMhM80zR
	OBoVK99HNqHjRHsn+kGUPdDPOUIMLl1lgTEuHbmRaiLtKbOLRM2dbbV9cGxZ5KYh
	aFlLWmoOzBVeuRpY2uKPfC7/US93uhwWRBaWoWa+vDhz1V1jqSe93TOQxflahHcA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4q83g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 06:19:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ34RtX1743330;
	Thu, 26 Nov 2026 06:19:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5dcuxbc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 06:19:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQ6JkBG51118458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 06:19:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3A1120043;
	Thu, 26 Nov 2026 06:19:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AA6420040;
	Thu, 26 Nov 2026 06:19:45 +0000 (GMT)
Received: from [9.111.6.167] (unknown [9.111.6.167])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Nov 2026 06:19:45 +0000 (GMT)
Message-ID: <cda46aba-3a92-45a9-91d2-97b50b9773e2@linux.ibm.com>
Date: Thu, 26 Nov 2026 07:19:44 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390: Export arch_smp_send_reschedule
To: Steffen Eiden <seiden@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson
 <seanjc@google.comu>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org
References: <20261125-vcpu_kick-v1-0-a203b01ab957@linux.ibm.com>
 <20261125-vcpu_kick-v1-1-a203b01ab957@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261125-vcpu_kick-v1-1-a203b01ab957@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyMyBTYWx0ZWRfXywzDqnZOUeZ4
 uuhXla2fopV8/YKj70heSvLlMFx08dcdoHUFgduRnVG93lp8EBEF0WGwXCQdYi+NNhhzPaBYoAZ
 znUfH+88VKQ9q0ZbZr5r8YQ6S91NzPs=
X-Proofpoint-GUID: EgphuU_LGPAZNDuquVpj65zfRyyyHD3-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyMyBTYWx0ZWRfX9Z1hiF7f+AdI
 xAUcUAKP3sCOcfzcX4h3Aw53OSkH2Aom6XKMRo7GcoRkVeYjW20VWDL+/65/nlnTtPyqSUOsya4
 XzykzIkK68tWa0fxmACPtRqG9fzrZrSOqXMcrz8TCNr1fxgNDmfunm9JAwnyAYQk+LS8PvafNGV
 fdKbTMLwScxUjelcA/Fe0WewMsBzf5QEyt6ANCuOETHZeo2uBrQRoUk2KHtElD9Msq3DsLAHoIY
 gqobH5anaidX+YW5F3MbJbOp+PlEHInOfmP5ugbIR7nJ6ypfOlHlVWgR1F6S0Hd8L2Mzcna5IQ/
 ZQKBl/2MZt3WpKLZAHkCYbK/i6SBLdy0kwJdZQlbPefiGMnyx0k6F1uqtC6chjmR+JO0CfQCR4Y
 cAFH045mPKr9ID9YLq08kfrTrB+izp+cpJQQg2a3ilDgORvaI17J6OlAioH4jLgu5LPPRL7bTxg
 gculyHmE1802RG9XabQ==
X-Proofpoint-ORIG-GUID: EgphuU_LGPAZNDuquVpj65zfRyyyHD3-
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b07cf86 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=d9NvWjuJi6MohXtkMQsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260023

Am 25.11.26 um 17:38 schrieb Steffen Eiden:
> Export arch_smp_send_reschedule in order to be able to use the generic
> vcpu_kick infrastructure which is required for arm on s390 smp support.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   arch/s390/kernel/smp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index f7c262a17c03..14d198789e30 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -531,6 +531,7 @@ void arch_smp_send_reschedule(int cpu)
>   {
>   	pcpu_ec_call(per_cpu_ptr(&pcpu_devices, cpu), ec_schedule);
>   }
> +EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
>   
>   #ifdef CONFIG_IRQ_WORK
>   void arch_irq_work_raise(void)
> 

There is a similar patch from Sean already.
