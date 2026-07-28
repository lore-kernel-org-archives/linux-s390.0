Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E2628688C;
	Tue, 28 Jul 2026 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259981; cv=none; b=mIE6fdk8/A50tNDakaVkrCL/87nzC5nDQuoUoIsb5QeNB7tKYqp6EeTOcbpbJ/Z6JLZcdiOrZn+6mtFa8cg/I+s/cCXkpvgP82OdMM4RRj4NhhGwbZqAtwwVLDLFzNw6yLiVu6DADEoym9217CbTdfRY7U8hKu67Su5ZZLaF+us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259981; c=relaxed/simple;
	bh=mzMFX+0HSPySRyDAyUgRiUuO3ycC52pX0VfSaltnjm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QcfHFWBzF5pBob0kZuLJ/sG+zFqTzNUb6U8d/R9wJkmFrqGIoQ1Pdsjuk70WRIa5ko4/Y7CWsTlqZbHmg1InlY3RQb2evkc6xFpKs5z4SA8tvXBMB4EHpWcxU3RvjRcXbsMFFxsHR1SrFECat+qdZredAbDAENy5VPXxoNkt4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THZxSXdI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THZxSXdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2814E1F000E9;
	Tue, 28 Jul 2026 17:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785259980;
	bh=5DOXu7+3UlAvldy+wPuUnLgxsnzA6XaWpquWVmFREAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=THZxSXdIADFlLWKoGp/s3wJ6kEbMWlJYpSWiKtXkToXkbz485Hj1MHyVukxzV6cGk
	 Rc5ke7KHAn6X4Tw6Hz0m/wc3AVqJ4p7zBi4PmIvUK7FVuQbtLfa+YQ1+GP+X5pWXv8
	 SSGrVcJ+4qy1jZwKDCyTWfs0crskhwxKTuM+WQNZ38D7VJ4C2aWX7kszLjzotyXbj8
	 Ae0bu2mWFZFnNV59HbaxItvs1XlWTaCda04l86IZ6UiFWY94Tpq9d8cycgJuGpCVMR
	 936XAQYnM18Zic2mz/aSgJ7JWI1LcxnldI0ede7TmyvrcIN9ZutE077Rod0FzbSW/z
	 VhdncOQDX7l1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/13] KVM: s390: Return -EINTR if a signal was
 pending while faulting-in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260728170708.294400-8-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
 <20260728170708.294400-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:32:59 +0000
Message-Id: <20260728173300.2814E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Nested virtualization (vSIE) skips the SIE instruction and corrupt=
s guest state when a signal interrupts the shadow page fault handler.
- [High] Instruction handlers using read_guest/write_guest (e.g., STSI, LPS=
W) silently skip execution if a signal is pending during page fault-in.
--

--- Patch [7]: [PATCH v4 07/13] KVM: s390: Return -EINTR if a signal was pe=
nding while faulting-in ---
commit 1e3636aa03c57bfbcde97da61dcda6802d420d61
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Return -EINTR if a signal was pending while faulting-in

If a signal is pending while trying to fault-in a page, return -EINTR
instead of -EAGAIN. Also fix unpack_one() and handle_mvpg_pei() so
that they can handle -EINTR properly.

> diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
> index fee80047bd94f..4ff4c59709566 100644
> --- a/arch/s390/kvm/faultin.c
> +++ b/arch/s390/kvm/faultin.c
> @@ -92,8 +92,8 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct =
kvm *kvm, struct guest_fa
>  		if (is_noslot_pfn(f->pfn))
>  			return PGM_ADDRESSING;
>  		/* Signal pending: try again. */
> -		if (f->pfn =3D=3D KVM_PFN_ERR_SIGPENDING)
> -			return -EAGAIN;
> +		if (is_sigpending_pfn(f->pfn))
> +			return -EINTR;

[Severity: High]
This is a pre-existing issue, but does propagating this error cause
nested virtualization (vSIE) to skip the SIE instruction when a signal
interrupts the shadow page fault handler?

If a signal is sent to the vCPU thread while handling a nested fault,
gaccess_shadow_fault() calls kvm_s390_get_guest_page(), which returns -EINT=
R.

This error propagates without rewinding the L2 guest PSW via
retry_vsie_icpt() or kvm_s390_rewind_psw():

arch/s390/kvm/vsie.c:vsie_handle_mvpg() {
    ...
    if (rc_dest < 0)
        return rc_dest;
    ...
}

arch/s390/kvm/vsie.c:vsie_run() {
    ...
    if (rc || scb_s->icptcode)
        break;
    ...
}

When userspace resumes KVM_RUN, does execution continue at the advanced PSW,
skipping the SIE instruction and corrupting L2 guest state? Does vSIE need
to be addressed similarly to how handle_mvpg_pei() is fixed in this patch?

>  		/* Check if it's read-only memory; don't try to actually handle that c=
ase. */
>  		if (f->pfn =3D=3D KVM_PFN_ERR_RO_FAULT)
>  			return -EOPNOTSUPP;
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index 1980df61ef304..a40fe2a10cbfe 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
[ ... ]
> @@ -369,27 +369,30 @@ static int handle_mvpg_pei(struct kvm_vcpu *vcpu)
>  	if (rc)
>  		return kvm_s390_inject_prog_cond(vcpu, rc);
> =20
> -	do {
> -		rc =3D kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(srcaddr), fa=
lse);
> -	} while (rc =3D=3D -EAGAIN);
> -	if (rc)
> -		return rc;
> -
> -	/* Ensure that the source is paged-in, no actual access -> no key check=
ing */
> +	/* Ensure that the destination is paged-in, no actual access -> no key =
checking */
>  	rc =3D guest_translate_address_with_key(vcpu, vcpu->run->s.regs.gprs[re=
g1],
>  					      reg1, &dstaddr, GACC_STORE, 0);
>  	if (rc)
>  		return kvm_s390_inject_prog_cond(vcpu, rc);
> =20
> +	/*
> +	 * If an error happens below, the instruction needs to be retried.
> +	 * Positive error codes are impossible; addressing exceptions would
> +	 * have been discovered and reported above.
> +	 */
> +	kvm_s390_retry_instr(vcpu);

[Severity: High]
This isn't a bug introduced by this patch, but while adding the instruction
retry logic here, do other instruction handlers using read_guest() or
write_guest() in arch/s390/kvm/priv.c also need this fix?

If a signal interrupts kvm_s390_faultin_gfn() during an instruction interce=
pt,
the handler receives -EINTR (or -EAGAIN prior to this patch) and returns it
to userspace without calling kvm_s390_retry_instr().

Does this leave the guest's PSW at the instruction following the intercept,
causing the instruction to be skipped when userspace resumes the vCPU?

arch/s390/kvm/priv.c:handle_stsi() {
    ...
    if (rc) {
        rc =3D kvm_s390_inject_prog_cond(vcpu, rc);
        goto out;
    }
    ...
}

arch/s390/kvm/priv.c:kvm_s390_handle_lpsw() {
    ...
    rc =3D read_guest(vcpu, addr, ar, &new_psw, sizeof(new_psw));
    if (rc)
        return kvm_s390_inject_prog_cond(vcpu, rc);
    ...
}

> +
>  	do {
> -		rc =3D kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(dstaddr), tr=
ue);
> +		rc =3D kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(srcaddr), fa=
lse);
>  	} while (rc =3D=3D -EAGAIN);
>  	if (rc)
>  		return rc;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728170708.2944=
00-1-imbrenda@linux.ibm.com?part=3D7
