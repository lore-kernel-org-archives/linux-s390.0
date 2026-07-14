Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF5A294A10;
	Tue, 14 Jul 2026 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072066; cv=none; b=kAGlOmAgqMNcEXIhL4kKrnb5KUvMeR/qYmC18KgPKcfdRQnAxM7iJv0F+ZtPyPysRXAopycBOovOy/xTDymiLXeAAZDsgfAjiwXMC/f/rSM1SQzSqMdsNKEz3wZDnnW75cYNK2xpTFX3rDqteLx6tBSTF1XX/Fm3CFUsxJEHJAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072066; c=relaxed/simple;
	bh=D6A6T7fbi59se672s5HJKrVhvVFYC4p+mHT0aZTBh0Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rsQcXkNCjL59eU9PYNJIYa2T9Ko9rYXiZjwcGLqBShV9yeg+XDdSWr6jfNv7yKRHAVEpFEodWe6XV65Wd9xh7gtxohOMw9Ffl9+JW8jOSXUjeEnMjJW+fBbKhCbjGnMVS4ShX5WOSfKDBNN1q6Ndl54DyhZHJo/TUfdUioxG9SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yw6CzIK6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yw6CzIK6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092371F000E9;
	Tue, 14 Jul 2026 23:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784072065;
	bh=Iv4SDTb8vdjr3NMUksMhxAo9AmuHtck/KrHr9GllcSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yw6CzIK6B4vf/fPLXZLOHoU6Y/k5/39obT+DUHQ19NbICFKlz066xU4t/YXWCwz+a
	 qa6bbpwyf5EUVAXf981TNduDnpxF0KiJ9POYk+l608w7/qwzf1DnHM59yoraHtyxQ2
	 zLN6UGbq7NlV6ZCn452WW/hViX3qW8w+0O8nipqUUgW5ixj0jvl97PsY3ZAs1MCh/q
	 2t8Bf/QspRfULoMevxHWA9hc0d9OCBJvP84be967emoK3ueXUX+nzFMFfzeLVVyD9I
	 V4zRv1bQiNWSoJn9KlLINkaYaZYFh8Bt6UPdGJKYcYoSi/ZUzD3u2jRE5Ov2o2QRtV
	 r2cpRcHVS2IIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/6] s390/vfio_ccw: copy maximum possible IDAL from
 guest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260714232208.1683788-5-farman@linux.ibm.com>
References: <20260714232208.1683788-1-farman@linux.ibm.com>
 <20260714232208.1683788-5-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 23:34:24 +0000
Message-Id: <20260714233425.092371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] calc_max_idal_len() returns a word count instead of a byte length,=
 causing truncated guest memory reads and silent guest memory corruption.
--

--- Patch [4]: [PATCH v1 4/6] s390/vfio_ccw: copy maximum possible IDAL fro=
m guest ---
commit 3ab642e4c4a6646b5b0bec62ab380c4cc0ea0ac2
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: copy maximum possible IDAL from guest

An Indirect Data Address word is always 2K/4K aligned (depending on
format/type), except for the first word in a list. This unaligned
word makes calculating the number of addresses in a list challenging.
The current code attempts to be efficient about this by reading the
first word before making its calculations, but it introduces
inefficiencies trying to do the math on supposedly equal values.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 74b1f25e01e72..dac53e26509e5 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -523,16 +523,24 @@ static int ccwchain_fetch_tic(struct ccw1 *ccw,
>  	return -EFAULT;
>  }
> =20
> +static int calc_max_idal_len(struct ccw1 *ccw, struct channel_program *c=
p)
> +{
> +	int idal_size =3D idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
> +	int idal_mask =3D ~(idal_size - 1);
> +	int idal_len =3D idal_size - (ccw->cda & ~idal_mask);
> +
> +	/* This overestimates for Format-1 or 2K-Format-2 IDAWs */
> +	return idal_len / 8;
> +}
> +
>  static dma64_t *get_guest_idal(struct ccw1 *ccw, struct channel_program =
*cp, int idaw_nr)
>  {
> -	struct vfio_device *vdev =3D
> -		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
>  	dma64_t *idaws;
>  	dma32_t *idaws_f1;
>  	int idal_len =3D idaw_nr * sizeof(*idaws);
>  	int idaw_size =3D idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
>  	int idaw_mask =3D ~(idaw_size - 1);
> -	int i, ret;
> +	int i;
> =20
>  	idaws =3D kzalloc_objs(*idaws, idaw_nr, GFP_DMA | GFP_KERNEL);
>  	if (!idaws)
> @@ -540,11 +548,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, str=
uct channel_program *cp, int
> =20
>  	if (ccw_is_idal(ccw)) {
>  		/* Copy IDAL from guest */
> -		ret =3D vfio_dma_rw(vdev, dma32_to_u32(ccw->cda), idaws, idal_len, fal=
se);
> -		if (ret) {
> -			kfree(idaws);
> -			return ERR_PTR(ret);
> -		}
> +		memcpy(idaws, cp->guest_idal, idal_len);
>  	} else {
>  		/* Fabricate an IDAL based off CCW data address */
>  		if (cp->orb.cmd.c64) {

[ ... ]

> @@ -586,7 +590,7 @@ static int ccw_count_idaws(struct ccw1 *ccw,
>  	struct vfio_device *vdev =3D
>  		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
>  	u64 iova;
> -	int size =3D cp->orb.cmd.c64 ? sizeof(u64) : sizeof(u32);
> +	int size =3D calc_max_idal_len(ccw, cp);
>  	int ret;
>  	int bytes =3D 1;
> =20
> @@ -596,10 +600,13 @@ static int ccw_count_idaws(struct ccw1 *ccw,
>  	if (ccw_is_idal(ccw)) {
>  		/* Read first IDAW to check its starting address. */
>  		/* All subsequent IDAWs will be 2K- or 4K-aligned. */
> -		ret =3D vfio_dma_rw(vdev, dma32_to_u32(ccw->cda), &iova, size, false);
> +		ret =3D vfio_dma_rw(vdev, dma32_to_u32(ccw->cda),
> +				  cp->guest_idal, size, false);

[Severity: High]
Does this pass a word count instead of a byte count to vfio_dma_rw()?

calc_max_idal_len() returns a word count because it divides the remaining b=
ytes
by 8. When this value is stored in size and passed to vfio_dma_rw(), it see=
ms
it will read at most 1/8th of the required IDAL data.

Later in get_guest_idal(), the code copies the full required byte length fr=
om
the partially-filled cp->guest_idal buffer:

	memcpy(idaws, cp->guest_idal, idal_len);

Could this result in copying stale or uninitialized data to the host IDAL,
causing the hardware to perform DMA to incorrect guest physical addresses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714232208.1683=
788-1-farman@linux.ibm.com?part=3D4
