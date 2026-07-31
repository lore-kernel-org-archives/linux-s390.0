Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D343EB81D;
	Fri, 31 Jul 2026 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504799; cv=none; b=FC4i2BBtQ4r7LrTs2QLrLD86dzzOGNcywHPu/9470l3pBcCRvpwaIVjYI5USzZDtOZmbvHY1g6pLVrpk7RiPH2GOlMHKEqXTF76QlSRNcm4hP8Eyd6Lv1KBjgibBhbozttKeLrngxdfDmmGvOF07QqWsmjafooXUk7MLhKQbeeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504799; c=relaxed/simple;
	bh=GGZNkGPQGFd6cGsDAzN21bmuXWew1bFWJ5a7M/MJ0VA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cg8bLM4zsR1dZzZ8bl0h5HcRGjJdjjIpw4Xe9Ymp+wuJsZ/I+ot+3l07GXhbLYv5WnOZowOKTnIBugX3iw9MTypyIdNi4b3Hs34rddw6tcZS5WHud3rvZfapKRIxzKuFtLBAK5Wj7DixQ4z4twpcMNgIRMU4Kziezt2mieQlJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/xiOom/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/xiOom/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB3F1F000E9;
	Fri, 31 Jul 2026 13:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504798;
	bh=2YAlLpjnujENoqVxlCswyP5wg9hvubinC2JRmI0WhWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J/xiOom/Zq+21HRVMhZI7h/AMuI0Lzyltsx8XBNfmcEUIkoQf69KoMY+2amTr6DPq
	 sFyg2Df1jhOXtsWbyYeQAcYfevm6xZ4FppXilYIWyxMYsCVGOcAQEilLKvd+N+xh8U
	 dzxvFzEGYvYHZ4cotKooBHlTcJVsBI3/ZSMCaVftzy1taZODx1rh5zTGD1z6o94waY
	 MmUdUgqzoHNv1TE7MBe1H6gAMOPazxLBVPoVnnSP88GzOe/4vgomowar4/Nva50zUH
	 KW3eBPz8txRra+MjuCSpJ9C8lZtR5kkhg+aWMFhnE9dfKr6MX4DZJ2GN7qh6vjYU0y
	 NNDOcukA3yBUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/14] KVM: s390: Fix overclearing ESCA in case of
 error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260731130138.173983-5-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
 <20260731130138.173983-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:33:17 +0000
Message-Id: <20260731133317.9FB3F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Out-of-bounds ESCA entry accesses for ucontrol VMs due to bypa=
ssed vCPU ID limit check.
- [High] Memory leak of `vcpu->arch.mc` when `kvm_arch_vcpu_create` fails.
- [High] Memory leak in `kvm_s390_pv_create_cpu` error path allows maliciou=
s userspace to exhaust host memory (OOM).
--

--- Patch [4]: [PATCH v7 04/14] KVM: s390: Fix overclearing ESCA in case of=
 error ---
commit 3c41df2f29ed108f81950295bc782ec27a142a6b
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix overclearing ESCA in case of error

> If an attempt is made to create a vCPU with an already existing ID,
> the duplicated vCPU will be destroyed.

[Severity: High]
This isn't a bug introduced by this patch, but does this duplicated vCPU
error path leak memory?

If a duplicated vCPU ID causes kvm_arch_vcpu_create() to fail, the error
path jumps to out_free_sie_block:

arch/s390/kvm/kvm-s390.c:kvm_arch_vcpu_create() {
    ...
out_free_sie_block:
    free_page((unsigned long)(vcpu->arch.sie_block));
    return rc;
}

This frees vcpu->arch.sie_block, but doesn't it leave vcpu->arch.mc
allocated? Can userspace intentionally exhaust host memory by repeatedly
creating duplicate vCPUs?


[Severity: High]
This is a pre-existing issue, but does a duplicate vCPU ID also trigger a
leak in the PV CPU creation error path?

If uv_call() fails due to the duplicate ID, kvm_s390_pv_create_cpu() calls
kvm_s390_pv_destroy_cpu():

arch/s390/kvm/pv.c:kvm_s390_pv_create_cpu() {
    ...
    cc =3D uv_call(0, (u64)&uvcb);
    if (cc) {
        u16 dummy;
        kvm_s390_pv_destroy_cpu(vcpu, &dummy, &dummy);
        return -EIO;
    }
}

Because uv_call() failed, the secure CPU handle is unpopulated (0). The
destroy function checks this handle and returns early:

arch/s390/kvm/pv.c:kvm_s390_pv_destroy_cpu() {
    if (!kvm_s390_pv_cpu_get_handle(vcpu))
        return 0;
    ...
}

Does this skip the free_pages() calls, abandoning the allocated
vcpu->arch.pv.stor_base and sida_addr?

> When destroying a vCPU, its ESCA entry will be cleared. In the above
> scenario, the spurious duplicate vCPU is destroyed, but the ESCA entry
> corresponding to the original vCPU is cleared.
>=20
> Fix by skipping clearing the ESCA entry if the vCPU creation was not
> successful, i.e. if the pointer to the ESCA in the state description is
> not set.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 9e3e6b0d72ad6..2acdff130fa6c 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -86,7 +86,7 @@ static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
>  	struct esca_block *sca =3D vcpu->kvm->arch.sca;
>  	union esca_sigp_ctrl *sigp_ctrl =3D &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
> =20
> -	if (!kvm_s390_use_sca_entries())
> +	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
>  		return;
>  	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_ECALL_PEND);

[Severity: Critical]
This isn't a bug introduced by this patch, but does this function perform
an out-of-bounds write for ucontrol VMs?

For ucontrol VMs, kvm_arch_vcpu_precreate() skips the sca_can_add_vcpu()
bounds check, allowing vcpu_id to reach up to 254 (KVM_MAX_VCPU_IDS - 1).=20
However, the ESCA block (sca->cpu) only contains 248 slots.

When a vcpu_id is >=3D 248, does the subsequent write to sigp_ctrl overwrite
adjacent memory?

arch/s390/kvm/interrupt.c:sca_clear_ext_call() {
    ...
    WRITE_ONCE(sigp_ctrl->value, 0);
}

Similar out-of-bounds access happens in sca_inject_ext_call() during
cmpxchg(). Can an unprivileged user exploit this by creating a ucontrol VM
with vcpu_id >=3D 248 and triggering vCPU teardown?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130138.1739=
83-1-imbrenda@linux.ibm.com?part=3D4
