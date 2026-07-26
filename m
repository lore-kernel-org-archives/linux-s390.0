Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6B2299A87;
	Sun, 26 Jul 2026 04:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785039323; cv=none; b=srwBASdgQjz4JqSCfKPxcifOF5m3b+2KrbKGT/RSMDoXknjkhkpChiLFj/AMfpEkzhpdbCKTsbDAX5xsYKEqXZ0GwKsGIukNZs14d37N4/3pkRTvWYpxmQ4Kb5LLMwSVvqO2ISdLKePy9WdbuIVflclJx1BJtCTRnkrfu/55XOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785039323; c=relaxed/simple;
	bh=EL/vioQNl5VQuIgW9pliRPuIX7VtdQi4NqEICqVepls=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hWAu1bt84f6b8xIM7eO6vTv2XylAgMv8ZZrxdGm8pJgoRdz0yEcLlJNRs3ybk41rCaqD0yF77CsWVB6azsYLw+g1C80pPfUB3k+p2cYNwf85n5O8EAqZyEqd/LwFHMsx3CoNnQv2c9KbNadxcIx0l+dYqcZyH7DheCVlGV5TxLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIWWFMIv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIWWFMIv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C703F1F000E9;
	Sun, 26 Jul 2026 04:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785039319;
	bh=Em3x0raK1bUVUVT5B+3QhNZzLs8isOWGyM2Fxan4mAs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HIWWFMIvAXHpIreZ3SM8Hh+viTvnr3AGMm2sQBdvFx5LC7dNigj8Ze36IB5HIJN7Y
	 8qASbTxD8bMSdi49brfN8Mnz9U2ltz6RrhRfFUnYLv8KPANDOVwQz5YgP+AKNe8UhC
	 wvaUrIs5ZHsW3JcAirGaUhkeHTplff0jzhegtddNYgp1tLgt+SqUnOf56mhpBVEP8k
	 m4Tc3eq1J1nI629Hhhv4FtuSbXNt10hiNyD8bRc71h3hD94vZxmYu+Q3msW4Ht1X2P
	 jCCL9PDI8ZD7RYO7VseTh8mEe+YcvaevNvZvoZmFWk1zompKcJcPNp8PFev0ihghwU
	 rWnpSHcbd2ADg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/10] s390/vfio_ccw: free all memory if cp_init()
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260726040129.2946151-2-farman@linux.ibm.com>
References: <20260726040129.2946151-1-farman@linux.ibm.com>
 <20260726040129.2946151-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 04:15:18 +0000
Message-Id: <20260726041518.C703F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded mutual recursion between `ccwchain_handle_ccw` and `ccwc=
hain_loop_tic` can lead to kernel stack exhaustion.
- [High] Out-of-bounds read of `cp->guest_cp` in `ccwchain_calc_length`.
--

--- Patch [1]: [PATCH v5 01/10] s390/vfio_ccw: free all memory if cp_init()=
 fails ---
commit fee68998110983d79a8ac5ec5666d53fcd26abad
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: free all memory if cp_init() fails

The commit addresses a memory leak in the channel program initialization
process. It moves the cleanup of allocated CCW segments out of the
recursive ccwchain_handle_ccw() logic into a new wrapper function
ccwchain_build_ccws(). This ensures that all segments are freed if an
error occurs.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 7561aa7d3e017..086d1b54bdb05 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -455,9 +455,6 @@ static int ccwchain_handle_ccw(dma32_t cda, struct ch=
annel_program *cp)
>  	/* Loop for tics on this new chain. */
>  	ret =3D ccwchain_loop_tic(chain, cp);

[Severity: High]
This is a pre-existing issue, but can this unbounded mutual recursion lead =
to
kernel stack exhaustion?

If a malicious guest constructs a channel program consisting of a long sequ=
ence
of forward-jumping Transfer in Channel (TIC) commands that do not loop back=
 to
previously processed chains, it could trigger unchecked mutual recursion.

When the guest issues an SSCH instruction, the host kernel intercepts it and
evaluates the program. ccwchain_handle_ccw() calls ccwchain_loop_tic(), whi=
ch
in turn calls ccwchain_handle_ccw() for any new segments:

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_loop_tic() {
	...
		/* Build a ccwchain for the next segment */
		ret =3D ccwchain_handle_ccw(tic->cda, cp);
		if (ret)
			return ret;
	...
}

Since there is no enforced limit on the recursion depth or the total number=
 of
chains, a long sequence of non-cyclic TICs could cause uncontrolled mutual
recursion, exhausting the kernel stack and causing a host panic.

[Severity: High]
This is also a pre-existing issue, but does ccwchain_calc_length() have an
out-of-bounds read vulnerability?

When ccwchain_handle_ccw() allocates cp->guest_cp, it copies a maximum of
CCWCHAIN_LEN_MAX (256) elements:

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_handle_ccw() {
	...
	ret =3D vfio_dma_rw(vdev, gcda, cp->guest_cp,
			  CCWCHAIN_LEN_MAX * sizeof(struct ccw1), false);
	...
	/* Count the CCWs in the current chain */
	len =3D ccwchain_calc_length(gcda, cp);
	...
}

However, in ccwchain_calc_length(), the do-while loop condition allows up to
CCWCHAIN_LEN_MAX + 1 iterations:

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_calc_length() {
	...
	do {
		...
		ccw =3D cp->guest_cp + cnt;
		...
		if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
			break;
		...
	} while (cnt < CCWCHAIN_LEN_MAX + 1);
	...
}

If a malicious guest submits a channel program where the first 256 CCWs all
have the command-chaining or data-chaining flags enabled, the loop will not
break early and will execute a 257th iteration.

During this iteration, ccw points to the 257th element (index 256), and
ccw_is_chain(ccw) reads its flags byte. This reads past the 2K allocation
boundary, potentially triggering a host kernel panic or memory safety tooli=
ng.

> =20
> -	if (ret)
> -		ccwchain_free(chain);
> -
>  	return ret;
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726040129.2946=
151-1-farman@linux.ibm.com?part=3D1
