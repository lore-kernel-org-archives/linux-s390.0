Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981786;
	b=hmE/Dh1fzQwOQvc40SyU8S6xeqGF3cYKH00CGTLd0VmcWDzJDQTd3HfKjssqyGsAUm8J
	 JfA0aSnIHQSfGr7DZChoq58v2wi/9X58LjhVes8RsyL4SZlvYfaVU7d7IQruBPZ1O3NOp
	 0a6vZ7qg5s0022uvWpVPUrLrRXT7qc2aOjYiHa+hO8eUjC6Rhdn3BUq5vhx342GxuUoT9
	 1JGweL8GQ6GFdwgt8XxFnvg9N7orCmPrvh01jJEl2/NMCGQoqM5JpSUNt8cYe5Ef6N72M
	 h8dcQaz16GdfGCDjYVLhf1sE6Aryt88qFhEHYKlTqOn1XrwZ8wb/RjRdFAV6L++RtEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981786;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mVA3t8z+4SHp8VtBiHar6wW2MGwvMPuHY+XO8ByX/gc=;
	b=1+wXa7lftN7nGeZ+6TsQa0ldAGaKoa+Nrn6uXIL6a8iFdpn8dbSf4cQcse73Krlc8tEY
	 1/JGcKrAQsPhiLV3QKFanvRYnI3EbRD2cGoR6JbyxCZvIfGNB3B3rBka1Yt8VRPAiOSaV
	 9aHcSrkRYZ4Ckl6DoKCYZp843YbkYOLWynKyOaf2CK24ekwKxrlGMtPEFsckttItzEGIg
	 CahUI1jemwsA0DGZBEgC6Tu7S1ZuBwoRAfzWrt5msMG8eHLwHKp9yrNdYrMhjBGUZjklM
	 H+VZd99dPKeda7m6HQJoDRkzbGca+gu6sfSD8cX4Pe6qjwpXyw96XWyuqwQ0sQytldw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KR1mNkp3;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320F9606D811;
	Fri,  6 Nov 2026 16:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 320F9606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KR1mNkp3
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FE6MA2711245;
	Fri, 6 Nov 2026 16:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mVA3t8
	z+4SHp8VtBiHar6wW2MGwvMPuHY+XO8ByX/gc=; b=KR1mNkp3v/c0mE7+CDHtYh
	kYJEMs2DErP4OQMY4ozgxR74JEnCV93hlBJMJBtCol8YjZeRhQpaGnkiO6lgv0NU
	CNFMB4/rm1/jHXBNRcBQG6ZvwJj2ya+LuHQKaQQOzDmETdd12XAiw3vHDOgMDp5P
	NXamW4rxrfh+AWlT85dgPNn4bOsrvEl96MFCh4XE1uvxmS4EXqwCSax6dGQhHqUP
	YC/zwWGHOLBUawD6WFPJkCjr+k6qgdl9+iAC3RBR9Suxj7wLxI0ijazRErd6WVMQ
	xxC6WUvtGhzhcC1d8ixbN45/9z0UzGrbun6HKXyNVyG0XXv7pbcBh6uQfoln1xNg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r95jtr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:16:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4uew3538281;
	Fri, 6 Nov 2026 16:16:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrk9mt680-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:16:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6GG2fZ32178556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:16:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 920422004B;
	Fri,  6 Nov 2026 16:16:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4E8620040;
	Fri,  6 Nov 2026 16:15:58 +0000 (GMT)
Received: from [9.124.212.22] (unknown [9.124.212.22])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:15:58 +0000 (GMT)
Message-ID: <e425d6bd-9aea-4d50-b0fc-1793e20739c4@linux.ibm.com>
Date: Fri, 6 Nov 2026 21:45:57 +0530
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
Subject: Re: [PATCH] sched: Decouple PREFERRED_CPU from PARAVIRT
To: Mete Durlu <meted@linux.ibm.com>, Yury Norov <ynorov@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
References: <20261106-preferredcpu-v1-1-3f0ca4944f8b@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261106-preferredcpu-v1-1-3f0ca4944f8b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aedfd47 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=JfrnYn6hAAAA:8 a=VnNF1IyMAAAA:8 a=gfLSLzf0Go29dtxIkr0A:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: AIIvz_oKV71mYmYVZ_0qXABjgMKqBXfI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfX3S8z12iP9PQy
 MJkI+XgIk7VOKr9KsOzdg48iepuBuzHVQAUP0oiFDOluCyvkxz/A3+OEuppWBXR3S08bb+rhJTK
 kQp6nlmAKAmVkid0reNkJSlXIQlsWtU7y6wUjwDGcQZGjouc0e9rsO4sfbbFe6S75CN3mSJn7Qz
 KKoNo00D9BdoUnRgWxKz+p/3Q5GA6UB7nFiTB7rd4CHIET44DHS8jKmIY7TzuGud78RowLKpjds
 cUMvkFF0FKi1IpyFmmlutVK1jbZYU0vAAbab/+Xoaw01yth9fS1+Uk/o4V6HpQIckVZsx65pmFz
 8zrkysn10m40RWilPfiB6YlqjztLlf96mOEG8EkG4bQ/lGCUk+sVbFOgk81J28aVZkv+1vcYwkJ
 X/ZYXAuh/OP4ZLEKBAFKEaKNP4ZFfGG6LYbDSJRRgnKDYqBYOpMC9w4pwAMcVilmot6Z8ociDdQ
 G4U94ZUrsOkPdKBCZVw==
X-Proofpoint-GUID: aV6iTcGbBbYqI1blTyT_3jQiBb9iW5Nl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfX3DGrl3tqZuG9
 xbDWQ3qcuqUaTsikXLehhaHZ/d7/NzmtU6mk0TzqBs8GfxJrnatAjhaCnrdYmzENQ71hJyzD7Y5
 COYvQ+EStfyQBokLBl0U+D6wQOk0i14=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060064



On 11/6/26 6:05 PM, Mete Durlu wrote:
> PREFERRED_CPU mechanism does not rely on any feature introduced by PARAVIRT
> but PREFERRED_CPU still gated behind PARAVIRT. Any architecture that
> would like to enable PREFERRED_CPU mechanism has to also enable PARAVIRT
> and bring additional changes to accommodate PARAVIRT's requirements.
> 
> As an example, s390 doesn't enable PARAVIRT config for hardware virtualized
> Logical Partitions (LPAR). The steal time is accounted for the LPARs via
> architecture's own steal time accounting mechanism instead of the common
> steal time infrastructure PARAVIRT supplies.
> For s390 to enable PREFERRED_CPU, PRAVIRT and its required stubs are
> just unncessary.
> 
> Based on the discussion between Yury Norov and Peter Zijlstra over
> Yury's original patch [1]:
> 
> Introduce a new config flag HAVE_CPUTIME_STEAL to indicate that the
> architecture has steal time measurement capabilities already implemented
> and to signal that PARAVIRT is not required.
> Remove PARAVIRT gating from CPU_PREFERRED and add HAVE_CPUTIME_STEAL
> instead.
> Select HAVE_CPUTIME_STEAL for s390 and powerpc-pseries configs.
> 
> [1] https://lore.kernel.org/all/20261101192203.6979-2-ynorov@nvidia.com/
> 
> Reviewed-by: Yury Norov <ynorov@nvidia.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

> ---
>   arch/Kconfig                           | 8 ++++++++
>   arch/powerpc/platforms/pseries/Kconfig | 1 +
>   arch/s390/Kconfig                      | 1 +
>   drivers/virt/Kconfig                   | 2 +-
>   kernel/Kconfig.preempt                 | 2 +-
>   5 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 1163736de1f9..01b8251970f6 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1080,6 +1080,14 @@ config HAVE_IRQ_TIME_ACCOUNTING
>   config HAVE_PV_STEAL_CLOCK_GEN
>   	bool
>   
> +config HAVE_CPUTIME_STEAL
> +	bool
> +	default y if HAVE_PV_STEAL_CLOCK_GEN
> +	help
> +	  Selected directly by config PARAVIRT through HAVE_PV_STEAL_CLOCK_GEN
> +	  or directly by architectures that have their own CPUTIME_STEAL
> +	  accounting.
> +
>   config HAVE_MOVE_PUD
>   	bool
>   	help
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> index 7d125e288f6e..3c49baf606d7 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -41,6 +41,7 @@ config PPC_SPLPAR
>   	depends on PPC_PSERIES
>   	select PARAVIRT_SPINLOCKS if PPC_QUEUED_SPINLOCKS
>   	select PARAVIRT_TIME_ACCOUNTING if VIRT_CPU_ACCOUNTING_GEN
> +	select HAVE_CPUTIME_STEAL
>   	default y
>   	help
>   	  Enabling this option will make the kernel run more efficiently
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 7138d923d86f..39379e72ffdf 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -204,6 +204,7 @@ config S390
>   	select HAVE_BUILDTIME_MCOUNT_SORT
>   	select HAVE_CMPXCHG_DOUBLE
>   	select HAVE_CMPXCHG_LOCAL
> +	select HAVE_CPUTIME_STEAL
>   	select HAVE_DEBUG_KMEMLEAK
>   	select HAVE_DMA_CONTIGUOUS
>   	select HAVE_DYNAMIC_FTRACE
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index eeb84e578ddf..a3721d34a55c 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -43,7 +43,7 @@ config FSL_HV_MANAGER
>   
>   config STEAL_GOVERNOR
>   	tristate "Dynamic vCPU management based on steal time"
> -	depends on PARAVIRT && SMP
> +	depends on SMP && HAVE_CPUTIME_STEAL
>   	select PREFERRED_CPU
>   	default m
>   	help
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index edc067a0c422..ffd2cb2a4d69 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -197,4 +197,4 @@ config SCHED_CLASS_EXT
>   
>   config PREFERRED_CPU
>   	bool
> -	depends on SMP && PARAVIRT
> +	depends on SMP && HAVE_CPUTIME_STEAL
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261104-preferredcpu-b3c00594bd74
> 
> Best regards,

