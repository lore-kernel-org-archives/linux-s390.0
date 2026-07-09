Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CC23839B8;
	Thu,  9 Jul 2026 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611461; cv=none; b=uB2PQZlmVV4zeEYN32TQvuMESQNxT5nCLpwiyf6bMBEu59KI0u/7usnN5zbn0b21gR2ZL52APiNDeej42droWo9tNYX9sDrM9L9kNrBGXbNfp+j6M+kCkstjj9O2x63MKjuD1zoBDeTnyWB9CU/K7as8LKQN8oDtAEARqV+sS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611461; c=relaxed/simple;
	bh=NayHod9PkByFav7e69dVzaqh8u3XitxWDOeOd+0iK2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tJSsW329ObSd8b6IkbC/yNG2n3bBSGRGVBAb8X1tSbQ6AdfMmigpICx38xWoiksf0j4kInJ4fsco/CrfbYS4lpbpwfoEzVV0+za5oM58poDbbX5nn/CvvEojIc2JJxAikC0xyt9ZcwCnOtP68AdGRbhleU1vKQbGrN3hp/YzAXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxH2j4VV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxH2j4VV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFF01F000E9;
	Thu,  9 Jul 2026 15:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611457;
	bh=D7OV3mmckUzPuP0MBi70y320z16VZK5UiH+ZY2Fh7rk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jxH2j4VV9G0qfkp5c9Uaj8FEiZ1hF74CPUhNvIGJXl9cxPjofmz/8qY5MbhhmP70n
	 imbeYESeuCNmZ2AMpp6OkHBKTQ4V9EksVc6Gkzd0ufinveNv9db0MBJykNxRag9IQY
	 mksPoSfkVLOXEruu/0c1dMdGHgx6EgId1S/BIMdjHCjwJSqL4LpO7X6UMhYGSVMymV
	 z3VFOij9OFQzDDQPv/S2o/KtjwBrF0F+fKSjespmQNaD3CUUD1uvxyaLr0wzWfUQKx
	 7wZKXnBZN1mhKdrtms4h6U09YkJ15RPPtp97CcqywjteBLUAKhIZA5g933OVLVXnQ8
	 fXLlMm5HhNc+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/21] KVM: s390: vsie: Shadow VSIE SCA in guest-1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260709-vsie-sigpi-v1-16-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-16-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:37:36 +0000
Message-Id: <20260709153736.EDFF01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [Critical] Incorrect pointer arithmetic in `get_sca_entry_addr()` compute=
s wildly out-of-bounds host and guest physical addresses.
- [Critical] Incomplete error rollback in `get_vsie_page_cpu_nr()` leads to=
 host NULL pointer dereference and XArray corruption.
- [Critical] Guest-controlled `icpua` field from the SIE control block is u=
sed directly as an array index without bounds checking, leading to arbitrar=
y OOB reads and writes.
- [Critical] Concurrent `memset` of a shared `vsie_page` during SCA reuse c=
auses data corruption and potential Host DoS.
- [Critical] Shadow SCBs are left unprotected during guest execution becaus=
e `VSIE_PAGE_IN_USE` is prematurely cleared.
- [High] Unvalidated guest-provided `sda` in the SCA allows out-of-bounds r=
eads of host physical memory.
- [High] Failure in `pin_sca()` permanently leaks the `vsie_sca` reference,=
 allowing a malicious guest to exhaust the VSIE SCA pool.
- [High] Stale `vsie_sca` pointers in cached `vsie_page`s break SCB executi=
on when a guest toggles SIGPIF off, and enable Use-After-Free.
- [High] KVM caches the guest's SCA address in `vsie_page->sca_gpa` and ign=
ores dynamic updates to the SCB's SCAO field.
- [High] Mismatched locking causes a data race on the `vsie_sca->pages[]` a=
rray.
- [Medium] Multiple guest-triggerable `WARN_ON_ONCE` assertions enable host=
 syslog flooding and Denial of Service.
- [Medium] XArray internal nodes and elements are permanently leaked on VM =
destruction and SCA reuse due to missing `xa_destroy()` and incomplete `xa_=
erase()` cleanup.
--

--- Patch [16]: [PATCH 16/21] KVM: s390: vsie: Shadow VSIE SCA in guest-1 -=
--
commit 9e60c38b165cf3838037fe34e3e571d246e77218
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Shadow VSIE SCA in guest-1

This commit restructures the vsie handler to create a guest-1 shadow of the
SCA if guest-2 attempts to enter SIE with an SCA. It adds the vsie_sca
struct and manages its lifecycle and lookup via a map in the arch vsie
struct.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 4b492af155429..74455c689c51b 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
[ ... ]
> @@ -694,6 +694,22 @@ static int shadow_scb_minimal(struct kvm_vcpu *vcpu,=
 struct vsie_page *vsie_page)
[ ... ]
>  	scb_s->ecb2 |=3D scb_o->ecb2 & ECB2_ESCA;
> =20
>  	if (vsie_page->vsie_sca) {
>  		scb_s->eca |=3D scb_o->eca & ECA_SIGPI;
>  		scb_s->ecb |=3D scb_o->ecb & ECB_SRSI;
>  		write_scao(scb_s, virt_to_phys(&vsie_page->vsie_sca->ssca));
>  		scb_s->osda =3D virt_to_phys(scb_o);
>  	}

[Severity: High]
Does this code use a stale vsie_sca pointer if the guest executes the same
SCB with SIGPIF disabled?

When get_vsie_page() retrieves a cached vsie_page, it does not clear
vsie_page->vsie_sca. If the guest previously executed this SCB with SIGPIF
enabled, but now executes it with SIGPIF disabled, will shadow_scb_minimal()
forcefully inject SIGPIF configuration using a stale pointer? Since vsie_sca
can be recycled, could this cause cross-guest isolation breaches?

[ ... ]
> @@ -927,6 +927,21 @@ static int pin_sca(struct kvm *kvm, struct vsie_sca =
*vsie_sca)
[ ... ]
>  	vsie_sca->sca_o_nr_pages =3D pin_guest_pages(kvm, vsie_sca->sca_gpa, nr=
_pages,
>  						   vsie_sca->sca_o_pages);
>  	if (WARN_ON_ONCE(vsie_sca->sca_o_nr_pages !=3D nr_pages))
>  		return -EIO;

[Severity: Medium]
Is this WARN_ON_ONCE triggerable by a malicious guest?

If the guest provides an unmapped sca_gpa, pin_guest_pages() will return
-EFAULT. This causes an underflow when compared to nr_pages, triggering the
warning. Should guest-driven errors return directly without asserting to
prevent syslog flooding?

[ ... ]
> +static int get_sca_entry_addr(struct kvm *kvm, struct vsie_sca *vsie_sca=
, u16 cpu_nr, gpa_t *gpa,
> +			      hpa_t *hpa)
> +{
> +	hpa_t offset;
> +	int pn;
> +
> +	/*
> +	 * We cannot simply access the hva since the esca_block has typically
> +	 * 4 pages (arch max 5 pages) that might not be continuous in g1 memory.
> +	 * The bsca_block may also be stretched over two pages. Only the header
> +	 * is guaranteed to be on the same page.
> +	 */
> +	if (test_bit(VSIE_SCA_ESCA, &vsie_sca->flags))
> +		offset =3D offsetof(struct esca_block, cpu[cpu_nr]);
> +	else
> +		offset =3D offsetof(struct bsca_block, cpu[cpu_nr]);
> +	pn =3D ((vsie_sca->sca_gpa & ~PAGE_MASK) + offset) >> PAGE_SHIFT;
> +	if (WARN_ON_ONCE(pn >=3D vsie_sca->sca_o_nr_pages))
> +		return -EINVAL;
> +
> +	if (gpa)
> +		*gpa =3D vsie_sca->sca_o_pages[pn].gpa + offset;
> +	if (hpa)
> +		*hpa =3D vsie_sca->sca_o_pages[pn].hpa + offset;
> +	return 0;
> +}

[Severity: Critical]
Does this address arithmetic overshoot the pinned page boundaries?

The offset calculated here is the full structural offset from the start of
the SCA (which can be up to 5 * PAGE_SIZE). When calculating the hpa, this
full offset is added to the base physical address of the pn-th page, rather
than just the offset within that specific page. Can this instruct the
hardware to access unpinned, arbitrary host physical memory?

[ ... ]
> +static struct vsie_sca *get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s=
390_sie_block *scb_o,
> +				     gpa_t sca_gpa)
> +{
[ ... ]
> +	} else {
> +		/* reuse previously created vsie_sca allocation for different osca */
> +		vsie_sca =3D get_reuseable_vsie_sca(kvm);
> +		/* with nr_vcpus scas one must be reusable */
> +		if (IS_ERR(vsie_sca))
> +			goto out;
> +		WARN_ON_ONCE(atomic_read(&vsie_sca->ref_count) !=3D 1);
> +
> +		xa_erase(&kvm->arch.vsie.osca_to_sca, vsie_sca->sca_gpa >> 6);
> +		for (cpu_nr =3D 0; cpu_nr < KVM_S390_MAX_VSIE_VCPUS; cpu_nr++) {
> +			vsie_page_n =3D vsie_sca->pages[cpu_nr];
> +			if (!vsie_page_n)
> +				continue;
> +
> +			/* unpin but keep the vsie_page for reuse */
> +			unpin_scb(kvm, vsie_page_n);
> +			release_gmap_shadow_safe(kvm, vsie_page_n);
> +			memset(vsie_page_n, 0, sizeof(struct vsie_page));

[Severity: Critical]
Is it safe to memset the vsie_page while it is still in the addr_to_page
XArray?

The vsie_page is zeroed out here, clearing its VSIE_PAGE_IN_USE flag, but it
is never removed from the addr_to_page XArray. A concurrent VCPU executing
get_vsie_page() can perform a lockless xa_load(), observe the in-use flag as
0, and claim the page. Could this cause the first thread to clear scb_o
while the second thread actively executes shadow_scb() using the now-NULL
pointer?

> +			vsie_page_n->scb_gpa =3D ULONG_MAX;

[Severity: Medium]
Does this code leak XArray entries?

Because scb_gpa is set to ULONG_MAX without calling xa_erase(), does this
leave dangling pointers and leak XArray internal nodes?

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
> +		vsie_sca =3D ERR_PTR(rc);
> +		goto out;
> +	}

[Severity: High]
Does this error path leak the vsie_sca reference?

The ref_count is initialized to 1 earlier. If pin_sca() fails (e.g., due to
an unmapped guest sca_gpa), the function returns ERR_PTR(rc) and the caller
bypasses put_vsie_sca(). Since get_reuseable_vsie_sca() expects a ref_count
of 0 for reuse, will these stranded objects permanently exhaust the finite
pool of vsie_sca structures?

[ ... ]
> @@ -1032,8 +1242,8 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct=
 vsie_page *vsie_page)
>  	gpa_t gpa;
>  	int rc =3D 0;
> =20
> -	gpa =3D read_scao(vcpu->kvm, scb_o);
> -	if (gpa) {
> +	gpa =3D vsie_page->sca_gpa;
> +	if (gpa && !vsie_page->vsie_sca) {
>  		rc =3D validate_scao(vcpu, scb_o, gpa);

[Severity: High]
Will this ignore dynamic updates to the guest's SCAO field?

By reading the cached vsie_page->sca_gpa instead of dynamically calling
read_scao(), KVM seems to lock the SCA address permanently after it is first
set in vsie_page_init(). If a guest updates the SCAO field for a reused SCB,
will KVM silently continue pinning and shadowing the old address?

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
Is the cpu_nr index validated against the bounds of the pages array?

The cpu_nr parameter comes directly from the guest-controlled icpua field.
Since it is not bounds-checked against KVM_S390_MAX_VSIE_VCPUS, can a
malicious guest provide an out-of-bounds or negative index, causing KVM to
read from and later overwrite arbitrary host memory with a newly allocated
page pointer?

> +	if (!vsie_page) {
> +		vsie_page_new =3D alloc_vsie_page(vcpu->kvm);
> +		if (!vsie_page_new)
> +			return ERR_PTR(-ENOMEM);
> +		vsie_page_new->vsie_sca =3D vsie_sca;
> +		__set_bit(VSIE_PAGE_IN_USE, &vsie_page_new->flags);
> +
> +		/* be careful to not loose a page here if we raced */
> +		scoped_guard(mutex, &vsie_sca->mutex) {
> +			vsie_page =3D vsie_sca->pages[cpu_nr];
> +			if (!vsie_page) {
> +				WRITE_ONCE(vsie_sca->pages[cpu_nr], vsie_page_new);

[Severity: High]
Does this create a data race on the vsie_sca->pages array?

This code writes to the array while holding vsie_sca->mutex. However,
vsie_sca_update() also writes to this array but holds vsie_sca_lock instead
of vsie_sca->mutex. Could this lock mismatch corrupt array pointers?

> +				vsie_page =3D vsie_page_new;
> +			}
> +		}
> +	}
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
Does this error path leave vsie_page->scb_gpa with a stale value?

If vsie_page_init() fails to pin the SCB, it returns an error but leaves
vsie_page->scb_gpa updated to the unpinnable address. By returning ERR_PTR
here without rolling back scb_gpa to ULONG_MAX, if this page is encountered
again, vsie_page_init() will see the stale value and mistakenly call
xa_erase(). Can this arbitrarily delete a valid entry belonging to another
VCPU's SCB?

Also, since the error is driven by guest-controlled input (an unpinnable
SCB address), does WARN_ON_ONCE(rc) allow a guest to spam the host syslog?

[ ... ]
> +static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_pag=
e,
> +		       struct vsie_sca *vsie_sca)
> +{
[ ... ]
> +	for_each_set_bit_inv(cpu_nr, mcn, cpu_slots) {
> +		rc =3D get_sca_entry_addr(vcpu->kvm, vsie_sca, cpu_nr, NULL, &sca_o_en=
try_hpa);
> +		if (rc)
> +			goto err;
> +
> +		if (vsie_page->scb_o->icpua =3D=3D cpu_nr) {
> +			vsie_sca_update(vsie_sca, cpu_nr, vsie_page, sca_o_entry_hpa);
> +		} else {
> +			sca_o_entry_hva =3D (hva_t)phys_to_virt(sca_o_entry_hpa);
> +			if (is_esca)
> +				scb_o_gpa =3D ((struct esca_entry *)sca_o_entry_hva)->sda;
> +			else
> +				scb_o_gpa =3D ((struct bsca_entry *)sca_o_entry_hva)->sda;

[Severity: High]
Are alignment checks missing when reading the guest-provided sda?

The guest-provided sda is read from the SCA and passed to
get_vsie_page_cpu_nr(), which maps a single 4096-byte page. If KVM does not
enforce 512-byte alignment on sda, could a malicious guest provide an addre=
ss
near the end of the page? This would cause the 512-byte shadow_scb() read to
cross the boundary of the pinned page into adjacent, unpinned host physical
memory.

> +			vsie_page_n =3D get_vsie_page_cpu_nr(vcpu, vsie_sca, scb_o_gpa, cpu_n=
r);
> +			if (!vsie_page_n)
> +				rc =3D -EAGAIN;
> +			if (IS_ERR(vsie_page_n))
> +				rc =3D PTR_ERR(vsie_page_n);
> +			if (rc)
> +				goto err;
> +			rc =3D shadow_scb(vcpu, vsie_page_n);
> +			vsie_sca_update(vsie_sca, cpu_nr, vsie_page_n, sca_o_entry_hpa);
> +			put_vsie_page(vsie_page_n);
> +			if (rc)
> +				goto err;
> +		}
> +	}

[Severity: Critical]
Does calling put_vsie_page() prematurely expose the shadow SCB?

put_vsie_page() clears the VSIE_PAGE_IN_USE flag. Because these pages reside
in the global addr_to_page pool, another host VCPU looking for a free page
can observe the in-use flag as 0 and claim it. Can this concurrent VCPU call
vsie_page_init() and overwrite the memory of the shadow SCB while the
hardware is actively using it for nested execution?

[ ... ]
>  void kvm_s390_vsie_destroy(struct kvm *kvm)
>  {
>  	struct vsie_page *vsie_page;
> -	int i;
> +	struct vsie_sca *vsie_sca;
> +	int i, cpu_nr;
> +
> +	guard(mutex)(&kvm->arch.vsie.mutex);
[ ... ]
> +	for (i =3D 0; i < kvm->arch.vsie.sca_count; i++) {
> +		vsie_sca =3D kvm->arch.vsie.scas[i];
> +		kvm->arch.vsie.scas[i] =3D NULL;
> +
> +		for (cpu_nr =3D 0; cpu_nr < KVM_S390_MAX_VSIE_VCPUS; cpu_nr++) {
> +			vsie_page =3D vsie_sca->pages[cpu_nr];
> +			vsie_sca->pages[cpu_nr] =3D NULL;
> +			if (!vsie_page)
> +				continue;
> +			unpin_scb(kvm, vsie_page);
> +			kvm_s390_vsie_destroy_page(kvm, vsie_page);
> +		}
> +
> +		unpin_sca(kvm, vsie_sca);
> +		free_vsie_sca(kvm, vsie_sca);
> +	}
> +	kvm->arch.vsie.sca_count =3D 0;
>  }

[Severity: Medium]
Does this teardown leak XArray entries?

When freeing vsie_sca objects, there are no calls to xa_erase() to remove
them from the osca_to_sca XArray. Furthermore, xa_destroy() is missing for
both addr_to_page and osca_to_sca. Will this permanently leak dynamically
allocated XArray internal nodes every time a VM is destroyed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-vsie-sigpi=
-v1-0-ea9f12066408@linux.ibm.com?part=3D16
