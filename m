Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363B3BB119;
	Fri, 18 Sep 2026 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746112; cv=none; b=oNTrbMd9lkGjB4kHkQLY+prMvbSlp/UiEqNair5+JotlgHt9Ps46xq1tmis5v5ej+ezAkBUJuBwMdiAO/dpVdywzmpOX0LHQo+zm45WAZnoOW5NAKZTd5v//aZ0Mjz3uko7JOTm8eiFUcUXLmEOUGWSe3Y66Iy6ftGfNeyEy8p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746112; c=relaxed/simple;
	bh=EFMtgUmA7lz9ymFtDJhBo0ROnmjD9/VGvksyE3VF/g8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DrtqTKRJqzH3kJrK8K6qNkguiJAAUN4bz9kS6ieNZ8ZgilymVyoWGJjIeFNHdt780unFMcvnB+ZD7y3K9aV4xXl4GU4b5d9531D6BPdcrWjbptMHVqZ/XsCna0NlVSucHFQnNisYzsXgdk44MEjzvRqTroM9dXv8DJp0ceWIrUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmGjCEwv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmGjCEwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8001F000FF;
	Fri, 18 Sep 2026 15:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789746110;
	bh=lFutK2R7zDxmQCmG0Bw0QFRGPDmALDdo45llFVFMrz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bmGjCEwv3qBqsIHZ5A/0lxUk/TzeFNIldD1ioN6PZhPedv82F4zQLHIu3x+uPSphb
	 oS8tKwUkAYXw7EODRVl4OTCrmBGybPiClGY6VulaSGP2SH64Nj0Zxb2SZM7gJRmlf8
	 W0YGHC5nWXPZepkXQey5o8X4EXNnVWfFXg0rTfnN8fX5uJykkh21qzi1LDcqSakIVn
	 r1x9CMHQ5LMY2MHiMywMmqpzyzjj1rYJU9GZJ1Bp+/Ud8T3fKoEK9Tya5+FV+rYZcE
	 oDNdKqG+VLtDGrBDIcMTvcaVQBbDlZ6bg5+w5ibH+RVjCrgsf06ULwc+Q3XfHFCJb1
	 9y0UrzNIDVeEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 16/21] KVM: s390: vsie: Shadow VSIE SCA in guest-1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-16-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-16-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:41:49 +0000
Message-Id: <20260918154150.1E8001F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] kvm: s390: vsie: eager shadowing of sibling CPUs injects spurious =
validity intercepts into executing vCPU
- [High] kvm: s390: vsie: hardware-delivered SIGP interrupts lost due to sc=
b_s cpuflags overwrite
- [Medium] kvm: s390: vsie: xa_erase during vsie_sca format mismatch leads =
to osca_to_sca cache corruption on recycle
- [Low] kvm: s390: vsie: missing READ_ONCE() in double-checked locking for =
vsie_page allocation
--

commit bc7cd9198517c5c02b2b44870fd9b7fe1176a09f
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Shadow VSIE SCA in guest-1

This commit restructures kvm_s390_handle_vsie() to create a guest-1 shadow =
of
the SCA if guest-2 attempts to enter SIE with an SCA. This enables the mach=
ine
to directly monitor intervention bits and handle SIGP instructions without
exiting VSIE.

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index c67623a0185ef..ce053905a9d8e 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c
> @@ -958,6 +1049,142 @@ static struct vsie_sca *alloc_vsie_sca(void)
[ ... ]
> +static int get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s390_sie_block=
 *scb_o,
> +		struct vsie_sca **vsie_sca_out)
> +{
[ ... ]
> +	down_write(&kvm->arch.vsie.vsie_sca_lock);
> +	vsie_sca =3D xa_load(&kvm->arch.vsie.osca_to_sca, sca_gpa >> SCA_ALIGNM=
ENT_SHIFT);
> +	if (vsie_sca) {
> +		WARN_ON_ONCE(atomic_inc_return(&vsie_sca->ref_count) < 1);
> +		if (is_esca =3D=3D test_bit(VSIE_SCA_ESCA, &vsie_sca->flags))
> +			goto out;
> +		/* found vsie_sca with matching sca_gpa but wrong format */
> +		put_vsie_sca(vsie_sca);
> +		xa_erase(&kvm->arch.vsie.osca_to_sca, sca_gpa >> SCA_ALIGNMENT_SHIFT);
> +	}

[Severity: Medium]
When erasing the mismatched vsie_sca from osca_to_sca, does vsie_sca->sca_g=
pa
also need to be cleared?

> +
> +	/* check again under write lock if we are still under our vsie_sca limi=
t */
> +	if (vsie_sca_new && kvm->arch.vsie.sca_count < max_vsie_sca) {
[ ... ]
> +	} else {
> +		/* reuse previously created vsie_sca allocation for different osca */
> +		vsie_sca =3D get_vsie_sca_unused(kvm);
> +		/* with nr_vcpus scas one must be reusable */
> +		if (IS_ERR(vsie_sca)) {
> +			rc =3D PTR_ERR(vsie_sca);
> +			goto out;
> +		}
> +
> +		/* unused vsie_sca exclusive under vsie_sca_lock write lock */
> +		xa_erase(&kvm->arch.vsie.osca_to_sca, vsie_sca->sca_gpa >> SCA_ALIGNME=
NT_SHIFT);

[Severity: Medium]
If a mismatched vsie_sca was erased above without clearing its sca_gpa, and
is later recycled here by get_vsie_sca_unused(), will this xa_erase() blind=
ly
erase the newly inserted, active vsie_sca from the xarray using the stale
sca_gpa index?

> +		for (cpu_nr =3D 0; cpu_nr < KVM_S390_MAX_VSIE_VCPUS; cpu_nr++) {
[ ... ]
> +static int get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie_sca *=
vsie_sca, gpa_t scb_gpa,
> +				u16 cpu_nr, struct vsie_page **vsie_page_out)
> +{
> +	struct vsie_page *vsie_page, *vsie_page_new =3D NULL;
> +	int rc;
> +
> +	vsie_page =3D vsie_sca->pages[cpu_nr];

[Severity: Low]
Since this initiates a double-checked locking pattern, should this initial
lockless read be protected by READ_ONCE() to prevent the compiler from
reloading or tearing the pointer read?

> +	if (!vsie_page) {
> +		vsie_page_new =3D alloc_vsie_page(vcpu->kvm);
[ ... ]
> +static int _shadow_sca_cpu(struct kvm_vcpu *vcpu, struct vsie_page *vsie=
_page,
> +			   struct vsie_sca *vsie_sca, hpa_t sca_o_entry_hpa,
> +			   unsigned int cpu_nr, bool is_esca)
> +{
> +	hva_t sca_o_entry_hva =3D (hva_t)phys_to_virt(sca_o_entry_hpa);
> +	struct vsie_page *vsie_page_n;
> +	gpa_t scb_o_gpa;
> +	int rc;
> +
> +	if (is_esca)
> +		scb_o_gpa =3D ((struct esca_entry *)sca_o_entry_hva)->sda;
> +	else
> +		scb_o_gpa =3D ((struct bsca_entry *)sca_o_entry_hva)->sda;
> +	if (scb_o_gpa & 0x1ffUL)
> +		return set_validity_icpt(vsie_page->scb_o, 0x0001U);

[Severity: High]
If a sibling CPU's SCB address is unaligned, does this improperly inject a
validity intercept into the currently executing primary vCPU's original SCB
(vsie_page->scb_o)?

Since the guest architecture permits configuring an SCA where idle CPUs mig=
ht
have uninitialized or invalid SCBs until they actually execute SIE, could t=
his
cause a localized configuration issue in an idle CPU to crash a valid, runn=
ing
sibling CPU?

> +
> +	rc =3D get_vsie_page_cpu_nr(vcpu, vsie_sca, scb_o_gpa, cpu_nr, &vsie_pa=
ge_n);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D shadow_scb(vcpu, vsie_page_n);
> +	update_vsie_sca(vsie_sca, cpu_nr, vsie_page_n, sca_o_entry_hpa);
> +	if (rc) {
> +		/* copy intercept to primary scb_o, no unshadow_scb() on exit */
> +		unshadow_intercept(vsie_page->scb_o, &vsie_page_n->scb_s);
> +		rc =3D 1;
> +	}

[Severity: High]
Similarly, if shadowing a sibling CPU's SCB fails, does this incorrectly co=
py
the validity intercept onto the primary executing vCPU, aborting it instead=
 of
the sibling?

> +	put_vsie_page(vsie_page_n);
> +
> +	return rc;
> +}
[ ... ]
> @@ -1828,12 +2052,165 @@ static int get_vsie_page(struct kvm_vcpu *vcpu, =
unsigned long addr,
[ ... ]
>  int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
>  {
[ ... ]
> -	rc =3D pin_scb(vcpu, vsie_page);
> -	if (rc)
> -		goto out_put;
>  	rc =3D shadow_scb(vcpu, vsie_page);
>  	if (rc)
>  		goto out_put;
> +	if (vsie_sca) {
> +		/* pin and shadow the sca including all scb_o in the g3 conf */
> +		rc =3D shadow_sca(vcpu, vsie_page, vsie_sca);
> +		if (rc)
> +			goto out_put;
> +	}

[Severity: High]
With the introduction of the shadow SCA, hardware-delivered SIGP interrupts
(like EXTERNAL CALL) can now be delivered directly to a target vCPU by sett=
ing
bits in its shadow SCB (vsie_page->scb_s.cpuflags).

If the target vCPU is not running in SIE when this happens, the interrupt
remains pending in the shadow SCB. When that vCPU later enters SIE,
kvm_s390_handle_vsie() calls shadow_scb().

Inside shadow_scb(), prepare_cpuflags() and update_intervention_requests()
read the original guest SCB state (scb_o->cpuflags) and completely overwrite
the shadow state (scb_s.cpuflags):

int newflags, cpuflags =3D atomic_read(&vsie_page->scb_o->cpuflags);
atomic_set(&scb_s->cpuflags, newflags);

Because KVM does not harvest or sync these hardware-delivered bits from
scb_s.cpuflags back to scb_o->cpuflags on VSIE exit, does this inadvertently
wipe out the pending interrupts and cause the guest vCPU to hang indefinite=
ly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D16
