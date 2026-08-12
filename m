Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7765F471D0D;
	Wed, 12 Aug 2026 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548505; cv=none; b=HgOLWBWyprIh+s4HdTZt6KdQqIKbqpxLpLuHUkcgQlRtDvLBxGzK8MRnWJozgqZGWBBepfVhTXEfBQ61XzNRE2eDboFwmzdxQH1ospZkvw7KsBwc8XNTPnN9HYF/scyWgur7uPu/GUXQATQSsoa7N/9S6vOi3J6BrVBU6vRfHqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548505; c=relaxed/simple;
	bh=gRfOKRawTwQ0pOvxz82yPARS8ikKI9lrzjiHBdqwcwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AbCkiO+8ww/D2TxynlehxD5nRYhEqEL1eKkAStZeekWKiWrn8YHcEiz0x9Ojy2soC6ag9L2k8X3Mc4s+WBhWZleeaAcqhP1Xm/iHb6vqPL1gpUBfx89wdJt+dDgLFiNYZj/ZcdFtGA7iEfoKPO9kwKyoOrAN+qEKRmPBjuJk/BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YizzQdPy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YizzQdPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F392A1F000E9;
	Wed, 12 Aug 2026 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786548490;
	bh=zb7h1RJizXPQ212/6UlaktQkbrep/qEQKPjhc1YvRqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YizzQdPyf/Qtp43RCNq4RH113bUYeAvGSFmJNAL/pkip5RliD2rLFNNFWFIxSyAjj
	 zwEK8sZjiQJnk+K7Fv857tCrzR4tsfcyVhZ8trAh5eZe9gFehpPt6Djit04Gup4OZU
	 4RDYnC/gzl5sTgarghgTBrnW5nSHO/IUrIyR2Vv3frFKvfNZBOJW8McTL6J1lo7H69
	 Wh6X92PeK8nrk7YUBt2F13ULcC6eimI9hFjuw5hBWLWo/xxKt2zeAV2UBJ4wvVyejf
	 Wt4yxhC8fgk2WETdJNU0xTc8VCixT9efzRN42eG60gqCD0jYutRFDyaK1R1KNeouJ5
	 /4Izk1xV/xIzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/20] KVM: s390: vsie: Lazily keep original scb
 pinned after vsie exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260812-vsie-sigpi-v4-11-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-11-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:28:09 +0000
Message-Id: <20260812152809.F392A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Ignored `xa_insert` errors in `vsie_page_init` break architectural=
 double-use protection, cause XArray corruption, and expose a guest-trigger=
able host `WARN_ON_ONCE`.
- [High] Guest-triggerable `PGM_ADDRESSING` exceptions are incorrectly tran=
slated into a host `-ENOMEM` error, aborting the VM.
- [Medium] The intended lazy pinning optimization is completely defeated be=
cause the SCB is unconditionally unpinned at the end of every VSIE executio=
n.
- [Medium] Non-atomic bitwise operations on `vsie_page->flags` violate docu=
mented atomic requirements and create data races.
- [Low] `SCB_ALIGNMENT_SHIFT` is not defined anywhere in the codebase, caus=
ing a build failure.
--

--- Patch [11]: [PATCH v4 11/20] KVM: s390: vsie: Lazily keep original scb =
pinned after vsie exit ---
commit 987277adb095f19cd7aeacd230e5c42d67de0027
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: KVM: s390: vsie: Lazily keep original scb pinned after vsie exit

This patch updates the nested virtualization code to cache the pinned
original SCB for a vsie_page. It introduces pinning state flags and delays
unpinning until the vsie_page is reused or the VM is destroyed.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index d2582519b3ecc..490c29b369cd0 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
[ ... ]
> @@ -760,14 +761,18 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct=
 vsie_page *vsie_page)
>  }
> =20
>  /* unpin the scb provided by guest 2, marking it as dirty */
> -static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
> -		      gpa_t gpa)
> +static void unpin_scb(struct kvm *kvm, struct vsie_page *vsie_page)
>  {
> -	hpa_t hpa =3D virt_to_phys(vsie_page->scb_o);
> +	hpa_t hpa;
> +
> +	if (!test_bit(VSIE_PAGE_SCB_PINNED, &vsie_page->flags))
> +		return;
> =20
> +	hpa =3D virt_to_phys(vsie_page->scb_o);
>  	if (hpa)
> -		unpin_guest_page(vcpu->kvm, gpa, hpa);
>  	vsie_page->scb_o =3D NULL;
> +	__clear_bit(VSIE_PAGE_SCB_PINNED, &vsie_page->flags);
>  }

[Severity: Medium]
Does this introduce a data race on the flags field?=20

The vsie_page struct documentation states that flags must be modified
atomically. Since other threads might concurrently update the
VSIE_PAGE_IN_USE bit using atomic operations like test_and_set_bit() in
try_get_vsie_page(), using the non-atomic __clear_bit() here could
overwrite those concurrent changes.

>  /*
> @@ -776,19 +781,22 @@ static void unpin_scb(struct kvm_vcpu *vcpu, struct=
 vsie_page *vsie_page,
>   * Returns: - 0 if the scb was pinned.
>   *          - > 0 if control has to be given to guest 2
>   */
> -static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
> -		   gpa_t gpa)
> +static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  {
>  	hpa_t hpa;
>  	int rc;
> =20
> -	rc =3D pin_guest_page(vcpu->kvm, gpa, &hpa);
> +	if (test_bit(VSIE_PAGE_SCB_PINNED, &vsie_page->flags))
> +		return 0;
> +
> +	rc =3D pin_guest_page(vcpu->kvm, vsie_page->scb_gpa, &hpa);
>  	if (rc) {
>  		rc =3D kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
>  		WARN_ON_ONCE(rc);
>  		return 1;
>  	}
>  	vsie_page->scb_o =3D phys_to_virt(hpa);
> +	__set_bit(VSIE_PAGE_SCB_PINNED, &vsie_page->flags);
>  	return 0;
>  }

[Severity: Medium]
Similar to the unpin_scb() function above, should this be an atomic
set_bit() to avoid racing with concurrent access to vsie_page->flags?

[ ... ]
> @@ -1529,17 +1537,45 @@ static struct vsie_page *alloc_vsie_page(struct k=
vm *kvm)
>  	return vsie_page;
>  }
> =20
> +static int vsie_page_init(struct kvm_vcpu *vcpu, struct vsie_page *vsie_=
page, unsigned long scb_gpa)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	int rc;
> +
> +	if (vsie_page->scb_gpa !=3D ULONG_MAX)
> +		xa_erase(&kvm->arch.vsie.addr_to_page, vsie_page->scb_gpa >> SCB_ALIGN=
MENT_SHIFT);

[Severity: Low]
Is SCB_ALIGNMENT_SHIFT defined in this tree?=20

It doesn't appear to be defined anywhere in the codebase, which would
cause a build failure here and in the xa_insert() and xa_load() calls
below.

> +	vsie_page->scb_gpa =3D scb_gpa;
> +	rc =3D pin_scb(vcpu, vsie_page);
> +	if (rc) {
> +		vsie_page->scb_gpa =3D ULONG_MAX;
> +		return -ENOMEM;
> +	}

[Severity: High]
When pin_scb() fails due to an invalid guest physical address, it
successfully queues a PGM_ADDRESSING exception for the guest and returns
1.=20

By returning -ENOMEM here, are we incorrectly escalating a guest-level
addressing fault into a host-level memory allocation failure? This will
propagate up to the run loop and abort the VM instead of just delivering
the exception to the guest.

> +
> +	vsie_page->sca_gpa =3D read_scao(kvm, vsie_page->scb_o);
> +	WARN_ON_ONCE(xa_insert(&kvm->arch.vsie.addr_to_page, scb_gpa >> SCB_ALI=
GNMENT_SHIFT,
> +			       vsie_page, GFP_KERNEL_ACCOUNT));

[Severity: High]
Could ignoring the error from xa_insert() here bypass the architectural
double-use protection?=20

If two nested vCPUs concurrently execute the SIE instruction with the same
guest SCB address, the second one will fail to insert. By wrapping this in
WARN_ON_ONCE and ignoring the failure, the guest can intentionally trigger
a host warning.=20

Furthermore, the second vCPU proceeds with the duplicate vsie_page, and
when it is later reused, the xa_erase() at the top of vsie_page_init()
will erase the valid XArray entry belonging to the first vCPU.

> +
> +	return 0;
> +}
[ ... ]
> @@ -1552,53 +1588,69 @@ static struct vsie_page *get_vsie_page(struct kvm=
 *kvm, unsigned long addr)
[ ... ]
> +	rc =3D vsie_page_init(vcpu, vsie_page, addr);
> +	mutex_unlock(&kvm->arch.vsie.mutex);
> +	if (vsie_page_new)
> +		free_vsie_page(vsie_page_new);
> +	if (WARN_ON_ONCE(rc)) {
> +		unpin_scb(kvm, vsie_page);
> +		vsie_page->scb_gpa =3D ULONG_MAX;
>  		put_vsie_page(vsie_page);
> -		mutex_unlock(&kvm->arch.vsie.mutex);
> -		return NULL;
> +		return ERR_PTR(rc);
>  	}

[Severity: High]
Following up on the vsie_page_init() return value, this WARN_ON_ONCE will
be triggered if the guest provided an invalid SCB address. Does this
result in a guest triggerable host warning before returning the -ENOMEM
error?

[ ... ]
> @@ -1626,7 +1678,7 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
[ ... ]
>  out_unshadow:
>  	unshadow_scb(vcpu, vsie_page);
>  out_unpin_scb:
> -	unpin_scb(vcpu, vsie_page, scb_addr);
> +	unpin_scb(vcpu->kvm, vsie_page);
>  out_put:
>  	put_vsie_page(vsie_page);

[Severity: Medium]
Will this unconditional call to unpin_scb() at the end of every nested SIE
execution defeat the lazy pinning optimization?=20

Since every normal exit flows through out_unpin_scb, the
VSIE_PAGE_SCB_PINNED flag is cleared and the SCB is unpinned immediately,
bypassing the intended cache behavior.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D11
