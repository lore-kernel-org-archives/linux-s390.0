Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901313A9630;
	Mon, 31 Aug 2026 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788213649; cv=none; b=DOVo3zKINsUYC9jtoLpnrRqidmifhdiRvKd0auOeL2nrmSr4jSRm1v6+hY6uypE0QM2flm5Hx4PJKCpR+BIEw6bzCsFjW1UYVi9JKYbssAdVS0tYJWC5nUM6gtedvOIHuysY3eLTYSr6ZyY880WlYxB51klcF8zJ+pLml/Nynrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788213649; c=relaxed/simple;
	bh=eozcPZTTmA5GtcDUU1bnwHqt0x3iA7/SmIvj+ktfWXo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tn75ER6V4l3OTxW0WmcdPzp38u2K0+M5cSp9nP5d5PFhHDAbq04J9p8FvP1/HhQ3e5jpDNHgBUfJ+S9VIdgm0Btp6+8wkD1zBZccnprFyG04yY62+QnA4nacXr1XxV9bVQGZD0rVAeFhmtKFaYZxDWQU/T41mGna6mVZJPehAXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwzKHvkG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwzKHvkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25581F000E9;
	Mon, 31 Aug 2026 22:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788213648;
	bh=WtfBuVYl8rXMb1WQu8DoxL6vpphsWjq6jfVssFLfii8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iwzKHvkGjYl2+iN69OUIAaaKiy9eogfNv8ju1DELhM413ToEDa8TMd0iBKhtsroh5
	 QWp0UUu1qwDXVfxj7Ul6Kj1ikG6erDFWicm4hBXiMrtWBH0F9EzdlcXzyN7cE5b3k/
	 WFV1W4c3d+hJz/oogfgTZqC0W2FM/I4pc16GqdK944Q5UGD5e4c2ihRIOBARMEXIOJ
	 IztnkPJ4yZrOPtOsu9JvQFtEMQllKEqQ9nE92vb2ZRQCde6262QAsAaV1J0alDb+i4
	 ZepcSoOScqPGZHDRIgjq44FDz2Ef4eLY/HHKC4kzibaH08GuWOZn5CFX5ruy5ZEY0s
	 UYVweJTpoRVGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 22/23] KVM: s390: arm64: Implement basic page fault
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, "Heiko
 Carstens" <hca@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20260831144802.834315-23-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-23-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:00:47 +0000
Message-Id: <20260831220047.B25581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unused local variable 'esr' and unused parameters 'slot' and 'hva'.
--

commit 0b610e782223a98a4d9a93986b45a74687aeae46
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement basic page fault handler

This commit adds host functionality to page in guest memory. If the guest d=
oes
something unexpected or illegal, it exits to userspace and aborts execution.

[ ... ]
> diff --git a/arch/s390/kvm/arm64/mmu.c b/arch/s390/kvm/arm64/mmu.c
> new file mode 100644
> index 0000000000000..bf3442d3609b2
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/mmu.c
> @@ -0,0 +1,177 @@
[ ... ]
> +/*
> + * user_mem_abort() - handle a dat fault for the gmap of a vcpu
> + *
> + * Return: 0 on success, < 0 in case of error.
> + * Context: The mm lock must not be held before calling. May sleep.
> + */
> +static int user_mem_abort(struct kvm_vcpu *vcpu, gpa_t fault_ipa,
> +			  struct kvm_memory_slot *slot, hva_t hva)
> +{

[Severity: Low]
Are the slot and hva parameters needed for user_mem_abort in
arch/s390/kvm/arm64/mmu.c? They are passed into the function but never acce=
ssed
inside the function body. Could they be removed to avoid unused parameter
warnings?

> +	struct guest_fault f =3D { };
> +	int ret;
> +
> +	if (kvm_s390_cur_gmap_fault_is_write(vcpu))
> +		f.write_attempt =3D FOLL_WRITE;
> +	f.gfn =3D gpa_to_gfn(fault_ipa);
> +
> +	ret =3D kvm_s390_faultin_gfn(vcpu, NULL, &f);
[ ... ]
> +int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_memory_slot *memslot;
> +	bool translation =3D false;
> +	phys_addr_t fault_ipa;
> +	unsigned long esr;
> +	unsigned long hva;
> +	bool write_fault;
> +	bool guest_size_err;
> +	bool writable;
> +	bool is_iabt;
> +	int ret;
> +	gfn_t gfn;
> +	int idx;
> +
> +	esr =3D kvm_vcpu_get_esr(vcpu);

[Severity: Low]
Is the esr variable needed here? It is assigned the result of
kvm_vcpu_get_esr(vcpu) in kvm_handle_guest_abort(), but it is never
evaluated subsequently in the function.

> +	fault_ipa =3D kvm_vcpu_get_fault_ipa(vcpu);
> +	is_iabt =3D kvm_vcpu_trap_is_iabt(vcpu);
> +	guest_size_err =3D vcpu->arch.sae_block.icptr =3D=3D SAE_ICPTR_GUEST_AD=
DRESS_SIZE;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D22
