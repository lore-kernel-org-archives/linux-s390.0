Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F9E39FCB4;
	Thu, 16 Apr 2026 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344829; cv=none; b=ESgQUElN9fMldvfG8cbKWi9vZD7g3Mzw0cVsBNvNJABci+js0YghgHP+IBI3E/hpEVYx6f3xgAlswb9EvwS/YcCCNHiJ5q3Gn6DlDQT0mGgQ7B6Hw6Me7zQcHh8LlufXHzGHwMoPRPPTdShAjUFZwz2kFh2FhkwYt9oEMUIz+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344829; c=relaxed/simple;
	bh=63dp7SlgmOxi197iG0g9Hq200vm4448xNqqy2iUmeo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lT1wjy/0kvMKjPkmaMPmvMbc2luBWShijqOSwuk+wKp3t/rdxlcUvktxTbWt1oNwegQ5ySaNZC4HyakP6mdzJHxfvRv7AP9V+x2ucGqxA0RAubzvwj1dYxPjAR3YVl9oZvtqNjU+eI5WZLLz/KRC3fGT1NfeFs/LUqRkPEYnzaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J96npSvX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J96npSvX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G9aI781861213;
	Thu, 16 Apr 2026 13:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pqFG4Q
	O8HfP+fFwkZO7Eo6wItK0zCl8WRPM9giOYJVw=; b=J96npSvXONglaE0LtmRSpJ
	0KFr1vvT59kjWZ+3CJKE8vA0Hx4UWQsTRyeTdUBwd3a/KD9tTSkwgb2EFXGJSD+K
	/NIWKOt96n4jRKb6oNa71Z7Lrme5F0DE4+IUU8j5n2DAnW5SVyeC9DuV+MHIje0+
	i3OJRJMr2pQDrDlaZRmxSCk+5jU6usEC0xnnHKwo1RMJYOkpsqvZJNqGpnm2CTr4
	N4YgI7CQgLNKyMcKjU7pzBhTkKw/ftWgwZ7QnT2UZJkNxu9OsuhtKw8r3jPYotsm
	JitryRL8GDEsrYFtkIX/Y11R2ofx2vaoXOw2V5yl7n4vSLIvJq49GnQghYlMRA7w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89pmmey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 13:07:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GCuCc6004188;
	Thu, 16 Apr 2026 13:07:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24kjvh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 13:07:02 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63GD6v7U59965896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 13:06:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAE0320043;
	Thu, 16 Apr 2026 13:06:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 903402004B;
	Thu, 16 Apr 2026 13:06:56 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 13:06:56 +0000 (GMT)
Message-ID: <b1f22f3a-398e-4ce6-8092-aff9c9aaaf9f@linux.ibm.com>
Date: Thu, 16 Apr 2026 15:06:56 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: pci: fix GAIT table indexing due to
 double-scaling pointer arithmetic
To: Junrui Luo <moonafterrain@outlook.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Niklas Schnelle
 <schnelle@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
        stable@vger.kernel.org
References: <SYBPR01MB7881AB7449FEB6B58E4BA6F2AF222@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <SYBPR01MB7881AB7449FEB6B58E4BA6F2AF222@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: NW56HftzDTMgUDFZwgF8K7OabTsz_0QM
X-Proofpoint-ORIG-GUID: 14o-LYMtCCHIV5jIu7CNS0KmfqmHsa7N
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69e0def7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=VnNF1IyMAAAA:8 a=8PThvJbLQf9hx8_nC84A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEyMiBTYWx0ZWRfX7xBa5k7TOSbS
 jhume73xGAauRYkukiaJEAphxWVy6YBOd8MyWXza2beljEnn5My7b65568WaF7tRzSPXGuv/qiT
 3yadZxx9kndJIIjGMj4rpmCeKpNILVtZjiahaJVE2uje7U1eYtGVgMDQifu1JL6rOP0ZJsGxwO7
 aQFWSGWHLh6OWLFsE4hunKVT4G+sXOhUvPAjlC4yfQ6KnL2l35/gLM6pUafN6Z+8iMzMRdeMBXw
 TlGO6PwRXgcFq4uXO9SAKCwXmJq8nyyvJDWTh2Hh0EsZLTJ/OKDf44QoqMdoMAmYKfaeCS9aXj1
 mh4ToZkEgYOhTZ/DN4mMVIRiXF2HKTh00wUlBZAEtlSGoN/Hnsr7wQ3bZz8oVQTo/g0XnKi1dWG
 rzQRhWAie7VJ4W4ln970ScWsfvzSJmDCjN7UATwBJibT5eafcFPr1p3BaD5aN2j9fR6IyluIP6v
 G/Bz5AsUA0Moga2EoaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160122

Am 15.04.26 um 11:26 schrieb Junrui Luo:
> kvm_s390_pci_aif_enable(), kvm_s390_pci_aif_disable(), and
> aen_host_forward() index the GAIT by manually multiplying the index
> with sizeof(struct zpci_gaite).
> 
> Since aift->gait is already a struct zpci_gaite pointer, this
> double-scales the offset, accessing element aisb*16 instead of aisb.
> 
> This causes out-of-bounds accesses when aisb >= 32 (with
> ZPCI_NR_DEVICES=512)
> 
> Fix by removing the erroneous sizeof multiplication.
> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Fixes: 73f91b004321 ("KVM: s390: pci: enable host forwarding of Adapter Event Notifications")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

looks good to me.
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Out of interest, was this found by static code checking or AI by any chance?



@Matt, can you test/review this as well?

> ---
>   arch/s390/kvm/interrupt.c | 3 +--
>   arch/s390/kvm/pci.c       | 6 ++----
>   2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 7cb8ce833b62..f48f25c7dc8f 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -3307,8 +3307,7 @@ static void aen_host_forward(unsigned long si)
>   	struct zpci_gaite *gaite;
>   	struct kvm *kvm;
>   
> -	gaite = (struct zpci_gaite *)aift->gait +
> -		(si * sizeof(struct zpci_gaite));
> +	gaite = aift->gait + si;
>   	if (gaite->count == 0)
>   		return;
>   	if (gaite->aisb != 0)
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 86d93e8dddae..eed45af1a92d 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -290,8 +290,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>   				    phys_to_virt(fib->fmt0.aibv));
>   
>   	spin_lock_irq(&aift->gait_lock);
> -	gaite = (struct zpci_gaite *)aift->gait + (zdev->aisb *
> -						   sizeof(struct zpci_gaite));
> +	gaite = aift->gait + zdev->aisb;
>   
>   	/* If assist not requested, host will get all alerts */
>   	if (assist)
> @@ -357,8 +356,7 @@ static int kvm_s390_pci_aif_disable(struct zpci_dev *zdev, bool force)
>   	if (zdev->kzdev->fib.fmt0.aibv == 0)
>   		goto out;
>   	spin_lock_irq(&aift->gait_lock);
> -	gaite = (struct zpci_gaite *)aift->gait + (zdev->aisb *
> -						   sizeof(struct zpci_gaite));
> +	gaite = aift->gait + zdev->aisb;
>   	isc = gaite->gisc;
>   	gaite->count--;
>   	if (gaite->count == 0) {
> 
