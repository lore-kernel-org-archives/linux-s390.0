Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0050E477E53
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945228; cv=none; b=JYYof8JHezslJa8oqmRTB5np0pw+O9a3W7hbYqqnrpMGDbRiLa0SX7eyxZZahEHzlYnXSHn5XSelddX3r2/bfl4bsTiAXRcS1ymjDjBHf5NQbiUfLOuEibYxgLjsGyRXw+/gQ3UHm3t6IU9FPPgr9idFv265BQibVsas19d+X9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945228; c=relaxed/simple;
	bh=EaiJQrVqa4oOK0tcxwyGkbSNkx5Mgo8Rk3pVoDFRmyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mzZ8DMlure13XpF7G8F5XZKb/gBSkmdhe6ao/qRNTIJ8AerqpTZtkIzTcWocJLi52O3dEPPuIU+aVkD2JeIFSiFJjo8HYOubKRzZiobtw0Paey00czURB5yyZC5FeS8NzvW8LEh/lWkfpvqczlwnECLHj/+b4XIrJn4t9L+RmfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsGrGtRu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsGrGtRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AC61F000E9;
	Wed,  5 Aug 2026 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785945226;
	bh=80A4niEzQZFqMk4dMrcLAm8CgmTqiAg+J0hrJLUrnQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nsGrGtRuzQ8JeW8W/Sji+QFv0bIFJ9e7PQ0e1T+cAQvVemeaUyyUDCLHifUH/Lik0
	 jT/t6HGrSKHWnRZ/qo2tk5jfg3vArDKP3K+H4xplzTsO7Nsz2SLySxRh34s+BjSE6P
	 g7NBCfwUQGTxSOkuIbl70IT4dqjQkK7ie6YqvFrr4TQt8+meLqNlYRDFm/ugp6pZiF
	 lCmkvVqLrBpjld4vGdfeuNMP/bJ/pmQ01DW9eJ53A/01GbIMpYWrhwNAR4yC7YVHet
	 BG3NwjdI1+R9diCHuGyWhqCRYqGXreQ6FMZvM9NC9eFWOziWNpKHUKTc1eP4J4qryF
	 rYk/PY7jH0sFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/19] s390/dasd: Add
 dasd_eckd_build_cp_tpm_writefulltrack()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260805111612.1285190-12-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-12-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 15:53:45 +0000
Message-Id: <20260805155346.06AC61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Split memory segments (bvecs) result in truncated physical rec=
ords, corrupting the track format.
- [High] Missing `bio_has_data()` guard before iterating over request segme=
nts.

Pre-existing issues:
- [High] Negative bitwise shift and truncated extended parameter length whe=
n formatting >16 tracks.
--

--- Patch [11]: [PATCH 11/19] s390/dasd: Add dasd_eckd_build_cp_tpm_writefu=
lltrack() ---
commit 756c6129bbfe82549e28cc85e3b42100ba732cd0
Author: Stefan Haberland <sth@linux.ibm.com>
Subject: s390/dasd: Add dasd_eckd_build_cp_tpm_writefulltrack()

Adds the channel program builder for WRITE_FULL_TRACK requests, used
by dasd_eckd_ese_format() to format and write a set of tracks
atomically.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index ae122fbdca3ed..8379c8a40382f 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
[ ... ]
> +static __maybe_unused struct dasd_ccw_req *
> +dasd_eckd_build_cp_tpm_writefulltrack(struct dasd_device *startdev,
> +				      struct dasd_block *block,
> +				      struct request *req,
[ ... ]
> +	if (prepare_itcw(itcw, first_trk, last_trk,
> +			 cmd, basedev, startdev,
> +			 0,
> +			 trkcount, blksize,
> +			 datasize,
> +			 tlf,
> +			 blk_per_trk) =3D=3D -EAGAIN) {

[Severity: High]
This is a pre-existing issue in prepare_itcw(), but formatting more than
16 tracks could cause undefined behavior here.

When DASD_ECKD_CCW_WRITE_FULL_TRACK is processed and trkcount (passed as
count to prepare_itcw) exceeds 16, the expression (16 - count) inside
prepare_itcw() evaluates to a negative number:

drivers/s390/block/dasd_eckd.c:prepare_itcw() {
    ...
    if (count > 8) {
        lredata->extended_parameter[0] =3D 0xFF;
        lredata->extended_parameter[1] =3D 0xFF;
        lredata->extended_parameter[1] <<=3D (16 - count);
    ...
}

Does shifting left by a negative amount cause a corrupted extended parameter
bitmask?

Additionally, since extended_parameter_length is hardcoded to 2 bytes,
requests spanning more than 16 tracks may truncate the track bitmask.

> +		/* Clock not in sync and XRC is enabled.
> +		 * Try again later.
> +		 */
> +		ret =3D -EAGAIN;
> +		goto out_error;
> +	}
[ ... ]
> +	/* process data records */
> +	rec =3D first_offs + 1;
> +	rec_count =3D 0;
> +	rq_for_each_segment(bv, req, iter) {

[Severity: High]
Could this cause a NULL pointer dereference if a data-less operation (like
REQ_OP_WRITE_ZEROES) is routed here?

The block subsystem guidelines mention that accesses to bio data fields
require a bio_has_data() guard before iteration, as operations like discard
or write zeroes lack data buffers.

> +		dst =3D bvec_virt(&bv);
> +		seg_len =3D bv.bv_len;
> +		while (seg_len) {
[ ... ]
> +			/*
> +			 * This block ends the track; the next one starts a new
> +			 * track. The track-end marker emitted below carries the
> +			 * CBC flag.
> +			 */
> +			if (!len_to_track_end)
> +				new_track =3D 1;
> +
> +			last_tidaw =3D add_track_record(itcw, &filldata, &fillsize,
> +						      cyl, head, rec, dst, part_len);

[Severity: Critical]
If a logical block is fragmented across memory boundaries (for example, a
4096-byte block split into two 2048-byte segments due to page boundary
crossing), does this erroneously emit multiple eckd_count headers with
truncated lengths?

Instead of chaining TIDAWs for a single physical record, calling
add_track_record() for each segment piece might advance the record
counter twice and permanently corrupt the track format.

> +			if (!last_tidaw)
> +				goto out_error;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D11
