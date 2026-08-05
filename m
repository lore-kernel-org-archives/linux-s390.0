Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4069447252A
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942668; cv=none; b=pIQpayjl+xpTWNnyo6KgvYOU4zc9jgdYAjgI1wROHgmakBRyykoLLD8+o/vo7O/+Dkx/KbxfbZdifbio06PreSCMAaWd2xBkA1QK7TwISZeYf0m7jKlKCQSwdCarUbcDGeU6F8XRfCgbXI2relUQLa8T+XwEqzbnChF1v9i8ekc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942668; c=relaxed/simple;
	bh=/ywmdSb1NbdoFRowtode9ciCUS3ip7nkNfqOmgr6HsE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kCzWWgTM6YUM3N3uMxFvwu1D+tt6XN2j0R8+4bf8pPx3GBuPGKFNA7JASEM5TwERi+yMoUVpVIYJZ2JRv2PwvIHWm8M6QuFQ/rw18+1HDxcBN20hjq83FB36mFeyBe64i66PPATy9UL5QJ8hz6E9Jdx3LKS6h+Rx6GSkqxjFCGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqUf4HlN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqUf4HlN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F361F000E9;
	Wed,  5 Aug 2026 15:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785942666;
	bh=nPRdcDR/Pu/hhbUkO4F8z5eJ7GCYGZdOwH1LMstoFgw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dqUf4HlNzsh2/LrJDOjs3rV+gn9fwuyYVNeFclbnkkUVW9nnjw1saNrbV8QhBRavO
	 ESs8Yo6HuRenXwSkrQmOXRBqIx3uGQ3l77A0LDYCHPVbRF5k30Jt+obJOdoSV7VrAS
	 0EaUjzGUARDyaaqtIKxTAKMXMosfW29APUrLxU3XPJw/0W3H7NTaBY7wn+Tc31onfT
	 8E3sDniWMiNo027Y9EmjwwqI0bs8Hf6FL/Ryy5wkfl7JohfCrg3d+5dIXDHC0NXbMj
	 OH2tiyKQJ3hLwUb5fSNFB1fh1SEmBGc814xV8/eUwICbQfViKS5B/Iw7YQKpy0Ghhz
	 D9hoC/puj42Cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/19] s390/dasd: Add range-based format-track collision
 detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260805111612.1285190-10-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-10-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 15:11:05 +0000
Message-Id: <20260805151106.47F361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Removing the `trkcount` snapshot protection before the new col=
lision detection becomes active leaves a window for data corruption via dou=
ble-formatting.
- [High] Defensive check `if (!cqr->block)` introduces a guaranteed NULL po=
inter dereference on its error path.
--

--- Patch [9]: [PATCH 09/19] s390/dasd: Add range-based format-track collis=
ion detection ---
commit 1e9c1dce6a9ae6f45c013547038cfe3ae41af93a
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Add range-based format-track collision detection

Replace the single per-device format_entry slot with an array of 16
slots so multiple format requests can be in flight at once. This also
rewrites test_and_set_format_track() to check range overlaps and removes
the older trkcount snapshot logic.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -1402,13 +1402,6 @@ int dasd_start_IO(struct dasd_ccw_req *cqr)
>  		if (!cqr->lpm)
>  			cqr->lpm =3D dasd_path_get_opm(device);
>  	}
> -	/*
> -	 * remember the amount of formatted tracks to prevent double format on
> -	 * ESE devices
> -	 */
> -	if (cqr->block)
> -		cqr->trkcount =3D atomic_read(&cqr->block->trkcount);
> -
>  	if (cqr->cpmode =3D=3D 1) {

[Severity: Critical]
Does removing this trkcount snapshot before the new collision detection is
active introduce a regression where concurrent threads could double-format=
=20
tracks?

The commit message notes the new collision detection only becomes active
later in the series. By removing the older trkcount protection here,
it seems we might be introducing a bisection hole. For instance, if
thread B completes a format and removes the track from format_list, could
thread A's ERP routine see an old No Record Found error and proceed to
format the track again, erasing thread B's data?

[ ... ]

> @@ -2880,6 +2873,28 @@ static void __dasd_process_block_ccw_queue(struct =
dasd_block *block,
> =20
>  static void dasd_return_cqr_cb(struct dasd_ccw_req *cqr, void *data)
>  {
> +	struct dasd_ccw_req *temp_cqr;
> +	struct dasd_block *block;
> +
> +	/* only format CQRs are candidates */
> +	if (!cqr->block || unlikely(!cqr->format))
> +		goto out;
> +
> +	block =3D cqr->block;

[ ... ]

> +out:
>  	dasd_schedule_block_bh(cqr->block);
>  }

[Severity: High]
If cqr->block is NULL, the if statement above evaluates to true and jumps
to the out label. Would this result in a regression with a guaranteed NULL
pointer dereference when dasd_schedule_block_bh() unconditionally accesses
it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D9
