Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38498442374;
	Wed, 26 Aug 2026 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757955; cv=none; b=bXpSUqsb9HyIGeVHL39DBl6x4SzEfhNEvVtwUjpTapBm5Jprk+N5n4/F/Yg7Rd0KI8LR76Pt6c21YrGCYar1brXc1aArVUSMSueRNdo6i7XmT0XlaOGMMSzaOdMUjdt+jHScw3VBuk2ukKEsDjMAIAj4CjjskjMi3IwaYbbkqe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757955; c=relaxed/simple;
	bh=0cOBJuo+Sl6RdeKWeHpov9he8pPUaz7xxTJKQ53O/3Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kfpl/7zoY/PN+Q6Fk2OqmMybIq3pge8HW9OZC4LVuJxJDnabPUPgPXi7uViNtN6DlWiotgD56wJO3kPwojoSw753Cc3G0GUSkhXvQmepRuYJJQNLrVwQbUf9Ix9bozqVNaH8u7h+Wl1rkXEuWFjWnbdbZbAqfn4kSY9+H7WskAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4HfMlwW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4HfMlwW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24201F000E9;
	Wed, 26 Aug 2026 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757946;
	bh=Ojg7QWrTl+2gmmrrPz5OrOsmSKegQ47UXhAbw25bQ+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U4HfMlwWB2OK6f+7sIuRVdAkf1AfBNqV1pR1fyF9ytbTp+h1knAbNS99uNNuI+uKD
	 uJoCzgCjJn8Oy3Ivn6591FGQi0Yf1qdlTP2pwYQLnjmEqGxNv+uy3pTHUiABzwDffq
	 Y8trKpd+e/C82Vk83djheo4bVgYF8S3ZhsSKM3vS0laN7P3Nqzrr0UzzCQ9egao1T0
	 LeSg6tnfnRdH970t/tPXNtzGTVXLLwSqiucs6xH0de15mCtvTAIyKaGdp8uHRnC4Qe
	 WFMndenu6rlX9CKlAjGyS/UqrnsLYRlhzWozJ4fnicrd32MRWzud2PGzT48PLN3zCV
	 JHVenxi4NlWqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/21] KVM: s390: vsie: Shadow VSIE SCA in guest-1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260826-vsie-sigpi-v5-16-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-16-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:25:45 +0000
Message-Id: <20260826152545.E24201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] `get_vsie_page_cpu_nr()` incorrectly wraps positive return cod=
es (like 1 for validity intercepts) in `ERR_PTR()`, bypassing `IS_ERR()` ch=
ecks and causing a host kernel panic.
- [High] Stale `sca_gpa` in reused `vsie_sca` causes incorrect `xa_erase()`=
 of valid shadow SCAs.
- [High] `get_vsie_sca()` incorrectly translates guest validity intercepts =
or unbacked SCA errors into KVM_RUN `-EINVAL` exits, abruptly crashing the =
VM.
- [Medium] Guest-triggerable `WARN_ON_ONCE` if `xa_store()` fails due to me=
mory pressure.
--

commit 763d66e9883805b058573509abca88b10cdfb124
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Shadow VSIE SCA in guest-1
   =20
This commit restructures kvm_s390_handle_vsie() to create a guest-1 shadow
of the SCA if guest-2 attempts to enter SIE with an SCA. The original SCA
is pinned in guest-2 memory, and references to existing shadow SCAs are
stored in a map to efficiently reuse them.

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index 3c94faa35b44e..4bd11eaa7d81d 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c
[ ... ]
> @@ -958,6 +1051,128 @@ static struct vsie_sca *alloc_vsie_sca(void)
>  	return vsie_sca;
>  }
> =20
> +/* Clear the vsie_sca struct but keep the vsie_page references, mutex an=
d ref_count */
> +static void clear_vsie_sca(struct vsie_sca *vsie_sca)
[ ... ]
> +/* Pin and get an existing or new guest-3 system control area.*/
> +static struct vsie_sca *get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s=
390_sie_block *scb_o)
> +{
[ ... ]
> +	/* validate scb_o as we do not unshadow on error here */
> +	rc =3D validate_scao(vcpu, scb_o, sca_gpa);
> +	if (rc)
> +		return ERR_PTR(-EINVAL);

[Severity: High]
Does this code incorrectly translate a guest validity intercept into a fatal
host KVM error?

When validate_scao() fails, it returns a positive validity intercept value
(like 1). Returning ERR_PTR(-EINVAL) here overrides that intercept and
returns -EINVAL instead.

> +
> +	down_read(&kvm->arch.vsie.vsie_sca_lock);
> +	vsie_sca =3D get_vsie_sca_existing(kvm, sca_gpa, is_esca);
> +	up_read(&kvm->arch.vsie.vsie_sca_lock);
> +	if (vsie_sca)
> +		return vsie_sca;
[ ... ]
> +	/* check again under write lock if we are still under our vsie_sca limi=
t */
> +	if (vsie_sca_new && kvm->arch.vsie.sca_count < max_vsie_sca) {
[ ... ]
> +	} else {
> +		/* reuse previously created vsie_sca allocation for different osca */
> +		vsie_sca =3D get_vsie_sca_unused(kvm);
> +		/* with nr_vcpus scas one must be reusable */
> +		if (IS_ERR(vsie_sca))
> +			goto out;
> +
> +		xa_erase(&kvm->arch.vsie.osca_to_sca, vsie_sca->sca_gpa >> SCA_ALIGNME=
NT_SHIFT);

[Severity: High]
If we are reusing an orphaned vsie_sca, does its sca_gpa still hold the old,
stale address? If so, does this xa_erase() inadvertently remove a valid
active shadow SCA from the osca_to_sca xarray?

[ ... ]
> +	rc =3D pin_sca(kvm, vsie_sca);
> +	if (rc) {
> +		vsie_sca->sca_gpa =3D ULONG_MAX;
> +		put_vsie_sca(vsie_sca);
> +		vsie_sca =3D ERR_PTR(rc);
> +		goto out;
> +	}
> +
> +	WARN_ON_ONCE(xa_store(&kvm->arch.vsie.osca_to_sca, vsie_sca->sca_gpa >>=
 SCA_ALIGNMENT_SHIFT,
> +			      vsie_sca, GFP_KERNEL_ACCOUNT));

[Severity: Medium]
If xa_store() fails due to memory pressure, it returns an error pointer.
Since this is a non-null value, will this WARN_ON_ONCE trigger?

Guest-reachable warnings can be exploited for log spam or DoS.

> +
> +out:
> +	up_write(&kvm->arch.vsie.vsie_sca_lock);
> +	if (vsie_sca_new)
> +		free_vsie_sca(kvm, vsie_sca_new);
> +	return vsie_sca;
> +}
[ ... ]
> @@ -1815,11 +2027,165 @@ static struct vsie_page *get_vsie_page(struct kv=
m_vcpu *vcpu, unsigned long addr
[ ... ]
> +static struct vsie_page *get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, str=
uct vsie_sca *vsie_sca,
> +					      gpa_t scb_gpa, u16 cpu_nr)
> +{
[ ... ]
> +	if (vsie_page->scb_gpa !=3D scb_gpa || vsie_page->sca_gpa !=3D vsie_sca=
->sca_gpa) {
> +		scoped_guard(mutex, &vcpu->kvm->arch.vsie.mutex) {
> +			unpin_scb(vcpu->kvm, vsie_page);
> +			rc =3D init_vsie_page(vcpu, vsie_page, scb_gpa);
> +		}
> +		if (rc) {
> +			put_vsie_page(vsie_page);
> +			return ERR_PTR(rc);
> +		}

[Severity: Critical]
If init_vsie_page() returns a positive validity intercept (such as 1), does
wrapping it in ERR_PTR(rc) return (void *)1?

Since 1 is not >=3D -MAX_ERRNO, IS_ERR() downstream will evaluate to false,
treating this as a valid pointer.

> +
> +		reset_vsie_page(vcpu->kvm, vsie_page);
> +	}
> +
> +	return vsie_page;
> +}
[ ... ]
> +static int _shadow_sca_cpu(struct kvm_vcpu *vcpu, struct vsie_page *vsie=
_page,
> +			   struct vsie_sca *vsie_sca, hpa_t sca_o_entry_hpa,
> +			   unsigned int cpu_nr, bool is_esca)
> +{
[ ... ]
> +	vsie_page_n =3D get_vsie_page_cpu_nr(vcpu, vsie_sca, scb_o_gpa, cpu_nr);
> +	if (!vsie_page_n)
> +		return -EAGAIN;
> +	if (IS_ERR(vsie_page_n))
> +		return PTR_ERR(vsie_page_n);
> +
> +	rc =3D shadow_scb(vcpu, vsie_page_n);

[Severity: Critical]
Because IS_ERR(vsie_page_n) evaluates to false for (void *)1, does this all=
ow
the invalid pointer 0x1 to be dereferenced in shadow_scb(), leading to a ho=
st
kernel panic?

[ ... ]
> @@ -1838,33 +2204,71 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
[ ... ]
> +	} else {
> +		/* get the vsie_sca with pinned original sca */
> +		vsie_sca =3D get_vsie_sca(vcpu, scb_o);
> +		if (IS_ERR(vsie_sca)) {
> +			rc =3D PTR_ERR(vsie_sca);
> +			goto out_unpin;
> +		}

[Severity: High]
If get_vsie_sca() returned ERR_PTR(-EINVAL) due to validate_scao() failing
above, rc becomes -EINVAL here.

Does returning -EINVAL abort the KVM_RUN ioctl entirely, abruptly crashing
the VM instead of gracefully reflecting an error to the guest?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D16
