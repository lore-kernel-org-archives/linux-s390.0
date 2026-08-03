Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80C941D210;
	Mon,  3 Aug 2026 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776629; cv=none; b=PmpPtELhCNaPIHOY5D1SILF9GuAbnMpG/eBrvjt+Qz641K1Batj+yRaerT6lL5SAjEAk9fmmQMYieO0aYiiMqqQoc1dCqEURF76YXqeLy61eQWGTG5mpyEVZuVnLRqegs8bFpES3mFW+ErF84oMThHrAO9K/QjmygsyO1yDY+Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776629; c=relaxed/simple;
	bh=OKUUg1o40n9dn9EvtE63hYLuvtzR2SjZPTu7BDrrXHk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RtLNq7/EB1QEvX+xpvWjW82o3dMU8QiwotVeophR1Np0v7DjT/CuPy2rpHZ+Zl4yopBQz/bi0B60c0UdvLm/K2QVakScWcabeL+BiGh2lTrgAu1oVmemwkgHuN2NCJk9djS4zU36atJvyHx5ZJtk0wZrfr/1uScRxs2wqAvA6H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKr3uwac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKr3uwac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050E21F000E9;
	Mon,  3 Aug 2026 17:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785776621;
	bh=ftqbryoshi0kyb4aFde12uDbE8z3uZvZPzlCbzUowPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KKr3uwacyxAqgSLL4Mfuvkr1OOh35te6MVRdqxydtw6qegWrYU2m4yFNycBwkBI+t
	 nHEJ6/HgUSkbfCaPK0a4L8Gh8B8kmIHpdDbfJcQGJ3Hy59PFiYTQQzCGdgtQWc3AQ7
	 cMCdRv09ncR3ia53p3maudKazNZh6IgAnlzUnWNDk2zJKCD/j1fTh8Fsmcq4c7XCwC
	 w1hOvBHnOktEwLOa0rONmU56VCXP3OJ9FZten6xYe7fPqv7xeeR2zXy4PcPZSQa098
	 6p1cte8AaKstMoQ7hPuDljVDBz4nrA8Xb4lYtjmqiMaHo3QBOQQcXBL5Xb8k3qOrwR
	 LF0OjAQb8Ko5Q==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 14/23] KVM: s390: Fix overclearing ESCA in case of
 error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260803160924.236807-15-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-15-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 17:03:40 +0000
Message-Id: <20260803170341.050E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds memory accesses to the ESCA block for KVM_VM_S390_UC=
ONTROL VMs with vcpu_id >=3D KVM_S390_ESCA_CPU_SLOTS (248).
- [High] Memory leak of `vcpu->arch.mc` in `kvm_arch_vcpu_create` error pat=
hs.
- [High] Memory leak of `stor_base` and `sidad` pages in `kvm_s390_pv_creat=
e_cpu` when Ultravisor call fails.
--

--- Patch [14]: [GIT PULL v1 14/23] KVM: s390: Fix overclearing ESCA in cas=
e of error ---
commit d5a31a585e995dfd927fed9a3fff444b9b4d0db1
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix overclearing ESCA in case of error

If an attempt is made to create a vCPU with an already existing ID,
the duplicated vCPU will be destroyed, clearing its ESCA entry. This
commit skips clearing the ESCA entry if the vCPU creation was not
successful.

Message-ID: <20260803124040.126471-5-imbrenda@linux.ibm.com>

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
This is a pre-existing issue, but does this function have an out-of-bounds
write if the VM is KVM_VM_S390_UCONTROL and the vcpu_id is >=3D 248?

If a user with CAP_SYS_ADMIN creates a ucontrol VM and initializes a vCPU
with a vcpu_id between 248 and 254, indexing into sca->cpu[vcpu->vcpu_id]
would be out of bounds since KVM_S390_ESCA_CPU_SLOTS is 248.

Functions like sca_clear_ext_call(), sca_inject_ext_call(), and
sca_ext_call_pending() appear to access this without bounds checking. Could
this corrupt adjacent memory pages?

[ ... ]

[Severity: High]
This is a pre-existing issue, but does kvm_arch_vcpu_create() leak
vcpu->arch.mc in the error path?

Looking at the error handling in kvm_arch_vcpu_create():

out_ucontrol_uninit:
	if (kvm_is_ucontrol(vcpu->kvm)) {
		gmap_remove_child(vcpu->arch.gmap);
		vcpu->arch.gmap =3D gmap_put(vcpu->arch.gmap);
	}
out_free_sie_block:
	free_page((unsigned long)(vcpu->arch.sie_block));
	return rc;

If an error occurs during kvm_s390_vcpu_setup() and it jumps to
out_ucontrol_uninit, it appears kvm_s390_free_mmu_cache() is never called
before returning. Can userspace systematically leak the KVM MMU cache by
inducing vCPU setup failures?

[Severity: High]
This is a pre-existing issue, but does kvm_s390_pv_create_cpu() leak
stor_base and sidad pages when the Ultravisor call fails?

In kvm_s390_pv_create_cpu(), if the uv_call fails, it tries to clean up:

	if (cc) {
		u16 dummy;

		kvm_s390_pv_destroy_cpu(vcpu, &dummy, &dummy);
		return -EIO;
	}

However, kvm_s390_pv_destroy_cpu() checks the handle:

	if (!kvm_s390_pv_cpu_get_handle(vcpu))
		return 0;

Since vcpu->arch.pv.handle is populated only after a successful UV call,
this will return early. Does this bypass the free_pages() and free_page()
calls for stor_base and the SIDA, permanently leaking them?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D14
