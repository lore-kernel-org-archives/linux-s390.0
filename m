Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69273E6394
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514417; cv=none; b=gJTBtLOKeAzMhOWMteA/c1o4nJhB8timAxk/IRNRplpa/fN+2Sw1EOBeNIB2Suj8NJE204mYkiOh5DDAk/6EGrZu7Zevg9Pcg9mvk5cpxxoZySy6IJQpqWR/2vNeRSjXMIVSA7RT8P+5FGm1VQFQAu3No1SgZHpQLvr+u7PLuCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514417; c=relaxed/simple;
	bh=dhq3Flw/5DM0plPZmyXLkE/1PrFox4gaKvucWeA4jvA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gRH5VqiuWfi+Y2FThnc1AScW0PMy/uJqcR6LOgEqHoIswcimbqPg4D1+FA0ZNQz/o6rhGU7ynBZpzXehynB9drHx6/1YyEc92Ny/cXhhUo+KXwKYzFrvCKM4dtwZs0TPGM3zmo6ROwPt7HnWT5V4EqNlZ6CPw46TXlQRqZYiC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBGf7W65; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBGf7W65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9DB1F00AC4;
	Fri, 31 Jul 2026 16:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785514415;
	bh=RoiMJ4XYGPyGxo9tBiI3xAdU8h0K5VmlcIfmJqmaHxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RBGf7W65wb5bl/cuAb8d5uqYaalo630trSWrpN9EdOOM0F18PykIngrCY2bSIrL1/
	 g0eUxcfjdsH4srkBe6VQNlZoIZyPfEDzMBlVNHHUyADIDClW0G/CpyusV32DgoG+hS
	 r3rLAYscmwesredQXbJdwyIc1guMHoqNg2zpksO46RKr0t7sDpD1ooWgGI/Dl/ztHk
	 Wwdmm5lWkko6A359uH1YLrDia5aTpXRA4pflenEqM69d2qCUSc/qe9kvVTT78qhfPg
	 /s0jgaga0moAsUhizJJXBipphIM4xmbYhLjJnTusJxv+1dIEEe1WCdnTiM+VyMwsmH
	 icGaqhBq9MGdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/17] s390/dasd: Add
 dasd_eckd_build_cp_tpm_writefulltrack()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260731153842.1729627-10-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
 <20260731153842.1729627-10-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:13:34 +0000
Message-Id: <20260731161335.3E9DB1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unconditional iteration over payload segments violates subsystem=
 guidelines and risks a NULL pointer dereference for payload-less requests.
- [Low] Unused static function `dasd_eckd_build_cp_tpm_writefulltrack` caus=
es a build warning/breakage.
--

--- Patch [9]: [PATCH v5 09/17] s390/dasd: Add dasd_eckd_build_cp_tpm_write=
fulltrack() ---
commit 2c25716c288b80bde9127da58f3afd957ee39c9c
Author: Stefan Haberland <sth@linux.ibm.com>
s390/dasd: Add dasd_eckd_build_cp_tpm_writefulltrack()

This commit adds the channel program builder for WRITE_FULL_TRACK requests.
It emits an eckd_r0 header, an eckd_count plus data pair for every record,
and a terminating pseudo-count to format and write tracks atomically.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index c1a26485f506d..8d8bd40ba896b 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
[ ... ]
> @@ -4741,6 +4749,339 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_tp=
m_track(
[ ... ]
> +static struct dasd_ccw_req *dasd_eckd_build_cp_tpm_writefulltrack(struct=
 dasd_device *startdev,

[Severity: Low]
Because this static function is defined but not called anywhere in this
commit, will this generate a -Wunused-function warning and potentially break
builds with -Werror?

> +								  struct dasd_block *block,
> +								  struct request *req,
> +								  sector_t first_rec,
> +								  sector_t last_rec,
> +								  sector_t first_trk,
> +								  sector_t last_trk,
> +								  unsigned int first_offs,
> +								  unsigned int last_offs,
> +								  unsigned int blk_per_trk,
> +								  unsigned int blksize,
> +								  struct dasd_ccw_req *ocqr)
> +{
[ ... ]
> +	/* process data records */
> +	rec =3D first_offs + 1;
> +	rec_count =3D 0;
> +	rq_for_each_segment(bv, req, iter) {
> +		dst =3D bvec_virt(&bv);

[Severity: Medium]
Does this code risk a NULL pointer dereference for payload-less requests?

Iterating over a bio without data using rq_for_each_segment() triggers a
NULL pointer dereference on bio->bi_io_vec. Subsystem guidelines require
using a bio_has_data() guard before accessing data fields. If a payload-less
request (like FLUSH or DISCARD) is passed here, it could crash.

> +		seg_len =3D bv.bv_len;
> +		while (seg_len) {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731153842.1729=
627-1-sth@linux.ibm.com?part=3D9
