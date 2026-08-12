Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740E7430CE2;
	Wed, 12 Aug 2026 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532162; cv=none; b=lFsFbNRBBp8prSnVgHzph6PptF3SwqEyAPBfKWiYju/RrA/JsmcCccf8nU9w2LGbkz84tCTsxmFUpPvlUBU2L46wiQiepKt0Qt0MfWWn/sELH91ZMLSYr3yxsiHrXXxbwOzSQCAhoYdAy+ocrkOhfl+OUFaghWYh1f85C/ETbck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532162; c=relaxed/simple;
	bh=UMcvaOg2ldIBnyg5VbO8NBz/+nfxFff5/eMOpeBl2a0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fTGR+4mFrqUDJNNkAFMHtAiqQ18uFEi+NwlMdAa5FCw6tu1H+3JTHH0VXDKIFCOcBuQ8JWptaTuKRL7GS8KsG+4DprHiQO6Dk1KQ2R0S9keU9I4SPanFbkMjyvs8YpnW8mS8OfHGojDQCQm7Z0dtTyW8cc1eni63tr9l76vlg6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PafHXsoM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PafHXsoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D621F000E9;
	Wed, 12 Aug 2026 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786532158;
	bh=PVa2s0n86iLYBSuwYNmnIZl04pTcB3cPAu3zTQu5j/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PafHXsoMK39hmmI/A3515U8aqsYfdXu9Uj9ix4jrHQLhBA1LBhzIfpUvNdGl1M5eg
	 MjgQ7TCknPka76xy8EGx0HaIKmcYD5ooWEGKso8IXRPhDLcZKQKauURy95o8DuFrNG
	 uH/zpyw+Wntu5t60fjwsigmwjipoY+Uhv9nlL/vfda3LZpIG3F9k0oyECdiQrCiH1X
	 RSKsxVRRUiBP3OnmC/fcgLv0XQflAuPmiprbWmtOUG5UvVfQOp00ct1ynQUhcIuLF2
	 EQu7XobzqmgL2g0ItHw1iaoujGIYhUQkLk5cC5Mn1+gZoF5QWcHnRiWY9UPq5kH7IJ
	 hmBatugicnGuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/9] KVM: s390: Fix get_all_floating_irqs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260812104436.109741-4-imbrenda@linux.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
 <20260812104436.109741-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 10:55:57 +0000
Message-Id: <20260812105557.E4D621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential NULL pointer dereference due to a TOCTOU data race on `g=
i->origin`.
--

--- Patch [3]: [PATCH v2 3/9] KVM: s390: Fix get_all_floating_irqs() ---
commit b1b05a4cfd3db133f1eddf2ecf286b6b12e10c50
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix get_all_floating_irqs()

This commit modifies the reporting of floating interrupts to userspace=20
to use a non-destructive test. It ensures that the GISA IPM bits are=20
not inadvertently cleared and lost if the userspace output buffer is=20
too small.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c

[ ... ]

> @@ -2242,7 +2247,7 @@ static int get_all_floating_irqs(struct kvm *kvm, u=
8 __user *usrbuf, u64 len)
>  				ret =3D -ENOMEM;
>  				goto out_nolock;
>  			}
> -			if (gisa_tac_ipm_gisc(gi->origin, i)) {
> +			if (gisa_test_ipm_gisc(gi->origin, i)) {

[Severity: High]
This is a pre-existing issue, but is it possible for gi->origin to be
dereferenced as NULL here?

Looking at get_all_floating_irqs(), gi->origin is accessed multiple times
without lock protection or READ_ONCE(). The pointer is initially checked
earlier in the function:

    if (gi->origin && gisa_get_ipm(gi->origin)) {

and then accessed repeatedly inside the loop for each ISC.

Could the compiler reload the gi->origin pointer from memory between the
initial check and these loop iterations?

If a concurrent KVM_PV_ENABLE ioctl is invoked, it can execute
kvm_s390_pv_init_vm() -> kvm_s390_cpus_to_pv() -> kvm_s390_gisa_disable() ->
kvm_s390_gisa_destroy(), which sets gi->origin =3D NULL.

Since the KVM_DEV_FLIC_GET_ALL_IRQS ioctl does not hold kvm->lock, could
this concurrent clearing lead to a NULL pointer dereference if the compiler
reloads gi->origin inside the loop?

>  				irq =3D (struct kvm_s390_irq *) &buf[n];
>  				irq->type =3D KVM_S390_INT_IO(1, 0, 0, 0);
>  				irq->u.io.io_int_word =3D isc_to_int_word(i);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812104436.1097=
41-1-imbrenda@linux.ibm.com?part=3D3
