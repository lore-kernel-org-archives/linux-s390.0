Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7693D6CA5;
	Sun, 26 Jul 2026 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087613; cv=none; b=tcMIfTc1N90BbDIF39H8FJe4vCf7FqgH0R1uCuDczMI6QPAxRmFc3hlMwAdxmNhy0VygcEWn9ccQ18vbgpAxAud5rdiN65SP/jnCegT5m0rP5EliPF8WD2w3H5ctQh2DtrWpIG24V+DTnahge5MnhI1APnaDrnYIpFAG7HySYjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087613; c=relaxed/simple;
	bh=tGq9Xe5djD8NEW9++dDHZWyKtzcKAaD+QxINb1rZJHk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tveQZ68eKuAk3RmylRlQZ/aTSXZM/iwifGvLXTO4C3p+noCZZ8B6yDZZ7PHZDWboEhRoJZipCZvdLUyPQq/i2TmVyNzxeu+t//J8VMZaKVt1EqyoaD/DIPEjlD7hyN/o8MN2tDigrR/HZb4IX/nhfoNkPsl8P/EQAVxpjI8wklw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5ugJpKa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5ugJpKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EC91F000E9;
	Sun, 26 Jul 2026 17:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087612;
	bh=+uMZQq1nndo5vV+rB/hzZNVRX6Auswa2CFaQ54rhkdI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b5ugJpKa/7AIF16hGbGGwnGWo20xHtWlCJXd/WC3il/L55ruwQPEJrp1eJ7yvHKuY
	 WvnzHOdBN7WZZLbel5NGQyZY0E3XwwGUFQAXxUTvqaX3u4FJc8VlLU6bt9W475+awj
	 cl0y4Pt6k4IBmYHCRDeeKY8BnjSBY0Dbz3S7bztRF6spWu9xq0Cd7sihJahYeeSyZB
	 3JoBsTP8NTQq7JuPlQtR488WyeKrfj4aASUY8NnDC/7mvLBCgWo8UmzeNXGhX4wB2u
	 bBqFEfnerfRfYLsrFLREklmVAoN9xyYjb9lFuZHdPidHJl0CtiO6Zq1q+OEnmlyEoZ
	 1Ybh2Zzdo+KDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/10] s390/vfio_ccw: ensure first IDAW remains
 constant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260726172153.1818056-5-farman@linux.ibm.com>
References: <20260726172153.1818056-1-farman@linux.ibm.com>
 <20260726172153.1818056-5-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:40:11 +0000
Message-Id: <20260726174012.37EC91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out of Bounds Memory Read in get_guest_idal for Format-1 IDALs
--

--- Patch [4]: [PATCH v6 04/10] s390/vfio_ccw: ensure first IDAW remains co=
nstant ---
commit c3bce41a8cd87ec5448bafb458598e338f70a2c4
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: ensure first IDAW remains constant

The first IDAW in a list does not need to be on a 2K/4K boundary
like all others, and so is read separately to accurately calculate
the size of the buffer needed to read the full IDAL. This commit
verifies that the address found in the first IDAW is unchanged between
reads to ensure a consistent set of IDAWs being worked with.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index af632f9d54535..6275794751cb4 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -523,6 +523,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, stru=
ct channel_program *cp, int
>  		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
>  	dma64_t *idaws;
>  	dma32_t *idaws_f1;
> +	u64 first_idaw;
>  	int idal_len =3D idaw_nr * sizeof(*idaws);

[Severity: High]
This is a pre-existing issue, but does this unconditionally calculate the D=
MA=20
read length assuming 8-byte IDAWs?

Since sizeof(*idaws) evaluates to 8 for the dma64_t type, but Format-1 IDAW=
s=20
are only 4 bytes (dma32_t), idal_len appears to be double the required size=
=20
for Format-1.

When this over-calculated size is later passed to vfio_dma_rw() in this same
function:

get_guest_idal() {
    ...
    ret =3D vfio_dma_rw(vdev, dma32_to_u32(ccw->cda), idaws, idal_len, fals=
e);
    ...
}

Could this cause valid I/O requests to fail if the over-calculated length=20
happens to cross into an unmapped adjacent guest memory page?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726172153.1818=
056-1-farman@linux.ibm.com?part=3D4
