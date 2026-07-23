Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021CA456DFB;
	Thu, 23 Jul 2026 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831405; cv=none; b=U3iDseVVHv+i+V/KvBErgSvwhUeNo88d6hO5XaceDUV/CVBFgGsZlesICrI6571qHmHx3RBqpN3i3rdekHOLTT1YmlsoSA1VFCLtaQthaieiBvB80QrzbyV35vIg1n/sG4NnaHrjgwzYl+qC4010rcdRzpz/qYXG0EkURtCyK1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831405; c=relaxed/simple;
	bh=Upm6fw24jGhRmA7QauJVviOADrHChMem/s6+QhxPUjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G5VCXnsD41BangPB5e3EftTusZwdmFN4O5Lkzsn9+lbRZkWYY0uY1b9cHQrnq5Yk1BLt50suuN6PRaEAgruIOTy3CyUvNn73Pd4JyJNUUmEGtg24d1PbpU64AfQ0HtdeF15NJgEUso+hHqAEgfXvPAzdFF1CQEsnhOlGzL6byxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF2F1F000E9;
	Thu, 23 Jul 2026 18:29:56 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] s390/vfio_ccw: ensure first IDAW remains
 constant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260723174751.1180334-5-farman@linux.ibm.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-5-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 18:29:55 +0000
Message-Id: <20260723182956.2AF2F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Applying a bitwise shift directly to a restricted `__bitwise` type =
(`dma64_t`) and implicitly casting it strips type annotations, triggering s=
parse warnings.

Pre-existing issues:
- [High] `get_guest_idal` reads too many bytes for Format-1 IDALs, potentia=
lly causing spurious failures for valid channel programs.
--

--- Patch [4]: [PATCH v3 4/8] s390/vfio_ccw: ensure first IDAW remains cons=
tant ---
commit e8a4291c688f39a3fdc915242b5bb6676e357ac5
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: ensure first IDAW remains constant

This commit ensures the first IDAW in a list is read separately to accurate=
ly
calculate the buffer size needed. It verifies that the address found in the
first IDAW is unchanged between reads to maintain consistency.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 258a99930c6a0..06b6bc6142a0f 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -533,6 +533,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, stru=
ct channel_program *cp, int
>  		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
>  	dma64_t *idaws;
>  	dma32_t *idaws_f1;
> +	u64 first_idaw;
>  	int idal_len =3D idaw_nr * sizeof(*idaws);

[Severity: High]
This is a pre-existing issue, but does get_guest_idal() read too many bytes
for Format-1 IDALs here?

Because idal_len is calculated using sizeof(*idaws) which evaluates to 8
bytes, instead of the actual 4 byte IDAW size for Format-1 IDALs,
vfio_dma_rw() will attempt to read idaw_nr * 8 bytes.

If a guest VM submits an I/O request with a Format-1 IDAL that fits exactly
at the end of a mapped page, this could cross the page boundary into an
unmapped page and cause the DMA read to fail, spuriously rejecting a valid
request.

[ ... ]

> @@ -549,6 +550,17 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, str=
uct channel_program *cp, int
>  			kfree(idaws);
>  			return ERR_PTR(ret);
>  		}
> +
> +		if (cp->orb.cmd.c64)
> +			first_idaw =3D dma64_to_u64(idaws[0]);
> +		else
> +			first_idaw =3D dma32_to_u32(idaws[0] >> 32);

[Severity: Low]
Does applying a bitwise shift directly to a restricted __bitwise type like
dma64_t and passing it to dma32_to_u32() trigger sparse warnings?

Since idaws[0] is of type dma64_t (__bitwise u64) and dma32_to_u32() expects
a dma32_t (__bitwise u32), this implicitly strips type annotations.

Should this be explicitly cast using (__force u64) before shifting to avoid
violating sparse type rules?

> +
> +		/* Unexpected mismatch from earlier read */
> +		if (first_idaw !=3D cp->guest_iova) {
> +			kfree(idaws);
> +			return ERR_PTR(-EINVAL);
> +		}
>  	} else {
>  		/* Fabricate an IDAL based off CCW data address */
>  		if (cp->orb.cmd.c64) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723174751.1180=
334-1-farman@linux.ibm.com?part=3D4
