Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE6341D655
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163527; cv=none; b=NVGq0sCnbYs2gPibOiqAnOzz0dbLtanzJYTN6QfjxZov2d+WtxEz+1EqY3sp3aLI3LU4vk5prFfOVsTsxCD2MnyZVlWXMtSuos+SW8a2wS3iWycluiaUCA+cA9sMR/vDP2Wfg0wSf3aXEALMmH/cdHkcEvVrFuDuJ0n57dX3BSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163527; c=relaxed/simple;
	bh=6njMrcXskTNnsjom7IBu9nKTCQxp9raadtBGfB0Utjg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bo86CQwM8sFTI3thNkOlA7jUPBy5NLmzOwW9WycnJ/4/omBCilAePPHUgG8p0P1YPzfqbFX5NO6xzA3E5h6hSEWWK2VIGiwk/zvJTouLNkNG3YoPRq3y618lrZtkMVqqIoVC05HNMfw7ngAQvaxRUWc2r0AJxlQT4VFoHrdq4lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAvVipxy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAvVipxy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088ED1F00A3D;
	Mon, 27 Jul 2026 14:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163525;
	bh=OgbViO4n2RJjszbYTFiq7RMxm8kwZJT0St9i4pPPXF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fAvVipxyagjlvP5vhouJb0MAC1fVcyg7bNIc56PvfGrhPDCwUIdku0KbrEiwCNRIN
	 H9llF5weZeLbZtSXJL5Xg1aK7RWLkvz0/hNBnLNoOefx0KfqlUKwjgw/SIBEbktIjj
	 hutpJUpCHkd3OdQIBjei7RHfpLgvSlQ6UzD+nWZRoLrCG2zLwqWLtYZXXkgwciSDYy
	 uAFljuL0ZoJF1UlPgp/T0efHjYhuMtzZ0qAY/lbm7DsiUsQ/Xt/BXiXI2tKQeaJWUI
	 oH55tP7qqvlDYX1dpi9SRPucOb1CC6ah4isxde3Ru+i2VaiuEuUdgzjZhiQVNYRG4z
	 a8n1tWRrNJnPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] s390/dasd: Fix undersized format-check buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260727142840.567286-4-sth@linux.ibm.com>
References: <20260727142840.567286-1-sth@linux.ibm.com>
 <20260727142840.567286-4-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:45:24 +0000
Message-Id: <20260727144525.088ED1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but missing input va=
lidation allows an unprivileged user to trigger a massive memory allocation=
, leading to a stack trace or kernel panic (if panic_on_warn is enabled).
- [High] This problem wasn't introduced by this patch, but out-of-bounds ar=
ray reads occur in the while loop parsing trailing zeroes in the format buf=
fer, potentially leading to a kernel panic.
--

--- Patch [3]: [PATCH 3/3] s390/dasd: Fix undersized format-check buffer ---
commit fff320f435d672762ac313457acd2d29da83d443
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Fix undersized format-check buffer

This patch fixes an issue where a 64-bit calculation for a buffer size was
silently truncated to a 32-bit integer. By using a size_t and checking for
multiplication overflows, it prevents undersized allocations that lead to
out-of-bounds writes.

Cc: stable@vger.kernel.org #4.7

> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[ ... ]

> @@ -3490,7 +3491,9 @@ static int dasd_eckd_check_device_format(struct das=
d_device *base,
>  	rpt_exp =3D recs_per_track(&private->rdc_data, 0, cdata->expect.blksize=
);
> =20
>  	trkcount =3D cdata->expect.stop_unit - cdata->expect.start_unit + 1;
> -	fmt_buffer_size =3D trkcount * rpt_max * sizeof(struct eckd_count);
> +	if (check_mul_overflow(trkcount, rpt_max, &fmt_buffer_size) ||
> +	    check_mul_overflow(fmt_buffer_size, sizeof(struct eckd_count), &fmt=
_buffer_size))
> +		return -EINVAL;
> =20
>  	fmt_buffer =3D kzalloc(fmt_buffer_size, GFP_KERNEL | GFP_DMA);

[Severity: High]
This is a pre-existing issue, but since the track range start_unit and
stop_unit are user-controlled via the ioctl, could an unprivileged user
still trigger a massive memory allocation request here?

Without the __GFP_NOWARN flag, passing an extremely large size to kzalloc
will log an allocator warning, which can panic the kernel if panic_on_warn
is enabled.

Should we add __GFP_NOWARN to this allocation, or enforce a stricter upper
bound on trkcount?

[Severity: High]
This is also a pre-existing issue, but do we have an out-of-bounds array
read later on when evaluating the tracks from this same format buffer?

Looking at dasd_eckd_format_evaluate_tracks() called when processing
these tracks in transport mode:

drivers/s390/block/dasd_eckd.c:dasd_eckd_format_evaluate_tracks() {
    ...
            while (fmt_buffer[pos].record =3D=3D 0 &&
                   fmt_buffer[pos].dl =3D=3D 0) {
                if (pos++ > max_entries)
                    break;
            }
    ...
}

Since the loop condition evaluates fmt_buffer[pos] before checking if pos
exceeds max_entries, it seems we can read past the end of the allocated
fmt_buffer array.

Additionally, this out-of-bounds pos index is passed to
dasd_eckd_count_records(), resulting in another unconditional out-of-bounds
read:

drivers/s390/block/dasd_eckd.c:dasd_eckd_count_records() {
    ...
    head =3D fmt_buffer[start].head;
    ...
}

Could this trigger memory safety warnings or a kernel panic if the read
crosses into an unmapped page?

>  	if (!fmt_buffer)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727142840.5672=
86-1-sth@linux.ibm.com?part=3D3
