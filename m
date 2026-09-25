Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EAC3DC4C9;
	Fri, 25 Sep 2026 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330682; cv=none; b=e4uN5ghf673QQOPZnR80yeasr7hWiI0GA7hAMCtp/GcK9MiHUlYqchxmgH6HsYQIC5e12cD9bthKDOtTEaZtYm+qe5e1a/WlNspIXIH1Kkoh4i+SyyRuM61sZVwh5HOjMCI9pFqLaPAHELLCHHpri1iyDK5lG78q6FCuJGw/pSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330682; c=relaxed/simple;
	bh=9nIehBGhJkMvM90IM2RpZ275Lrv2opTIM540FAJ1pgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vq49XhYuzBUSw1zvnjSQ55ChomRQv9+3Dep8MFnbt8qk3qDvUB4/Mevi/nzHFHf8vzzKTdPgApl+HsVpUfHFFBYthuu+Sk2CgUvH++olZ8ySIOw9jfzqFamwRBnhcwlKF+RpEnJP23Kij9Xa6WfezOauYWFgO85p/zU1lt8EbCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=id9Yc/8e; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="id9Yc/8e"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aGrY2393664;
	Fri, 25 Sep 2026 10:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8ARepd
	15hulVUF7wlLkcGUduLo128QqEF7wGBIq5gY4=; b=id9Yc/8eAUIEH/n/RhY7MC
	c9QuJ+I4zYGha400WPpumHT6qAzIvCTnT+dBSVYBaEd3TCw4LswSpfTHffb9vU03
	3wYzztoZrW+i2xP5+ygsJ4UYkHvnSUG+HtMtlA7Buc0Y0q87W9pwO4ivHqAZlp+I
	Km+uM/nWq2FTA3Dnpe7QgoC8j0b6fZn7zo72eDCg9G41zyvotFqS28vGLj2jDcE+
	VHty2e6zS0ToymotssWa4GORYqZpfnsLEUrKvG7fu4dL+EuRvDgHbMADh3qPZUfK
	nB9RmfNfsVwM3IaIyufkNt5YLiDH+pD2J0okdpk2WTL5yJZIltWAQ+PIBYCXsq9g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske26cup-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 10:04:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PA3Q2D1959531;
	Fri, 25 Sep 2026 10:04:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7ee5uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 10:04:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PA4ZbE50594228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 10:04:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88FB02004F;
	Fri, 25 Sep 2026 10:04:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CFE720040;
	Fri, 25 Sep 2026 10:04:35 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 10:04:35 +0000 (GMT)
Message-ID: <2988db19-755c-445a-8226-95e99904a232@linux.ibm.com>
Date: Fri, 25 Sep 2026 12:04:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] KVM: s390: Add opportunistic floating IRQ
 injection
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org, pasic@linux.ibm.com
References: <20260820121546.24694-1-frankja@linux.ibm.com>
 <20260820121546.24694-4-frankja@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260820121546.24694-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O5I6YfGGPWqZnPiSTJXIYky6VYSR-Mw8
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab64738 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=4WfngMj7Zh_IP9iRE-IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzOCBTYWx0ZWRfXxdLnUQ4OBB1l
 78xFHL2I/sHbpxr8Lethg/fbeEAHJBDYueOWNOxBa5OIKUQl7d528gF5Hasf8iBmSeE4TZhR0VG
 YAzJ/Gp9H/3+5rdFoP2opkjvSigDR7Y=
X-Proofpoint-GUID: O5I6YfGGPWqZnPiSTJXIYky6VYSR-Mw8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzOCBTYWx0ZWRfXyT9KUhy8zwBa
 hOq9MmkhvaIcTseN52tdFJEjy9nKBed66b5SGg2EWZ+jHNjbHpeTZ4wf2iUOsFGXnnVZpvx5Ni6
 NI93l8eJax0SeqmV0CcsGC7b4HlKOx6X7nfvcGJXJOKmDNV/L+HIzJNgbn4wsxz2nzvuP2lIaNh
 cLPzdXQqVZdc/Cz+XfOY0iAF1AQq4+0/FmFmJ6Q7Cxgqi0mO6bYkHPaY2Iw/YZyyHgU5JPTVyeB
 oY1PsgV4NHjycGmaswLyljHcgK36vsQUlrIX/coK4xAyH+Il4QSHHS715O6x4kwLjNQPC5rUrdf
 +QQ7PAa6CecPXEGPBQhrAbuImxU8BzLAOXQMr/1WSkNJdpYd7lYKdlJ7VsN7oX1wRXxPvF7YPd0
 aCI+cdZMujxfPKFXYJsJsh/765E1M7UzEoEddh3woa6V+0U0EmCBgexU0vJFrL95S+DF0FrexOs
 NJJToujqdnUa5kZVfcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250038



Am 20.08.26 um 14:12 schrieb Janosch Frank:
> Try to distribute floating IRQs which haven't been taken by a VCPU yet
> to sleeping VCPUs. This lowers the risk of floating IRQs not being
> delivered.

I think this could be too expensive in the innermost loop.
As an alternative:
what about actually adding a check in handle wait that triggers if we are going
to sleep despite pending interrupts.> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h |  1 +
>   arch/s390/kvm/interrupt.c        | 31 +++++++++++++++++++++++++++++++
>   arch/s390/kvm/kvm-s390.c         |  3 +++
>   arch/s390/kvm/kvm-s390.h         |  1 +
>   4 files changed, 36 insertions(+)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index b4182ca4435f..1d62bdd7aca5 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -467,6 +467,7 @@ struct kvm_vm_stat {
>   	u64 gmap_shadow_r3_entry;
>   	u64 gmap_shadow_sg_entry;
>   	u64 gmap_shadow_pg_entry;
> +	u64 inject_redist;
>   };
>   
>   struct kvm_arch_memory_slot {
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index b3e4bfeacff2..54f20347f553 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -367,6 +367,37 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
>   	return active_mask;
>   }
>   
> +void distribute_float_irqs(struct kvm *kvm)
> +{
> +	struct kvm_vcpu *dst_vcpu;
> +	int sigcpu, online_vcpus;
> +
> +	if (!READ_ONCE(kvm->arch.float_int.pending_irqs))
> +		return;
> +
> +	online_vcpus = atomic_read(&kvm->online_vcpus);
> +
> +	/*
> +	 * Not too worried about synchronization for idle_mask. We
> +	 * might burn too many cycles but apart from that waking a
> +	 * vcpu is not harmful.
> +	 */
> +	sigcpu = find_first_bit(kvm->arch.idle_mask, online_vcpus);
> +	/* Well nobody's sleeping so someone will likely take the IRQ soon */
> +	if (sigcpu == online_vcpus)
> +		return;
> +
> +	do {
> +		dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
> +		if (deliverable_irqs(dst_vcpu)) {
> +			kvm->stat.inject_redist++;
> +			kvm_s390_vcpu_wakeup(dst_vcpu);
> +			break;
> +		}
> +		sigcpu = find_next_bit(kvm->arch.idle_mask, online_vcpus, ++sigcpu);
> +	} while (sigcpu < online_vcpus);
> +}
> +
>   static void __set_cpu_idle(struct kvm_vcpu *vcpu)
>   {
>   	kvm_s390_set_cpuflags(vcpu, CPUSTAT_WAIT);
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 518a69c55e85..d6d46688d980 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -86,6 +86,7 @@ const struct kvm_stats_desc kvm_vm_stats_desc[] = {
>   	STATS_DESC_COUNTER(VM, gmap_shadow_r3_entry),
>   	STATS_DESC_COUNTER(VM, gmap_shadow_sg_entry),
>   	STATS_DESC_COUNTER(VM, gmap_shadow_pg_entry),
> +	STATS_DESC_COUNTER(VM, inject_redist),
>   };
>   
>   const struct kvm_stats_header kvm_vm_stats_header = {
> @@ -4572,6 +4573,8 @@ static int vcpu_pre_run(struct kvm_vcpu *vcpu)
>   		rc = kvm_s390_deliver_pending_interrupts(vcpu);
>   		if (rc || guestdbg_exit_pending(vcpu))
>   			return rc;
> +
> +		distribute_float_irqs(vcpu->kvm);
>   	}
>   
>   	rc = kvm_s390_handle_requests(vcpu);
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index 8e886bcef4a0..7115a8f5b188 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -376,6 +376,7 @@ int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
>   void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu);
>   void kvm_s390_clear_float_irqs(struct kvm *kvm);
>   void kvm_s390_pv_sclp_kick(struct kvm_vcpu *vcpu);
> +void distribute_float_irqs(struct kvm *kvm);
>   int __must_check kvm_s390_inject_vm(struct kvm *kvm,
>   				    struct kvm_s390_interrupt *s390int,
>   				    struct kvm_s390_interrupt_info *inti);

