Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF4C45D1BC;
	Tue, 28 Jul 2026 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251404; cv=none; b=iNJLjL09fO83ceHiJaDfNi4hp/WaVq8e21CS75RhySrKJOeNyQZHjBt0D/OJCoN/pGSjUTH6PhLLtwI3rJ7TRUipCrZ4m+XGgdR8SjnVbLl0CdOSB44bHfxUf7k6OuMF1fxw3t4EJWj/zXN+Q7gaEM8FdFPa2MxggicznGQbLDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251404; c=relaxed/simple;
	bh=IMKcCkz9UiUszt+8kcuGf6pTll+1k3hyyL09pgwg/Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHD8sY7epQcCHcEg4rq/ufRIfsWIYz7bia5EmYOZQeMWjQln59+9/sZ6e/Z9pajEMNZ9qwGhy8cY3xz31g7OotbJys8c1FH2qWloe2EjZq8g5cadubuzG5vTMNf0dAjvRTeOsRU2ws5HaiINa768AW1Zj6WRhdXQ5A99f8B9KvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A4xz4pX3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A4xz4pX3"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SElp1d1501297;
	Tue, 28 Jul 2026 15:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lFMgU6
	unBCbDHZimf08a3hpQNPz4TqdkdJrq46LMZsU=; b=A4xz4pX3TiNg1lCA4UxOE3
	MLFrp1l8dG/gcKob1p2AhWujIfhtijwT4bbebUa7BnJtBfzcVqW9r9ZBtzA2cWtc
	La/27Ucf6Zz2mXKYU8SrqMJGUgAhlYXiO8vSqcg//NClxNCdVZ4wcKz/dpjF7012
	amdx+KCd+lsvqx8wdjMfgCIkU12LfhFnh/BmyRubxw0oEzfzPCNHQzzb86Fglw7L
	5P94ox8sV8yWLQq7pB7EfXlgcwp4P/OiQxGWC2MMF87JE5572osanRABXPZKee1e
	/ygYACn26sOBt+ScP1NhG6TFqY5K6mejmrrBzgfdii6YbbTqA9f63cycmhvWcwyQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcwbqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 15:09:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SEuIeP008515;
	Tue, 28 Jul 2026 15:09:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhabvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 15:09:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SF9seE28246388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 15:09:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70B6020043;
	Tue, 28 Jul 2026 15:09:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91F9D2004B;
	Tue, 28 Jul 2026 15:09:53 +0000 (GMT)
Received: from [9.111.53.50] (unknown [9.111.53.50])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 15:09:53 +0000 (GMT)
Message-ID: <aec51291-eacd-43f0-9791-c8984cde78bc@de.ibm.com>
Date: Tue, 28 Jul 2026 17:09:53 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] KVM: s390: Fix unlikely NULL gmap dereference
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
 <20260727150254.236021-2-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260727150254.236021-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oRf52uvLjiXImTUJylwVEYMw9o1uCLkr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEzMiBTYWx0ZWRfXyAQKPLjtjKvJ
 1VJOtp/4EUSPe6LMIOBJP4vTstab0fT4M3B2SjUZU6AINZM5L3C7XLNAeKfpIUxtMTKW/HOzW4v
 fi7jUXeKc5hkx6K1jsSn5GJit8vfkuI=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a68c647 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=_YX56pO25_faRPOBtT8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEzMiBTYWx0ZWRfX//SAZo6s52Nm
 G1TH+66me4FWINNboBdVgworbhpl6Rexc7gcVS/bIdBGpx4FOMkaCW352279EFypQkZOLfFnwdo
 xjROHOslThym5UPCsFbysjAIjAsQSSjJBMWOfCBUkXgmvP21DbeW0PpDzWQLzFMlFIKxMsoFrj6
 PVf6EZa35KJrhwFrM+M7XminQHGDQQpFNH2WdUcNmk+dMbI7PNEK5FEO+kW9+AuUtOe3LSGAGjv
 zDITDoRrNIcAbnEyz5Wu2+DmHROBUx7/cIV/Bmr/oFuFXm1fXq5kG0lI0iSvFr+yUoSeD5ylGtH
 Te7hWdkPx94IGOKHSAlLedg7YIiDnXRXC3wT2CGRwvr1bXvmfX7f3+Vd1WWCOdgGL62tig1nuxP
 lgsJzP9qCZqmkOddrqfnFoqxqGgD5HB2raweybBJ7j6dPpUCVfQoM72FUqCR7afwv02TfKea1i6
 hgzOqOZXLIm3yHuxOwA==
X-Proofpoint-GUID: oRf52uvLjiXImTUJylwVEYMw9o1uCLkr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280132


Am 27.07.26 um 17:02 schrieb Claudio Imbrenda:
> When creating a new vCPU, kvm_vm_ioctl_create_vcpu() will call
> kvm_arch_vcpu_postcreate() after the file descriptor for the new vCPU
> has been created. The new file descriptor has not been returned yet,
> but a malicious userspace program could try to guess it.
> 
> If a malicious userspace program manages to start the newly created vCPU
> before kvm_arch_vcpu_postcreate() is called, __vcpu_run() will try to
> dereference vcpu->arch.gmap and trigger a NULL pointer dereference.
> 
> Fix this by adding a new field to struct kvm_vcpu_arch to keep track of
> the initialization status of the vCPU. Refuse to run a vCPU that is not
> fully initialized.
> 
> Fixes: dafd032a15f8 ("KVM: s390: move vcpu specific initalization to a later point")
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h | 1 +
>   arch/s390/kvm/kvm-s390.c         | 8 ++++++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index eaa34c5bd3c1..edf75b6ad20c 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -440,6 +440,7 @@ struct kvm_vcpu_arch {
>   	bool skey_enabled;
>   	/* Indicator if the access registers have been loaded from guest */
>   	bool acrs_loaded;
> +	bool initialized;
>   	struct kvm_s390_pv_vcpu pv;
>   	union diag318_info diag318_info;
>   	struct kvm_s390_mmu_cache *mc;
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 150b5dd2170e..22535f76ae05 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3613,6 +3613,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>   	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0 ||
>   	    vcpu->kvm->arch.user_operexec)
>   		vcpu->arch.sie_block->ictl |= ICTL_OPEREXC;
> +
> +	WRITE_ONCE(vcpu->arch.initialized, true);

while highly unlikely, I think sashiko is right, the compiler could reoder the
gmap assignment. A barrier() before the WRITE_ONCE would do but smp_store_release
does not hurt (and it has some sanitizer support).

>   }>   
>   static bool kvm_has_pckmo_subfunc(struct kvm *kvm, unsigned long nr)
> @@ -5039,6 +5041,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>   	    kvm_run->kvm_dirty_regs & ~KVM_SYNC_S390_VALID_FIELDS)
>   		return -EINVAL;
>   
> +	if (!READ_ONCE(vcpu->arch.initialized))
> +		return -EINVAL;
> +

I think we really do not need smp_load_acquire here and below, but it certainly
is nicer to have equivalent pairs. So if you use a barrier, its fine to leave it
as is, but maybe simply use smp_load_acquire here and below and smp_store_release
above.

>   	vcpu_load(vcpu);
>   
>   	if (guestdbg_exit_pending(vcpu)) {
> @@ -5523,6 +5528,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>   	long r;
>   	u16 rc, rrc;
>   
> +	if (!READ_ONCE(vcpu->arch.initialized))
> +		return -EINVAL;
> +
>   	vcpu_load(vcpu);
>   
>   	switch (ioctl) {

