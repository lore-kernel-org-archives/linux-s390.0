Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EED250AC26;
	Fri, 18 Sep 2026 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746086; cv=none; b=ejfmpfktsRspdNM0RdMR3eOjOj/ngzM6roCNDhdwN9LoE0MeCaLbNhGtzzetiHl2brhveBBD8tSq56ZeutFe4YF2BZNYBzM2y/q7ord08iG3LhYy22m4ICglbioClKrdUsUSBUp4PdsrBXLQHeXhxdK5/Qvu3Sq/jSC/4UuLZTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746086; c=relaxed/simple;
	bh=f1/3rGz/GgXwYGvLcZdP3N7a8wWrQyudJUVkY1Rjj1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fzhNI/6R+dGQm3tPLccTh3JQVnKdoWaqxFx+h/qCG0QjtM0SxvknuRAghFoq94F76AShiLJVxv2lx3f/J5edAMbmRrZt8QKKp+m+s91xlQ//4VEzpiGoQ1GjQ/bQzx4fEzF0zH453p+BsnbxFeM7YjERDf8p2G+2hFGOR+94GUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0tjk+1e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0tjk+1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0441F000FF;
	Fri, 18 Sep 2026 15:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789746084;
	bh=lZWdeP5ID92dChWEl/54r+s2yl9vvgiM2R7ncjT3ZT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V0tjk+1eN9EWd8g4w+CZHdxm9j/R3c/D3L9DyRliM3UZcx5AOacWwkrX/OaNbrJRX
	 apxzd9kIxy5we/nup4xD4Jo9TJcGMWSAgiHxwY5PukwuqDs/dyCLcYDXaqQiw7K0Rh
	 luJOtuN+2NvyD+bd6L/73CkB4vNQsoSxIxcsqUF8NC0k6jmIh09Yd+9qm6YTv7SBlF
	 Cq+4h4uKJ6Io97IPwWnD92m1ccPG+EHTDYd4ntJAJnlSai5lwt4PMLX71iQFcNtUcP
	 kiUT48L3Ol0FZx/tyEwmKdph3mZ+lxuVO7hPxuE8poQBVVJIboN7iqJGX8prCwlJsr
	 eYMRP/O4yL3+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 17/21] KVM: s390: vsie: Allow guest-3 cpu add and
 remove with ssca
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-17-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-17-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:41:23 +0000
Message-Id: <20260918154124.2D0441F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/vsie: guest-triggerable WARN_ON_ONCE via TOCTOU in _shadow_sc=
a()
--

commit ca227c9ec2b75acd2f50c492891b3a3c6f6dca0d
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Allow guest-3 cpu add and remove with ssca

This patch modifies the vsie_sca update mechanism to detect guest-3 CPU
configuration changes by copying and comparing the MCN. It replaces the
manual MCN pointer calculation in _shadow_sca() with explicit flag updates
and centralized copying functions.

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index ce053905a9d8e..698f17a5f19d6 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c

[ ... ]

> @@ -2150,17 +2187,17 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, str=
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
Could this open a TOCTOU (Time-Of-Check to Time-Of-Use) window where a
malicious nested guest modifies the ECB2_ESCA bit in its SIE control block?

If the guest modifies vsie_page->scb_o in memory after the host originally
pinned pages for a BSCA configuration, sie_uses_esca(vsie_page->scb_o) might
now return true.

By dynamically mutating VSIE_SCA_ESCA in vsie_sca->flags here, wouldn't
this cause get_sca_entry_addr() to calculate an ESCA-sized cpu_offset
against the original BSCA pinned page count (sca_o_nr_pages)?

In get_sca_entry_addr():

    if (test_bit(VSIE_SCA_ESCA, &vsie_sca->flags))
        cpu_offset =3D offsetof(struct esca_block, cpu[cpu_nr]);
    ...
    pn =3D ((vsie_sca->sca_gpa & ~PAGE_MASK) + cpu_offset) >> PAGE_SHIFT;
    if (WARN_ON_ONCE(pn >=3D vsie_sca->sca_o_nr_pages))
        return -EINVAL;

Would this mismatch trigger the WARN_ON_ONCE() and potentially cause a host
denial of service if panic_on_warn is set?

> +		clear_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
> +	sca_mcn_copy(vsie_sca, phys_to_virt(sca_o_hpa(vsie_sca)));
> =20
>  	/* pin and make shadow for ALL scb in the sca */
>  	cpu_slots =3D is_esca ? KVM_S390_MAX_VSIE_VCPUS : KVM_S390_BSCA_CPU_SLO=
TS;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D17
