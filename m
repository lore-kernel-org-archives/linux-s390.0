Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA18538837C;
	Wed, 12 Aug 2026 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551004; cv=none; b=UxPdsTyL6xxt7OGvOky+9M49eKYEpqVpJZcmW42jfsULHXc+194L3jTrLltIjj4KWplLvcH0njTHQ8rUz9CK6Yg1GoUwF8N93jdRVYK0yBEhglOF36E/6R/Swo3dl1N0xY2d2YA2BU+RYP7GG5HZXoXOPufssXgt833AwiVoPbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551004; c=relaxed/simple;
	bh=5oYGFMaCGzIeB6J5P/qrATKMiF1+0/73EC3cANIQglY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dDk32kud5XCl00qbAiKUJSZFQwTnVnhyrm9VaDLOURo5zXWiMUhmX355p6G7fQo1F1874SPcJwxbX0UIzHRESJs6r5NYzDjit9kR/9Qj5fY5RN5UTbGooMSux9/mXTvjx0nCqmWazzUC15aVLECs6y8lS27zc7CEhRutSjGiltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQpZ6Mu3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQpZ6Mu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332CB1F000E9;
	Wed, 12 Aug 2026 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786551002;
	bh=Mh89i++HhrW4nzRydisHuVtLh59VDct8vxa0bOM5T98=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gQpZ6Mu3Dmt04v4gWTWDNgRBpM5x+5d3msTe3o2zd9l9uec6+kylKdPXHh32QnIA8
	 gS03s28l1zAHzXdgFdHMYAJfOXCulfSHmnWENkjbYsJiWLuS10u1Qcr3Zj0l4T+Qph
	 R+xZ1eMMsiZJAwJ24SC3/N1OzXlr//xbwxbSDgVCj+Egtlcy75oR8anHcAHKXQscMt
	 jE7QY++7egR3t2iGXJjrQR2q3HaRgiZ5dlX3fbP4ZRZ2FSlzPPPdFH++2Wv22NiJax
	 fsMWoKAZBA6Cw4tNXrxpzkJo7ctXyATe3J59diIyYNGIvoIGmE/T7NchoDIr2+U5jz
	 hNBquF3ayw2xQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/20] KVM: s390: vsie: Shadow VSIE SCA in guest-1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260812-vsie-sigpi-v4-14-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-14-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:10:01 +0000
Message-Id: <20260812161002.332CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] Reusing a `vsie_sca` unconditionally zeroes and unpins `vsie_p=
age` structures that may be actively executing in hardware via a concurrent=
 non-SCA VSIE run.
- [Critical] Reusing a `vsie_page` for a different SCB without resetting th=
e shadow control block leads to cross-VM state leakage.
- [Critical] Unvalidated guest-controlled `icpua` field leads to out-of-bou=
nds array indexing, enabling massive out-of-bounds host memory accesses.
- [High] VSIE error paths improperly convert guest-level validity intercept=
s and addressing exceptions into fatal host-level negative errors, allowing=
 a nested guest to abort the host VM.
- [High] The shadow SCA is never linked to the shadow SIE control block, co=
mpletely breaking the VSIE-Interpretation-Extension feature.
- [High] A Time-Of-Check to Time-Of-Use (TOCTOU) vulnerability exists when =
iterating over the guest-modifiable `mcn` mask, allowing malicious guests t=
o evade error cleanup and leave dangling host pointers in the shadow SCA.
- [High] An unbounded memory leak of XArray nodes occurs because stale mapp=
ings are never erased from `addr_to_page`.
- [High] Failing to pin a reused `vsie_sca` leaves a dangling `sca_gpa` tha=
t causes erroneous XArray erasure upon the next reuse attempt, corrupting t=
he SCA lookup cache.
- [Medium] Overwriting `vsie_page_old->scb_gpa` with `ULONG_MAX` causes KVM=
 to pass a bogus GPA to `mark_page_dirty()`, silently losing dirty tracking=
 for the guest SCB.
- [Medium] `shadow_sca()` fails to detect guest modifications to the SCA CP=
U mask (`mcn`) after the first shadow, breaking dynamic CPU hotplug in the =
nested guest.
--

--- Patch [14]: [PATCH v4 14/20] KVM: s390: vsie: Shadow VSIE SCA in guest-=
1 ---
commit 4635296fb400229acd33f3f98111bf5ac95e07d2
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Shadow VSIE SCA in guest-1

Restructure kvm_s390_handle_vsie() to create a guest-1 shadow of the SCA
if guest-2 attempts to enter SIE with an SCA. When active, shadow SCAs and
CPUs are created to allow direct machine monitoring of intervention bits,
reducing VM exits.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index e632311222002..2fd349e52bd6d 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c

[ ... ]

> +static struct vsie_sca *get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s=
390_sie_block *scb_o)
> +{
> +	struct vsie_sca *vsie_sca, *vsie_sca_new =3D NULL;

[ ... ]

> +	if (vsie_sca_new && kvm->arch.vsie.sca_count < max_vsie_sca) {
> +		/* make use of vsie_sca just created */
> +		vsie_sca =3D vsie_sca_new;
> +		vsie_sca_new =3D NULL;
> +
> +		kvm->arch.vsie.scas[kvm->arch.vsie.sca_count] =3D vsie_sca;
> +		kvm->arch.vsie.sca_count++;
> +		atomic_set(&vsie_sca->ref_count, 1);
> +	} else {
> +		/* reuse previously created vsie_sca allocation for different osca */
> +		vsie_sca =3D get_reuseable_vsie_sca(kvm);
> +		/* with nr_vcpus scas one must be reusable */
> +		if (IS_ERR(vsie_sca))
> +			goto out;
> +		WARN_ON_ONCE(atomic_read(&vsie_sca->ref_count) !=3D 1);
> +
> +		xa_erase(&kvm->arch.vsie.osca_to_sca, vsie_sca->sca_gpa >> SCA_ALIGNME=
NT_SHIFT);
> +		for (cpu_nr =3D 0; cpu_nr < KVM_S390_MAX_VSIE_VCPUS; cpu_nr++) {
> +			vsie_page_n =3D vsie_sca->pages[cpu_nr];
> +			if (!vsie_page_n)
> +				continue;
> +
> +			/* unpin but keep the vsie_page for reuse */
> +			unpin_scb(kvm, vsie_page_n);
> +			release_gmap_shadow_safe(kvm, vsie_page_n);
> +			memset(vsie_page_n, 0, sizeof(struct vsie_page));
> +			vsie_page_n->scb_gpa =3D ULONG_MAX;

[Severity: Critical]
Does this unconditionally zero and unpin a vsie_page that might be actively=
=20
executing in hardware via a concurrent non-SCA VSIE run?

If a guest uses the same SCB address in two different virtual CPUs, one vCP=
U=20
might enter VSIE without an SCA and claim the vsie_page without incrementin=
g=20
vsie_sca->ref_count. Could this reuse path then destroy the memory while th=
e=20
first vCPU is actively running it?

> +		}
> +		unpin_sca(kvm, vsie_sca);
> +		clear_vsie_sca(vsie_sca);
> +	}
> +
> +	if (sie_uses_esca(scb_o))
> +		__set_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
> +	vsie_sca->sca_gpa =3D sca_gpa;
> +
> +	/*
> +	 * The pinned original sca will only be unpinned lazily to limit the
> +	 * required amount of pins/unpins on each vsie entry/exit.
> +	 * The unpin is done in the reuse vsie_sca allocation path above and
> +	 * kvm_s390_vsie_destroy().
> +	 */
> +	rc =3D pin_sca(kvm, vsie_sca);
> +	if (rc) {
> +		put_vsie_sca(vsie_sca);
> +		vsie_sca =3D ERR_PTR(rc);
> +		goto out;

[Severity: High]
Does failing to pin a reused vsie_sca leave a dangling sca_gpa that causes =
an=20
erroneous XArray erasure on the next reuse?=20

The sca_gpa retains the failing address when it is released to the pool. Wh=
en=20
get_reuseable_vsie_sca() picks it up again, it appears it will call xa_eras=
e()=20
on the old sca_gpa, potentially deleting a valid entry stored by another=20
thread.

> +	}
> +
> +	WARN_ON_ONCE(xa_store(&kvm->arch.vsie.osca_to_sca,
> +			      vsie_sca->sca_gpa >> SCA_ALIGNMENT_SHIFT, vsie_sca, GFP_KERNEL)=
);
> +
> +out:
> +	up_write(&kvm->arch.vsie.vsie_sca_lock);
> +	if (vsie_sca_new)
> +		free_vsie_sca(kvm, vsie_sca_new);
> +	return vsie_sca;
> +}

[ ... ]

>  static int vsie_page_init(struct kvm_vcpu *vcpu, struct vsie_page *vsie_=
page, unsigned long scb_gpa)
>  {
> +	struct vsie_page *vsie_page_old;
>  	struct kvm *kvm =3D vcpu->kvm;
>  	int rc;
> =20
> -	if (vsie_page->scb_gpa !=3D ULONG_MAX)
> -		xa_erase(&kvm->arch.vsie.addr_to_page, vsie_page->scb_gpa >> SCB_ALIGN=
MENT_SHIFT);

[Severity: High]
Are old scb_gpa mappings permanently leaking in the XArray here?=20

By removing the xa_erase() call, a guest executing VSIE in a tight loop wit=
h=20
varying scb_addrs might force KVM to recycle vsie_pages while continuously=
=20
accumulating stale entries in addr_to_page, eventually exhausting host memo=
ry.

> -
> +	vsie_page->scb_gpa =3D scb_gpa;
> +	rc =3D pin_scb(vcpu, vsie_page);
> +	if (rc) {
> +		vsie_page->scb_gpa =3D ULONG_MAX;
> +		return -ENOMEM;
> +	}

[Severity: High]
Can this return a fatal host-level error for a guest-level addressing=20
exception?=20

If a nested guest enters VSIE with an invalid scb_o address, pin_scb() retu=
rns=20
1. By converting this and returning -ENOMEM here, does this allow a nested=
=20
guest to abort the host VM instead of correctly injecting a program interru=
pt=20
into the guest?

> =20
>  	vsie_page->sca_gpa =3D read_scao(kvm, vsie_page->scb_o);
> -	WARN_ON_ONCE(xa_insert(&kvm->arch.vsie.addr_to_page, scb_gpa >> SCB_ALI=
GNMENT_SHIFT,
> -			       vsie_page, GFP_KERNEL_ACCOUNT));
> +
> +	/*
> +	 * store the vsie_page in addr_to_page
> +	 * mind that g2 may have reused the sca - make sure we do not remove th=
e sca from
> +	 * the new config when reusing the vsie_page_old
> +	 */
> +	vsie_page_old =3D xa_store(&kvm->arch.vsie.addr_to_page, scb_gpa >> SCB=
_ALIGNMENT_SHIFT,
> +				 vsie_page, GFP_KERNEL_ACCOUNT);
> +	if (WARN_ON_ONCE(xa_err(vsie_page_old)))
> +		return 0;
> +	if (vsie_page_old && vsie_page_old !=3D vsie_page)
> +		WRITE_ONCE(vsie_page_old->scb_gpa, ULONG_MAX);

[Severity: Medium]
Does overwriting the old vsie_page's scb_gpa with ULONG_MAX silently lose=20
dirty tracking?=20

When this evicted page is later unpinned via unpin_scb(), it will call=20
mark_page_dirty() using ULONG_MAX instead of the actual guest physical=20
address of the SCB, losing the migration state.

> =20
>  	return 0;
>  }

[ ... ]

> +static struct vsie_page *get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, str=
uct vsie_sca *vsie_sca,
> +					      gpa_t scb_gpa, u16 cpu_nr)
> +{
> +	struct vsie_page *vsie_page, *vsie_page_new =3D NULL;
> +	int rc;
> +
> +	vsie_page =3D vsie_sca->pages[cpu_nr];

[Severity: Critical]
Does this use an unvalidated guest-controlled icpua field directly as an ar=
ray=20
index?=20

Since cpu_nr comes from scb_o->icpua without prior bounds checking against=
=20
KVM_S390_MAX_VSIE_VCPUS in kvm_s390_handle_vsie(), a malicious guest could=
=20
provide an out-of-bounds value (up to 65535), leading to massive out-of-bou=
nds=20
read/write on the kernel heap.

> +	if (!vsie_page) {
> +		vsie_page_new =3D alloc_vsie_page(vcpu->kvm);

[ ... ]

> +	if (vsie_page->scb_gpa !=3D scb_gpa || vsie_page->sca_gpa !=3D vsie_sca=
->sca_gpa) {
> +		scoped_guard(mutex, &vcpu->kvm->arch.vsie.mutex) {
> +			unpin_scb(vcpu->kvm, vsie_page);
> +			rc =3D vsie_page_init(vcpu, vsie_page, scb_gpa);
> +		}
> +		if (WARN_ON_ONCE(rc)) {
> +			put_vsie_page(vsie_page);
> +			return ERR_PTR(rc);
> +		}
> +	}

[Severity: Critical]
When reusing a vsie_page for a different SCB, does this lead to cross-VM st=
ate=20
leakage?=20

By updating the pinning via vsie_page_init() but omitting critical state re=
set=20
steps like memset(&vsie_page->scb_s, 0, ...), release_gmap_shadow_safe(), a=
nd=20
prefix_unmapped(), this might leave old shadow control block state intact a=
nd=20
stale GMAP translations active from a different nested VM.

> +
> +	return vsie_page;
> +}

[ ... ]

> +static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_pag=
e,
> +		       struct vsie_sca *vsie_sca)
> +{
> +	bool is_esca =3D sie_uses_esca(vsie_page->scb_o);
> +	unsigned int cpu_nr, cpu_slots;
> +	struct vsie_page *vsie_page_n;
> +	hpa_t sca_o_entry_hpa;
> +	hva_t sca_o_entry_hva;
> +	unsigned long *mcn;
> +	gpa_t scb_o_gpa;
> +	int rc;
> +
> +	if (is_esca)
> +		mcn =3D phys_to_virt(sca_o_hpa(vsie_sca)) + offsetof(struct esca_block=
, mcn);
> +	else
> +		mcn =3D phys_to_virt(sca_o_hpa(vsie_sca)) + offsetof(struct bsca_block=
, mcn);
> +
> +	/* pin and make shadow for ALL scb in the sca */
> +	cpu_slots =3D is_esca ? KVM_S390_MAX_VSIE_VCPUS : KVM_S390_BSCA_CPU_SLO=
TS;
> +	for_each_set_bit_inv(cpu_nr, mcn, cpu_slots) {
> +		rc =3D get_sca_entry_addr(vcpu->kvm, vsie_sca, cpu_nr, NULL, &sca_o_en=
try_hpa);
> +		if (rc)
> +			goto err;

[ ... ]

> +	vsie_sca->ssca.osca =3D sca_o_hpa(vsie_sca);
> +
> +	return 0;
> +
> +err:
> +	for_each_set_bit_inv(cpu_nr, mcn, cpu_slots) {
> +		vsie_sca->ssca.cpu[cpu_nr].ssda =3D 0;
> +		vsie_sca->ssca.cpu[cpu_nr].ossea =3D 0;
> +	}

[Severity: High]
Is there a TOCTOU race when iterating over the guest-modifiable mcn mask he=
re?=20

Since mcn is read directly from guest memory twice, could a malicious guest=
=20
toggle bits between the initialization loop and this error cleanup loop? By=
=20
unsetting a bit before the error loop, the guest could force KVM to skip=20
clearing the ssda for that CPU, leaving a valid physical pointer to a shado=
w=20
SCB inside the active shadow SCA.

> +	return rc;
> +}
> +
> +/* Shadow or reshadow the SCA on VSIE enter. */
> +static int shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page=
, struct vsie_sca *vsie_sca)
> +{
> +	int rc =3D 0;
> +
> +	guard(rwsem_write)(&vcpu->kvm->arch.vsie.vsie_sca_lock);
> +	if (!vsie_sca->ssca.osca)
> +		rc =3D _shadow_sca(vcpu, vsie_page, vsie_sca);

[Severity: Medium]
Does this fail to detect guest modifications to the SCA CPU mask after the=
=20
first shadow?=20

If the guest dynamically updates the CPU mask (e.g., setting a new bit in m=
cn=20
to bring up a new guest-3 vCPU) and re-enters VSIE, KVM will immediately=20
return without updating the shadow SCA since ssca.osca is already populated=
.=20
Could this break dynamic CPU hotplug for nested guests?

> +
> +	return rc;
> +}
> +
>  int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
>  {

[ ... ]

> =20
> -	rc =3D pin_scb(vcpu, vsie_page);
> -	if (rc)
> -		goto out_put;
>  	rc =3D shadow_scb(vcpu, vsie_page);
>  	if (rc)
> -		goto out_unpin_scb;
> +		goto out_put;

[Severity: High]
Does the shadow SCA need to be linked to the shadow SIE control block durin=
g=20
shadow_scb() setup?=20

If write_scao() is not called for the active VCPU within shadow_scb() (and=
=20
pin_blocks() also skips setting scaol when vsie_page->vsie_sca is present),=
 it=20
appears scb_s->scaol will remain 0, which would break the newly added=20
VSIE-Interpretation-Extension feature.

> +	if (vsie_sca) {
> +		/* pin and shadow the sca including all scb_o in the g3 conf */
> +		rc =3D shadow_sca(vcpu, vsie_page, vsie_sca);
> +		if (rc)
> +			goto out_put;
> +	}
> +
>  	rc =3D pin_blocks(vcpu, vsie_page);
>  	if (rc)
>  		goto out_unshadow;
>  	register_shadow_scb(vcpu, vsie_page);
> +
>  	rc =3D vsie_run(vcpu, vsie_page);
> +
>  	unregister_shadow_scb(vcpu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D14
