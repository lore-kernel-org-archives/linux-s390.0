Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EEE3E3C7B;
	Thu, 23 Jul 2026 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831178; cv=none; b=ekRGd4o5RQK6JkzBtWo8iYaHVzE69Ey7GMgWaNKSi5bnQ4mgF2PU5jcyT+lyPAxVJf4yjb7H2+6Ylt1I7nzyn56DHIeZi/Ty9QIX8GWoFvYbp6445Udx3T+XX7bSxRXXgay1MS6mRSj/10tcw2b/5Ff1LBOfPCO1Mszl/i7YZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831178; c=relaxed/simple;
	bh=bfQ93CfVDtXL/rlAXYO77XGsfSmUjhxfbE50Klmh6yg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kFdeySMoXXM6v9uof67db0N7A5YImb35QWVvutIgUc+Re0eECeW/SMgCiZ2gydqQinmMYu0HE/Kh30se3VuBxtNl8aW8R8BfXd/BDADb3vz1nMeIuhb1chxCSTxbBjP6k0rFNQT4xPB3f2R3WQBpUNlVaOjOHMkQ8aWFvL8u5Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMGnUdNc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMGnUdNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE1F1F000E9;
	Thu, 23 Jul 2026 18:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784831168;
	bh=1jiHYqqramL44FEP0XcS4qB+Yw1VD7T4baEsYw5Qsoc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eMGnUdNc2lxXhblyBfl0fjQ9ZtatkmEa+CKhdUax8jfZF3KkKnjBN0ukPtp4SYcr7
	 Ggj2iKoFl+yBbFW4qGR+ilU9JDDdDPp3vQAmRlSrcsqlUwRwQN5F/LoHvcLhBl6IP6
	 5q1sH/UZem5TvYjLBPg884GD/4Y26oyUps4bvH/3t/uQQNU1g5dgOfDPXUGSBXxnKw
	 jedmuLUFxbdiXXAUD33ZoVyLJVD51UxhUDMv2r/RtvOF0whY7On2RAYut/ocbslPOb
	 KglQb/YL0G6UUBXtcbg7dU6ORQvYeuaNyI98mA6hqbv70fBRYdxyEg4TswdGS1qlmt
	 uBsyZrc5rPsew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/8] s390/vfio_ccw: limit the number of channel
 program segments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260723174751.1180334-3-farman@linux.ibm.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 18:26:07 +0000
Message-Id: <20260723182608.3BE1F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Off-by-one error in ccwchain_calc_length allows a guest-triggered =
out-of-bounds read.
--

--- Patch [2]: [PATCH v3 2/8] s390/vfio_ccw: limit the number of channel pr=
ogram segments ---
commit b0f514e864a35fcb11c0505d666fd9d7fbad12c0
Author: Eric Farman <farman@linux.ibm.com>
Subject: s390/vfio_ccw: limit the number of channel program segments

This commit limits the number of channel program segments that can exist
in a single channel program. It breaks channel programs into segments
when it encounters a Transfer-In-Channel (TIC) CCW, and adds a check to
ensure the segment count does not exceed a global limit. This prevents
hitting an arbitrary limit due to recursive processing.

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
This isn't a bug introduced by this patch, but does ccwchain_calc_length()
contain an off-by-one error that allows a guest-triggered out-of-bounds rea=
d?

When a guest VM submits a channel program containing a sequence of 256 CCWs
with the command-chaining or data-chaining flag set, the driver handles
this request and calls ccwchain_calc_length() to parse the chain.

The array cp->guest_cp is allocated to hold exactly CCWCHAIN_LEN_MAX (256)
elements. However, the loop in ccwchain_calc_length() uses the condition
while (cnt < CCWCHAIN_LEN_MAX + 1):

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_calc_length() {
	do {
		cnt++;
		...
		if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
			break;

		ccw++;
	} while (cnt < CCWCHAIN_LEN_MAX + 1);
}

Does this allow the loop to iterate up to 257 times? During the 257th
iteration (cnt =3D 257), does the pointer ccw advance past the end of the
cp->guest_cp array, causing the ccw_is_chain(ccw) macro to dereference
an out-of-bounds pointer to read ccw->flags?

Could this lead to a kernel heap out-of-bounds read and subsequent kernel
panic if KASAN is enabled, allowing an unprivileged guest to impact host
stability?

> +	/* Limit number of chains in a single channel program */
> +	if (cp->ccwchain_count >=3D CCWCHAIN_COUNT_MAX)
> +		return -EINVAL;
> +
>  	/* Need alloc a new chain for this one. */
>  	chain =3D ccwchain_alloc(cp, len);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723174751.1180=
334-1-farman@linux.ibm.com?part=3D2
