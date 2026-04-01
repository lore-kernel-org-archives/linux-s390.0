Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055D03FADEE;
	Wed,  1 Apr 2026 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042734; cv=none; b=teYr6X/kUtD9jVKmhf0FzkRIllPPnYOQC5clLDQSWsWXBQn2EV3r9T1TyX9nboO5QCqA8lGbbhPO5aKw+rtkS7mqATHb13vXbMaM+TFkg8aZLVwVbJopzfZ2X0uoGz+eAVKZEeoBdSb5CNM6hx10RyB79yE+2FVezs0F+uFakK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042734; c=relaxed/simple;
	bh=OCnLWkIkFkss2nBor0nyvAM8mp0fMHdIYYgLKSxMZ1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIVZZuVX6dwtEhAKnLQjlAmawAk7Y0fERQupaeCmHBh3tlTzjPxj179KfxSsadDxLDU/aGbmL3jzy26hoNYW41iH3YyKwMIMdnLEyHPKcI+X2iqCnKwdhqq9EJEgMLy6ICby2zWv1FaBD8Zkq/sLzUzgQLAzd3Hp8MgAEQhSXQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hY7VaEzu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hY7VaEzu"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63175IBu3246357;
	Wed, 1 Apr 2026 11:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qEZvvB
	HIkYiCec4/iD9JhXygPb+INqsCI5GTcQpLpMI=; b=hY7VaEzu7YdbqdTbyM4YLv
	2MxW+fFqh+XyebjnISwaKVBqydeCw9i6JhYf7O7vlli3KQwr7rGiBMLaIk1oved2
	vMhJZSkEBN0DHeffcWViHK9CRWLAMnEEwvjbYYfCOidosXLOW7sovrgATQucoxZz
	T1v2FC1MpOl0L/46c02wj51ZlJPjcGico4l1OE9mzmOllkrtFaNYsCrDP9Hxz+RQ
	OBQw8W/ygFwdyjeg3Lio1J95H1v4l8HtfQGp1m/pm/ulXhNto9E0IcsUibv119xb
	qbtY+WIpwue4DuWapGLqoT+lZAp605tt21FNuKheHWXwCNlf3V8hq9ozbwryI5SQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms72ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 11:25:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631Av3Uq005977;
	Wed, 1 Apr 2026 11:25:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy5d8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 11:25:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631BPETk42009046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 11:25:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAED620040;
	Wed,  1 Apr 2026 11:25:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E27B20043;
	Wed,  1 Apr 2026 11:25:14 +0000 (GMT)
Received: from [9.111.57.22] (unknown [9.111.57.22])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 11:25:14 +0000 (GMT)
Message-ID: <7aed180b-65ad-42fe-8785-d6ee0c112815@linux.ibm.com>
Date: Wed, 1 Apr 2026 13:25:14 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] KVM: s390: vsie: Allow non-zarch guests
To: Eric Farman <farman@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20260401020915.1339228-1-farman@linux.ibm.com>
 <20260401020915.1339228-2-farman@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260401020915.1339228-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cd009f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Dd2RYGZ7o6lLYqCbQRkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEwMyBTYWx0ZWRfX0ZtsrB6VuqJo
 taIri+/nYd2s5e4g1u8x9jhTO4lPQuyCOYJyRIGcOA9BnqFOaKhSmjMeyXtPfteSTNyN2cycbfA
 /J7UEDhCQJYUhCFBvYlOwXSiQPiptkpF403ZGz1cXvPHcZbRZcQ1lJnLVB/xbG+xf8azYEGFs8O
 sBSGR12ABh05CXEo9F4/zIZj/ZjP+OSl7wNodlgpXWTOTfVdhd+lwhtoYxerivj9qFKvCOk4zhD
 1IdqbqWbcTzb/3/FkI8VtebqyNopbZn1V77XWTTb6gHtRSbICDUddF/one+gs2kLAJx1RbYdeE5
 irMrYFpcQh97AVjoPRVcc0v8oeABxIVaKXxNQJPiUP10pkydbfLL5+W0RFN4wCCTDipqwORzwuG
 /dEhhRwSuMnr9zaqSJCZO9LBu6cjzuNmM5Eo7tmDL59PagwMJXddU8bM/KAKmgal939t3Eqfmj9
 HgRoaU46WfJSeix6hQg==
X-Proofpoint-GUID: 3_mUZDt9E4RtYoKBWorv79yk9lTAHpEM
X-Proofpoint-ORIG-GUID: 3_mUZDt9E4RtYoKBWorv79yk9lTAHpEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010103

On 4/1/26 04:09, Eric Farman wrote:
> Linux/KVM runs in z/Architecture-only mode. Although z/Architecture
> is built upon a long history of hardware refinements, any other
> CPU mode is not permitted.
> 
> Allow a userspace to explicitly enable the use of ESA mode for
> nested guests, otherwise usage will be rejected.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h | 1 +
>   arch/s390/kvm/vsie.c             | 8 +++++---
>   2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 3039c88daa63..8a4f4a39f7a2 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -656,6 +656,7 @@ struct kvm_arch {
>   	int user_stsi;
>   	int user_instr0;
>   	int user_operexec;
> +	int allow_vsie_esamode;
>   	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
>   	wait_queue_head_t ipte_wq;
>   	int ipte_lock_count;
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 72895dddc39a..888370a02ef7 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -125,8 +125,9 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>   	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
>   	int newflags, cpuflags = atomic_read(&scb_o->cpuflags);
>   
> -	/* we don't allow ESA/390 guests */
> -	if (!(cpuflags & CPUSTAT_ZARCH))
> +	newflags = 0;

Not sure why you have that here but removed setting newflags below.

> +	/* we don't allow ESA/390 guests unless explicitly enabled */
> +	if (!(cpuflags & CPUSTAT_ZARCH) && !vcpu->kvm->arch.allow_vsie_esamode)
>   		return set_validity_icpt(scb_s, 0x0001U);
>   
>   	if (cpuflags & (CPUSTAT_RRF | CPUSTAT_MCDS))
> @@ -135,7 +136,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>   		return set_validity_icpt(scb_s, 0x0007U);
>   
>   	/* intervention requests will be set later */
> -	newflags = CPUSTAT_ZARCH;

I'd leave this but set it to 0.

> +	if (cpuflags & CPUSTAT_ZARCH)
> +		newflags = CPUSTAT_ZARCH;
>   	if (cpuflags & CPUSTAT_GED && test_kvm_facility(vcpu->kvm, 8))
>   		newflags |= CPUSTAT_GED;
>   	if (cpuflags & CPUSTAT_GED2 && test_kvm_facility(vcpu->kvm, 78)) {

I can fix that up if you want.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
