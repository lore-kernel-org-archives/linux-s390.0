Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CCD36196A
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948511; cv=none; b=dzb4Qlytsa96X+ObnLkxRg8V+OlMTQqXL/894Jlz3hHhe+lgmrRoYnda7h/BOppbG0LggNAAE8GYimlB45IHB8SmS0eciQ6kpZwOEulpWses/J5b2JO7oewbuKB1su7wzDA/gY49HuYLWLY5HxoDvIPAAFXC7jhc7Ht/+VBjPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948511; c=relaxed/simple;
	bh=ei2JCicnGHxDokgd1CWbPX9R4+yi33xt3Ov3EzSJJWI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lGPMP8fDfBmlS8uUb5MIHYqw1HlufmYaqFe9Uhj9ivcyKKKbLwjYwujG0TRz1OI2/uiPqh/olpZUelP/MOumk/YhSRaFlsDU5cpi8sodj5DeIMu+1jtqErZoqn/frkEDCn3m9VENpEJY6JszOStSDT5K1yA1fcMTpX3UEWOnv38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F090X6nD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F090X6nD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D741F000E9;
	Wed,  5 Aug 2026 16:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948510;
	bh=WegASUQh0WCIPdVcO3QmVLBx69xW19WgVlyjfzqQA9s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F090X6nDx9+e2kw0r/Qzw5jZWLYQKKiD0INTmY8L7TOGXz2geX+oN45noprtTRazC
	 48g3/shz3VRBcIjj0OPQ4A9KfEj1LVM1ZISnFsLNHSwzNk6M7+X1aK9oFG02Jsrrgk
	 mWMsuihsOvAJ5ruFh7PXpoZoE7JQSAv9FgRLMZchA5P85YP+hdF9Wr1nV3v1NPQa2/
	 EXYVjmQLBiq+gmZ7bBrcoTeoZDGQr9Snd3mSnTi66eiX+nPmc9/WC6KpgGWd+GEaTt
	 IWlKFlVGGHemvUpUm5UApaxAmPlZ1M0/UO7ZItbrCK5/Vu8m4zKv/bo2dukiagjfur
	 +XKRSN8+vVJpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/19] s390/dasd: Derive adaptive ESE fulltrack
 heuristic from ft_bias
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260805111612.1285190-15-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-15-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:48:29 +0000
Message-Id: <20260805164830.21D741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Concurrent IOs bypass the lockless exclusion in `dasd_ese_heuris=
tic_tick`, causing multiple threads to execute state transitions and corrup=
ting the heuristic's state and backoff intervals.
--

--- Patch [14]: [PATCH 14/19] s390/dasd: Derive adaptive ESE fulltrack heur=
istic from ft_bias ---
commit e9a2e43413ef73d4ffb3fe2ea3f44d65c5f79bff
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Derive adaptive ESE fulltrack heuristic from ft_bias

Derives adaptive ESE fulltrack heuristic parameters from ft_bias to
locklessly switch between fulltrack and plain writes based on device
sparseness.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 067ab66209b65..62c03c4787c83 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[ ... ]

> @@ -3231,6 +3240,69 @@ static void clear_format_track(struct dasd_format_=
entry *format,
>  	spin_unlock_irqrestore(&block->format_lock, flags);
>  }
> =20
> +/*
> + * Adaptive ft_bias heuristic, called once per IO from dasd_eckd_build_c=
p().
> + * Probes the device formatting state by briefly switching to ft0 and me=
asuring
> + * the NRF rate; parameters are derived from ft_bias.
> + */
> +static void dasd_ese_heuristic_tick(struct dasd_device *basedev)
> +{
> +	int ios, nrf, rate;
> +
> +	if (atomic_inc_return(&basedev->ese_io_cnt) < (int)basedev->ese_probe_i=
nterval)
> +		return;
> +
> +	/*
> +	 * One wins the race to evaluate, the rest see ios =3D=3D 0 after the
> +	 * xchg and return early, preventing redundant state transitions.
> +	 */
> +	ios =3D atomic_xchg(&basedev->ese_io_cnt, 0);
> +	if (ios <=3D 0)
> +		return;

[Severity: Medium]
Can this lockless exclusion logic be bypassed if a third thread increments
the counter right after the first thread clears it?

If Thread A and Thread B both pass the atomic_inc_return() threshold check
concurrently, they will both proceed to the atomic_xchg().

If Thread A executes atomic_xchg() first, it resets the counter to 0 and
proceeds to evaluate the state machine.

If Thread C then calls dasd_ese_heuristic_tick() and increments the counter
from 0 to 1, it will return early because it is below the threshold. Howeve=
r,
Thread B could then execute its atomic_xchg() and receive 1.

Since 1 is greater than 0, Thread B will also pass the ios <=3D 0 check and
evaluate the state machine concurrently with Thread A.

Could this concurrent execution corrupt the heuristic state and backoff
intervals, causing premature transitions (for example, from FT1_ACTIVE to
PROBING)?

> +
> +	switch (basedev->ese_probe_state) {
> +	case DASD_ESE_HEU_FT1_ACTIVE:
> +		/* Start ft0 probe window, reset NRF counter for clean measurement */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D14
