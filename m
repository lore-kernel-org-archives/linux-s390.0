Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88037484241;
	Thu, 27 Aug 2026 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847207; cv=none; b=Uewuuu54atYE8zGKL7J/ftLfrvAXNYAGqTQsQKboGOFml2P27nZeHTPSGU8Qh3UOxbYl71rhgSd9A521uGVdNo49lH9sEt7G5y+RsaBITM9ErFMAJARauzCLCoMNxsP8W3EnQgQB8vXr7cHzslMDPWkXoO/jfNQJay6hFzdehRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847207; c=relaxed/simple;
	bh=snqZgKEHtgko0PzFdJtn1zJmu9xfkKgORbzBjxjm5ak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l4uI3rs3C0TCI09B+Zh9SknTnuZxW3p1nc+jtXx242nhkcPze8kHqIgcoZOuhny0E/7I1ucqeGaP0yl4RMcteoNVnYLc2WOEDzpWB3p8PuFI7Q9QjtlO5BUTjpqjDR9XZhl8piGS+KvHTsTFCgi98lp0hiy5l6RdqYwFbr0HVcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WumoTU/m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WumoTU/m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178601F000E9;
	Thu, 27 Aug 2026 16:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787847206;
	bh=WcoXQfLEj1/yq858Q2G1hWAz8AzP4Mu7IVXuQTJqYHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WumoTU/mNetPglIbUBgWrUpHXd7ZNw/FizrxkmkL3RWXY/PwtoN59LOwRYnoccyHy
	 PNvubZCqII98CFBa5fwTk8ugrCr7DAZQ/rukB321QmlRf2nnI+7oM4C5Lnuyi5lQMW
	 TxIDivkYKxpoN7kvykhtaRU+6E9jvvKPPbVZOh86Jx20lzzKHzucasEIkzTEzmwkPp
	 5t1VeQ6JBkQnEMvXsOBmc2cfrjaR/z/3UH9ATdBNi8kKDpQ97on81IqtlaT1yBx+3N
	 aKJ8TpspIhE+j5cvg2UIiI15deXRcwaUDUKhbDhYPP07Mnmku5b+KiU6J0qSHiO2Hz
	 mw0ssmQpnyo8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 18/21] KVM: s390: vsie: Add VSIE max shadow
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-18-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-18-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:13:25 +0000
Message-Id: <20260827161326.178601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing return value assignment in get_vsie_sca() leads to der=
eferencing ERR_PTR and a host kernel panic.
- [High] Reference leak of vsie_sca upon xa_insert failure allows a guest t=
o permanently exhaust the SCA pool.
--

commit b0058b2ab33487566dfa6d36cbbfbcc7b06a1519
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Add VSIE max shadow configuration

This commit introduces two new module parameters, vsie_shadow_scb_max
and vsie_shadow_sca_max, to configure the maximum number of VSIE shadow
control blocks and system control areas kept by guest-1. It modifies
get_vsie_sca() and get_vsie_page() to respect these new limits.

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index bfd5df1f8b9ca..3a839154fdfed 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c
[ ... ]
> @@ -1086,7 +1096,8 @@ static int get_vsie_sca(struct kvm_vcpu *vcpu, stru=
ct kvm_s390_sie_block *scb_o,
>  	 * We want at least #online_vcpus shadows, so every VCPU can execute the
>  	 * VSIE in parallel. (Worst case all single core VMs.)
>  	 */
> -	max_vsie_sca =3D MIN(atomic_read(&kvm->online_vcpus), KVM_S390_MAX_VSIE=
_VCPUS);
> +	max_vsie_sca =3D min_t(unsigned int, max_t(unsigned int, atomic_read(&k=
vm->online_vcpus),
> +			     vsie_shadow_sca_max), KVM_S390_MAX_VSIE_VCPUS);
> =20
>  	if (kvm->arch.vsie.sca_count < max_vsie_sca) {
>  		vsie_sca_new =3D alloc_vsie_sca();
[ ... ]
> 	} else {
> 		/* reuse previously created vsie_sca allocation for different osca */
> 		vsie_sca =3D get_vsie_sca_unused(kvm);
> 		/* with nr_vcpus scas one must be reusable */
> 		if (IS_ERR(vsie_sca))
> 			goto out;

[Severity: Critical]
This is a pre-existing issue, but missing a return value assignment here
can lead to a host kernel panic.

If get_vsie_sca_unused() exhausts the pool and returns ERR_PTR(-EAGAIN),
the IS_ERR check triggers a goto to the out label without setting rc.
As a result, rc remains 0 (success) while the error pointer is assigned
to *vsie_sca_out:

> out:
> 	up_write(&kvm->arch.vsie.vsie_sca_lock);
> 	if (vsie_sca_new)
> 		free_vsie_sca(kvm, vsie_sca_new);
> 	if (vsie_sca)
> 		*vsie_sca_out =3D vsie_sca;
> 	return rc;

Because the caller kvm_s390_handle_vsie() receives a success code, it
proceeds to call get_vsie_page_cpu_nr(), which dereferences the error
pointer.

Can a malicious guest deterministically trigger this crash by forcing memory
allocation failures on the xa_insert path to exhaust the pool?

[ ... ]
> 	rc =3D xa_insert(&kvm->arch.vsie.osca_to_sca, vsie_sca->sca_gpa >> SCA_A=
LIGNMENT_SHIFT,
> 		       vsie_sca, GFP_KERNEL_ACCOUNT);
> 	if (rc =3D=3D -EBUSY)
> 		rc =3D 1;
>=20
> out:

[Severity: High]
This isn't a bug introduced by this patch, but does this error path
permanently leak a vsie_sca reference?

If xa_insert() fails (e.g., returning -ENOMEM), it sets rc and jumps to out.
However, it skips calling put_vsie_sca(vsie_sca) to clean up the reference
count initialized to 1.

Because the caller receives an error code and also skips cleanup, the
ref_count remains stuck at 1 and the vsie_sca can never be reclaimed by
get_vsie_sca_unused().

Could a guest apply memory pressure to repeatedly trigger this, exhaust the
SCA pool, and pave the way for the ERR_PTR dereference bug above?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D18
