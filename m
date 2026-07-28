Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BB4378D94;
	Tue, 28 Jul 2026 03:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211194; cv=none; b=kMtu1x+0wLbF0KCqGzLVMHPiv6m+y71vLQdEWKiqIxhS31KKMun9I+So5u353E/4OJd87I6WDYktSnlmSxZjSJaoelOxE4Z90NJCRPZa2yYuqcbxNYf4gUa+xA6taGuW664CzsiOwCmp5BV4MmkcL/4qfDn1ctR5hoN9RPQugto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211194; c=relaxed/simple;
	bh=anDSb8BbAzDx5ymFFe8mrT0uOvEQIDLheJzXixVDez0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X6SVVxBHSvV37+3iwlMxMSJrbIeDsAoVNEEKgvU4TVTKegcXayElo0I0BnhX5NtHG0MYNQQFoCQu+gLzsWr/x6EtjqqxFHG3Ln3jJe2EBYM2/VlyOkbYwCIn/MZ0TpX6inSwoADWwjSrEC2AjuvxCh9CZjJYq7wZHtcYTcus8Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIpzbDQF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIpzbDQF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EC51F000E9;
	Tue, 28 Jul 2026 03:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211191;
	bh=VMPUzaQEqOMO7T72kl2aKv2Xe03IxXhIjZ2XwwS5UQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GIpzbDQF5LzmLjn2OVJEZr9tDgK9JEQETTTuriHmz/GDOCwYAHH9ntLD7DsNBJjxR
	 VDaTGg1eYhhtKdl8s3MirJfnqIQKnM8JKaVdg/UPQPZtvtthob3V8DtaFnsWujO340
	 ULuK3PtSYyX1vZUR6iJQVXxHMTp4OjVX0TpHknldp5HkbtfYxikZs7+SXl92lBIkaS
	 rAKww2VC64mxT0uQsnajKZrBpv8kjO+yrkCQQDvSno4bS5gn4IapegdOdmu/DdELuD
	 SThLddtKTKFoT+asFp5+g91cBOEWuHv2L4ceYntAGJQwu+nGhUyCucZDNNkI8p9ZmQ
	 US7+raFg0PFRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 03/10] s390/vfio_ccw: fix out of bounds check on CCW
 array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260728033022.2658232-4-farman@linux.ibm.com>
References: <20260728033022.2658232-1-farman@linux.ibm.com>
 <20260728033022.2658232-4-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 03:59:50 +0000
Message-Id: <20260728035950.D0EC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A preexisting logic flaw allows a guest to cause the host's Ch=
annel Subsystem to execute out-of-bounds memory as a Channel Command Word (=
CCW), potentially leading to arbitrary host memory corruption via DMA.
--

--- Patch [3]: [PATCH v9 03/10] s390/vfio_ccw: fix out of bounds check on C=
CW array ---
commit 622cd15d4520f97b7f1bb4f1d15867ddea2a23a6
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: fix out of bounds check on CCW array

This commit modifies the loop in ccwchain_calc_length() to fix an
out-of-bounds array access that could examine the 257th CCW before failing.
It changes a do..while loop to a for loop to strictly bound the CCW array
examination.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 1c2890d139c6b..af632f9d54535 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
[ ... ]
> @@ -377,11 +377,9 @@ static void ccwchain_cda_free(struct ccwchain *chain=
, int idx)
>  static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
>  {
>  	struct ccw1 *ccw =3D cp->guest_cp;
> -	int cnt =3D 0;
> -
> -	do {
> -		cnt++;
> +	int cnt;
> =20
> +	for (cnt =3D 1; cnt <=3D CCWCHAIN_LEN_MAX; cnt++, ccw++) {
>  		/*
>  		 * We want to keep counting if the current CCW has the
>  		 * command-chaining flag enabled, or if it is a TIC CCW
> @@ -391,15 +389,10 @@ static int ccwchain_calc_length(u64 iova, struct ch=
annel_program *cp)
>  		 * after the TIC, depending on the results of its operation.
>  		 */
>  		if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
> -			break;
> -
> -		ccw++;
> -	} while (cnt < CCWCHAIN_LEN_MAX + 1);
> -
> -	if (cnt =3D=3D CCWCHAIN_LEN_MAX + 1)
> -		cnt =3D -EINVAL;
> +			return cnt;

[Severity: Critical]
This is a pre-existing issue, but does this calculation adequately account =
for
the hardware's behavior of skipping a CCW when a Status Modifier is present=
ed?

If a guest submits a channel program where a CCW that can generate a Status
Modifier (like a Search CCW) has the command-chaining (CC) flag enabled and=
 is
followed by a TIC CCW that lacks the CC flag and jumps to a different chain,
the loop will stop counting at the TIC because both !ccw_is_chain(ccw) and
!is_tic_within_range(...) are true.

In this scenario, ccwchain_calc_length() returns a length of exactly 2. The
host would then allocate 16 bytes for chain->ch_ccw from the DMA heap. When=
 the
hardware executes the first CCW and encounters a Status Modifier, it skips =
the
TIC and fetches the next CCW from 16 bytes into the allocation, which is
out-of-bounds of the host's DMA heap allocation.

By grooming the host heap, could a guest place controlled data adjacent to =
this
allocation, which the hardware would then execute as an untranslated CCW,
potentially leading to arbitrary host memory corruption via DMA?

> +	}
> =20
> -	return cnt;
> +	return -EINVAL;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728033022.2658=
232-1-farman@linux.ibm.com?part=3D3
