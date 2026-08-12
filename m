Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13070480942;
	Wed, 12 Aug 2026 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555588; cv=none; b=oi9q6ghd0564CRYsS0GElEp8JnjbAki4wqwKCrc2PW2hJu9ZqklwHH9zBOFCh/9xlMR3+s0OgPNHabpwrl1W+fYybRMZ9EbjEPRGW67ser6zlM6zI6YLbx9u3JZ+vYNXAqamQiVHeMdRdfeG0lElTvX9Tm8hnZgs4NeZGw+RAzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555588; c=relaxed/simple;
	bh=KE2m12XycHZEEhv7qv2JzW2kbZEA+TAz5aPV7pGkyT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KiteIxsQ8942mnglDvxEXuyJlE/0ozkqM5haP+BUfeSBC01KI/joVcHrsB7rRmp2BLpF8V5D4nrEIpf8ckEy85zBE0JqA/kmCj5BuzHE8cHZCwY23lHQ6Ex2qh3kFGzdUOtOAzZzSx1rQy75TI/cBK2hoTriujnPYcVlwirDtTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmuTFOAm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmuTFOAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6331F000E9;
	Wed, 12 Aug 2026 17:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555587;
	bh=Var/ROzAVlg9AZn9u4bE8txMsoGKLKam5l4VhxJIMOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jmuTFOAmtf6r/6Mkfqv61sb6PWxQBFDp1ToQCUADOU80CWOQ5aLsTUZOGwdxEDlJ2
	 zrjevuAq3ShK/09vwfMbcclc4ZpfJC9RsOc8PC/EZShcdiGzVUZtTxTk3A7z1MA4Rw
	 BMlGA8CwKLb7+fNBPjMh5FQF7cmB46em7AScp1YQLjOtV0vNujL0dJ9qe+AmKm86v/
	 Xb4E14j6eL+k3lmqfSs+Qo1PbqZtlix3Qp1Hv6uvhUPTEi+KOf70FsZkzCkNDtsVbd
	 9037Z/Sp4okq+p1JYGRx5dKOhTMoe++rerSWJAe+x9s/D2sw7Hrs3M14Jyck79W3t3
	 nu6aKPlTUATqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 19/20] KVM: s390: vsie: Create minimal scb shadows
 for not running g3 blocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812-vsie-sigpi-v4-19-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-19-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:26:26 +0000
Message-Id: <20260812172626.8C6331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Silent failure / Lost Validity Intercept on SCA Shadowing
- [High] Cross-VM Data Leak / Stale TLB due to missing ihcpu initialization
- [Medium] L2 Guest State Leak due to Uninitialized Shadow SCB

Pre-existing issues:
- [High] Guest State Corruption in unshadow_scb when prepare_cpuflags fails
--

--- Patch [19]: [PATCH v4 19/20] KVM: s390: vsie: Create minimal scb shadow=
s for not running g3 blocks ---
commit 5e715443b75203daf2ad2801d214c07f27b51bf4
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: KVM: s390: vsie: Create minimal scb shadows for not running g3 blo=
cks

Instead of creating a full shadow for vSIE control blocks, this commit crea=
tes
a minimal shadow for SIGP purposes for currently not running guest-3 control
blocks. This reduces the overhead of shadowing the entire guest-3 configura=
tion.
The shadow will be fully recreated later when a vSIE is entered with that S=
CB.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index a1b679b4aa361..3a7c58dddf22d 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -709,6 +708,39 @@ static void unshadow_scb(struct kvm_vcpu *vcpu, stru=
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

[Severity: Medium]
Does this limited clearing leave stale L2 execution state in the shadow SCB?

When get_vsie_page_cpu_nr() recycles a vsie_page, it doesn't clear the shad=
ow
SCB with memset().

If shadow_scb_minimal() only clears these specific fields, could uninitiali=
zed
data from a previous nested guest (such as ipa and ipb) leak back to the L1
hypervisor's memory when unshadow_scb() is called during an intercept?


[Severity: High]
Does this missing initialization also cause a stale TLB issue for the recyc=
led
SCB?

Because get_vsie_page_cpu_nr() fails to set vsie_page->scb_s.ihcpu =3D 0xff=
ffU,
and shadow_scb_minimal() doesn't clear it either, a recycled SCB could reta=
in a
stale ihcpu value.

If the L1 guest provides an scb_o->ihcpu that matches the host CPU, could
hardware skip the TLB flush for the shadow SCB, leading to cross-VM memory
access?

[ ... ]

> @@ -728,17 +760,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct =
vsie_page *vsie_page)
>  	unsigned long new_mso =3D 0;
>  	int rc;
> =20
> -	/* make sure we don't have any leftovers when reusing the scb */
> -	scb_s->icptcode =3D 0;
> -	scb_s->eca =3D 0;
> -	scb_s->ecb =3D 0;
> -	scb_s->ecb2 =3D 0;
> -	scb_s->ecb3 =3D 0;
> -	scb_s->ecd =3D 0;
> -	scb_s->fac =3D 0;
> -	scb_s->fpf =3D 0;
> -
> -	rc =3D prepare_cpuflags(vcpu, vsie_page);
> +	rc =3D shadow_scb_minimal(vcpu, vsie_page);
>  	if (rc)
>  		goto out;

[Severity: High]
This is a pre-existing issue, but does unshadow_scb() corrupt the L2 guest
state if prepare_cpuflags() fails?

In shadow_scb(), prepare_cpuflags() is evaluated (via shadow_scb_minimal)
before the L2 guest state is copied from scb_o to scb_s:

shadow_scb() {
    rc =3D shadow_scb_minimal(vcpu, vsie_page);
    if (rc)
        goto out;
   =20
    // guest state is copied to scb_s here
    ...
out:
    if (rc)
        unshadow_scb(vcpu, vsie_page);
}

If prepare_cpuflags() fails, shadow_scb() jumps to out and calls
unshadow_scb(), which unconditionally overwrites the L2 guest state in scb_o
with the data from scb_s.

Since scb_s hasn't been populated with the guest state yet, does this corru=
pt
the L2 guest's state variables (CPU timer, clock comparator, PSW, etc.) in =
the
L1 memory?

[ ... ]

> @@ -2164,7 +2184,7 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struc=
t vsie_page *vsie_page,
>  				rc =3D PTR_ERR(vsie_page_n);
>  			if (rc)
>  				goto err;
> -			rc =3D shadow_scb(vcpu, vsie_page_n);
> +			rc =3D shadow_scb_minimal(vcpu, vsie_page_n);
>  			vsie_sca_update(vsie_sca, cpu_nr, vsie_page_n, sca_o_entry_hpa);
>  			put_vsie_page(vsie_page_n);
>  			if (rc)

[Severity: High]
Can this error path bypass the validity intercept delivery?

In _shadow_sca(), if shadow_scb_minimal() fails for a secondary vCPU, the
function propagates the error without unshadowing:

_shadow_sca() {
    ...
            rc =3D shadow_scb_minimal(vcpu, vsie_page_n);
            vsie_sca_update(vsie_sca, cpu_nr, vsie_page_n, sca_o_entry_hpa);
            put_vsie_page(vsie_page_n);
            if (rc)
                goto err;
    ...
}

This error is returned to kvm_s390_handle_vsie(), which then jumps to out_p=
ut:

kvm_s390_handle_vsie() {
    ...
        rc =3D shadow_sca(vcpu, vsie_page, vsie_sca);
        if (rc)
            goto out_put;
    ...
out_put:
    put_vsie_page(vsie_page);
    ...
}

Because this bypasses out_unshadow for the primary vCPU, does this silently
drop the ICPT_VALIDITY intercept code, causing the L1 hypervisor's SIE
instruction to appear as if it completed successfully when it actually fail=
ed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D19
