Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D593532AABD;
	Sat, 25 Jul 2026 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993963; cv=none; b=L9vIzzUuLKvqczPqlCgRZq48PQ93aCJQmlgQXgNVOPPlruiIpCSCvgrrYUIE8AREBFRHeMFI1q9vz/Y+y7m0g6oLf5H2Z/Bg4gpOtC0xJWbvwP5rmIql3AUJY0Xq13O/aHrXKjikvmcnT2K1vu3uJpWIZsqBvO9mXP3YtYE+9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993963; c=relaxed/simple;
	bh=OJc0wcLHFROHsJjlZfqaYfaK/wjw5m+omSSQ6qKS7gc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mTdFNk/BKOv5hufL2TBSAw1E95vKbr5w8Jwn5bTqkUoTIiPtp7BY3R4ybdX5vuzXaPSh8bzDcueedXPgoQd5MWrkIxudi34zlIXsxQ5/Ur1G9dY6Fd6RKf4huV3grYglQPNqQleU08AjrzvRINj7VOqKis9v2f4WF5jwCVDV8AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyJsv2B9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyJsv2B9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3701F000E9;
	Sat, 25 Jul 2026 15:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784993961;
	bh=jVuR25+dPCJZ8ld0xYzB1jOQpGDuDHWzYqT51N+BvzU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HyJsv2B9cnGCRscEbu7lyeKPttOYcdi5NmUpvhevKdbPscAXnq2R1AMTFGAqKuDYS
	 rLrEKJ61MuzegppWKR7ABDmEERZ926FzdePycWU9GLaWLYUZdb2YGy5s+gAXC4S9HF
	 T1A6Xk+9CQJp7d9VMzB6aPmlBuqHeAPovzoVhnJINNEIigWhGzttJwWHqFn1U7vMwN
	 iaAB5nkLRoj8yzhqHTQodBTINrrPTL6uAL3VQtcQU7YnGsakRzlpBliBzCKlNukz9A
	 87gP9OImd8gWQfV6rAWvPTDpgZBQeikIiuE4QPCj40G2zgwCx56nOdTbgitCbt737h
	 zeXL7OVN5+INA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/9] s390/vfio_ccw: limit the number of channel
 program segments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260725152705.3958100-3-farman@linux.ibm.com>
References: <20260725152705.3958100-1-farman@linux.ibm.com>
 <20260725152705.3958100-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:39:20 +0000
Message-Id: <20260725153921.0F3701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `ccwchain_calc_length` function can read out-of-bounds when ev=
aluating a maximum-length CCW chain.
- [Medium] `vfio_dma_rw` unconditionally fetches exactly 2K bytes regardles=
s of actual chain length.
--

--- Patch [2]: [PATCH v4 2/9] s390/vfio_ccw: limit the number of channel pr=
ogram segments ---
commit 329c62f260a235e5ffc6e09ecde7b4928c02051c
Author: Eric Farman <farman@linux.ibm.com>
Subject: s390/vfio_ccw: limit the number of channel program segments

This commit imposes a limit on the number of channel program segments
(linked by TIC) that can exist in a single channel program. It breaks
channel programs into segments when encountering a Transfer-In-Channel (TIC)
CCW and enforces a global limit on the number of segments to prevent unboun=
ded
recursion.

[ ... ]
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
> +	/* Limit number of chains in a single channel program */
> +	if (cp->ccwchain_count >=3D CCWCHAIN_COUNT_MAX)
> +		return -EINVAL;
> +

[Severity: Medium]
This isn't a bug introduced by this patch, but does the unconditional read =
of
2K bytes in ccwchain_handle_ccw() cause valid short programs to fail?

Earlier in ccwchain_handle_ccw(), the code performs a hardcoded 2K read bef=
ore
calculating the actual chain length:

ccwchain_handle_ccw() {
    ...
    ret =3D vfio_dma_rw(vdev, gcda, cp->guest_cp,
                      CCWCHAIN_LEN_MAX * sizeof(struct ccw1), false);
    if (ret)
        return ret;
    ...
}

If a guest submits a short channel program located near the end of a mapped
memory region, and the adjacent page is unmapped, vfio_dma_rw() will fail t=
he
entire transaction instead of returning a partial read.

Could this lead to rejection of valid channel programs based on their memory
layout?

[Severity: High]
This is a pre-existing issue, but can the length calculation read out of
bounds?

In ccwchain_calc_length(), which is called just before the new limit check,
the code evaluates a maximum-length CCW chain:

ccwchain_calc_length() {
    ...
    if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
        break;
    ...
}

If a guest VM submits a channel program where the first 256 CCWs all have
the chain flag set, the loop increments the counter to 257. On the 257th
iteration, calling ccw_is_chain(ccw) reads the flags field from guest_cp[25=
6],
which is one element past the end of the allocated CCWCHAIN_LEN_MAX array.

Can an unprivileged guest trigger an out-of-bounds read by providing a
specially crafted channel program?

>  	/* Need alloc a new chain for this one. */
>  	chain =3D ccwchain_alloc(cp, len);
>  	if (!chain)
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725152705.3958=
100-1-farman@linux.ibm.com?part=3D2
