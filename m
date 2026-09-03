Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFBE4AFE01;
	Thu,  3 Sep 2026 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442103; cv=none; b=M+EbtR1SLPjULHheW7JXZ2NxRgG5tfGNmw4IEcEWd2pZ/G4m541875BsDGEzB18Ht0e8f1iglGaVGmwgOUoz9DDNsbERPg7lHOuhJfT19e0QKM4cQp8arkE5DE4MPaLxDR53bNSAooysGs0GYuPvPjVBd0NfH/Bx+uKaXaoFUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442103; c=relaxed/simple;
	bh=GN4Psq55rFjFS1C/HYok3UXx4567d8p12h5hTyZDSAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GaPuddDUNZkPFMwc1KrbgGa+K9Kfrg0yOJk5Jdc6xYiaE4LRJY0fqqXUaNrC3TMjgzzuEvUNS//6zhoLdCBGq1YfCBy+E9XJ10MkKIzQpRTgbjmGqYkFOhNa8eXsqLq70LGt2/7ZbwuoBRq8bwvR3as6oDPWlIbnlwmGP4MdKck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uy3CZC4d; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uy3CZC4d"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AVmIt2617826;
	Thu, 3 Sep 2026 13:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=c6AXeP
	+YlW4+I8ohY4m8qYvFYmyRVywE1mRoFjcW6CA=; b=Uy3CZC4dA8FE/Edqc52Zwe
	vCL0WX1mRjs9+nQokaRTWHyMQz4EBHAWPmQdW58aOYziZUkeZL6my6FKy3kwP4Wc
	dSqhNjDJA8eNoSUuqCn/rE2c4RB8GUQRAXnyZHok5+ncR2c1ry/BAklTqzGLPumt
	CMAyVEh4jPgl+1uRC0Sv5vpkeZPvOSKh1vGy90/uQD5v6utSUSuE4LHZ/++wRTNT
	+WJPHVpuJb1vRgR0W/IQ7qIAVad6vTSny8dwR/4i0jd1LXeuCr7L8ZK6W+wKAxGM
	Bhji6GS+I2spDO1hAtP5CbnhUBwn4IkaQklcClXsOduy2U2S28lCcCUwx9PlOvmQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj4tnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 13:27:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683DQKYq030491;
	Thu, 3 Sep 2026 13:27:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hqs6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 13:27:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683DRHhH45154640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 13:27:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF2A02004E;
	Thu,  3 Sep 2026 13:27:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1C1F20040;
	Thu,  3 Sep 2026 13:27:16 +0000 (GMT)
Received: from [9.111.55.202] (unknown [9.111.55.202])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 13:27:16 +0000 (GMT)
Message-ID: <d706435a-3984-4ef3-b319-1efc92517650@linux.ibm.com>
Date: Thu, 3 Sep 2026 15:27:16 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 21/23] KVM: s390: arm64: Implement vCPU IOCTLs
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
 <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-22-seiden@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260831144802.834315-22-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Re-AndqEYSkfIQe94bsKaIRQFl4-05IY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX/S21DBOLHWUt
 lrZ5RjELVXOZHrOvQ9og3FVzamtx9ZWJnuuUkCT+1SItSyq3AkzF5rgkWC5Fp3c4FnnHAdE1xNe
 cxt6EeEKpqIWyKrEYEo5nMueqzu1ey3ZecIaVAaCAqwxPqeLzHIJZr0FFGJ0hX22YQ1chSfu5US
 bvRmV1tVwwyuHrUl1XAwFEr75ZN9JAPaqez1qpMn/g+4MY8IFapb7R5e0FRQTaMzEpgP+6iC0AB
 2mQuRUgjjFAASL21KhDA98HgvRFrhpGGKHdKGe7Rfk54jERdg1WtWJv9nvs0/Ienag3Vw4xQpaq
 co77o+XreoVaNEz/ZFOGJjRN4ywCJDSG7hb8fUAfevH4jjhnMFFMn3oYXFs238ZxiyBzxkoMcUD
 vhpN+Wb4OYp89Tm/mqUt9c9ZYIyqh93B6RAxE3DwbDLPXbYijEZl6J2RAcFOTLqwYgHJNeMdH46
 rPc6a2fCZ+QpibBMCeA==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9975bb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=68K9mThq9ovHU1SOSbYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX2qg5HwtyAckk
 7gCuIKNO55JiyIGwKlHp1MgUYFecQ8Y83psnkoDHB6DdwRGvBwL6gPwJbXmdwDnmsOklY0SIR1A
 loh8qYtAvhm3jzAf4jhSHeZu8j4+vlU=
X-Proofpoint-ORIG-GUID: -5Q7whLG351pmqVYlITrN1rjX7Sxx1Bl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030113

On 8/31/26 4:47 PM, Steffen Eiden wrote:
> Implement all required vCPU (arch) IOCTLs.
> 
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---

[...]

> +static void arm_vcpu_run(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_sae_block *sae_block = &vcpu->arch.sae_block;
> +
> +	adjust_pc(vcpu);
> +
> +	local_irq_disable();
> +	guest_timing_enter_irqoff();
> +	guest_state_enter_irqoff();
> +	local_irq_enable();
> +
> +	sae_block->icptr = 0;

We already do that in the function below, no?
If possible I'd like to avoid setting ictpr here.

> +
> +	sae64a(sae_block);
> +
> +	local_irq_disable();
> +	guest_state_exit_irqoff();
> +	guest_timing_exit_irqoff();
> +	local_irq_enable();
> +}
> +
> +/** kvm_arch_vcpu_ioctl_run() - run arm64 vCPU
> + *
> + * Execute arm64 guest instructions using SAE.
> + *
> + * Returns:
> + * 1 enter the guest (should not be observed by userspace)
> + * 0 exit to userspace
> + * < 0 exit to userspace, where the return value indicates n error
> + *
> + *
> + */
> +int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> +{
> +	DECLARE_KERNEL_FPU_ONSTACK32(fpu_save);
> +	struct kvm_run *kvm_run = vcpu->run;
> +	int ret;
> +
> +	if (kvm_run->exit_reason == KVM_EXIT_MMIO) {
> +		ret = kvm_handle_mmio_return(vcpu);
> +		if (ret <= 0)
> +			return ret;
> +	}
> +
> +	vcpu_load(vcpu);
> +
> +	kernel_fpu_begin(&fpu_save, KERNEL_FPC | KERNEL_VXR);
> +	load_vx_regs((vcpu->arch.ctxt.vregs));
> +
> +	if (!vcpu->wants_to_run) {
> +		ret = -EINTR;
> +		goto out;
> +	}
> +
> +	kvm_sigset_activate(vcpu);
> +
> +	might_fault();
> +
> +	kvm_vcpu_srcu_read_lock(vcpu);
> +
> +	ret = 1;
> +	do {
> +		if (signal_pending(current)) {
> +			kvm_run->exit_reason = KVM_EXIT_INTR;
> +			ret = -EINTR;
> +			break;
> +		}
> +
> +		if (need_resched())
> +			schedule();
> +
> +		if (ret > 0)
> +			ret = check_vcpu_requests(vcpu);
> +
> +		vcpu->arch.sae_block.icptr = 0;

Here

> +
> +		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
> +
> +		if (kvm_request_pending(vcpu)) {
> +			vcpu->mode = OUTSIDE_GUEST_MODE;
> +			continue;
> +		}
> +
> +		kvm_vcpu_srcu_read_unlock(vcpu);
> +
> +		arm_vcpu_run(vcpu);
> +
> +		vcpu->mode = OUTSIDE_GUEST_MODE;
> +
> +		kvm_vcpu_srcu_read_lock(vcpu);
> +
> +		ret = handle_exit(vcpu);

ARM increases stat.exits here and since you copied the stat fields over 
we could do that too.

General question to the ARM maintainers:
We'll be adding more stat fields in the very soon future.
Are you fine with us adding them under any name or should we prefix them 
so it's clear they exist because of our architecture / implementation 
and will likely never be added to ARM KVM?

In the past we've added a lot of stats and I'd expect us to at least add 
stats for every intercept reason.

> +
> +	} while (ret > 0);
> +
> +	kvm_vcpu_srcu_read_unlock(vcpu);
> +
> +	kvm_sigset_deactivate(vcpu);
> +out:
> +	if (unlikely(vcpu_get_flag(vcpu, INCREMENT_PC)))
> +		adjust_pc(vcpu);
> +
> +	save_vx_regs(vcpu->arch.ctxt.vregs);
> +	kernel_fpu_end(&fpu_save, KERNEL_FPC | KERNEL_VXR);
> +	vcpu_put(vcpu);
> +
> +	return ret;
> +}
