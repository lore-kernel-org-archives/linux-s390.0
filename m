Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3C05038EA;
	Fri, 18 Sep 2026 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746652; cv=none; b=mY/xq7+Pf0XCIoNVGrSeAbNH4BxGgbbLhwfB1JK0fLixFEVdULPOsXwB+o62WazOl3tti47TT8B0F1zOxTxc3HgJ/nB6inTXHOHe0Xg8D/AGweixHyOLEmwb3DF5XteidAvHjvJNaZWL4JGRt8EiTJd7562LVnxYP6yS5vnQ99s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746652; c=relaxed/simple;
	bh=c0ulTxHGkAoUymxsk6rAHzEebFJZhNNs6FHlItbMSfc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ul+AVhT7Ff9XZEAoTmbHEbvXw6SDSGpRjfxKnxdtQhQqH3gcBMGkY6yZIEvva23/4gFJ0A2RKCfAwHjRirLiMY2ZcOcQVa4MxkMFFj1EqGDWnmOKE9T4Lik7JIA68WbXR7/j7zSmt09QbfV0kAdFuy3qudTg/L6Sy8ftic9d9NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zr6y8qd5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr6y8qd5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C9B1F000FF;
	Fri, 18 Sep 2026 15:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789746650;
	bh=P++khf8ZZmxK6RYPJo0Vkd9e6O/83RWhDxGp1k2CSZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zr6y8qd5pX8gDi2LjEBQS0SURoqAC3yDmKDpDmr0LLiHhKy//Q/xL78uOyMlCxmJI
	 KcC8P41RAM94OWSMGe1hS/9mdoVNN6KqPpzez3fUxtwwbZpvo64MjAxVKsrRQ2eZcY
	 AFqpKujzzyf8HQVTAxwLmputofM2K0UZW3qFpcdgK6QgXwNNDlnPY/odE2/yKQIEva
	 pBxy5/XldKjpxMQwO+PRqfhTKyUSqTddx3weW+/IKoyZrAJLZHd7dy3w3o9VDWbTxE
	 H2yhcrE+47owL5hA9Glf35SeOcynD/dCTQKNzK00HbubC1fFanXBWfLK3IlGio5EJs
	 bJh4WVPog5b4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 20/21] KVM: s390: vsie: Create minimal scb shadows
 for not running g3 blocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-20-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-20-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:50:49 +0000
Message-Id: <20260918155050.11C9B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kvm: s390: vsie: host DoS via unbacked nested SCA address
- [Medium] kvm: s390: vsie: missing hpid and cpnc in minimal shadow SCB bre=
aks SIGPI
--

commit feee29bf065106ccfaff09da7c439bae1d45d3eb
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: KVM: s390: vsie: Create minimal scb shadows for not running g3 blo=
cks

This commit optimizes the shadowing of vSIE control blocks by creating a
minimal shadow for non-running guest-3 blocks instead of a full shadow. The
minimal shadow is designed to only contain information necessary for SIGPI =
and
SRSI, reducing the overhead of shadowing the entire guest-3 configuration.

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index 59037964efc9e..c99cc03ecb81d 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c
[ ... ]
> @@ -722,6 +721,39 @@ static void unshadow_scb(struct kvm_vcpu *vcpu, stru=
ct vsie_page *vsie_page)
>  		scb_o->ihcpu =3D scb_s->ihcpu;
>  }
> =20
> +static int shadow_scb_minimal(struct kvm_vcpu *vcpu, struct vsie_page *v=
sie_page)
> +{
> +	struct kvm_s390_sie_block *scb_s =3D &vsie_page->scb_s;
> +	struct kvm_s390_sie_block *scb_o =3D vsie_page->scb_o;
> +	int rc;
> +
> +	/* make sure we don't have any leftovers when reusing the scb */
> +	scb_s->icptcode =3D 0;
> +	scb_s->eca =3D 0;
> +	scb_s->ecb =3D 0;
> +	scb_s->ecb2 =3D 0;
> +	scb_s->ecb3 =3D 0;
> +	scb_s->ecd =3D 0;
> +	scb_s->fac =3D 0;
> +	scb_s->fpf =3D 0;
> +
> +	rc =3D prepare_cpuflags(vcpu, vsie_page);

[Severity: Medium]
Does this zeroing sequence miss carrying over the HPID and CPNC values?

Unlike the full shadow_scb(), shadow_scb_minimal() does not seem to set
scb_s->hpid =3D HPID_VSIE or copy scb_o->cpnc to scb_s->cpnc. Without the
correct HPID (0x5) initialized in the minimal shadow SCB, will hardware SIGP
Interpretation (SIGPI) fail or incorrectly intercept for non-running guest-3
CPUs?

The hardware SIGPI mechanism requires the sender's HPID to match the target
SCB's HPID.


[Severity: High]
Can an L2 guest setting an unbacked nested SCA address cause a host DoS?

Looking at get_vsie_sca() and kvm_s390_handle_vsie() in
arch/s390/kvm/s390/vsie.c, if a malicious L2 guest sets sca_gpa in its SCB
to an invalid or unbacked guest physical address, pin_sca() fails and
returns -EINVAL:

arch/s390/kvm/s390/vsie.c:get_vsie_sca() {
    ...
	rc =3D pin_sca(kvm, vsie_sca);
	if (rc) {
		put_vsie_sca(vsie_sca);
		vsie_sca->sca_gpa =3D ULONG_MAX;
		goto out;
	}
    ...
}

This unhandled -EINVAL is then propagated unmodified through
get_vsie_sca() and returned by kvm_s390_handle_vsie() out of the instruction
handler, instead of injecting a validity intercept:

arch/s390/kvm/s390/vsie.c:kvm_s390_handle_vsie() {
    ...
out_unpin:
	unpin_guest_page(vcpu->kvm, scb_addr, scb_hpa);

	if (rc =3D=3D -EAGAIN) {
		kvm_s390_rewind_psw(vcpu, 4);
		rc =3D 0;
	}
	return rc < 0 ? rc : 0;
}

Does this bypass the -EAGAIN check and bubble up to the KVM core, crashing
the host userspace process (e.g., QEMU) and bringing down the entire L1 VM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D20
