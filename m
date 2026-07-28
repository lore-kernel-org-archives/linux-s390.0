Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE2939F160;
	Tue, 28 Jul 2026 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259641; cv=none; b=jICxOgMn/ROjOrUjT9evRa4STp2QIUYEctBDXNd+FmxeLlX8hb+3YpgjD7HJ2D6RE94Hh0gH3YHZev9Z5yQchk9vh/DU/kEL11h96KuiLYGTl/RBfJnohr0Of3abhjPvS/M/zvRA47PKxkhgIfY0KmOS60DuyPrcrZL/Xc5CSsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259641; c=relaxed/simple;
	bh=ZaMRLTLnJMiUG2Fhtolc0mpShs1xvvP9BEUwP8EKI58=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jibMmM2b9bxPBQEhZ/FzL3z6jhRs4OC2ZOBUuw+W6kBojHuRA92ZEN54HUHS3M2UPTEa3fFbWtKxL5b0wxs0ZuooUtEsbepx2NNx+FFXLqLyB0JWMluGf2kyJGob3YJVithsFEV3WxZIO8c2YzHIMukqxZDKACTRk8wI5FfnIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwqAvAq6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwqAvAq6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F771F00A3A;
	Tue, 28 Jul 2026 17:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785259640;
	bh=OoRbrUozT59SG++HlWkKD0NrGZ9aJNXkVNaLEMo2PTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WwqAvAq67GuPTX/nYzUtkD0Vhn7Zgv0cdMR56VPqVoemmOiCSRJDfDE223etSjKZm
	 QImDwV7Ydu/4JaJDomi/x5aXKY6a1eyWhsvYfCegxsTN71qoYzEX3szUv9A3+3Y1GM
	 bDwstjV1JXKnEanFP2xN0qrUy+PptP3yKIUzaf8+mOepuKJx+yG1kLtAUkr3fpvrED
	 0GHDvBeONIULZ0Fmz2dtf1qtFnMvZTJ1QStpnzYltzGClDwPmmMBuVTkIEuaRtx0rS
	 gWoz829Sqr47BNLGGtvjduzZT/QNVw4NdN+aOhEYrnKSAbCf4hjE/I4Ml+McbIpZ6u
	 uubJn6JbGVTgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/13] KVM: s390: Fix overclearing ESCA in case of
 error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260728170708.294400-7-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
 <20260728170708.294400-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:27:19 +0000
Message-Id: <20260728172719.E2F771F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of MMU cache on kvm_arch_vcpu_create() error path.
- [High] Out-of-bounds array access and kernel memory corruption in ESCA in=
terrupt handlers for UCONTROL VMs due to unconstrained vcpu_id.
--

--- Patch [6]: [PATCH v4 06/13] KVM: s390: Fix overclearing ESCA in case of=
 error ---
commit a40c7240ce30546ef77f030cf591a1bc94d9f75b
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix overclearing ESCA in case of error

If an attempt is made to create a vCPU with an already existing ID, the
duplicated vCPU will be destroyed. This patch avoids clearing the ESCA
entry if the vCPU creation was not successful.

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

[Severity: High]
This is a pre-existing issue, but does this pointer calculation allow an
out-of-bounds access for UCONTROL VMs?

UCONTROL VMs bypass the sca_can_add_vcpu() bounds check during
kvm_arch_vcpu_precreate(), which allows vcpu_id to reach up to 254 instead
of the array limit of 247.

When a successfully initialized UCONTROL vCPU is destroyed,
kvm_arch_vcpu_destroy() unconditionally calls kvm_s390_clear_local_irqs(),
which invokes sca_clear_ext_call().

Because the sigp_ctrl pointer is computed without verifying if the VM is a
UCONTROL VM, a vcpu_id of 254 resolves to an offset 132 bytes beyond the
allocated esca_block.

Could the subsequent WRITE_ONCE(sigp_ctrl->value, 0) further down in the
function then overwrite adjacent kernel memory?

>  	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_ECALL_PEND);
> =20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index fa6a0bacd9675..24b48dc5655b1 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3459,7 +3459,7 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu)
>  {
>  	struct esca_block *sca =3D vcpu->kvm->arch.sca;
> =20
> -	if (!kvm_s390_use_sca_entries())
> +	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
>  		return;

[Severity: High]
This isn't a bug introduced by this patch, but does the error path for vCPU=
=20
creation leak the MMU cache?

In kvm_arch_vcpu_create(), vcpu->arch.mc is dynamically allocated:

arch/s390/kvm/kvm-s390.c:kvm_arch_vcpu_create() {
    ...
    vcpu->arch.mc =3D kvm_s390_new_mmu_cache();
    ...
}

If a subsequent initialization step fails (such as gmap_new_child() failing
for UCONTROL VMs, or kvm_s390_vcpu_setup() returning an error), the function
jumps to the out_free_sie_block label.

While this error path frees vcpu->arch.sie_block, it completely neglects to
call kvm_s390_free_mmu_cache(vcpu->arch.mc).

Since the caller (kvm_vm_ioctl_create_vcpu()) then directly frees the vcpu
struct without calling kvm_arch_vcpu_destroy(), does this permanently leak
the kvm_s390_mmu_cache and its associated page tables?

> =20
>  	clear_bit_inv(vcpu->vcpu_id, (unsigned long *)sca->mcn);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728170708.2944=
00-1-imbrenda@linux.ibm.com?part=3D6
