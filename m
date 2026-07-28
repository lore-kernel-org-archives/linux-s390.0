Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2C48248B;
	Tue, 28 Jul 2026 01:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203536; cv=none; b=O+lM6wenDRbV+jqWSQq8AutHmelM1dUQ+xZsE3vWnEPHah8Dy3xrkhort17M+vhhhr3siEDxROGgwPEq4zacqhg0lx0YxqFksiDbMS2QFISsrX2sn7Jc42i2Rimv7LztP4t6kIT53XTWJqAfy2ilZ3fJ2qeEFFzUsdf3dWoF67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203536; c=relaxed/simple;
	bh=uph7UgF3+37lqpFudA3rKFLdJsHUguAhEbTCy/nreSI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V1OaMOEQGkJ659yM2YMJKIlVBZ7FDmeh/SmOojCc2afy3MuQferf1xHrgR3fu2pUENcCHOmylJqFIc5fB5riCcmu+TmfrrUGChy6/MOf71g9ei+7Hd7u/cT6Dho3iIt5vDoAFaqRgoMohDw9+H9HbF8bkL3tHF2bfcjOY6+F0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IykhgPVd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IykhgPVd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95101F000E9;
	Tue, 28 Jul 2026 01:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785203535;
	bh=DHVPL9+T804LgqSnQ96TXyat6JMsizjg42G/Zw0VW/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IykhgPVddYlgsEf49/r+4dX5lE0Pdp/GK4KvJg5i67aN7eT8EYnG2Y+AUNBzpkhZI
	 wNo5+6BtNBaIjMhhre0uB8IM0H1a/fQVz6scof8Yix9xjxV6GjsJ0Mm4TeMqe1xCAS
	 T61Fl5Hw5JRlGUPnUF0P1L2ET4G4+wA7QZs9L6ns6E9SfrQKD8UNqUmJXWi1sCGwuQ
	 QYZfxgJ120yjms7hQyZQMiNuPolf4rOR0tI/EW4LN4rjVslCPK4x0hiOQXWmBYn0qe
	 /YwAPL0bdzhNV8VGyS4KwjHjQZKgw9grarZLrFVXffPfOFSb9g/PvyXEzYXMktQpBe
	 tyJuu33iXj1AQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/10] s390/vfio_ccw: limit the number of channel
 program segments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260728013509.1551753-3-farman@linux.ibm.com>
References: <20260728013509.1551753-1-farman@linux.ibm.com>
 <20260728013509.1551753-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 01:52:14 +0000
Message-Id: <20260728015214.C95101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A malicious guest can trigger a host kernel out-of-bounds read=
 and potentially execute DMA to arbitrary host physical addresses by concur=
rently modifying the first IDAW in a channel program.
- [High] An off-by-one error in `ccwchain_calc_length` causes a determinist=
ic out-of-bounds read when processing a channel program with exactly `CCWCH=
AIN_LEN_MAX` chained CCWs, which can crash the host if KASAN is enabled.
--

--- Patch [2]: [PATCH v8 02/10] s390/vfio_ccw: limit the number of channel =
program segments ---
commit 8d46ac3adbb3bfeb184e8057b932faa35fe79719
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: limit the number of channel program segments

The processing of channel programs, and the CCWs within them, is done
recursively. As such, there is an arbitrary (but not architectural)
limit to the number of CCWs that can exist in a single channel program.
The vfio-ccw logic breaks these channel programs into segments whenever
it encounters a Transfer-In-Channel (TIC) CCW, and the combined number
of segments count towards the global limit. Impose an equivalent limit
to the number of segments until such logic can be made non-recursive.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 086d1b54bdb05..1c2890d139c6b 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c

[ ... ]

> @@ -441,6 +442,10 @@ static int ccwchain_handle_ccw(dma32_t cda, struct c=
hannel_program *cp)
>  	if (len < 0)
>  		return len;
> =20

[Severity: High]
This is a pre-existing issue, but does ccwchain_calc_length() have an
off-by-one error leading to an out-of-bounds read?

When a guest provides a channel program with exactly CCWCHAIN_LEN_MAX chain=
ed
CCWs, the do-while loop in ccwchain_calc_length() executes 256 times:

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_calc_length() {
    ...
    } while (cnt < CCWCHAIN_LEN_MAX + 1);
    ...
}

This increments cnt to 256 and advances ccw to point to guest_cp[256].
Since the loop condition (256 < 257) evaluates to true, the loop executes
a 257th time, dereferencing ccw in !ccw_is_chain(ccw). Since guest_cp is
allocated with exactly 256 elements, this read crosses the slab boundary.

Could this crash the host if KASAN is enabled?

[Severity: Critical]
This is a pre-existing issue, but can a malicious guest trigger an
out-of-bounds read and potentially execute DMA to arbitrary host physical
addresses by concurrently modifying the first IDAW in a channel program?

When fetching a guest CCW, ccw_count_idaws() performs the first fetch from
guest memory to calculate the required array size:

drivers/s390/cio/vfio_ccw_cp.c:ccw_count_idaws() {
    ...
    ret =3D vfio_dma_rw(vdev, dma32_to_u32(ccw->cda), &iova, size, false);
    ...
}

It then calls get_guest_idal(), which allocates a kernel buffer and reads t=
he
entire IDAL from guest memory again into the undersized kernel buffer:

drivers/s390/cio/vfio_ccw_cp.c:get_guest_idal() {
    ...
    ret =3D vfio_dma_rw(vdev, dma32_to_u32(ccw->cda), idaws, idal_len, fals=
e);
    ...
}

If a guest provides a page-aligned first IDAW during the first fetch, and
concurrently modifies its memory so the second fetch reads a misaligned fir=
st
IDAW, the hardware will require more IDAWs than originally allocated.

Does this cause the hardware to read past the end of the idaws kernel buffer
and interpret adjacent memory as host physical addresses for DMA?

> +	/* Limit number of chains in a single channel program */
> +	if (cp->ccwchain_count >=3D CCWCHAIN_COUNT_MAX)
> +		return -EINVAL;
> +
>  	/* Need alloc a new chain for this one. */
>  	chain =3D ccwchain_alloc(cp, len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728013509.1551=
753-1-farman@linux.ibm.com?part=3D2
