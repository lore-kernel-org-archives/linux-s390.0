Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F537A852;
	Thu,  2 Jul 2026 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006987; cv=none; b=DazjYoYqLBxT1zexM2l4vSrIrQDr45DE1fAQPvuJ3Wp+ILjfu2Pd0sA32lpLC/XVXirbZnTCmzs78vNy7mOD4DiY59Vq8a2OeRjIjcTvKE/5C39CaI7PZiiegtSCoa0jiyyAsKDjTnnf8L++aWTdFCpDXuseBHiGdm6wKXJiJAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006987; c=relaxed/simple;
	bh=MdomA+tab8Subwvcr7OzxtUfKkCH/gKq3tcuNqO3VOE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jGnpUp+MLWTWstQ5bNAUY1PjQYWpPXudljLUskww5k1033pL8yJxi1nhlFbxWQjucl3luIq5Xb3Xdm1uBr+OEU9e8LDfnfIgn2tyOTWqb+0v255RSInVh2YZJbe/DAqDtjk8yIkZb6DoJ8JEWALPfZHaOahoaE+gVXr2O10fKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOmg4s/W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOmg4s/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECF81F000E9;
	Thu,  2 Jul 2026 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006986;
	bh=53LbAyq+b/DK5/+9BCkLe/+647+sClpS7jluVjY5Y5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MOmg4s/WpDkHso1DB65hDIZHtoRX0Jm9iUu3aMkQkF72Vrp/RYSJkG0/9Z7/yQltr
	 YDDYDn6kKBPn1gWCJoIeLXA+2eJQeB+2dKUtiy1QjLshhcHmZaozQxE5YYFbM2rnXE
	 61obfWbXeb3g8NU10HzscvsBilCo/DdRDWfCa07d1LWgzFk03c1PO976rLTrHDN4tK
	 j3Ac+1TpsIYxnQRNRS7JJ12bgvuj+gpuzIlFd42cSdMtM9HZFZ5z+QbX7SEVFV+xEY
	 bJOwfnpGoV46kM1BD7AUFZu468pcSXqx6I8gpXq8n35ROkby8bIexgNtlQL7wKDnu5
	 HwJAsxeiolhaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/8] KVM: s390: Fix unlikely NULL gmap dereference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260702152406.204782-3-imbrenda@linux.ibm.com>
References: <20260702152406.204782-1-imbrenda@linux.ibm.com>
 <20260702152406.204782-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:43:05 +0000
Message-Id: <20260702154306.3ECF81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch incompletely fixes the race condition between vCPU c=
reation and `KVM_RUN`. While it fixes the `gmap` NULL pointer dereference, =
it leaves the initialization of other critical `sie_block` fields (`sca_add=
_vcpu`, `epoch`, `epdx`, `ictl`) in `kvm_arch_vcpu_postcreate()`, which can=
 run concurrently with `KVM_RUN` and corrupt host memory.
- [High] Calling `gmap_remove_child()` without holding `children_lock` in `=
kvm_arch_vcpu_create()` error path.
- [High] Concurrent creation of vCPUs with the same `vcpu_id` clears the va=
lid vCPU's SCA entry.
--

commit 8b61d8766d5d3ccd96fcdcaf7ad4379e712b4282
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix unlikely NULL gmap dereference

When creating a new vCPU, kvm_vm_ioctl_create_vcpu() will call
kvm_arch_vcpu_postcreate() after the file descriptor for the new vCPU
has been created. The new file descriptor has not been returned yet,
but a malicious userspace program could try to guess it.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 23c817595e28d..4a6d903e35231 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3604,10 +3604,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcp=
u)
>  	vcpu->arch.sie_block->epdx =3D vcpu->kvm->arch.epdx;
>  	preempt_enable();
>  	mutex_unlock(&vcpu->kvm->lock);
> -	if (!kvm_is_ucontrol(vcpu->kvm)) {
> -		vcpu->arch.gmap =3D vcpu->kvm->arch.gmap;
> +	if (!kvm_is_ucontrol(vcpu->kvm))
>  		sca_add_vcpu(vcpu);

[Severity: High]
This isn't a bug introduced by this patch, but does leaving sca_add_vcpu() =
and
other sie_block initialization in kvm_arch_vcpu_postcreate() leave a race
condition open?

The commit message notes that malicious userspace can start the newly creat=
ed
vCPU before kvm_arch_vcpu_postcreate() finishes. If kvm_vm_ioctl_create_vcp=
u()
drops vcpu->mutex and kvm->lock before calling kvm_arch_vcpu_postcreate(),
can KVM_RUN execute concurrently?

If KVM_RUN enters the guest before sca_add_vcpu() completes:

arch/s390/kvm/kvm-s390.c:sca_add_vcpu() {
	...
	vcpu->arch.sie_block->scaoh =3D sca_phys >> 32;
	vcpu->arch.sie_block->scaol =3D sca_phys & ESCA_SCAOL_MASK;
	vcpu->arch.sie_block->ecb2 |=3D ECB2_ESCA;
	...
}

Will the hardware use physical address 0 as the System Control Area base and
overwrite host absolute physical address 0 when updating inter-processor
states?

>  	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0 ||
>  	    vcpu->kvm->arch.user_operexec)
>  		vcpu->arch.sie_block->ictl |=3D ICTL_OPEREXC;

[ ... ]

> @@ -3850,6 +3848,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  		vcpu->arch.gmap =3D gmap_new_child(vcpu->kvm->arch.gmap, -1UL);
>  		if (!vcpu->arch.gmap)
>  			goto out_free_sie_block;
> +	} else {
> +		vcpu->arch.gmap =3D vcpu->kvm->arch.gmap;
>  	}
> =20
>  	VM_EVENT(vcpu->kvm, 3, "create cpu %d at 0x%p, sie block at 0x%p",

[Severity: High]
This is a pre-existing issue, but does the error handling path for ucontrol
vCPUs in kvm_arch_vcpu_create() safely remove the gmap child?

If kvm_s390_vcpu_setup() fails, the out_ucontrol_uninit path calls
gmap_remove_child(vcpu->arch.gmap). Looking at gmap_remove_child() in
arch/s390/kvm/gmap.c, it modifies child->list and has a lockdep assertion
for child->parent->children_lock:

arch/s390/kvm/gmap.c:gmap_remove_child() {
	lockdep_assert_held(&child->parent->children_lock);

	list_del(&child->list);
	...
}

Since kvm_arch_vcpu_create() does not acquire children_lock before jumping =
to
out_ucontrol_uninit, could this cause list corruption if concurrent creation
failures race?

[Severity: High]
This is also a pre-existing issue, but is there a risk of clearing a valid
SCA entry if userspace concurrently creates two vCPUs with the same vcpu_id?

Duplicate ID detection occurs in kvm_vm_ioctl_create_vcpu() after
kvm_arch_vcpu_create() succeeds. If the ID check fails, it eventually calls
kvm_arch_vcpu_destroy(), which unconditionally calls sca_del_vcpu():

arch/s390/kvm/kvm-s390.c:sca_del_vcpu() {
	...
	sca->cpu[vcpu->vcpu_id].sda =3D 0;
	...
}

If a valid vCPU already exists with this vcpu_id, does the failed creation
thread wipe out the valid vCPU's SCA interrupt delivery structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702152406.2047=
82-1-imbrenda@linux.ibm.com?part=3D2
