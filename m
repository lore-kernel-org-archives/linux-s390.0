Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E678748550D;
	Thu, 27 Aug 2026 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847360; cv=none; b=VFPa1Ckv+1PkGAH9jqYnbJpdtwUeLhgCIx2qQaYq6xbz3GqrVaVdOUY8fImEAuC6NoefiTQRKkVXDbclPIYpiSbnh6MfzVQ87BcJVm1qf1dVEAkICHBxmxOuMGHqeQmFOowo7aylEWWf9TM7/nNXtedFAv9tbv20nb3e/aPJEdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847360; c=relaxed/simple;
	bh=oSMk2CbIwyjEO7oG4RH4mgoEAMdUgMWWEePdO8Xo85Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bPxKj4NhVkMK1DjWUhuGPfGzJDIwzTs0lunuKHytCrjHmdgqp+dJU+Xu3b6QDz/UZbwSZQIyNngMZ2SclQEIs8D/prKB6Q7HC5wyq/Yk0mbHyQgT8tqF15Pmft5HFitoPiyt/WOO1I/kOhJNP2zwE8qp4D6GagzXOKaB04cOFRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhvxohFu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhvxohFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F27D1F000E9;
	Thu, 27 Aug 2026 16:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787847358;
	bh=jXlxVXfENBvZS248jdmDzMNPcLwj1TUGXPgjaLKqrHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hhvxohFukdoL1waxzvjWrER4PvV/yQHgQq+OK0FKAAXSzoPjxhlIiHpiSon42+6pF
	 71/Yo42aon4+p/GO+RC1ASA69DcAndDAx/r1wZq5y1u6fvj7qqauWg3xCgX9NlgK08
	 KXuDij9/qetSa4ctBSFeDC/2S1MdhhWw6UrMz2+39+dzbZPf2jleDvON/gKU8xM3yy
	 Upg/w9a6BBMal7y4+9QQBiLTYM2Lyq48qbTnCD4wzns2eBLcSvZZwEOu2hZRZQBDxA
	 urWfxXJmrBBGen+QVyG2Q27MBIYt7hL4B+80S+I/cr22mey5wCEGUZwXkzU2EQkSfq
	 6KztQQrjQteqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/21] KVM: s390: vsie: Shadow VSIE SCA in guest-1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260827-vsie-sigpi-v6-16-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-16-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:15:57 +0000
Message-Id: <20260827161558.1F27D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Unhandled ERR_PTR from get_vsie_sca_unused() leads to host ker=
nel panic.
- [Critical] XArray collision due to SCA alignment shift causes shadow SCA =
state mixups.
- [High] KVM permanently caches the SCA address, ignoring L1 guest updates =
when SSCA is not used.
- [Medium] Error path in `get_vsie_sca` leaks memory pins and the `vsie_sca=
` refcount.
--

commit 6a2015f888275e12b50521a0390805284a9592cd
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Shadow VSIE SCA in guest-1

Restructure kvm_s390_handle_vsie() to create a guest-1 shadow of the SCA
if guest-2 attempts to enter SIE with an SCA. If the SCA is used the
vsie_pages are stored in a new vsie_sca struct instead of the arch vsie
struct.

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index 69334d4a32311..16273cf5cbff5 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c

[ ... ]

> @@ -1031,6 +1031,16 @@ static struct vsie_sca *get_vsie_sca_existing(stru=
ct kvm *kvm, gpa_t sca_o_gpa, bool uses_esca)
>  {
>  	struct vsie_sca *vsie_sca =3D xa_load(&kvm->arch.vsie.osca_to_sca,
>  					    sca_o_gpa >> SCA_ALIGNMENT_SHIFT);
> =20
>  	if (!vsie_sca)
>  		return NULL;
>  	if (uses_esca !=3D test_bit(VSIE_SCA_ESCA, &vsie_sca->flags))
>  		return NULL;
>  	WARN_ON_ONCE(atomic_inc_return(&vsie_sca->ref_count) < 1);
>  	return vsie_sca;
>  }

[Severity: Critical]
Does this code allow an XArray collision if multiple SCAs share the same
64-byte block?

If a guest allocates two different SCAs (which is valid since BSCA only
requires 16-byte alignment), they will result in the same XArray index due
to SCA_ALIGNMENT_SHIFT. The returned shadow SCA is not verified to ensure
vsie_sca->sca_gpa =3D=3D sca_o_gpa, which could cause L2 VCPUs to operate o=
n the
wrong SCA context.

[ ... ]

> @@ -1124,6 +1124,10 @@ static int get_vsie_sca(struct kvm_vcpu *vcpu, str=
uct kvm_s390_sie_block *scb_o,
>  	} else {
>  		/* reuse previously created vsie_sca allocation for different osca */
>  		vsie_sca =3D get_vsie_sca_unused(kvm);
>  		/* with nr_vcpus scas one must be reusable */
>  		if (IS_ERR(vsie_sca))
>  			goto out;

[Severity: Critical]
If get_vsie_sca_unused() returns ERR_PTR(-EAGAIN) when the system exhausts
the maximum number of concurrent active shadow SCAs, doesn't this jump to t=
he
out label without setting an error code in rc?

This would leak the ERR_PTR to the caller because rc remains 0.

[ ... ]

> @@ -1164,13 +1164,13 @@ static int get_vsie_sca(struct kvm_vcpu *vcpu, st=
ruct kvm_s390_sie_block *scb_o,
>  	rc =3D xa_insert(&kvm->arch.vsie.osca_to_sca, vsie_sca->sca_gpa >> SCA_=
ALIGNMENT_SHIFT,
>  		       vsie_sca, GFP_KERNEL_ACCOUNT);
>  	if (rc =3D=3D -EBUSY)
>  		rc =3D 1;
> =20
>  out:
>  	up_write(&kvm->arch.vsie.vsie_sca_lock);
>  	if (vsie_sca_new)
>  		free_vsie_sca(kvm, vsie_sca_new);
>  	if (vsie_sca)
>  		*vsie_sca_out =3D vsie_sca;
>  	return rc;
>  }

[Severity: Medium]
If xa_insert() fails (e.g., returning -ENOMEM), this error path returns the
error code but still populates *vsie_sca_out with the valid vsie_sca pointe=
r.

Because the caller kvm_s390_handle_vsie() jumps to out_unpin on error and
skips the out_put_sca label, won't this leak the memory pinned by pin_sca()
and the vsie_sca refcount?

[ ... ]

> @@ -1245,13 +1245,12 @@ static void unpin_blocks(struct kvm_vcpu *vcpu, s=
truct vsie_page *vsie_page)
>  	struct kvm_s390_sie_block *scb_s =3D &vsie_page->scb_s;
>  	hpa_t hpa;
> =20
> -	hpa =3D (u64) scb_s->scaoh << 32 | scb_s->scaol;
> -	if (hpa) {
> -		unpin_guest_page(vcpu->kvm, vsie_page->sca_gpa, hpa);
> -		vsie_page->sca_gpa =3D 0;
> -		write_scao(scb_s, 0);
> -	}
> +	if (!vsie_page->vsie_sca) {
> +		hpa =3D (u64) scb_s->scaoh << 32 | scb_s->scaol;
> +		if (hpa) {
> +			unpin_guest_page(vcpu->kvm, vsie_page->sca_gpa, hpa);
> +			write_scao(scb_s, 0);
> +		}
>  	}

[ ... ]

> @@ -1300,8 +1300,8 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct=
 vsie_page *vsie_page)
>  	gpa_t gpa;
>  	int rc =3D 0;
> =20
> -	gpa =3D read_scao(vcpu->kvm, scb_o);
> -	if (gpa) {
> +	gpa =3D vsie_page->sca_gpa;
> +	if (gpa && !vsie_page->vsie_sca) {
>  		rc =3D validate_scao(vcpu, scb_s, gpa);
>  		if (rc)
>  			goto unpin;
> @@ -1310,7 +1310,6 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct=
 vsie_page *vsie_page)
>  			rc =3D set_validity_icpt(scb_s, 0x0034U);
>  			goto unpin;
>  		}
> -		vsie_page->sca_gpa =3D gpa;
>  		write_scao(scb_s, hpa);
>  	}

[Severity: High]
Does removing vsie_page->sca_gpa =3D 0; break the guest's ability to dynami=
cally
update the SCA?

Because pin_blocks() now uses the one-time cached vsie_page->sca_gpa instead
of evaluating the active L1 guest SCB via read_scao(), KVM might silently
overwrite the scaol field with the old cached physical address when the L1
guest updates the SCB.

[ ... ]

> @@ -2043,15 +2043,18 @@ static int get_vsie_page_cpu_nr(struct kvm_vcpu *=
vcpu, struct vsie_sca *vsie_sca, gpa_t scb_gpa,
>  				u16 cpu_nr, struct vsie_page **vsie_page_out)
>  {
>  	struct vsie_page *vsie_page, *vsie_page_new =3D NULL;
>  	int rc;
> =20
>  	vsie_page =3D vsie_sca->pages[cpu_nr];

[Severity: Critical]
If get_vsie_sca() successfully returned an ERR_PTR (due to the missing rc
update discussed earlier), won't this dereference the unhandled ERR_PTR
and cause a host kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D16
