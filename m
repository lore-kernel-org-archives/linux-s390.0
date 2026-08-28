Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076553D47D4;
	Fri, 28 Aug 2026 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787924123; cv=none; b=EKsiuIkpIHAhUdoh3xbrbcYRR3yRYJ3h+fKUaIEKQZcjbu+O6rtQWm1cR6cRAoqo94xtlqC66A7YoqVbYM/3iWIp7y/YshCx3p1eQzXWv+ArYcNu0/QnBONW8tdBO7ydUfnzC8QcfpUYsT7guz2qJFDZ3vdW0jLjsLDYGsq2eWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787924123; c=relaxed/simple;
	bh=Pz7f69K+RH5Fchqq/rsM1ft61yITqQXyHyngJemZUks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCMiKIXuK064ACZScUYHBr6HrSgyyN9kcDvCuI7u8Pm5LNm+kKJLhy7pfGkZxghHHp2jvl9uCCN6NnXLLxHopXxAfqZcoh5xMzBmLiAzvThzV++MMjo/bFisuGzSUgFwakFRkzmbUvhTQKxPaWAXriMi00362qVr3oaaD18hGT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UTGrcIRG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UTGrcIRG"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDVp2P2133870;
	Fri, 28 Aug 2026 13:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JcxPxF
	DwkA46qm0gx0PAMqkSvlmsVAaDSMlARO4fT20=; b=UTGrcIRGxrhMQo2mp6phfc
	NTRxFHmjgqztc62JgJaoXkN2EOfhpYEsDLKtajTNHLge9+wcNTB34Hb95t3LrlQA
	qcSfOt5338dsfpm9J/Qwg0OSXPV3SL7pAJfOLBxq7Uu2RyzyUelbT4zak/EWs34l
	ZsgS4ywJLRqJWOnW7alcQ55Q1lfbuONr8YCLuoUTUaU/5ov2mgeXimgUfYja4DdN
	HcUgA/tBBSDmxdp7CD0og8w1sm4ZkMTb0mVXLr1I0IWHFWzxCYnyPM0/7t+YJ7Au
	DuJ2NMeBpgTaNbcJihAzkzK3eCaxSORVtzAmOIkw16sSEoHGHiDsU/HmunsWJ9Rw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g5cgcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 13:34:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SDT59S009238;
	Fri, 28 Aug 2026 13:34:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwped1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 13:34:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SDYZpQ46072082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 13:34:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B011F2004B;
	Fri, 28 Aug 2026 13:34:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F130420040;
	Fri, 28 Aug 2026 13:34:34 +0000 (GMT)
Received: from [9.87.143.119] (unknown [9.87.143.119])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 13:34:34 +0000 (GMT)
Message-ID: <8b141a3d-1ea7-44ad-9311-2157ef37d59f@linux.ibm.com>
Date: Fri, 28 Aug 2026 15:34:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 31/33] KVM: s390: arm64: Implement vCPU IOCTLs
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
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-32-seiden@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260812153631.3376090-32-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 1iN58-ZtGQVhsX3epG6R3oFCSty4l4wa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExNyBTYWx0ZWRfX1AmfNCOtASel
 c8mqmuLOcWKwXmzh4FceT1fM4mNH8GhwNUJ3jbJ2LGLZYSp4epIckfveI3S85+LlYVEX726ijzG
 vLUMe4KXRzyhC+Te5h5BXrXU4GF4do4=
X-Proofpoint-GUID: BxhV8CeXPrNDES7uaKZTwgvSF3hFE8xk
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a918e71 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=YrsC2wo8uTxk9zgACYUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExNyBTYWx0ZWRfX6L8fAg0ygd3R
 RezB3TLIYUYtZOvfHzlMV1lg9Sq1vm7+kh5EX7yRjloUKyXbwh7tiPy3NawVOIkcJApFpAJNjw7
 QSylPgM2QZMU5qiWmNRU8uBS/yNdFJ/mLnfeI0ApRP2T2h03fLMsFVKutv23UoPn6mkEgn+mIVY
 +VrDhN4OqJDijzWFYbc9aWthwno+8QlA8VzRwkyxNa1CvnhZ9mPJi5yFnRrmQpnKJ41qATCnsTd
 R0sUzIkWqk/gvBZZzdlRA1F3qWU+c+BieY5ICZr3AlwY0Y6ms6vqlJjhfq9WA0uWsWVzVJOkcdp
 0iU50mIyo3AZ5HADR6ux6o24/X+kPFUs4Rq6I7YsgPm8pmzstJ1hKZzxjiCt4M2ywQpD8DYd23n
 lLQWriE1pzl0lMJZ4NOKib5iNeMbsmSPf6wFRNrytxcFdWZ7wIADKHS0dTUwBonquAQmuZk8mhi
 VM3hhtEBpORmWY2O47g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280117

On 8/12/26 5:36 PM, Steffen Eiden wrote:
> Implement all required vCPU IOCTLs.
> 
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   arch/s390/kvm/arm64/arm.c         | 392 ++++++++++++++++++++++++++++++
>   arch/s390/kvm/arm64/guest.c       |  47 +++-
>   arch/s390/kvm/arm64/handle_exit.c |  31 +++
>   arch/s390/kvm/arm64/handle_exit.h |   9 +
>   arch/s390/kvm/arm64/reset.c       |  73 ++++++
>   arch/s390/kvm/arm64/reset.h       |  11 +
>   arch/s390/kvm/arm64/trace.h       |   2 +-
>   7 files changed, 562 insertions(+), 3 deletions(-)
>   create mode 100644 arch/s390/kvm/arm64/handle_exit.h
>   create mode 100644 arch/s390/kvm/arm64/reset.c
>   create mode 100644 arch/s390/kvm/arm64/reset.h
> 

[...]

> +static int kvm_vcpu_initialize(struct kvm_vcpu *vcpu,
> +			       const struct kvm_vcpu_init *init)
> +{
> +	unsigned long features = init->features[0];
> +	struct kvm *kvm = vcpu->kvm;
> +
> +	scoped_guard(mutex, &kvm->arch.config_lock) {
> +		if (test_bit(KVM_ARCH_FLAG_VCPU_FEATURES_CONFIGURED,
> +			     &kvm->arch.flags) &&


In this case I'd rather have a long line than having to look at this 
mess. One of the cases where a normal mutex acquisition would have made 
the code more readable.


> +		    kvm_vcpu_init_changed(vcpu, init))
> +			return -EINVAL;
> +
> +		bitmap_copy(kvm->arch.vcpu_features, &features,
> +			    KVM_VCPU_MAX_FEATURES);
> +
> +		kvm_reset_vcpu(vcpu);
> +
> +		set_bit(KVM_ARCH_FLAG_VCPU_FEATURES_CONFIGURED,
> +			&kvm->arch.flags);
> +		vcpu_set_flag(vcpu, VCPU_INITIALIZED);
> +	}

[...]

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
> +	ret = 1;
> +	do {
> +		if (signal_pending(current)) {
> +			kvm_run->exit_reason = KVM_EXIT_INTR;
> +			ret = -EINTR;
> +			continue;

Why not break?
With continue we'll jump to the condition which is immediately false 
since we just set ret to a negative value.

> +		}
> +
> +		if (need_resched())
> +			schedule();
> +
> +		if (ret > 0)
> +			ret = check_vcpu_requests(vcpu);
> +
> +		vcpu->arch.sae_block.icptr = 0;
> +
> +		arm_vcpu_run(vcpu);
> +
> +		ret = handle_exit(vcpu);
> +
> +	} while (ret > 0);
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
