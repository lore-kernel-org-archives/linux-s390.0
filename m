Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A261238F941;
	Wed, 12 Aug 2026 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553637; cv=none; b=jMbSfoSnLcJ7vuyTkXcHlQ0dEo4KP+k+n+VVSRLbQ5+3ILcRJ7RJ1GTIgTmwCeh6jASKuDdIp0lmsVdnXUDY8pr6r35JfXFawNoboUe08PsdVuQM9hYeJo6BMaw1PH3AEk8LtOgoO1ux7OU/wLckFC9Qv6552wV1rpIZLO43XAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553637; c=relaxed/simple;
	bh=C+4Mix3PEXphsm4AipPjAPwqyM+cH4POblsOCkkRGOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jI9QUIDjDcSSJjYwqumgtVgCrDA61igcvRlQcN18y4gXvz98hJIEKNNe/T2F2RvrOWpu+eMVxGzA68VjMMgmcKT9RUwubDUwxVr0fi6CSEzT4cSNtLh/QNFRKXcksrtpT3cdHud00dWoTo/sBmYCA8KLahKzGtyCcc0t981Pvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cy2hDcPK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cy2hDcPK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA33B1F000E9;
	Wed, 12 Aug 2026 16:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786553636;
	bh=GilwAIACIWUHeaolcTI7B/+Pl2xK1TNaCka3WgS+Esc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cy2hDcPK1sc/40fybkLulb9SAQAQ8P0tNibB9XEphjGtXGKXPwSTXYhlcq9BTwP0W
	 raOxn8RlYbRrMhqB0udYLEeNSUTFA8LfABx5yHTQodzZLaOgzSARwbrKHi4POhqwg3
	 BnPv+BG5TIZqJNIr6gkW+F04nx+VNHeiBzDClHFfv7mzg//6cg9lblgEXaNaVtlj+Y
	 uzX4wYlKUAwdJ/oK5vYUzDySu9DcVp7MI8/kFhz02nSDC2Vl34L7M+cmGnsIadxI4t
	 eDAUKlOdqeqysBAdAVPKXUBuXDWSgGOSmuX1J/ZcW9O/5ctETDwIfvVpUn0oAb8SWO
	 2jJT/uUI8FTIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/20] KVM: s390: vsie: Add VSIE max shadow
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260812-vsie-sigpi-v4-17-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-17-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:53:55 +0000
Message-Id: <20260812165355.CA33B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] A `vsie_page` actively in use by a non-SCA VSIE execution can =
be corrupted (zeroed out) if its previously associated `vsie_sca` is concur=
rently selected for reuse, leading to host memory corruption.
--

--- Patch [17]: [PATCH v4 17/20] KVM: s390: vsie: Add VSIE max shadow confi=
guration ---
commit a1cb743a25bd4d366ca8bd61632e7dad29b9214d
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Add VSIE max shadow configuration

This commit introduces two new module parameters, vsie_shadow_scb_max and
vsie_shadow_sca_max. These parameters allow overriding the maximum number of
shadow control blocks and system control areas kept by KVM to minimize
repeated shadowing efforts.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 6088a9c31564f..5f6dd4b9e9fd7 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
[ ... ]
> @@ -1063,7 +1073,8 @@ static struct vsie_sca *get_vsie_sca(struct kvm_vcp=
u *vcpu, struct kvm_s390_sie_
>  	 * We want at least #online_vcpus shadows, so every VCPU can execute the
>  	 * VSIE in parallel. (Worst case all single core VMs.)
>  	 */
> -	max_vsie_sca =3D MIN(atomic_read(&kvm->online_vcpus), KVM_S390_MAX_VSIE=
_VCPUS);
> +	max_vsie_sca =3D min_t(unsigned int, max_t(unsigned int, atomic_read(&k=
vm->online_vcpus),
> +				vsie_shadow_sca_max), KVM_S390_MAX_VSIE_VCPUS);
> =20
>  	if (kvm->arch.vsie.sca_count < max_vsie_sca) {
>  		vsie_sca_new =3D alloc_vsie_sca();

[Severity: Critical]
Can a vsie_page actively in use by a non-SCA VSIE execution be corrupted
(zeroed out) if its previously associated vsie_sca is concurrently selected
for reuse?

When a guest VCPU executes a VSIE instruction with an SCA, KVM saves a poin=
ter
to the allocated vsie_page in vsie_sca->pages[cpu_nr] during
get_vsie_page_cpu_nr().

If another VCPU later executes a non-SCA VSIE using the same SCB address,
it fetches this same vsie_page, sets vsie_page->vsie_sca =3D NULL in
kvm_s390_handle_vsie(), and enters guest execution. The page pointer remain=
s in
vsie_sca->pages.

Concurrently, if the guest exhausts the max_vsie_sca limit (which can now be
influenced by vsie_shadow_sca_max), KVM will recycle the original vsie_sca.
In get_vsie_sca(), this reuse path iterates over vsie_sca->pages:

arch/s390/kvm/vsie.c:get_vsie_sca() {
    ...
    vsie_sca =3D get_reuseable_vsie_sca(kvm);
    ...
    for (cpu_nr =3D 0; cpu_nr < KVM_S390_MAX_VSIE_VCPUS; cpu_nr++) {
        vsie_page_n =3D vsie_sca->pages[cpu_nr];
        if (!vsie_page_n)
            continue;

        unpin_scb(kvm, vsie_page_n);
        release_gmap_shadow_safe(kvm, vsie_page_n);
        memset(vsie_page_n, 0, sizeof(struct vsie_page));
        ...
    }
    ...
}

Does this unconditional memset() corrupt the vsie_page while it is actively
being used by the non-SCA VSIE execution, without checking if it is current=
ly
in use (VSIE_PAGE_IN_USE)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D17
