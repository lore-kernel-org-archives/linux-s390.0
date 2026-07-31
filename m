Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F36453A31
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515636; cv=none; b=YYmltDHQswScKhq3QotX5pQ8Gpfkx2PtGvMiKwRlYPw3t0ye7Y6JU+aguyjoAFWxZiRHKpdNZ4eoOLVpmU7v7yexwzREc2cFHbN7WLbVQ+GBie2y1txvIYaUc2eiz55CbtEF5+BKZkX/LjdBBOWo7nqqCvQ524/frYpY1Y2i0nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515636; c=relaxed/simple;
	bh=g+2IZ26vJIqANnaCLbjqCSaHBZyOiVMIM52N9iOxiVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PGmVfQMjm0+GSCy5msn8URG9PaAcso5JL+XW8nbrHH5dJbN//9XKxTbM0gEqa8yBvanxZMGDEKDEhlp+OhdeJqe5/e2b6rocUSJWhJBnwKuge9dx9kownvYQgm0Gjj9CNFxTdR4Z9hDHmmPct8idcBM4qneH+BnyEcbjaW/ljMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aV/D4C2w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aV/D4C2w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CA81F00AC4;
	Fri, 31 Jul 2026 16:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785515635;
	bh=Q5voP36XimdiEzF3AQWj9G7rB3JYJeF2wgz2hfPtCdQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aV/D4C2wK0DOMpvgjKM999+DmekulGLdF97McHPaqm1NF7KomG8Xe6TNHn3Rzpcpw
	 EXuA894Verss/xAkcVNwKPU+yx0JpZviRdFqNc0uC2NttJEzJGiaJPSJYzuHbEAlZJ
	 QqUWwJDYwlpIbXzsp/EP+8Tq5rstLQ198aVcylNGZyeOQZR2EG7VeiUH0kweCrCPKK
	 YHfePWGqQyWkDUs7IdNcJUOgCwRblvcAYdbG75HVPn15dgN0x2Mh4cGTmFbZO5CO2i
	 gYb4xDCMghD31TUVVbRvVixuHPevpC+3fbb3pXW92QsblUy2vNNcKCoUODnec4AKGT
	 ha1AfEgVxyS2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/17] s390/dasd: Use WRITE_FULL_TRACK in ESE format
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260731153842.1729627-11-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
 <20260731153842.1729627-11-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:33:54 +0000
Message-Id: <20260731163354.B3CA81F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] An infinite loop occurs when a WRITE_FULL_TRACK CQR encounters an =
INV_TRACK_FORMAT error because the ERP request fails to inherit the `fillda=
ta` pointer, bypassing the intended permanent-failure path.
- [High] dasd_eckd_build_cp_tpm_writefulltrack() iterates over bio segments=
 without verifying if the request has data buffers, risking a NULL pointer =
dereference for data-less requests.
- [Medium] Non-transient errors (like -EINVAL) from `dasd_eckd_build_cp_tpm=
_writefulltrack` cause wasteful retry loops instead of failing fast.
- [Medium] Double counting of I/O statistics for aborted ESE format replace=
ment requests.
--

--- Patch [10]: [PATCH v5 10/17] s390/dasd: Use WRITE_FULL_TRACK in ESE for=
mat handler ---
commit 9457d60af3530b5a71a57c6a68b8e701a0e817f4
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Use WRITE_FULL_TRACK in ESE format handler

This commit modifies the ESE unformatted track handler to use
WRITE_FULL_TRACK. It changes dasd_eckd_ese_format() to return void and
stage the CQR directly, while marking the origin CQR as aborted.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index 35f722e20c6d3..19a04155d271c 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -1737,26 +1737,23 @@ void dasd_int_handler(struct ccw_device *cdev, un=
signed long intparm,
>  			dasd_schedule_device_bh(device);
>  			return;
>  		}
> -		fcqr =3D device->discipline->ese_format(device, cqr, irb);
> -		if (IS_ERR(fcqr)) {
> -			if (PTR_ERR(fcqr) =3D=3D -EINVAL) {
> -				cqr->status =3D DASD_CQR_ERROR;
> -				return;
> -			}
> +		if (cqr->filldata) {
>  			/*
> -			 * If we can't format now, let the request go
> -			 * one extra round. Maybe we can format later.
> +			 * A WRITE_FULL_TRACK cqr carries the complete
> +			 * track image; INV_TRACK_FORMAT here means the
> +			 * generated image or the media itself is bad, not
> +			 * that the track still needs formatting - retrying
> +			 * via ese_format() would just resubmit the same
> +			 * write. Let it fail instead.
>  			 */
> -			cqr->status =3D DASD_CQR_QUEUED;
> -			dasd_schedule_device_bh(device);
> -			return;
> -		} else {
> -			fcqr->status =3D DASD_CQR_QUEUED;
> -			cqr->status =3D DASD_CQR_QUEUED;
> -			list_add(&fcqr->devlist, &device->ccw_queue);
> +			cqr->status =3D DASD_CQR_ERROR;
> +			cqr->stopclk =3D now;
> +			dasd_device_clear_timer(device);
>  			dasd_schedule_device_bh(device);
>  			return;
>  		}
> +		device->discipline->ese_format(device, cqr, irb);
> +		return;
>  	}

[Severity: High]
Could this cause an infinite loop during Error Recovery (ERP)?

When a WRITE_FULL_TRACK request fails with INV_TRACK_FORMAT, the ERP
engine creates a retry request but doesn't seem to copy the filldata
pointer from the base request. If this ERP request fails again with
INV_TRACK_FORMAT, will the interrupt handler see a NULL filldata here
and incorrectly call ese_format() again? This would generate a new base
request instead of failing, potentially looping infinitely.

[ ... ]
> @@ -2752,6 +2756,9 @@ static void __dasd_cleanup_cqr(struct dasd_ccw_req =
*cqr)
>  			error =3D BLK_STS_IOERR;
>  			break;
>  		}
> +	} else if (status =3D=3D DASD_CQR_ABORTED) {
> +		/* aborted requests are replaced with a new one so do not complete thi=
s */
> +		return;
>  	}
> =20
>  	/*

[Severity: Medium]
Could this result in double-counting I/O statistics?

dasd_profile_end() is called unconditionally at the beginning of
__dasd_cleanup_cqr():

__dasd_cleanup_cqr()
{
	...
	dasd_profile_end(cqr->block, cqr, req);
	...
	if (status =3D=3D DASD_CQR_ABORTED) {
		return;
	}
}

When the replacement format request eventually completes, won't it account
for the same block request again?

[ ... ]
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 8d8bd40ba896b..4fe1b78366b04 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
[ ... ]
> +	fcqr =3D dasd_eckd_build_cp_tpm_writefulltrack(startdev, block, req,
> +						     first_rec, last_rec,
> +						     first_trk, last_trk,
> +						     first_offs, last_offs,
> +						     recs_per_trk, blksize, cqr);

[Severity: High]
Can this cause a NULL pointer dereference for data-less requests?

If a REQ_OP_DISCARD or REQ_OP_WRITE_ZEROES operation fails with an ESE
format error, it seems ese_format() will unconditionally pass it to
dasd_eckd_build_cp_tpm_writefulltrack().

Since dasd_eckd_build_cp_tpm_writefulltrack() uses rq_for_each_segment()
which accesses bio data fields, and data-less requests have a NULL
bi_io_vec, does this need a bio_has_data() check before iterating?

>  	if (IS_ERR(fcqr)) {
>  		if (format)
> -			clear_format_track(format, block);
> -		return fcqr;
> +			clear_format_track(format, cqr->block);
> +		/*
> +		 * Transient conditions - the XRC clock is not in sync (-EAGAIN)
> +		 * or the format request pool is momentarily exhausted under load
> +		 * (-ENOMEM). Retry the origin without counting down its retries.
> +		 */
> +		if (PTR_ERR(fcqr) =3D=3D -EAGAIN || PTR_ERR(fcqr) =3D=3D -ENOMEM)
> +			cqr->retries++;
> +		goto out_retry;
>  	}

[Severity: Medium]
Does this cause non-transient errors like -EINVAL to be retried
unnecessarily?

By falling through to out_retry without failing immediately, it appears
permanent build errors might loop until the original request's retry
counter is exhausted. The original code explicitly checked for -EINVAL
and returned it to fail fast.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731153842.1729=
627-1-sth@linux.ibm.com?part=3D10
