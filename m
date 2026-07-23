Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EE64477E0
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816040; cv=none; b=UJl9nWgz9l0fDXp5S+pwPZmXaZqJ+ciEz1LZbWFgyAeMXLDLhDEIpQ2dvFgWUQxCcjA0WH1O3tPHlZCFB+rdxfVkLFykJZy9uiCz54SjafbBETi3O0D6ajrjq0//jQ7UbiRDGxGIU4wgeflkmjynMmCFksx7KIiW7JzadAY+gh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816040; c=relaxed/simple;
	bh=U9LQJjivzc4KZRDiEiOfBeAEuUBuVdOS248HtGeMU8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IkZ9cARd0+97YrPTBYLfE6yAJ+Gl+aF6Ge9KHlfYzlrWZLjAHJQDx761JNRk04wnRe34Am+e3zTKqWegFhhHgXFDbcX1X4+vSkNPjNWRfTalS6R98VrXVPxh+PKxLzoQvp5NmyK6cG6MDoo4oByQ6n8MjYLW+fLCr2olRyorbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+iUSgYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+iUSgYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BB21F000E9;
	Thu, 23 Jul 2026 14:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784816028;
	bh=Uauy3WV82/v/M3r3a7WT6JkSEILCjPVMWLVH8d/qync=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P+iUSgYHlxrkljjG1+5OxsoQVAavGEffFu9/EnYgv04RY/MWzl7anpGP+dpIJGtpi
	 kvPOLKZE+6yS1HW/0dwrp7rC4PJy8JCAQ/qv5GJ8BlHcRANgdEegmx6yYOAtcUzr4A
	 qZpg8FvxWsLiInmNgiU5Z39hkW1mpfVf9r6vMiK8rVcm8V+pAruJR/IYCsl8/5kvWb
	 6D4FlH6Wm2fTs7kqNHxJpuUshM6423hFLdpoeOCt+BG/+UAGhSIYaOdFPOIJeXoCkE
	 3bVdA/x1vdwTjI0GnZMB5bUgeeXvzOo9kRg4MD3qqfuwxN+IxNTYBH3DFogOaKRoQ2
	 Nn7dO8TYWn9pQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/13] s390/dasd: Use WRITE_FULL_TRACK in ESE format
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260723134743.672413-7-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
 <20260723134743.672413-7-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 14:13:47 +0000
Message-Id: <20260723141348.48BB21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Generating a WRITE_FULL_TRACK CCW for a request spanning more than=
 16 tracks causes a negative bit shift, producing an invalid hardware track=
 mask.
- [High] Bounce buffers allocated from `dasd_page_cache` are permanently le=
aked when an origin request is aborted and replaced by an ESE format reques=
t.
- [High] The `fillsize` allocation for `filldata` does not account for padd=
ing injected by `reserve_nocross()`, leading to out-of-bounds allocation fa=
ilures and dropped I/O.

Pre-existing issues:
- [Critical] Partial I/O completions on ERP requests lose the `proc_bytes` =
value, causing the block layer to incorrectly treat the entire request as s=
uccessful.
- [High] Error paths in `dasd_eckd_ese_format` fail to schedule the device =
tasklet or clear the timer, causing the I/O request to hang.
--

--- Patch [6]: [PATCH v3 06/13] s390/dasd: Use WRITE_FULL_TRACK in ESE form=
at handler ---
commit 2efec0cd23e150d9cbd9db63fa5fad5ebdee9860
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Use WRITE_FULL_TRACK in ESE format handler

Wire dasd_eckd_build_cp_tpm_writefulltrack() into the ESE unformated
track handler. dasd_eckd_ese_format() now returns void and builds a
writefulltrack CQR directly.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -3224,60 +3212,135 @@ dasd_eckd_ese_format(struct dasd_device *startde=
v, struct dasd_ccw_req *cqr,
[ ... ]
> +	rc =3D dasd_eckd_track_from_irb(irb, base, &curr_trk);
> +	if (rc) {
> +		/* sense data could not be parsed - this will not resolve by retrying =
*/
> +		cqr->status =3D DASD_CQR_ERROR;
> +		return;
> +	}

[Severity: High]
This is a pre-existing issue, but error paths in dasd_eckd_ese_format() fail
to schedule the device tasklet or clear the timer. If sense data cannot be
parsed or the track is out-of-bounds, dasd_eckd_ese_format() sets the status
to DASD_CQR_ERROR and returns. Since dasd_int_handler() expects the
discipline hook to handle scheduling on error, doesn't this leave the I/O
request stranded in the queue until the 5-minute fallback timeout fires?

[ ... ]
> +	fcqr =3D dasd_eckd_build_cp_tpm_writefulltrack(startdev, block, req,
> +						     first_rec, last_rec,
> +						     first_trk, last_trk,
> +						     first_offs, last_offs,
> +						     recs_per_trk, blksize, cqr);

[Severity: High]
Can trkcount exceed 16 here? When dasd_eckd_build_cp_tpm_writefulltrack()
calls prepare_itcw(), the count argument is used in a bit shift:

lredata->extended_parameter[1] <<=3D (16 - count);

If a user issues a large write request that spans more than 16 tracks,
won't this result in a negative bit shift, causing undefined behavior and
generating an invalid hardware track mask?

[Severity: High]
Does the fillsize allocation inside dasd_eckd_build_cp_tpm_writefulltrack()
account for the padding injected by reserve_nocross()?

fillsize =3D trkcount * (sizeof(struct eckd_r0) +
                       (sizeof(struct eckd_count) * (blk_per_trk + 2)));
filldata =3D dasd_alloc_chunk(&startdev->fill_chunks, fillsize);

When reserve_nocross() appends elements, it injects padding bytes to
prevent them from crossing page boundaries. Because this padding is not
budgeted in fillsize, the remaining space might drop below zero before all
track elements are written, causing reserve_nocross() to return NULL and
abort the request.

> @@ -5297,6 +5363,14 @@ dasd_eckd_free_cp(struct dasd_ccw_req *cqr, struct=
 request *req)
>  	sector_t recid;
>  	int status;
> =20
> +	/*
> +	 * special handling for format aborted requests
> +	 * only clean up the request, nothing finished
> +	 */
> +	if (cqr->status =3D=3D DASD_CQR_ABORTED) {
> +		status =3D DASD_CQR_ABORTED;
> +		goto abort;
> +	}
>  	if (!dasd_page_cache)
>  		goto out;

[Severity: High]
Does this early exit skip freeing the bounce buffers? If dasd_page_cache
is active and an origin request is marked DASD_CQR_ABORTED (because it
was replaced by an ESE format request), the goto abort statement bypasses
the loop responsible for calling kmem_cache_free(). Could this permanently
leak the bounce buffer memory allocated for the I/O segments?

> diff --git a/drivers/s390/block/dasd_erp.c b/drivers/s390/block/dasd_erp.c
> --- a/drivers/s390/block/dasd_erp.c
> +++ b/drivers/s390/block/dasd_erp.c
> @@ -120,13 +120,14 @@ dasd_default_erp_action(struct dasd_ccw_req *cqr)
>   */
>  struct dasd_ccw_req *dasd_default_erp_postaction(struct dasd_ccw_req *cq=
r)
>  {
> -	int success;
> +	int success, aborted;
>  	unsigned long startclk, stopclk;
>  	struct dasd_device *startdev;
> =20
>  	BUG_ON(cqr->refers =3D=3D NULL || cqr->function =3D=3D NULL);
> =20
>  	success =3D cqr->status =3D=3D DASD_CQR_DONE;
> +	aborted =3D cqr->status =3D=3D DASD_CQR_ABORTED;

[Severity: Critical]
This is a pre-existing issue, but does the loop that unwinds the ERP chain
just below here lose the proc_bytes value from a partial completion?

while (cqr->refers !=3D NULL) {
        struct dasd_ccw_req *refers =3D cqr->refers;
        list_del(&cqr->blocklist);
        dasd_free_erp_request(cqr, cqr->memdev);
        cqr =3D refers;
}

When an ERP retry hits an unformatted track, dasd_eckd_ese_format() or
ese_read() sets cqr->proc_bytes on the ERP request and marks it successful.
During this unwinding, the ERP request holding this partial completion is
freed without propagating proc_bytes to the base request. When the base
request is later processed, it will have proc_bytes =3D=3D 0, causing the b=
lock
layer to incorrectly treat the entire request as successful and silently
drop the unwritten or unread portion.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723134743.6724=
13-1-sth@linux.ibm.com?part=3D6
