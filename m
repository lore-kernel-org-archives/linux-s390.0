Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203AB3B9DA6;
	Tue, 28 Jul 2026 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260345; cv=none; b=nL2/cWNgtxi7CqXeYggMAfIl1pvZmOBuzVQ8ubmXbs8lBxiOaUytdtZn0rZj8IbjV2yx3mZdWl/GwapxhIFpmYAQyp4yGpYlgIvDgABATiT67a+9Fy7wsjIT7hDIZojBhW2i9ldHOrAUEPu91yURHLznpg4HmGKCf/5QsSu8QWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260345; c=relaxed/simple;
	bh=7CDsY73F9e+yUeTT0uKGeG3aRjFvS0s0KdhxJHIjfOc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tpc8QB+TX2XVO75x/8dzkP6OZJeTCm7Am0kR59ftj3/ECdvEK1RDPEdPCOcntgDXT3MAjA3+hD9PWarJdoZ2D1yyBj9K9m3QupitCURXSambsaEr2nZg7OkTWHSlGQK0rC1J3tbwdyG8j/kBRcxDfevS6Blk39AD0kBn0M5djDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVPiIaMM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVPiIaMM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34761F000E9;
	Tue, 28 Jul 2026 17:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260343;
	bh=GGOmGavii8rSHeWKjpJ6aDseh1v7eN7/iJJ61nY4eLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jVPiIaMMh8CeaAukxew1PBqeKdVRpj40D7/A7bG5nFipq79eQLRwTXKLW9QFRQORH
	 JM6imPaykr3yOnAs5Mj1EDlC3Xxk/tqm9MjaliMlLAVzl2INkcUwlsamuYeM1oN54D
	 EMufk/WTvmTHzrng+B1KaYY2+4hlKtVLytHuNKCsF/zmXcBTajvHJKKc7tAeprlvRK
	 lr7B8TVGvG3EcM5uWMQlfKKrN9SDQt5Kx71SJD9tycgnZCLeb5KYIU6f5Tscp+ejku
	 yvPbNtQF/13/gfBUJQ+x9r7NHbZZviIu4UTgbYGfi1eqcc4WsmnIB4cDq4T3kj5vmp
	 UhTtJAtcRIgZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/13] KVM: s390: Fix sca_clear_ext_call() for
 UCONTROL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260728170708.294400-14-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
 <20260728170708.294400-14-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:39:02 +0000
Message-Id: <20260728173902.D34761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Asymmetric resource teardown of CPUSTAT_ECALL_PEND for UCONTROL VM=
s leading to a permanent stuck state.
- [High] Double-decrement of `cmma_dirty_pages` counter due to a retry loop.

Pre-existing issues:
- [Critical] Out-of-bounds memory access in `sca_inject_ext_call()` and `sc=
a_ext_call_pending()` for UCONTROL VMs.
--

--- Patch [13]: [PATCH v4 13/13] KVM: s390: Fix sca_clear_ext_call() for UC=
ONTROL ---
commit d27d3f9f6aa096af6e829ecfb494bcc68d320453
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>
Date:   Tue Jul 28 17:07:08 2026 +0000

    KVM: s390: Fix sca_clear_ext_call() for UCONTROL

This commit fixes an out-of-bounds access in sca_clear_ext_call() for UCONT=
ROL
VMs by returning early before touching the ESCA block. UCONTROL VMs bypass =
ESCA
but can have vCPU IDs larger than the ESCA block capacity.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 2acdff130fa6c..8d146a0681dce 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -84,10 +84,13 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu,=
 int src_id)
>  static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
>  {
>  	struct esca_block *sca =3D vcpu->kvm->arch.sca;
> -	union esca_sigp_ctrl *sigp_ctrl =3D &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
> +	union esca_sigp_ctrl *sigp_ctrl;
> =20
> -	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
> +	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized || kvm_is_uc=
ontrol(vcpu->kvm))
>  		return;

[Severity: High]
Could this early return for UCONTROL VMs skip clearing the CPUSTAT_ECALL_PE=
ND
flag?

Prior to this patch, if an external call was injected into a UCONTROL VM,
sca_inject_ext_call() would set the CPUSTAT_ECALL_PEND cpuflag, and
sca_clear_ext_call() would later clear it. By adding an early return here
without a corresponding check in sca_inject_ext_call(), the flag is set but
never cleared. Would this leave the VM in a permanently corrupted state acr=
oss
resets?

[Severity: Critical]
This is a pre-existing issue, but UCONTROL VMs bypass the sca_can_add_vcpu()
constraints, allowing vCPU IDs up to KVM_MAX_VCPUS - 1 (254). The ESCA block
only holds KVM_S390_ESCA_CPU_SLOTS (248) entries.

While this patch prevents out-of-bounds access in sca_clear_ext_call(), it
fails to patch identical accesses in sca_inject_ext_call():

arch/s390/kvm/interrupt.c:sca_inject_ext_call() {
    ...
    union esca_sigp_ctrl *sigp_ctrl =3D &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
    ...
}

and sca_ext_call_pending():

arch/s390/kvm/interrupt.c:sca_ext_call_pending() {
    ...
    union esca_sigp_ctrl sigp_ctrl =3D sca->cpu[vcpu->vcpu_id].sigp_ctrl;
    ...
}

The entry point for userspace interrupt injection, __inject_extcall(), calls
sca_inject_ext_call() based on host hardware capabilities without verifying
if the target VM is UCONTROL.

Can a malicious userspace process trigger these out-of-bounds accesses by
injecting external calls or polling for pending interrupts on a vCPU with
an ID >=3D 248?

> +
> +	/* Initialize after the above check, to prevent going out of bounds */
> +	sigp_ctrl =3D &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
>  	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_ECALL_PEND);
> =20
>  	WRITE_ONCE(sigp_ctrl->value, 0);

[Severity: High]
I also noticed a separate issue introduced in commit 'KVM: s390: Fix
kvm_arch_commit_memory_region() when low on memory'.

Is there a risk that the retry loop in kvm_arch_commit_memory_region() caus=
es
a double-decrement of the cmma_dirty_pages counter?

arch/s390/kvm/kvm-s390.c:kvm_arch_commit_memory_region() {
    ...
    retry:
        ...
        _dat_walk_gfn_range(old->base_gfn, old->base_gfn + old->npages,
                            kvm->arch.gmap->asce, &ops, DAT_WALK_IGN_HOLES,
                            &kvm->arch.cmma_dirty_pages);
    ...
}

Inside this loop, _dat_walk_gfn_range() uses cmma_d_count_pte() to decrement
kvm->arch.cmma_dirty_pages for every PTE where cmma_d is set:

arch/s390/kvm/kvm-s390.c:cmma_d_count_pte() {
    if (pgste_of(ptep)->cmma_d)
        atomic64_dec(walk->priv);
    ...
}

Because cmma_d_count_pte() does not clear the cmma_d bit, if
dat_delete_slot() or dat_create_slot() fails with -ENOMEM, the code jumps
to retry and executes the pass again over the exact same range.

Could this decrement the counter a second time for unchanged PTEs, leading =
to
an underflow and breaking CMMA dirty page tracking during VM migration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728170708.2944=
00-1-imbrenda@linux.ibm.com?part=3D13
