Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0E442AF8F
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816001; cv=none; b=dQK1zeuBqXSqcg3670yyaTTx9r2idufIv90iHn2rTasjXx1eg/gL14l/3hEzZ1wFGiiewqOcUfsJBhKv4StHjgQ243nfdYqsVzE8wpP83WytQSnOa2z7ykRU8vNHArqcE5TXHIWhD3H80T9LVbBKNlEANGigEwy7DA1Wshy53qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816001; c=relaxed/simple;
	bh=LIOkG7idHOgST+pJXjztS1UG+IIyB5pEJRsUuH4LciI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=me+JWzurZ/55EpSlGNX3itlki2WXFeOSRPOmULzQu9HHjwvXBpGK2vyuC8bHk+F1siTK7pu079qWIV6Do/kDOd0p0OA7Wnui0WCS/joPtg8htyx1eKKDAwXl0Q1zz63W61bVuXBwopGblNlX70Q6RrJ0c9JFUopJHyvpDNMhsQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=At99WPgi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="At99WPgi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F111F000E9;
	Thu, 23 Jul 2026 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784815992;
	bh=OiKUdhFXNE8T/fztGZ+qzp10k8N7f8hMWBv+V7UuWyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=At99WPgi1HpaenA5n4msy0v+T9Fu0ITXCSPxQFTndeNldlcNrU1fmtGjgzzwV7g3Q
	 p+dr/uf9+5VoVBaqWjgWbsK8SX345vWKtHOquI3VriaR3wTp1g+ZlIOpmV1bBgYZc/
	 z1MKaM9Y/rKsQDwgUsagAmwI5C+k/Awboc14oCj7pwFliK1mAc8TsWWhAykzFtl8TK
	 0eOr8mBtNygy0msYwYXxDNbclgoh+CoPZa+tsAx8ZVh5aiNTDStzoNW6rL5aHaPkA0
	 JHaPAtVJ52yM3Ix5vs0oYvc4/oqv1Ui52iV3IUeSZ4AcsdxDyc2h65u2CO7cm6fccM
	 FdBWRTtzy+T+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/13] s390/dasd: Add range-based format-track
 collision detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260723134743.672413-4-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
 <20260723134743.672413-4-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 14:13:11 +0000
Message-Id: <20260723141312.37F111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Uninitialized track range fields in data requests break collis=
ion detection.
- [High] Unreachable collision detection logic due to incorrect callback.
- [High] Collision detection loop ignores queued requests, skipping the one=
s it is meant to wake up.
- [High] Error paths perform unprotected list deletions and permanently lea=
k format array slots.
--

--- Patch [3]: [PATCH v3 03/13] s390/dasd: Add range-based format-track col=
lision detection ---
commit 1d2db2dae28f75e003a69468da44050bd92fdedd
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Add range-based format-track collision detection

Replace the single per-device format_entry slot with an array of 16
slots so multiple format requests can be in flight at once, and extend
struct dasd_format_entry with a start_trk/end_trk/cqr range (replacing
the single track field).

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
[ ... ]
> @@ -2855,6 +2848,27 @@ static void __dasd_process_block_ccw_queue(struct =
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

[Severity: High]
Does this guard prevent the collision logic from ever being executed?

Regular data requests use dasd_return_cqr_cb() as their callback but they
do not have cqr->format set. ESE format requests have cqr->format set, but
they use dasd_eckd_ese_format_cb() as their callback instead of this one.

Will this path always take the goto out, making the collision logic
unreachable?

> +
> +	block =3D cqr->block;
> +	/*
> +	 * Mark queued CQRs that overlap this just-completed format
> +	 * range so they re-check in test_and_set_format.
> +	 */
> +	list_for_each_entry(temp_cqr, &block->ccw_queue, blocklist) {
> +		if (temp_cqr !=3D cqr &&
> +		    temp_cqr->status !=3D DASD_CQR_FILLED &&
> +		    temp_cqr->status !=3D DASD_CQR_QUEUED &&

[Severity: High]
Does this explicitly skip requests in the queued state, which are exactly
the ones waiting to be flagged?

Requests delayed due to a conflict (returning -EEXIST from
test_and_set_format_track) are put in the DASD_CQR_QUEUED state. If this
loop filters out DASD_CQR_QUEUED, does it ignore the exact requests it was
designed to evaluate and flag with collision =3D true?

> +		    dasd_req_conflict(cqr, temp_cqr)) {
> +			temp_cqr->collision =3D true;
> +		}
> +	}
> +out:
>  	dasd_schedule_block_bh(cqr->block);
>  }
> =20
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
[ ... ]
> @@ -3232,17 +3245,27 @@ dasd_eckd_ese_format(struct dasd_device *startdev=
, struct dasd_ccw_req *cqr,
>  	fdata.intensity =3D private->uses_cdl ? DASD_FMT_INT_COMPAT : 0;
> =20
>  	rc =3D dasd_eckd_format_sanity_checks(base, &fdata);
> -	if (rc)
> +	if (rc) {
> +		if (format)
> +			list_del(&format->list);
>  		return ERR_PTR(-EINVAL);
> +	}
> =20
>  	/*
>  	 * We're building the request with PAV disabled as we're reusing
>  	 * the former startdev.
>  	 */
>  	fcqr =3D dasd_eckd_build_format(base, startdev, &fdata, 0);
> -	if (IS_ERR(fcqr))
> +	if (IS_ERR(fcqr)) {
> +		if (format)
> +			list_del(&format->list);
>  		return fcqr;
> +	}

[Severity: High]
Are we modifying the list without holding block->format_lock here?

These error paths call list_del(&format->list) without acquiring the lock.
Additionally, they do not set format->cqr =3D NULL. Since
test_and_set_format_track() identifies free slots by checking
!device->format_entry[i].cqr, does this permanently leak format array slots?

Could this use clear_format_track(format, block) instead to properly lock
and clear the state?

> diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
> --- a/drivers/s390/block/dasd_int.h
> +++ b/drivers/s390/block/dasd_int.h
[ ... ]
> @@ -834,6 +842,13 @@ static inline void *dasd_get_callback_data(struct da=
sd_ccw_req *cqr)
>  	return cqr->callback_data;
>  }
> =20
> +static inline bool dasd_req_conflict(struct dasd_ccw_req *cqr1,
> +				     struct dasd_ccw_req *cqr2)
> +{
> +	return !(cqr1->format->end_trk < cqr2->start_trk ||
> +		 cqr2->end_trk < cqr1->format->start_trk);
> +}
> +

[Severity: Critical]
Are start_trk and end_trk guaranteed to be initialized for normal data
requests?

Since dasd_fmalloc_request() zero-allocates memory, cqr2->start_trk and
cqr2->end_trk default to 0 for normal data requests. When evaluated here,
the comparison cqr2->end_trk < cqr1->format->start_trk evaluates as
0 < format->start_trk, which is always true for any track > 0.

Does this silently fail to detect collisions for any tracks other than
track 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723134743.6724=
13-1-sth@linux.ibm.com?part=3D3
