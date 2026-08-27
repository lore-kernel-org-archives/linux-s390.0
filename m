Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685A13EEAD7;
	Thu, 27 Aug 2026 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847481; cv=none; b=UFbmtp94ewTQ+o/XhQiQT/UtElx9PBfmg3lSv9zDp6cBRr8AS+U2GRtCDrPlx9BRjrJ/RgIPOQiB65gVpHxGDRFGvs8btLrqmyPU7YKjExHxerJq8UzQhvXDnWg/8Jng47XXVzWBwCOL7fOHwlGfFM3X/u3aKtQmYr5Rxe2aPQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847481; c=relaxed/simple;
	bh=PncxDYmyuVuBE02JdtlGvOcQhg3DZZ5UojEupXPx6PA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TyCX5T6T3CywMrzQhteWTRSt0mnzwZjAh+YtJvXcDYbIOnIXyel8DJw+3cz9C6nw8wRgiRnpkezMz7l1WUa+CzdyRpjeCaHK2xlJ0jYeGQZNxikTYnEEVPgLp5+0bZz2zchqsop+e/dRb1LF8QxcWkWakkrHuDNqGocC24xXvZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXEYpIvO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXEYpIvO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B271F000E9;
	Thu, 27 Aug 2026 16:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787847480;
	bh=2B3RQGYAc2y3JcTFgtyIHuRorR0dq7r2i0M/0tbwMhw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lXEYpIvO/azh9XsSxlAlQD2jxLxNPjNk5QAMThGiRdH+mxNHTsvpkJoeV3er45Kpb
	 4qFLIfw82JaD9I7f0Q74kGg8xRSg18rGYggx0QosGJvN01R58J7o3ftbUtyeorwyHu
	 E499qQg44/4/My0LeZNvwd/ZM4E8J5QgVnN8Bh0dVrreVY8y5IqXktdB2xyCAd2nhM
	 vjxKwjES/r9efiaIbKlr3tfI9sBgWWAGWs/Fsmwa2DHVs2diC77cs9L8wl0njZ3hOA
	 6mxhMEA4Tah7ZdemyRNeK3DdUKXPiOdYhwPHCQjb6Ex+ZtYaq6gDF5bf5Sy82IcwXC
	 nyFqseCYh1j2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 21/21] KVM: s390: vsie: Enable use of VSIE SSCA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260827-vsie-sigpi-v6-21-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-21-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:17:59 +0000
Message-Id: <20260827161759.E0B271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The VSIE SSCA hardware interpretation (SIGPIF) feature is implicit=
ly enabled based on host capabilities, bypassing guest capability negotiati=
on and breaking live migration.
- [High] A TOCTOU race in `get_vsie_sca_unused` combined with an unhandled =
error path in `get_vsie_sca` causes KVM to return and dereference an ERR_PT=
R, leading to a host kernel panic.
--

commit 62219e86574d0b600ddf000bc1403125a0ac82ff
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Enable use of VSIE SSCA

This commit enables code paths actually configuring and using VSIE SIGPI and
SRSI. This feature improves guest-3 performance by allowing hardware to han=
dle
these instructions without exiting VSIE.

> diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
> index a1ce75be3955b..ffa5bbb8713bc 100644
> --- a/arch/s390/kvm/s390/s390.c
> +++ b/arch/s390/kvm/s390/s390.c
[ ... ]
> @@ -3363,7 +3367,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long=
 type)
> =20
>  	kvm->arch.use_pfmfi =3D sclp.has_pfmfi;
>  	kvm->arch.use_skf =3D sclp.has_skey;
> -	kvm->arch.use_ssca =3D sclp.has_vsie_interp_extf;
> +	kvm->arch.use_ssca =3D sclp.has_vsie_interp_extf && ssca;

[Severity: High]
By enabling the SSCA feature globally based on the host capability here,
does this bypass guest capability negotiation?

In arch/s390/kvm/s390/vsie.c, use_ssca() checks the global kvm->arch.use_ss=
ca
flag but appears to miss checking if the L1 guest actually negotiated the
KVM_S390_VM_CPU_FEAT_SIGPIF feature via test_kvm_cpu_feat().

Additionally, in shadow_scb_minimal():

    scb_s->eca |=3D scb_o->eca & ECA_SIGPI;
    scb_s->ecb |=3D scb_o->ecb & ECB_SRSI;

The requested features are copied into the shadow SCB without masking them
against the guest's negotiated capabilities. Could this allow a nested L1
guest to utilize hardware SSCA interpretation even if the VMM explicitly
disabled it, leading to silent live migration failures on destination hosts
without SSCA support?


[Severity: High]
Does enabling this feature expose a potential race condition and error poin=
ter
dereference in the VSIE SCA handling?

In arch/s390/kvm/s390/vsie.c, if get_vsie_sca_unused() runs concurrently wi=
th
put_vsie_sca() (which decrements the refcount without holding vsie_sca_lock)
and all SCAs are temporarily busy, it can return ERR_PTR(-EAGAIN).

When get_vsie_sca() receives this error:

    if (IS_ERR(vsie_sca))
        goto out;

It jumps to the out label without updating the local rc variable. Since rc
remains 0 from a previous successful call to validate_scao(), get_vsie_sca()
incorrectly returns success while passing out the ERR_PTR.

This leads to kvm_s390_handle_vsie() seeing a success return:

    rc =3D get_vsie_sca(vcpu, scb_o, &vsie_sca);
    if (rc)
        goto out_unpin;
    rc =3D get_vsie_page_cpu_nr(vcpu, vsie_sca, ...);

And passing the invalid pointer to get_vsie_page_cpu_nr(), which immediately
dereferences it:

    vsie_page =3D vsie_sca->pages[cpu_nr];

Could this unhandled error path allow a nested guest workload to trigger a
host kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D21
