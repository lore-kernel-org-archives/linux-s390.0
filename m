Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28BB2DF128;
	Tue,  2 Jun 2026 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780421453; cv=none; b=kXLkEpfSRMNQfhVtKOQKROfjMg39ClukoycePP+wynzo70SsdvmLxeS+Ds0cFYriDz75PARjukLvsve3NRuHYIQYvp8JeAzvHskn6k7PHvb419UGVFehNXAaAxJRIDy1/mXT6qrxke5cW9eXZ3Xm7M1jxXajbds8sSKu8FBWNTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780421453; c=relaxed/simple;
	bh=JWH7t4+sO4nKECiW6zgIu50W4yDEzzqFl4fGqfRqN+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DzVTHTSaVPiNADcuDgyQuAvVA749IZ1B+OKpSw7KcVPxuoYj0WSd1VkXPQXW9KgFX/GjcN9YS+YhrtOwfmHFVzotSa1jgQgGDGQzTN2hnrcYvmq8//szFaNBGDrkPGxSJXujiNzb7XYP2wyaBw+7WZhSyMwWQjRBFEBc0kO3Zrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pLEcsnzI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pLEcsnzI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652E2ALM3100564;
	Tue, 2 Jun 2026 17:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DfNdAl
	/1/Kw5DVTMdXvB+cCk+/rRiDtaoYmK/IuDXgk=; b=pLEcsnzIoMH+Tw+a0VeDdI
	uWirIOybttfgRbWniHJCRJH/HXHZLB2/lIE5TCPjHN2RpPsM8172x/G8RXhmmF+W
	TzQKrpVJEJHgW9M1qGBvoBTcpt1rjhT9VEDgb/iHewWxX6uJrrpbXgBM0xOfPtzW
	m844AchWY5eLSd3kXu14LLee8mDOHiwfGNX0dY7q37rteOvgEGcx5rqvT4rROBIT
	jGPTHFr13KXPtEgho2yPW0MySKsibjbTruASS1cPcwB7uesqur4SFjkct8eWOXOX
	7rrhC1RtnsqUuZqSh11an3QGkmj0QiHZQAWCnjbRUI4wXybJZKhpE0Jii44wFZlA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht6nn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:30:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652H97YE031908;
	Tue, 2 Jun 2026 17:30:48 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhc8vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:30:48 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652HUlt611207226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 17:30:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32CDC5803F;
	Tue,  2 Jun 2026 17:30:47 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D92E058054;
	Tue,  2 Jun 2026 17:30:45 +0000 (GMT)
Received: from [9.61.150.19] (unknown [9.61.150.19])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 17:30:45 +0000 (GMT)
Message-ID: <c9797cc0-d661-4208-bd89-d96fff3b8a07@linux.ibm.com>
Date: Tue, 2 Jun 2026 13:30:45 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic
 fast inject
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260531190353.204317-1-freimuth@linux.ibm.com>
 <20260531190353.204317-4-freimuth@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260531190353.204317-4-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HHTVh7IQsIklxulrs91YVk4UqEUwHG77
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1f1349 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=YGzSi6MavSGfRLApEBgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE2NSBTYWx0ZWRfX1TRIMRr8QCP5
 //CS5NudC2KsyVrQ6lWgFTT8yuhLoltLza/n1PmSttyhfPFOJe3Y3gwnVblB1H8h94u3M++WPru
 jy7iLGxTvNGPWdWzopzQsUhpgr8fhccmu3nre89lFsUbw75oS7Lm0UGuQecsMPzTDPKtNfAO/fw
 niHBSdRpgdMg9OcZ/nQxXjdSaHi6BP2GCkUzgpF9Lql3hmee4eOGi9wtT5avwxsTeyw6u73ycte
 pSxmPE2y0ZJN1VUu6b1rv/Q3enVWGYNX/RWdmOrFbJ6MB0GzAQ2WJFjnIaMpF2y9Uh3WHoJE/ky
 hZ37pmFTbLgscHkB+OImcg7RQUp4RF+prgkzZqwX/lp6OO9+XcDTnc+ymmGLq5FGYWgSzILXvNX
 0ecH7EgAMK8X4Nf+VWHKzzcqpmzk3s6727JptibxVYWvMxjyNQdN4Eom3Sw+QwEV6CMKI51kKFO
 7H090B79WcKL9kLl4WA==
X-Proofpoint-ORIG-GUID: HHTVh7IQsIklxulrs91YVk4UqEUwHG77
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020165

On 5/31/26 3:03 PM, Douglas Freimuth wrote:
> s390 needs a fast path for irq injection, and along those lines we
> introduce kvm_arch_set_irq_inatomic. Instead of placing all interrupts on
> the global work queue as it does today, this patch provides a fast path for
> irq injection.
> 
> The inatomic fast path cannot lose control since it is running with
> interrupts disabled. This meant making the following changes that exist on
> the slow path today. First, the adapter_indicators page needs to be mapped
> since it is accessed with interrupts disabled, so we added map/unmap
> functions. Second, access to shared resources between the fast and slow
> paths needed to be changed from mutex and semaphores to spin_lock's.
> Finally, the memory allocation on the slow path utilizes GFP_KERNEL_ACCOUNT
> but we had to implement the fast path with GFP_ATOMIC allocation. Each of
> these enhancements were required to prevent blocking on the fast inject
> path.
> 
> Fencing of Fast Inject in Secure Execution environments is enabled in the
> patch series by not mapping adapter indicator pages. In Secure Execution
> environments the path of execution available before this patch is followed.
> 
> Statistical counters have been added to enable analysis of irq injection on
> the fast path and slow path including io_390_inatomic, io_flic_inject_airq,
> io_set_adapter_int and io_390_inatomic_no_inject. The no inject counter
> captures adapter masked, coalesced and suppressed interrupts.
> 
> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

