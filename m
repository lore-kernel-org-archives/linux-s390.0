Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EADB3BB69D;
	Mon, 31 Aug 2026 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788213169; cv=none; b=dC9lr/3bxd5lNpot3ZGBOKhpYoDgfqVtKvPZu+j8RuxiQQnXjUD1SHOWhfIwc5Ylc6NUwY1jMMHV+ZaVq2bbi7F598ab9H5Sg+fQmn2+EmDDpBgpRN8JFggjvr3lcEY0Cq8EXGZiaVwmEhX/SEzEwLV83uPI4p7T8osBUUhXRjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788213169; c=relaxed/simple;
	bh=5LTK/u0ezZgqzNpOjrOGc00qoHRgfYnpnAECC4/Knzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pPljaWGZTb/0yDCOwlht68rOyQ9ZetgyySi1sC2/N3Fvsb5q1sL8bHBySgkIDqrpbG5MJG+rihbWGW42W3cAm4gB5agFhTtQHJYjosBok8sKGfwIMUtsjn2pHTthmxaxoU1GjdtCUrDQmhNzl2dXpxuYLm9A3zeNWeprs3SnouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHraFTOk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHraFTOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6971F00A3D;
	Mon, 31 Aug 2026 21:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788213162;
	bh=Qveue6JxgjDqlj6M6ET8ikxk/jVLaWAxhns4oXLoxYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GHraFTOkCmHVdZjbR8wmIbDvObsyqb0V/aCx/kmYBG6FjNdd/oCyfQwRkJrsMHEOs
	 l2mI5b9mI9HsUIPjsXj+PWAiIHnqoQVcKnKZklhX09gLDFCAlWuPY/rq6isSFGFPor
	 CwSzpkPDLlohbr1/7iEADwIN/oT7OqzpxsBS4TFsQmZhMkq2qk4J4erK5dnAdqW0qB
	 WK6NqO9aX10B32JoXsNGhkmGnfadN+KaE7dd7YrTNf24PEGOcOWXkkr/xXhBNNCU2W
	 QS7ISe/jWQZcttqbRo4wkCOHNJgUu15/D89u/7YaHCBb8nlQhcCVj8RLDqFkack5OT
	 4HdB7+ESBlAcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/20] KVM: s390: arm64: Finalize page fault handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260831145536.913567-18-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-18-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:52:41 +0000
Message-Id: <20260831215242.5B6971F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Architectural Violation: Injected aborts incorrectly set the ESR_E=
Lx_IL bit conditionally.
--

commit b703e320efef81f7ebb0637eda7231ef63b3ca22
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Finalize page fault handling

This commit finalizes page fault handling by replacing temporary error
returns with proper ARM64 exception injection. Specifically, it routes
PGM_ADDRESSING faults and out-of-bounds IPAs to kvm_inject_size_fault()
and kvm_inject_sea().

> diff --git a/arch/s390/kvm/arm64/mmu.c b/arch/s390/kvm/arm64/mmu.c
> index bf3442d3609b2..b5f1dc3ca0d28 100644
> --- a/arch/s390/kvm/arm64/mmu.c
> +++ b/arch/s390/kvm/arm64/mmu.c
> @@ -30,12 +30,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, gpa_=
t fault_ipa,
>  	ret =3D kvm_s390_faultin_gfn(vcpu, NULL, &f);
>  	if (ret <=3D 0)
>  		return ret;
> -	if (ret =3D=3D PGM_ADDRESSING)
> +	if (ret =3D=3D PGM_ADDRESSING) {
>  		/*
> -		 * Without the relevant sysregs we cannot do anything for now.
> -		 * Go back to userspace with an error. TODO sysreg handling
> +		 * There is no page with the requested address. Inject size fault
> +		 * which is the closest arm match to PGM-addressing
>  		 */
> -		return -ENOEXEC;
> +		kvm_inject_size_fault(vcpu);

[Severity: High]
This is a pre-existing issue, but does routing faults to
kvm_inject_size_fault() expose an architectural violation for 16-bit
instructions?

When a guest user-space process executing a 16-bit instruction triggers a
fault, this patch routes it to the exception injection logic. That logic
currently conditionally sets the IL bit based on instruction length:

arch/s390/kvm/arm64/inject_fault.c:inject_abt64() {
    ...
    if (kvm_vcpu_trap_il_is32bit(vcpu))
        esr |=3D ESR_ELx_IL;
    ...
}

(The same conditional logic is also present in kvm_inject_undefined()).

For an SError, Instruction Abort, or Data Abort with ISV =3D=3D 0, the
architecture mandates that the IL bit must be 1 regardless of the trapping
instruction's length.=20

Could this cause KVM to synthesize an ESR_ELx with IL=3D0 instead of the
required IL=3D1 for 16-bit instructions? If the guest OS exception handler
receives an architecturally invalid syndrome, could it malfunction or lead =
to
a guest kernel panic?

> +		return 1;
> +	}
>  	KVM_BUG_ON(ret, vcpu->kvm);
>  	return -EINVAL;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D17
