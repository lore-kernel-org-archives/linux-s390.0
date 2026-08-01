Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E55E3659FD
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785584399; cv=none; b=Nu4zZYBzbx4k4cCcerQi/5lxKdAWnrkBGnM3xC0W/8oWEGDC7v76o99qj4tn7g/CaECGb0z6NJd5c8ZWScHfgb5sogBDbyBS712d1TkDXME2a/NLMRaPaC2gbP9+9idoM5X3OBbw15XudHsX/3+N+DCGo2VJ7hGEawGauagwGwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785584399; c=relaxed/simple;
	bh=PF0U2ZHWUUQDTIXYOgqKuCKWlPfXVl3j9C6mOPmxcNA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uNa33eCbHRbbmnUMFnFQtEzfTtMFrbK7J1ZCLSfXEiC1HfLU9+tMq4k898H60CEMLSERhvGxlUZX04vIoQ80aH3WTU3FHm9MMTzaJ1JhutqpmrL4UEQ+9REOEXOnftixBl6cIA8A5znMbLhJeRxaRfNGYOON1cMwq5qwn3OuDfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfE33hUp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfE33hUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2BB1F00AC4;
	Sat,  1 Aug 2026 11:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785584398;
	bh=yLMEO/PjhYLKofWPDxkV4m0bzOuwyX/noRG/HyDRSiI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LfE33hUpRE0iszg0FHD3bthGYJP8tAaZMyOhtHCQLqt9sxIaBI+ynT5epybVCAC0o
	 k//e8mi4SJBbw6POdSsQtPaPHxV/E2sYtYEEr3j/NypS4p/saKsDf3k0z4taTZ+Dit
	 m1xBI3dFVu25i1SP3GY83ffxx8zsyWL7YA3N0GWykimoHUHqZJsuS1HeD36gDd4xL4
	 dMpJi/UUoNLoz/TxpQZGs6vxple2EHWwf5tNC1LZbM5VPVrfuxQ/rlAYff+WsL0KJz
	 0Jx8y0qb/Pm+B1jCOoP/GnWsW93lOvvwB1nkofYdYfcShunpRsr8H9fjX73INk+OgA
	 TS2DEgfsPrduQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/18] s390/dasd: Use WRITE_FULL_TRACK in ESE format
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260801111008.3391031-12-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
 <20260801111008.3391031-12-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:39:57 +0000
Message-Id: <20260801113957.CB2BB1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Skipping test_and_set_format_track() for full-track writes all=
ows concurrent partial-track formats to overwrite valid data with zero-padd=
ing.
- [Medium] Double counting of profiling statistics for aborted ESE format b=
ase requests.

Pre-existing issues:
- [Critical] Lockless access to `cqr->collision` creates a Time-Of-Check to=
 Time-Of-Use (TOCTOU) race that can lead to redundant track formatting and =
data corruption.
--

--- Patch [11]: [PATCH v6 11/18] s390/dasd: Use WRITE_FULL_TRACK in ESE for=
mat handler ---
commit d41c1ad780e71d8d577bfe81bd62b8114d2d1103
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Use WRITE_FULL_TRACK in ESE format handler

This commit wires dasd_eckd_build_cp_tpm_writefulltrack() into the ESE
unformatted track handler. It calculates the failing track ranges, builds a
WRITE_FULL_TRACK CQR, and aborts the origin CQR.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index dfbadd83bea21..f1235729326ee 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
[ ... ]
> @@ -2754,6 +2758,9 @@ static void __dasd_cleanup_cqr(struct dasd_ccw_req =
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
Could this result in double-counting of profiling statistics?
dasd_profile_end() is called unconditionally at the beginning of
__dasd_cleanup_cqr(). Since the aborted CQR is replaced by a format request
that will also complete and go through this cleanup path, won't the same
block request be profiled twice in the block and device accumulators?

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 8e18dad96299f..5e7a531707a0c 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
[ ... ]
> @@ -3251,60 +3239,138 @@ dasd_eckd_ese_format(struct dasd_device *startde=
v, struct dasd_ccw_req *cqr,
[ ... ]
> +	if (first_offs > 0 || last_offs + 1 < recs_per_trk) {
> +		/* test if tracks are already in formatting by another thread */
> +		if (test_and_set_format_track(first_trk, last_trk, cqr,
> +					      cqr->block, cqr->startdev, &format)) {

[Severity: Critical]
Is it safe to skip test_and_set_format_track() for full-track writes?

If a full-track write and a partial-track write are submitted concurrently
to the same unformatted track, the full-track write could skip acquiring the
format lock here. The partial-track write might then successfully acquire
the lock and build a zero-padded WRITE_FULL_TRACK CQR. If the partial-track
write executes on the device after the full-track write, couldn't it
overwrite the valid data from the full-track write with zeros?

[Severity: Critical]
This is a pre-existing issue, but is there a potential Time-Of-Check to
Time-Of-Use (TOCTOU) race inside test_and_set_format_track()?

Looking at test_and_set_format_track(), it checks cqr->collision without
holding a lock before acquiring block->format_lock:

test_and_set_format_track() {
    if (cqr && cqr->collision) {
        cqr->collision =3D false;
        return true;
    }
    spin_lock_irqsave(&block->format_lock, flags);
    ...
}

If a partial-track write fails with INV_TRACK_FORMAT while another format
operation is in progress on the same track, and this lockless read sees a
stale false value, it proceeds to acquire the lock. If the format entry was
just cleared by the other CPU's tasklet, it might find an empty format list,
assume the track is unformatted, and issue a zero-padded WRITE_FULL_TRACK,
which would destroy the data just written by the previous format operation.

Could we read the collision flag inside the lock to enforce memory ordering?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801111008.3391=
031-1-sth@linux.ibm.com?part=3D11
