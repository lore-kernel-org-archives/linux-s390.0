Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEDE448BAC;
	Fri, 25 Sep 2026 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328379; cv=none; b=oPLg2vZVVBemNCdXHVCFz9r3Liql63loVt2rtxNQK3El8S0pxg4iC2I9dw2G9f9+2rIUvrLUTzgS8ROEMy7JLUqzaOQD24wueqRRViVBNrSNpCF2RO8uIFF2MGG5rmmxBjFz729QDpNQjovtngClGAs3+ancUwze/YIJTmHL/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328379; c=relaxed/simple;
	bh=64dHyWF3xDUBkMx4BGsl56khJUs+xgfaksnmm3wiCt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffSzC0LWEF3WSGbPb0mZAXPaU456+tNtbfBFpjjRI7H1JyTHAOnpfI00OCkaI0uwlT+vMk8aJILcz1BwFuR5n2hizoAdFqHQ9XlQL9K0e1XF651Y1K3hzpWOuTzb+BC2kPWBuPS9HyNbSwENWfiA8Osrw07eA6WZ0mBGdtE0ns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nKvNAzg3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nKvNAzg3"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4a7LI061219;
	Fri, 25 Sep 2026 09:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GexJc5
	gTtjBkcWkvt4vab9sGnHk9Thv1LzGa5uHc+WE=; b=nKvNAzg366OLsOKnHmdgD3
	7ekHfJHtOCD0CblSYbd4hh4IeQP/3qgm11tfKRZ0Elv9+xPhZRN8IRYCOZKXF6eu
	3Jd5Th8rJFR3OVmNRnohVtGd2JPAQc22Z+zkjOrs6tB3c9SCyyK6o3JYvDixKqHy
	jKPkHid8PZgpFJp4XrhAFFVoHHIZP9xcZHtLN+c6d45iPaORFGP7xbbM/m3BCrQw
	stb2qN5uYXWP12QrN9lzyjqM4Xn5zqni/v4Ng3KXzfs+Fmy1nQFbjZtt4L7bz5AH
	OtFoO7cuKst/Q8r0H3mihrqDOTW/KTWK+9fR/JrKgngJqIK8l0ibvq4SZzV2uLlw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsp65n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 09:26:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lpnj3288818;
	Fri, 25 Sep 2026 09:26:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe21udt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 09:26:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P9Q9Ip41615846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 09:26:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 003FF20043;
	Fri, 25 Sep 2026 09:26:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2B6920040;
	Fri, 25 Sep 2026 09:26:08 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 09:26:08 +0000 (GMT)
Message-ID: <b7707a7e-26bc-4b0b-ad58-9cd7f8f820fa@linux.ibm.com>
Date: Fri, 25 Sep 2026 11:26:08 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] KVM: s390: Improve floating IRQ injection behavior
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org, pasic@linux.ibm.com
References: <20260820121546.24694-1-frankja@linux.ibm.com>
 <20260820121546.24694-2-frankja@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260820121546.24694-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab63e36 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=TmxeUN-tGvtwDhd3k4wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BwvIrOjyDQYThvqOtvKvEJE3k1bQnzYV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfX9/5CeGP8P5u0
 3H3YDpplKCtWwaynQV9PNtAF61IFU223GJec4/6ESJdJuMMgqvtBhMLG0Uw50flRclzOW9a6aFB
 kSbNb8fqyp2pQtRqZO3rEt+T0U0XdNMjAypO4ZUeJXtwp0TFSqbTtX+rkC5AvQVGi34l+n0bLYC
 BRLKY0YRPr/hJzISYUnhhtYO/ekQNbNiMn0E5JW5y5On2rjHDX4CbqvOF7ynBFWlplkluaWnppV
 bBdH1M8v+ORD79h0lyGITqOEF1tL8aZ2v5YuVC3b+3dgvFzIM93fXVLbPQLLqZByrkk1PDindw9
 Axkhz1PK8MPHzAfMK2ilFZx0VVkAEeV5t+eJ6bptL1offDmbF5ovR4dAlWy20nBOGMs5hqWVS4e
 3m8MyC/JbeSD/064sql6RgROadNUEwmL+nB8tSct5v+eUfXRvATmUFNWV/cJikcS5CwX40js5ss
 0vmVehkddduPjQKji6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfX1KWvi3mZ+AmO
 aB7ZqvkEpuwxaWLp4jb2xs2dR3u+pAQ6i398MRq1bLy6YNkKJDumfjxx3Wl0mZuzLboCZ+klA9a
 prOo6Qm27z1Y5fdJjATsDPipUxVHm84=
X-Proofpoint-GUID: BwvIrOjyDQYThvqOtvKvEJE3k1bQnzYV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250036



Am 20.08.26 um 14:12 schrieb Janosch Frank:
> Floating IRQs can be handled by any VCPU that opened its masks. The
> current design does not check if the mask is open when a floating IRQ
> is injected via the FLIC. It will wakeup the last VCPU that went
> sleeping hoping it's the correct one.
> 
> Improve this by checking if the VCPU has pending IRQs and if not try
                                        can deliver that particular IRQ> to find another VCPU which can take the IRQ.
> 
> This is not the final fix around this topic but we'll eventually
> inject a pending IRQ. The current code can easily deadlock a VM and
> with this fix we work around that.


One question below.


probably not the last version of that code ara but certainly a necessary
fix in the right direction.

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

We should apply this and add it to kvms390. We will get some
performance regression testing via the next kernel then and wait
for the results before sending out a pull request.


> [...]
>   /*
>    * Find a destination VCPU for a floating irq and kick it.
>    */
> -static void __floating_irq_kick(struct kvm *kvm, u64 type)
> +static void __floating_irq_kick(struct kvm *kvm, u64 type, int isc)
>   {
>   	struct kvm_vcpu *dst_vcpu;
>   	int sigcpu, online_vcpus, nr_tries = 0;
> +	u64 irq_pend_mask;
> +	unsigned long i;
>   
>   	online_vcpus = atomic_read(&kvm->online_vcpus);
>   	if (!online_vcpus)
>   		return;
>   
> +	irq_pend_mask = inti_to_irq_pend_mask(type, isc);
>   	for (sigcpu = kvm->arch.float_int.last_sleep_cpu; ; sigcpu++) {
>   		sigcpu %= online_vcpus;
>   		dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
> -		if (!is_vcpu_stopped(dst_vcpu))
> +		if (!is_vcpu_stopped(dst_vcpu) &&
> +		    deliverable_irqs(dst_vcpu) & irq_pend_mask)
>   			break;
>   		/* avoid endless loops if all vcpus are stopped */
> -		if (nr_tries++ >= online_vcpus)
> -			return;
> +		if (nr_tries++ >= online_vcpus * 2) {

why 2 rounds?

> +			dst_vcpu = NULL;
> +			break;
> +		}
>   	}
>   
