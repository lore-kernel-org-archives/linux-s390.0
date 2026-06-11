Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8318B380FCC;
	Thu, 11 Jun 2026 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194128; cv=none; b=TJhR+cxQFognlvbxOPX/lfiYu73v0RhnQSmNsPGfgxVdZkh2y410UR7sQXtqMAApj7e+l3OJX8+KO4gRF6dPkfxlqIYUTV4sHFUm5p/vjkov5ysfuOlerzzN1JaSsHCo0+ZPRIuXwaTeUf5WzcBeXdvfNWIMiuraij1DxGw6XMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194128; c=relaxed/simple;
	bh=VU7u4gcjsIJs96WJ32X+KbXTNkJwjC8iDCLEsym1PvA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W+xE2mtwZFXa5x2vbJlW7dByxWjqlCVeWYEbGEuJCuaQl1tVoJCxQd7O6WsUUxnFRP1rHpjCeEnMuI9GkR+626cuSNpbQkXYOGK+s52LryH4mnP5vrJ6U3uoT/wEwCd1wakwC5ts5xSv+UfFSalcugYf7uby2PG34YZAq1iH4UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPyXTcMi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPyXTcMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFA51F00893;
	Thu, 11 Jun 2026 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781194127;
	bh=67pyTVN1Quk2VsSRevFkiRkJdj2mczxJGsOwI6S5CMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aPyXTcMioo16GP6o7JRZKvXeRf96lKMSeg0OT1lVK3Bjj0NqgNBeR5acC4R2c6VWy
	 S3pQAbaM8FDOK+nmfutGJGnqtQpKsZ0X4rBVNkzb97GrQBrvFPeOLTvJDSUEmPVNd+
	 9E7WZsoUT4cQWdXx7ED45oiRxpPuTUpM/v5lHGZ0gRmmDGOhiNnrM36pf7/kXoBveo
	 hmOcsuEqW0djCRLGDMXPZXJ2viAXCkgn9WRHYHDdcEwJGIlusb1wSviGt25doVHE4o
	 q4bzQcYU2StUIXi00t/gla6Q9vXqkEkS+rQyt6LRmmdNB7TyKo6TKLv71QSvTLMZ8Q
	 WUuo6ZpTtACtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] KVM: s390: vsie: Implement ASTFLEIE facility 2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260611-vsie-alter-stfle-fac-v3-4-b1a35efedaba@linux.ibm.com>
References: <20260611-vsie-alter-stfle-fac-v3-4-b1a35efedaba@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 16:08:46 +0000
Message-Id: <20260611160847.1EFA51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Hardware alignment violation for Cryptographic Control Block (=
CRYCB) Format 2.
- [High] Uninitialized `reserved0` field in the shadow format-2 facility li=
st control block leads to hardware state corruption.
--

commit 74d49835ae9f08ad6c33a2e48ab3b975fa0b0159
Author: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

KVM: s390: vsie: Implement ASTFLEIE facility 2

This commit implements shadowing of the format-2 facility list when
running in VSIE, to support the ASTFLEIE2 facility available since
IBM z16.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 2ea3bbaf568e5..592d6b6f57292 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -65,9 +65,9 @@ struct vsie_page {
>  	gpa_t scb_gpa;				/* 0x0258 */
>  	/* the shadow gmap in use by the vsie_page */
>  	struct gmap_cache gmap_cache;		/* 0x0260 */
> -	__u8 reserved[0x0700 - 0x0278];		/* 0x0278 */
> -	struct kvm_s390_crypto_cb crycb;	/* 0x0700 */
> -	__u8 fac[S390_ARCH_FAC_LIST_SIZE_BYTE];	/* 0x0800 */
> +	__u8 reserved[0x06f8 - 0x0278];		/* 0x0278 */
> +	struct kvm_s390_crypto_cb crycb;	/* 0x06f8 */

[Severity: Critical]
Does moving crycb to offset 0x06f8 violate the hardware's 256-byte
alignment requirement for the Cryptographic Control Block (CRYCB) Origin
address?

When KVM applies CRYCB_FORMAT2 to this unaligned physical address in
shadow_crycb():

    scb_s->crycbd =3D (u32)virt_to_phys(&vsie_page->crycb) | CRYCB_FORMAT2;

will the hardware see a misaligned crycbd value and either inject a
validity intercept or mask out the lower bits, reading keys from
uninitialized padding instead of the actual control block?

[ ... ]

> @@ -999,6 +999,28 @@ static int handle_stfle_0(struct kvm_vcpu *vcpu, str=
uct vsie_page *vsie_page,
>  	return 0;
>  }
> =20
> +static int handle_stfle_2(struct kvm_vcpu *vcpu, struct vsie_page *vsie_=
page, u32 fac_list_origin)
> +{
> +	struct kvm_s390_flcb2 *flcb_s =3D (struct kvm_s390_flcb2 *)vsie_page->f=
ac;
> +	struct kvm_s390_sie_block *scb_s =3D &vsie_page->scb_s;
> +	u64 len;
> +
> +	if (read_guest_real(vcpu, fac_list_origin, &len, sizeof(len)))
> +		return set_validity_icpt(scb_s, 0x1090U);
> +
> +	/* discard reserved bits */
> +	len =3D (len & U8_MAX);
> +	flcb_s->length =3D len;
> +	len +=3D 1;

[Severity: High]
Could this leave the 7-byte reserved0 array in the shadow format-2
facility list uninitialized?

Since vsie_page structures are pooled and reused across nested executions
without zeroing the fac array, will reserved0 contain stale data from
previous executions, like facility bits from a prior format-0 STFLE
execution?

If the architecture requires these reserved bits to be zero, will passing
non-zero reserved bits to the hardware cause a validity intercept and
crash the nested guest?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-vsie-alter=
-stfle-fac-v3-0-b1a35efedaba@linux.ibm.com?part=3D4
