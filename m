Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB36F43E4BF;
	Wed,  8 Jul 2026 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514045; cv=none; b=CEshQ9IqSBtAPifl8n3xAN9ijO1uKTW5KynE91VGMMNuSbDAXpTefW43u7M3onCoLV+Yv+SG20GCRlVLmLbVoZ5Ta1HCNEVvq+LpnJijyGvkM8QKHUbr4pUwJxoKK3M5czaS/Y6IYTPYEs7skBLR5K/+g/sm3+wLZao9NIFpklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514045; c=relaxed/simple;
	bh=Sak7QvJcqGdzg6URahg33mOoQj3UmQ+VzJdS4O5wGxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcPs3QVo0QZ2WpjvV7lwWgXDJPerAQAXVeWXmEJe5WJ1g6G3A3WTNuZTcjFumlAtxlXLdmjr1Upx221CpW7MbnVRTg0MEV8Bzcpnx+1RIIOw6e7N3tnjCmcBYwZJSkg255SODaotLHKoLjG+fP9A/gW+tz1cQFb/527Je6GySN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E9ofePlA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E9ofePlA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668CImAq2335979;
	Wed, 8 Jul 2026 12:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=86wRgf
	AVz7FueE9U7ls4+RYnpg5fBqaadg/cqqUr6oY=; b=E9ofePlA8gqTWwjmNnafmV
	shu4r6m0oWXb8TtiP3Yro12BsY5b7UnXGtYld614T0iLBmzQXR+TS4LbHj2uZr+d
	tyKAK2e+bTDqMX1C9lOYLUBDwPYpn1CiUWsMvQUwHx914NS86eK+1SkdItB7806Q
	H6GKQJUJWKrcgQ5xRHXvcJiHb4WlQt4o0b98aqj+tsEuWRpvKzVKSpeq5g8QsKby
	sIyGmbAXHAOO4uKPYPmBM9mIQ5e11oZ/8HIip/9p/MNWg52eDYlpPYe+c0+ojDHN
	PrmKH/F1pwcCI2B6gUMTd+2lagNAI9Zy2VWD6sBbwrZrnHN9a7ni2+2xjbTqwqBA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsvqa8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 12:33:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668C52IQ008356;
	Wed, 8 Jul 2026 12:33:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgk805r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 12:33:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668CXVtI37486898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 12:33:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 856202004B;
	Wed,  8 Jul 2026 12:33:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5C332004D;
	Wed,  8 Jul 2026 12:33:30 +0000 (GMT)
Received: from [9.111.36.87] (unknown [9.111.36.87])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 12:33:30 +0000 (GMT)
Message-ID: <9b7bb3d0-dd39-440d-b006-b892dcaebcb2@linux.ibm.com>
Date: Wed, 8 Jul 2026 14:33:30 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/27] KVM: S390: Prepare gmap for a second KVM
 implementation
To: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter
 <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-16-seiden@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260706085229.979525-16-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rrQHrSs9iRFuf-X0DRN_bf6KueThCAoR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEyMCBTYWx0ZWRfX37+lU2cUJMwv
 8xaV7gpSbwtLQ9LCZSjHMX1E4vr3jf/xx28ZEd85wMCVsiQSNtIg4K3A2eOLSqiYkjQ32Nbmdsy
 Pe2f1sT9XUFnnI5O27U+OTDIcGhEvrc=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4e43a2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=8QvOpCumMmOhd9aBVjAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rrQHrSs9iRFuf-X0DRN_bf6KueThCAoR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEyMCBTYWx0ZWRfX5nXq20gFgEdu
 RvPsihU2PINojLJsSky2/gC+MxDtDmOqDLGx+QilpuWVR4UsD+wXPohKdi/mMrJD6L6kqwzXGn2
 8xNWNyAqofPWgCyojGPCHlg+YTZTmVd4FehXdYW6LjGaqK2F8q63qodP83Wmznp+4Vc4a1uP0z4
 3B771aL3La5JXi5cq3VuaqpI2ZCBCwJRcXnuqx6x7Id7BgJdx7r/zF3dIf79k4u1rg0uTyimsrl
 H/e1EUbjYMUjv6jQKdKiqwoGoJquxiomK3syQlxijKFrJYGmssLWf/NnNL0Wl9EeGQXuBx0HrPn
 oyLFeKpzGHSlcKwCnsVMstIlskuYL/17IgsjsqRnR1ZJ3ayQtIQQkEZ50Et8iq9xQQMflCVTqjg
 6tsUsxUmIu9MbJT4qMCvaPAPxr5RdLIS6rHS7GoVJ6g+iZg89aM/M2o3wogiys0zbC1zr5agULz
 cJGid0qqYAwg4TxeThA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080120

On 7/6/26 10:52, Steffen Eiden wrote:
> Refactor gmap code such that a second s390 (host) KVM implementation can
> use the gmap code as well. Move relevant definitions into the shared
> kvm_host.h. Move mmu code from s390 to gmap so the other KVM
> implementation can use it as well.
> 
> No functional change.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h      |   9 ++
>   arch/s390/include/asm/kvm_host_s390.h |  11 +-
>   arch/s390/kvm/gmap/Makefile           |   2 +-
>   arch/s390/kvm/gmap/faultin.c          |   1 -
>   arch/s390/kvm/gmap/gmap.c             |   5 -
>   arch/s390/kvm/gmap/gmap.h             |  15 ++
>   arch/s390/kvm/gmap/mmu.c              | 193 ++++++++++++++++++++++++++
>   arch/s390/kvm/s390/s390.c             | 134 ++----------------
>   arch/s390/kvm/s390/s390.h             |  16 +++
>   9 files changed, 245 insertions(+), 141 deletions(-)
>   create mode 100644 arch/s390/kvm/gmap/mmu.c
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index e76ceee11ef5..33af8842a71c 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -5,4 +5,13 @@
>   
>   #include <asm/kvm_host_s390.h>
>   
> +#define PGM_PROTECTION			0x04
> +#define PGM_ADDRESSING			0x05
> +#define PGM_SEGMENT_TRANSLATION		0x10
> +#define PGM_PAGE_TRANSLATION		0x11
> +#define PGM_ASCE_TYPE			0x38
> +#define PGM_REGION_FIRST_TRANS		0x39
> +#define PGM_REGION_SECOND_TRANS		0x3a
> +#define PGM_REGION_THIRD_TRANS		0x3b

Before we go out and do funny stuff like this I'd much rather have it 
all in one file even though the arm code won't use most of the PGMs.

Either we keep all of it in kvm_host.h or we move it out entirely into 
ptrace.h if the s390 kernel team doesn't complain.

I don't think this change belongs in this patch anyway.

[...]

> -bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu);
>   #define CREATE_TRACE_POINTS
>   #include "trace-gmap.h"
>   
> diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
> index 8773aa34f107..a04e0a4355a0 100644
> --- a/arch/s390/kvm/gmap/gmap.c
> +++ b/arch/s390/kvm/gmap/gmap.c
> @@ -24,11 +24,6 @@
>   #include "s390.h"
>   #include "faultin.h"
>   
> -static inline bool kvm_s390_is_in_sie(struct kvm_vcpu *vcpu)
> -{
> -	return vcpu->arch.sie_block->prog0c & PROG_IN_SIE;
> -}
> -

With a small modification we can re-use this in vsie.c and throw it into 
kvm_host.h before we move it into kvm_host_s390.h. Make it work on sblks 
instead of vcpus and name it something like kvm_s390_sblk_is_in_sie().



