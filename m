Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26A447A889;
	Thu,  6 Aug 2026 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029305; cv=none; b=Axdi8yaIRgho27PdAgFKVBa9sD53yaP1/uQ8ruIhbseIQXXZnu5cwjs8urz2UQ9vFmqIYPy3MOIYbjhInMa21SNOoSAtJZLsRE1M1UB5VYT3nApfG/tjWcJa3BskJPvpKkfGQqrAv+/LA+pFcnlw7XY7coFjiBPDZaqrU8pRqxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029305; c=relaxed/simple;
	bh=GoYWa6iDzcm8DSverJNOPLmrt1ZEnhPfXU921ByHweY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQyd2FewPMuoamEy1Bubz+Bfc9ZyLKkoyEOXwD/+XMt8rPTIlngyp/V8gAU2/dW+mq5XMH119tyGcZIc8HU9UCoB0lEaFw9Ua/BY9b027aOyCLm4BxI/Zvh+gvfTJVjA2M+PbxCxJxDARFd6XNTFitlJk9XYMa19PBm2+otLCQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mgr1meVY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mgr1meVY"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Enfsc2873432;
	Thu, 6 Aug 2026 15:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wZjTlf
	ign4lxv7sNtjFn9ggtqL6J4CEZroWGBI6YVMk=; b=Mgr1meVYqpqoTE8A4HzVGO
	DJGrlw97FDFXaye8+A8nB+mrVeUKzNp2VvHGOIHNPvtrCSzNHfhDNNh/yWXxZcvg
	uv8zvBXBiRa8A/TDlAVFqpyvaIhTg/XWbQSuOCEBWutXx/U02EfLEJmT7QPKRE8F
	44P0RIEAN+ZBnsZTiXR/KJlcGi7X+xgbPDUHRwCyln6BvUA0H+Pd9CLptXhHdTLn
	zUL/VLV7g44jfSC+ShjnyJgrTttK4LmkEOUhZMLMo7R+S3vfLtSsdm6+vRmY+awb
	CvhSmqLTU9U24MJCwbB+56y63UKDtMLsWI3HrnfdSa2MkGf/4CvQKlLniTSF7zAw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67j0k9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 15:14:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676FBQ2Q000528;
	Thu, 6 Aug 2026 15:14:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgkgf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 15:14:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676FEttR46334386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 15:14:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03BFA2004E;
	Thu,  6 Aug 2026 15:14:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58C8B20040;
	Thu,  6 Aug 2026 15:14:54 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.53.22])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  6 Aug 2026 15:14:54 +0000 (GMT)
Date: Thu, 6 Aug 2026 17:14:50 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, KVM <kvm@vger.kernel.org>,
        David
 Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>
Subject: Re: [PATCH v2] KVM: s390: Fix memory corruption by not reinjecting
 CK machine checks
Message-ID: <20260806171450.5ca84714@p-imbrenda>
In-Reply-To: <20260806145835.31818-1-borntraeger@linux.ibm.com>
References: <20260806145835.31818-1-borntraeger@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNSBTYWx0ZWRfXw8zPuTJVUEhj
 S3hOBa3vK4Eh4n2Q0VoxRfo9mN/kxSWBOyE56eOg5mHG8pd0Zw07Em06k4znHzMXw+fN4CAdiqR
 rXrJ95gorSS+MOwgPV7vzVL5UUCfF3E=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a74a4f3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=05PFFlanxVCGyDKB1lkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNSBTYWx0ZWRfXz1Yr/img4wLN
 +TUk2ODcGUopc0RFE22aj5/usDDO016HCPNixDZ94vYQZD6MMLftFzCV4HwRW8nwmegIeUYmTm1
 hNcmmHpoMIQb3ATk7+zliXFsYUhb5Wwkcx8k3B0BF2AMMQ2lOYUn/kylJLP1ygN3QfD6aA35n9R
 AlAvKc1hkaLOsDmYthRlrrxjvcJ7BLrt6dc4wo8ZGaq1M4tkwA4BkxXZx7aJaYOMp7uFAHAp2wX
 qEv9alhkgMHXiMnAZ9N8bNXiLd14PI5qrSl64KftV6gllaaUNTb7Fk1RLyU6DhrQ3Cp+KbPvmm6
 l/S317ofLvKVjXfLOW10r88WkDRobciAGIs0//yo/kuilf+ptdqAR+4pcEmm4AqZmKp9Oy0wDBG
 Ou6rd5B7dJScxXqBcxOtqMvamTitZ3pJVuh8DdC6iTXJo5xt2kJKLcahfEcri+4pGMpHLsANfHW
 6rne5QsTvoQtPhvQpGw==
X-Proofpoint-ORIG-GUID: t4CA2RgaBbeTht6j9rpxyeJzOkkik5TX
X-Proofpoint-GUID: t4CA2RgaBbeTht6j9rpxyeJzOkkik5TX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060115

On Thu,  6 Aug 2026 16:58:35 +0200
Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> Channel-subsystem damage machine checks are for the host channel
> subsystem. The guest channel subsystem is emulated in the userspace VMM.
> There is no point in forwarding such machine checks into the guest.
> 
> This also simplifies the machine check reinjection and avoids kfree of a
> stack variable as reported by sashiko.  There might be still machine
> checks that have the ck bit set with another bit (like instruction
> damage), mask out the CK bit in s390_backup_mcck_info(), like the CP and
> ED bits already are.
> 
> Fixes: 4d62fcc0b692 ("KVM: s390: Inject machine check into the guest")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
> v1->v2: move MCCK_CODE_NO_GUEST into nmi.h and reuse that
> 
>  arch/s390/include/asm/nmi.h |  3 +++
>  arch/s390/kernel/nmi.c      |  5 +----
>  arch/s390/kvm/interrupt.c   | 26 +++++++++-----------------
>  3 files changed, 13 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/s390/include/asm/nmi.h b/arch/s390/include/asm/nmi.h
> index 6454c1531854..7919b2b9ac9c 100644
> --- a/arch/s390/include/asm/nmi.h
> +++ b/arch/s390/include/asm/nmi.h
> @@ -22,6 +22,7 @@
>  #define MCCK_CODE_SYSTEM_DAMAGE		BIT(63)
>  #define MCCK_CODE_EXT_DAMAGE		BIT(63 - 5)
>  #define MCCK_CODE_CP			BIT(63 - 9)
> +#define MCCK_CODE_CK			BIT(63 - 11)
>  #define MCCK_CODE_STG_ERROR		BIT(63 - 16)
>  #define MCCK_CODE_STG_KEY_ERROR		BIT(63 - 18)
>  #define MCCK_CODE_STG_DEGRAD		BIT(63 - 19)
> @@ -33,6 +34,8 @@
>  #define MCCK_CODE_FC_VALID		BIT(63 - 43)
>  #define MCCK_CODE_CPU_TIMER_VALID	BIT(63 - 46)
>  
> +#define MCCK_CODE_NO_GUEST	(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE | MCCK_CODE_CK)
> +
>  #ifndef __ASSEMBLER__
>  
>  union mci {
> diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
> index e17a59d4d5a4..17297a8b63d9 100644
> --- a/arch/s390/kernel/nmi.c
> +++ b/arch/s390/kernel/nmi.c
> @@ -344,8 +344,7 @@ static void notrace s390_backup_mcck_info(struct pt_regs *regs)
>  
>  	sie_page = container_of(sie_block, struct sie_page, sie_block);
>  	mcck_backup = &sie_page->mcck_info;
> -	mcck_backup->mcic = get_lowcore()->mcck_interruption_code &
> -				~(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE);
> +	mcck_backup->mcic = get_lowcore()->mcck_interruption_code & ~MCCK_CODE_NO_GUEST;
>  	mcck_backup->ext_damage_code = get_lowcore()->external_damage_code;
>  	mcck_backup->failing_storage_address = get_lowcore()->failing_storage_address;
>  }
> @@ -357,8 +356,6 @@ NOKPROBE_SYMBOL(s390_backup_mcck_info);
>  #define ED_STP_ISLAND	6	/* External damage STP island check */
>  #define ED_STP_SYNC	7	/* External damage STP sync check */
>  
> -#define MCCK_CODE_NO_GUEST	(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE)
> -
>  /*
>   * machine check handler.
>   */
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 7514d9e2403c..3375a956637b 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -3099,9 +3099,7 @@ static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
>  void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
>  				     struct mcck_volatile_info *mcck_info)
>  {
> -	struct kvm_s390_interrupt_info inti;
> -	struct kvm_s390_irq irq;
> -	struct kvm_s390_mchk_info *mchk;
> +	struct kvm_s390_irq irq = {};
>  	union mci mci;
>  	__u64 cr14 = 0;         /* upper bits are not used */
>  	int rc;
> @@ -3120,20 +3118,14 @@ void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
>  	if (mci.w)
>  		cr14 |= CR14_WARNING_SUBMASK;
>  
> -	mchk = mci.ck ? &inti.mchk : &irq.u.mchk;
> -	mchk->cr14 = cr14;
> -	mchk->mcic = mcck_info->mcic;
> -	mchk->ext_damage_code = mcck_info->ext_damage_code;
> -	mchk->failing_storage_address = mcck_info->failing_storage_address;
> -	if (mci.ck) {
> -		/* Inject the floating machine check */
> -		inti.type = KVM_S390_MCHK;
> -		rc = __inject_vm(vcpu->kvm, &inti);
> -	} else {
> -		/* Inject the machine check to specified vcpu */
> -		irq.type = KVM_S390_MCHK;
> -		rc = kvm_s390_inject_vcpu(vcpu, &irq);
> -	}
> +	irq.u.mchk.cr14 = cr14;
> +	irq.u.mchk.mcic = mcck_info->mcic;
> +	irq.u.mchk.ext_damage_code = mcck_info->ext_damage_code;
> +	irq.u.mchk.failing_storage_address = mcck_info->failing_storage_address;
> +
> +	/* Inject the machine check to specified vcpu */
> +	irq.type = KVM_S390_MCHK;
> +	rc = kvm_s390_inject_vcpu(vcpu, &irq);
>  	WARN_ON_ONCE(rc);
>  }
>  

