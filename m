Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C11F42AF9C
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816066; cv=none; b=RP9dXCGmaGwGpeDqIKDbMDWrnWv6zCimTSFSOWk9C0GsM5i2FpgRVnC0yHXWuoVoyn4LT5HEBPK8XCu7RqFiwnFdxTr0sLWN2JgeIZ2uOYi5luC2Y20cZVk4B022gsE97dp0ZVjHIL9NMzyGhU2hpdq/OTaSMLyk8jyKwLiO1Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816066; c=relaxed/simple;
	bh=BXKbtXAdNQrQXo3YQlNR3SgpLdAkd75SmRoTvit2Uw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T2talako0liIZQaqmD6JrA3dc+dOWsdhbvP3ENqVjzWGu7SlgHCZGh2i1N3J9OzkbILRKiCGbVsQIQ+BizeYZsGpWrEIzk2dMjbFCD2VT3joqtu7fZSTt/zKB98ncFlExHen8Cc1+jcEqzbP4ZZWY1Xhrrpg94s7bRubFdPKAk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiHvOP5n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiHvOP5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220BA1F000E9;
	Thu, 23 Jul 2026 14:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784816054;
	bh=bwPGgO4DEOpjHUPONX+3KFHjXmB5zyLjX5i3fJNOqRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eiHvOP5nrD/JnGlgG5dfpnLuRWcuiMCnQZ+40MHQ769WKgRQiy8RpqkTNLdkrdVaB
	 Samyfi1AVR2Y7J8P4o64Y+gL3Gs5HX8fVKv9NwEGkToMOj+QMkXa97eqk3xfPyAtIR
	 RkucwB8ZMpGuu3Rou6dY8OIRDB7NR6INa3fUcRJ3eLmx0dCfkvzWK+IYOKlad1rAGz
	 5boSWlRjMR7zqv3zvV/u3J0S4A5A4Wx34hEoBAmZIubCXB/BgxgW6wbd+WuObYY8GZ
	 Sl6M2E7TxyHaT46+TGaLaUNOevlhIafVLcy2oxWRpPxEt+jBFodemoiyomu8zt50R9
	 g9QULgD2Rh2MA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/13] s390/dasd: Add
 dasd_eckd_build_cp_tpm_writefulltrack()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260723134743.672413-6-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
 <20260723134743.672413-6-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 14:14:13 +0000
Message-Id: <20260723141414.220BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Incorrect `len_to_track_end` initialization for subsequent tra=
cks leads to malformed channel programs with duplicate Track End markers.
- [High] The function iterates over bio data segments without verifying ope=
ration type safety, violating block layer guidelines.
--

--- Patch [5]: [PATCH v3 05/13] s390/dasd: Add dasd_eckd_build_cp_tpm_write=
fulltrack() ---
commit 86379d92de11de4619dd9c8f1c829907036c1f56
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Add dasd_eckd_build_cp_tpm_writefulltrack()

Add the channel program builder for WRITE_FULL_TRACK requests, used
by dasd_eckd_ese_format() to format and write a set of tracks
atomically and avoid the format cycle on ESE devices.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index a570fe2e85693..0962c9f72c864 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[ ... ]

> @@ -4714,6 +4722,337 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_tp=
m_track(

[ ... ]

> +	/* process data records */
> +	rec =3D first_offs + 1;
> +	rec_count =3D 0;
> +	rq_for_each_segment(bv, req, iter) {

[Severity: High]
Can this cause a NULL pointer dereference if a dataless request (like
REQ_OP_DISCARD or REQ_OP_FLUSH) is dispatched here?

The block layer guidelines indicate that iterating over bio data segments
requires checking blk_rq_has_data() or bio_has_data() first, as op_is_write=
()
evaluates to true for dataless operations, which have a NULL bi_io_vec.

> +		dst =3D bvec_virt(&bv);
> +		seg_len =3D bv.bv_len;
> +		while (seg_len) {
> +			if (new_track) {
> +				trkid =3D recid;
> +				offs =3D sector_div(trkid, blk_per_trk);
> +				count_to_trk_end =3D blk_per_trk - offs;
> +				count =3D min((last_rec - recid + 1),
> +					    (sector_t)count_to_trk_end);
> +				len_to_track_end =3D count * blksize;

[Severity: Critical]
Is len_to_track_end correctly initialized here for subsequent tracks?

It looks like this clamps the track length to the remaining data length
(count * blksize) instead of the physical track capacity
(blk_per_trk * blksize).

If len_to_track_end is set to the data length, it will reach zero premature=
ly.
Will this cause the track end marker to be emitted early inside this loop:

	if (new_track) {
		last_tidaw =3D add_track_end(itcw, &filldata,
					   &fillsize);
		...
	}

And then a second track end marker to be appended later in out_skip after t=
he
padding records? This might result in a malformed channel program that is
rejected by the hardware.

> +				recid +=3D count;
> +				new_track =3D 0;
> +				/* the R0 header of the next track */
> +				cyl =3D curr_trk / heads;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723134743.6724=
13-1-sth@linux.ibm.com?part=3D5
