Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76252535FBA;
	Wed, 23 Sep 2026 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172261; cv=none; b=aVgD0jG9ektlbDggT9B6M3JMCSrm46AyNQ4oohsVLWcpFh09xtyolFpjTadGUPfHfsZE0v5Wlqh+c38R94nN2LYyQqLKyeEhGlAJe62jykTpa0yZX4KPtAfvRop9qAibq/Oc0H2ZMqkpEjuV0nO/u0L/EeR26jSjxXxsV8Cp93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172261; c=relaxed/simple;
	bh=GOdms/FII9B39Z5lXe2XSILG2SFCtrvD6yzL7071DVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2ypo5ot7ed9hzJ8UIpMg4H5VQeHhR4K5NWX9TtvqTjq0MTFLyxtV8J5KEaX9hwcunTYLvyK/gBab8SQjGA2IT6ef9LEPyIO4t/Hg2VIjVtmQxHVq20TYt21UbXimhG9GKt2GM5lfGzgorekRH2qDoXIw52sH/IsNd4jly5JxVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IoXYFk9z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IoXYFk9z"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8ZgqE1030882;
	Wed, 23 Sep 2026 14:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=k1PANw
	X7woNhDPpZ4uBlTfAvqZkvgqy8uusp6VwtT50=; b=IoXYFk9z8KedkDkfNQAPVz
	ia2imVIPEQh6AjRkk3jQ3EOr2I4+Rd2KO8DU2RSucO+ijgF/N9y83uWASULi60E4
	pmnDK+VcpqzNcSGR0oyT9qGKYfnnMQK0Y9FshH/bSH5vhIMCYIKsEkklntFAOtNL
	Tm1lhpqu3siCHs9sQ0kV8kjG/6+9cDcFw8tq/USQ11ami2SdKSAMyW8+LgfTQOpi
	WxCIBefkDGOGEOruua5GcoUgwXzpyaK8kl1yH2f7RyNHHzYdmB0hsebYTnyTYNsb
	JfG/eJoQAxs4fsnWZlpNcdEJKGUJuY9pAyPtZTLfrAWSS8AvvUKYCnFV5Ka91ebg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1uq6r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 14:04:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NCPrv1008448;
	Wed, 23 Sep 2026 14:04:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jsa8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 14:04:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NE4BVp44433702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 14:04:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B10420043;
	Wed, 23 Sep 2026 14:04:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4198D20040;
	Wed, 23 Sep 2026 14:04:11 +0000 (GMT)
Received: from [9.111.80.133] (unknown [9.111.80.133])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 14:04:11 +0000 (GMT)
Message-ID: <45f3d2f6-75af-41eb-b8b5-a7cf42f345fa@linux.ibm.com>
Date: Wed, 23 Sep 2026 16:04:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/21] KVM: s390: vsie: Add helper unshadow_intercept()
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-12-f39806eaae37@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260918-vsie-sigpi-v7-12-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 2cgAq6lgY9znredeS3RAqFXJpThcKX-L
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab3dc60 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=RxkZ1HasL-odzlW5mFoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1NCBTYWx0ZWRfX5nMwD1lRw+dU
 4bWn1PTuusDgrLHzDHK3JLGf0IJkXfAq3axOeXZdwRuPCxDz7Adc9YSfM4tcLDo4XQy3/cuCqen
 i0YCHEbBjr/j6PpdukpuglmBrEzml+I=
X-Proofpoint-GUID: 7dA67ctnDgLmXqpYMYGS881bufEIzd5_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1NCBTYWx0ZWRfX1Bt5RAFzmEb2
 ZR9Fvp4FB+SRcV2iiErVdu7SFExaYUyBjp9dcXXnpnU4B3DWV8FepBP6AYrIWqNjeHozCgApSvE
 cKwHpEoq+vGmwgCq6NBhGxD6Madv/9FdGb2Ce7phiQiFGAYh6OyaOwGrhokYsrIZfEBbz+0L6ul
 tFYgTc6Q+nFrY9svuFSXoyUcFNp+34wuTc71TNQmcVo1kFEWylmmoYKE3bZitHza27gjav+iHAC
 emiKpSq3/yN458HfWWOEReZ7ZrSGwjnOlaj9jXwzFvC7whBvaA/F5t9KUf4GNqqoupRdTvab7DS
 4hAf/beaHv/b6PPKf+n0Oe/a4nT+mpwhUcFACVqw8mJSwbM6qoX/HnLhinC91SwAYK/SZfWiNMs
 I1t+BkfQCmH5MvdY03ISDD2ZBNMet1xQ595N72xK+YG0BpPcxqJYXAYKVcsqZouErAzjurEbl66
 oQLCH7AF9Xrn1TgGoVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230054

On 9/18/26 5:09 PM, Christoph Schlameuss wrote:
> Extract helper method from existing code to reuse in new code.
> 
> unshadow_intercept() acts like unshadow_scb() but only copies intercept
> information. Used where the rest of the scb is not yet shadowed.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   arch/s390/kvm/s390/vsie.c | 28 ++++++++++++++++++++--------
>   1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index 95baac9a1ccb..c42e2df4c0ab 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c
> @@ -565,18 +565,27 @@ static void prepare_ibc(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>   	}
>   }
>   
> -/* unshadow the scb, copying parameters back to the real scb */
> -static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
> +/*
> + * Only write the interception fields back; avoid clobbering the timer and
> + * guest-state fields in scb_o.
> + */
> +static inline void unshadow_intercept(struct kvm_s390_sie_block *scb_o,
> +				      struct kvm_s390_sie_block *scb_s)
>   {
> -	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
> -	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
> -
> -	/* interception */
>   	scb_o->icptcode = scb_s->icptcode;
>   	scb_o->icptstatus = scb_s->icptstatus;
>   	scb_o->ipa = scb_s->ipa;
>   	scb_o->ipb = scb_s->ipb;
>   	scb_o->gbea = scb_s->gbea;
I have the feeling that we make things difficult for ourselves by not 
writing SIE entry validities into the scb_o directly. And I think you 
somewhat recognized that problem since you chose to write the validity 
to scb_o and not scb_s in _shadow_sca_cpu() but I have yet to fully read 
that patch.

For 99% of the validities we've never even entered SIE so we copy data 
twice for absolutely no reason other than symmetry. out_unshadow in 
kvm_s390_handle_vsie() isn't really necessary, if pin_blocks() fails we 
can jump to unpin_scb() if we write the validity to scb_o.

Maybe we could move (un)shadow_scb() into vsie_run() and be done with it.

I have some more reading to do.
