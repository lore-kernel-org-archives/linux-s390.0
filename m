Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39116288C96;
	Mon, 13 Jul 2026 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957671; cv=none; b=rYVItgIPSd9bkfGBanqvxyysUl91QspMmslb9DG2Ap1KcgSqvJ81eeiNB86W5PqHD+iHKNnl29VKrjp8DBgYStTYW3f6A0qecIRabKLApDQrdJgyo7WWyMszaJ9pdWIQIvaVkk5HEuzV+fBEBtrsoJ0m+TnvSTB/OOGRjXOOHKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957671; c=relaxed/simple;
	bh=5WSUSK+9wqucQbWGHNGziXRu+ChpYpi8qn+llfKmEwk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mj0uJ1Bid0GOe7VaqfknXMlfFSHdKpvtDQbwxAFRbMD3Nmru/3Zqgp5NZgccth9ZhJp3CaLelTyY7a+ShMA6lIWrGj3w8Br4WCyWrOjYF2AwZidAn4UEUP5/6Uhia55foD6h6j+OBZBCMPE2O+MuNRrGQJY9Gi+ItK4KFFwzJHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deUKOA67; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deUKOA67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E2B1F000E9;
	Mon, 13 Jul 2026 15:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783957670;
	bh=uEiPOq2SjoLx2GMwztkv+qQAkkwjJeE0Irz7S0Bc7Jg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=deUKOA67cKhlFOQai6pmXTsIbOEIOvM8qa5ze7I/4FiEVZ44uT8nqa139gjKriXC5
	 xi1OUhREy7XM5AN9LLUxx6jQ4FJRYF4jIqg9FHPkH8MXN9eqt9+AzH2BCbeuTKjAnA
	 4Za8fGw3kHfsAzKmNHwKlYqo8wz1WuLhf4a8rDDHAxwqQc3UTFIOSo822v17r6nk+i
	 z+32AlANBceNuAmdIwNW79D8drDu1vWT8xW2SEiON5uiPvFgpLruJxg/Yr3oXb5RjJ
	 8WS4uoWH+7h8/om48GHLnFionqVJml7WU4mrHxvPI1OPpyX0EE4+E1Ml7I7+IvXgWV
	 TdmjIlVK/Yrzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] KVM: s390: Fix unlikely NULL gmap dereference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260713150857.269954-2-imbrenda@linux.ibm.com>
References: <20260713150857.269954-1-imbrenda@linux.ibm.com>
 <20260713150857.269954-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 15:47:48 +0000
Message-Id: <20260713154749.94E2B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Commit message and implementation mismatch regarding vCPU initia=
lization
- [Medium] Data race and lack of synchronization barriers on vcpu->arch.ini=
tialized

Pre-existing issues:
- [Critical] Incomplete fix leaves KVM_S390_MEM_OP vulnerable to NULL point=
er dereference
- [High] Data race on vcpu->arch.sie_block->epoch with KVM_SET_ONE_REG sile=
ntly drops userspace configuration
--

--- Patch [1]: [PATCH v2 1/7] KVM: s390: Fix unlikely NULL gmap dereference=
 ---
commit f0bb4780c8538aa3e30c05d74a7d340ba636dd73
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix unlikely NULL gmap dereference
   =20
When creating a new vCPU, kvm_vm_ioctl_create_vcpu() will call
kvm_arch_vcpu_postcreate() after the file descriptor for the new vCPU
has been created. The new file descriptor has not been returned yet,
but a malicious userspace program could try to guess it.

[ ... ]

> Fix this by moving the initialization of vcpu->arch.gmap into
> kvm_arch_vcpu_create(), which is called before the file descriptor for
> the vCPU is created.

[Severity: Medium]
The commit message states that the initialization of vcpu->arch.gmap is bei=
ng
moved to kvm_arch_vcpu_create(), but the implementation instead adds a new
vcpu->arch.initialized flag and leaves the gmap initialization in
kvm_arch_vcpu_postcreate(). Is this description accurate?

[ ... ]

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 23c817595e28d..374dae6dae81b 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3611,6 +3611,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0 ||
>  	    vcpu->kvm->arch.user_operexec)
>  		vcpu->arch.sie_block->ictl |=3D ICTL_OPEREXC;
> +
> +	WRITE_ONCE(vcpu->arch.initialized, true);

[Severity: High]
This is a pre-existing issue, but does overwriting the epoch here race with
userspace's KVM_SET_ONE_REG?

In kvm_arch_vcpu_postcreate(), the code overwrites the epoch without holding
vcpu->mutex:

	mutex_lock(&vcpu->kvm->lock);
	preempt_disable();
	vcpu->arch.sie_block->epoch =3D vcpu->kvm->arch.epoch;
	vcpu->arch.sie_block->epdx =3D vcpu->kvm->arch.epdx;
	preempt_enable();
	mutex_unlock(&vcpu->kvm->lock);

Since the file descriptor is already exposed, userspace could concurrently
execute KVM_SET_ONE_REG for KVM_REG_S390_EPOCHDIFF:

kvm_arch_vcpu_ioctl_set_one_reg() {
    ...
	case KVM_REG_S390_EPOCHDIFF:
		r =3D get_user(vcpu->arch.sie_block->epoch,
			     (u64 __user *)reg->addr);
    ...
}

Would the unlocked write in kvm_arch_vcpu_postcreate() silently clobber a
valid userspace configuration if KVM_SET_ONE_REG occurs just before it?

[Severity: Medium]
Could this WRITE_ONCE() allow compiler reordering?=20

Since there is no release barrier like smp_store_release(), couldn't the
compiler sink the initialization of vcpu->arch.gmap (which still happens
earlier in this function) below this flag update?

>  }
> =20
>  static bool kvm_has_pckmo_subfunc(struct kvm *kvm, unsigned long nr)

[ ... ]

> @@ -5037,6 +5039,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  	    kvm_run->kvm_dirty_regs & ~KVM_SYNC_S390_VALID_FIELDS)
>  		return -EINVAL;
> =20
> +	if (!vcpu->arch.initialized)
> +		return -EINVAL;
> +

[Severity: Medium]
Since this flag is written concurrently in kvm_arch_vcpu_postcreate(), does
this plain C read create a data race?  Should this be using READ_ONCE() or
smp_load_acquire() to ensure the memory accesses to vcpu->arch.gmap are saf=
ely
ordered?

[Severity: Critical]
This is a pre-existing issue, but does this fix leave KVM_S390_MEM_OP
vulnerable to a NULL pointer dereference?

The patch prevents KVM_RUN from executing before initialization, but doesn't
add a similar check for KVM_S390_MEM_OP. A concurrent KVM_S390_MEM_OP
handler will proceed:

kvm_s390_vcpu_mem_op() {
    ...
		r =3D check_gva_range(vcpu, mop->gaddr, mop->ar, mop->size,
				    acc_mode, mop->key);
    ...
}

If the KVM_S390_MEMOP_F_SKEY_PROTECTION flag is set, it routes to:

vcpu_check_access_key_gpa() {
    ...
	scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
		r =3D dat_get_storage_key(vcpu->arch.gmap->asce, gpa_to_gfn(gpa), &storag=
e_key);
    ...
}

Could this unconditionally dereference vcpu->arch.gmap->asce while it is st=
ill
NULL, resulting in a kernel panic?

>  	vcpu_load(vcpu);
> =20
>  	if (guestdbg_exit_pending(vcpu)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713150857.2699=
54-1-imbrenda@linux.ibm.com?part=3D1
