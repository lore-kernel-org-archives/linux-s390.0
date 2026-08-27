Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA909378D74;
	Thu, 27 Aug 2026 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847192; cv=none; b=VaSwZztRBJYGa5ZbWFvOGl2thSEutfy/PyXEI7egmf+6rKt08nqlC3Ywf/QITxk/Jn731R7fA8GTH8imDNLp3kTs0JotfPu5zAZgb1TO+ZSP0HETo1bwdSuPIUXmKIhXqkVc79EB4Fteqt9NUmwpmxWjerfIJjA+C4zWKJc0wrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847192; c=relaxed/simple;
	bh=UCkk9paDt13xmho+2P6vxZrYv1iFhJL/6SQbTMGY//8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BU3jEGh77C3A0cj5WZkfYQ/jXJsmdi7+2iYCYx/xc+fnz4V0Qgh6kAXR1UAHHlWJKb6CDOVU0+yJK/nni6rT8Ynx2ebgQ6uv2zbcTIatkP8xaMeKcIf8F5LA5sqvQGECfz5PVeEXgRVb0K8oXcx/tT2ZCdtvpntDs/lc19iiTeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0Iyd+cp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0Iyd+cp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DDA1F000E9;
	Thu, 27 Aug 2026 16:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787847190;
	bh=beMQYIWmfutVI1MzN2+qW3HfvI6B9jKl1VCMGCqoFhs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h0Iyd+cpYQ4rsr9k3UWFMZ+nApPzMAadCIQO5IqnOPGWv1a8QBgj5nl1Z+APXBnCC
	 SQiGzBzDG/sQtj1xZ3hY1pJOHuIlbs1IELk99uyr2P/rQ0MtoFKWYcB+mVJvBTArf0
	 Ao+wip1pXVTB93zhN7plcUGi1gwE0lLoNkfs5Z2arGzEdLM8FaWhOhca9xtQkB+AJ4
	 9kClCuHi0JtjrZ3a7HtjAH4kq5K1Ze+JqI3n9LuLTB91VKluXkotEZjK9fzVN17iKq
	 eUX5Yl2fj2/oRBlJvrcpuYBN9WFnzVBX2yAn4JoBVkwMYcV8Brf30Dh68R8JOm7dyw
	 X1jgu+e0HjOcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 17/21] KVM: s390: vsie: Allow guest-3 cpu add and
 remove with ssca
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-17-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-17-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:13:09 +0000
Message-Id: <20260827161310.30DDA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] TOCTOU race dynamically flipping the `VSIE_SCA_ESCA` flag allows a=
 malicious guest to trigger a host WARN_ON_ONCE DoS.
- [High] `_shadow_sca` leaves stale shadow SCA entries for removed CPUs bec=
ause it fails to fully clear the `ssca.cpu` array when the Maximum CPU Numb=
er (`mcn`) changes.
--

commit 89f8541d7b675dfb89404ede4f82b45ae240cc10
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Allow guest-3 cpu add and remove with ssca

This commit allows dynamically adding and removing processors for a running
guest-3 configuration. It accomplishes this by copying the Maximum CPU Numb=
er
(mcn) and fully re-initializing the shadowed System Control Area (ssca)
whenever a change in the mcn is detected.

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index 16273cf5cbff5..bfd5df1f8b9ca 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c
[ ... ]
> @@ -2142,17 +2179,17 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, str=
uct vsie_page *vsie_page,
>  	bool is_esca =3D sie_uses_esca(vsie_page->scb_o);
>  	unsigned int cpu_nr, cpu_slots;
>  	hpa_t sca_o_entry_hpa;
> -	unsigned long *mcn;
>  	int rc;
> =20
>  	if (is_esca)
> -		mcn =3D phys_to_virt(sca_o_hpa(vsie_sca)) + offsetof(struct esca_block=
, mcn);
> +		set_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
>  	else
> -		mcn =3D phys_to_virt(sca_o_hpa(vsie_sca)) + offsetof(struct bsca_block=
, mcn);

[Severity: High]
If a malicious guest concurrently flips the ECB2_ESCA bit in its SCB after
vsie_sca is pinned, _shadow_sca() will read this bit and dynamically toggle
the VSIE_SCA_ESCA flag on the shared vsie_sca structure.

Could dynamically flipping this flag based on untrusted guest memory introd=
uce
a time-of-check to time-of-use (TOCTOU) race?

This can cause subsequent ESCA-based offset calculations to exceed the
initially pinned BSCA pages, leading to a guest-triggerable out-of-bounds
WARN_ON assertion when the corrupted flag is later used:

get_sca_entry_addr() {
    ...
	pn =3D ((vsie_sca->sca_gpa & ~PAGE_MASK) + cpu_offset) >> PAGE_SHIFT;
	offset =3D (vsie_sca->sca_gpa + cpu_offset) & ~PAGE_MASK;
	if (WARN_ON_ONCE(pn >=3D vsie_sca->sca_o_nr_pages))
		return -EINVAL;
    ...
}

> +		clear_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
> +	sca_mcn_copy(vsie_sca, phys_to_virt(sca_o_hpa(vsie_sca)));
> =20
>  	/* pin and make shadow for ALL scb in the sca */
>  	cpu_slots =3D is_esca ? KVM_S390_MAX_VSIE_VCPUS : KVM_S390_BSCA_CPU_SLO=
TS;
> -	for_each_set_bit_inv(cpu_nr, mcn, cpu_slots) {
> +	for_each_set_bit_inv(cpu_nr, (unsigned long *)&vsie_sca->mcn, cpu_slots=
) {

[Severity: High]
If the guest removes a CPU, its bit in the Maximum CPU Number (mcn) mask
transitions from 1 to 0.

By using for_each_set_bit_inv(), we skip the removed CPU and fail to clear
its corresponding ssda and ossea entries in the ssca.cpu array.

Does iterating only over the currently set bits in mcn leave stale shadow
SCA entries for removed CPUs?

Could this leave hardware-visible pointers intact, potentially causing the
physical hardware to erroneously route intercepted hardware-assisted SIGP
operations to a stale shadow control block?

>  		rc =3D get_sca_entry_addr(vcpu->kvm, vsie_sca, cpu_nr, NULL, &sca_o_en=
try_hpa);
>  		if (rc)
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D17
