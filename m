Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE9C3B0AFB;
	Fri, 31 Jul 2026 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507439; cv=none; b=ppm8rJJrYQQ+5Su/31+R2B0/KfBBrMUEpAf/PMPY7ojWAJKBjK7dOPW4zP5Ym2qUW30Ji9JmPPcdRuqUYCrr/1/yLRCf+cgr2j5cteqpXo2jI8psxbUKNtHGR8qmp0K15rEjkD8B7BVQLz/wFf7cgAjfVnUS+ZUUm16oXnUyuD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507439; c=relaxed/simple;
	bh=NXosDiEwIiStMmREomZN8QYxK8d2k0Byt4m1WwGgTnM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J570Ja5+6btqF/Wq6VhtOqQjZhRUBV7kfquOiQ4LVXep9ejcjYS7DDE8ahqiLUC9BpboEfwuBioFxH/nnW1MSt0M9juIeUHwpANaEhmn3rkmIDWKDlVdDCddin9HzzCXGjos+OWJb046boqYfbJsrM4qbAchczOhyzjdgYInV+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb9UhInH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb9UhInH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDAA1F000E9;
	Fri, 31 Jul 2026 14:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785507438;
	bh=UGWqA2KyxE0abtM9ecfEHiDwd1jp5LH2FTvddBFITII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zb9UhInHhEi2oeFpeas+2L9jky0Gwi0Cm8v0JunU6Yz/ctpmw7FTku1/MMcsP97yn
	 34EXMt32493xdt7YT67H6wCz/1YzBbYzAyI2xuvNvdsshfhoPTDkKAhc42fPrzzETa
	 nkQv8OMFr2tOFb1eiLd4PceyOposAbHtHmzcKpmiNGhbbyr604oQO2c3TILXsB1Wlw
	 sR/EArrOBwSc+ZmPknztO3eBC+NxBO+HoSjnzbgzbzHPR/xt04by2j449w4PX+BXHl
	 3Bp6DcYDyK6vqCgtj8S2aaYwq70LC/0UkoIISoz7klIWEjm1p1jMciAvFQEjqRigmM
	 IT9XrVEg0wtOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 30/31] KVM: s390: arm64: Implement basic page fault
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org
In-Reply-To: <20260731130902.654679-31-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-31-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 14:17:16 +0000
Message-Id: <20260731141716.DDDAA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The check for `PGM_PROTECTION` in `kvm_s390_cur_gmap_fault_is_writ=
e()` does not apply `PGM_INT_CODE_MASK` to `hai.pic`.
- [Low] The local variable `esr` is assigned but never used.
--

--- Patch [30]: [PATCH v5 30/31] KVM: s390: arm64: Implement basic page fau=
lt handler ---
commit 4547e2330db1908b3d5e4eeca0c723949d349711
Author: Steffen Eiden <seiden@linux.ibm.com>

    KVM: s390: arm64: Implement basic page fault handler
   =20
    Add host functionality to page in guest memory. If the guest does
    something unexpected or illegal exit to userspace abort guest execution.

> diff --git a/arch/s390/kvm/arm64/mmu.c b/arch/s390/kvm/arm64/mmu.c
> new file mode 100644
> index 0000000000000..71cd582f24ff8
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/mmu.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/kvm_host.h>
> +
> +#include <arm64/kvm_emulate.h>
> +
> +#include <faultin.h>
> +
> +static inline bool kvm_s390_cur_gmap_fault_is_write(struct kvm_vcpu *vcp=
u)
> +{
> +	return vcpu->arch.sae_block.hai.pic =3D=3D PGM_PROTECTION ||
> +	       vcpu->arch.sae_block.hai.teid.fsi =3D=3D TEID_FSI_STORE;
> +}

[Severity: High]
Does this code handle concurrent event flags correctly?=20

If a protection fault occurs with concurrent event flags set (e.g., the PER=
 bit
0x80) in the Program Interruption Code, hai.pic will contain a value like
0x84.=20

Since this compares hai.pic directly to PGM_PROTECTION (0x04) without
applying PGM_INT_CODE_MASK, won't this result in a false evaluation?

If it fails to recognize it as a write fault, user_mem_abort() would call
kvm_s390_faultin_gfn() with f.write_attempt =3D 0, causing the host to map =
the
page read-only instead of making it writable. When the guest resumes, it co=
uld
immediately trap again with the same protection fault, leading to an infini=
te
page fault loop.

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
This isn't a bug, but is esr used anywhere else in this function?

It appears this local variable is assigned but never used, which could lead=
 to a
-Wunused-but-set-variable compiler warning.

> +	fault_ipa =3D kvm_vcpu_get_fault_ipa(vcpu);
> +	is_iabt =3D kvm_vcpu_trap_is_iabt(vcpu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D30
