Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FEA1A3AB0
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608233; cv=none; b=t2NNrlSSVP34s1QokNrp10X62IoURc5ekB8O/U/aH8roxdbWCIqXXTb8PFu15upVWvWZXg2IhQuf80SJQ0WfQtAy0ySehIJtFmVark7k179JVgX664L6bUKrbG6RDIOzA7/cQITWEylRRszVRQCIY0g1wXzOPwcGB3omLuT27Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608233; c=relaxed/simple;
	bh=B6PQlmUwxdTAWHHO6CdnMzhAcCnAUzyF0+5hjkaHUgg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pFHvYfzKJFzigjbyPQ9Rpvm0jp78nGSyWaQHXserCJdebINiw7DDP0unky8j5KXu0lNQyOBWiBZNgYHdnJMU5aUgDRE8sQbGCDASQZVyV6vCc5No/uWgIw15LbueprN7FW5Mc0yrPrIdMExeoRD8xbnSdV30/16+TrTM/CKWmd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8pfPQ6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8pfPQ6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698061F00AC4;
	Sat,  1 Aug 2026 18:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785608231;
	bh=khFlaSwPy9BX1+lMWnEqKNFe13aOpuLlUtwUvTC5EN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i8pfPQ6dDYm8ZA726Wy9OcveNyH6TlZ9sUdXbOKu+eO7Pc6T5ieuNfyorjYKY8x+h
	 6HDRKlHTTCr6y+g6QwIFs03QKuBX5H31A4ngKTbRW1PSBk84Nv/LoT011H9szsf+yO
	 Rz3551F5pbl+NSZeXcSvrDLhsCSJsRJ1gzKmIOqfUGAhdZBVebz2qQXHHF1O42VORS
	 FiOgaTXQJBE43jc3ePOEQapEsYyxvni3+YcgFOJiKnyi3RCF0Jm75XkjDAkii3WW0m
	 jfu3+kTXsl+aOTSjzFoaTR/Gu3QZyv3sip64EiyBTgsN7ulK7I+xTud4tVyvuQUPAb
	 1bXAx0R57Bivw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/19] s390/dasd: Add
 dasd_eckd_build_cp_tpm_writefulltrack()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260801180033.3679412-12-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-12-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:17:10 +0000
Message-Id: <20260801181711.698061F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The WRITE_FULL_TRACK channel program emits one ECKD COUNT record p=
er physical `bvec` segment fragment rather than per logical block, corrupti=
ng disk geometry, truncating user data, and overflowing TIDAW allocations.
- [High] Missing `bio_has_data()` guard before iterating over request segme=
nts in `dasd_eckd_build_cp_tpm_writefulltrack` causes a NULL pointer derefe=
rence on payload-less requests.
- [High] Negative bit shift in `prepare_itcw()` when track count exceeds 16=
 causes undefined behavior.

Pre-existing issues:
- [High] Preexisting functions `dasd_eckd_build_cp_tpm_track` and `dasd_eck=
d_build_cp_cmd_track` use `rq_data_dir()` to guard data access, failing to =
exclude dataless write operations and causing NULL pointer dereferences.
--

--- Patch [11]: [PATCH v7 11/19] s390/dasd: Add dasd_eckd_build_cp_tpm_writ=
efulltrack() ---
commit 194da1c99392fbbd1e70e7463ef11e36aaa6e8ba
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Add dasd_eckd_build_cp_tpm_writefulltrack()

This commit adds a channel program builder for WRITE_FULL_TRACK requests.
It creates an ITCW with a TIDAW list for track formatting and writing on
ESE devices.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index b54d1858db160..475c0aca4a5ae 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -4742,6 +4750,340 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_tp=
m_track(
>  	return ERR_PTR(ret);
>  }

[Severity: High]
This is a pre-existing issue, but functions like
dasd_eckd_build_cp_tpm_track() and dasd_eckd_build_cp_cmd_track() appear to
use rq_data_dir() to guard data access.

Does this safely exclude dataless write operations? If a dataless write like
REQ_OP_DISCARD or REQ_OP_WRITE_ZEROES is submitted, will the call to
rq_for_each_segment() cause a NULL pointer dereference on bi_io_vec? A
bio_has_data() guard might be required here to strictly verify the payload
before accessing data segments.

> +static __maybe_unused struct dasd_ccw_req *
> +dasd_eckd_build_cp_tpm_writefulltrack(struct dasd_device *startdev,

[ ... ]

> +	trkcount =3D last_trk - first_trk + 1;
> +	ctidaw =3D trkcount * 2 * (blk_per_trk + 2);

[ ... ]

> +	if (prepare_itcw(itcw, first_trk, last_trk,
> +			 cmd, basedev, startdev,
> +			 0,
> +			 trkcount, blksize,
> +			 datasize,
> +			 tlf,
> +			 blk_per_trk) =3D=3D -EAGAIN) {

[Severity: High]
Can this result in undefined behavior due to a negative bit shift?

The variable trkcount is calculated from the request dimensions and passed =
as
the count argument to prepare_itcw(). If trkcount exceeds 16, does the
operation lredata->extended_parameter[1] <<=3D (16 - count) inside
prepare_itcw() perform a shift by a negative amount?

[ ... ]

> +	/* process data records */
> +	rec =3D first_offs + 1;
> +	rec_count =3D 0;
> +	rq_for_each_segment(bv, req, iter) {

[Severity: High]
Does this iteration safely handle payload-less requests?

If a dataless request, such as REQ_OP_WRITE_ZEROES or REQ_OP_DISCARD, is
processed, the bi_io_vec will be NULL. Will executing rq_for_each_segment()
here cause a NULL pointer dereference? Should this iteration be guarded by a
check to bio_has_data() to ensure the payload is present?

> +		dst =3D bvec_virt(&bv);
> +		seg_len =3D bv.bv_len;
> +		while (seg_len) {

[ ... ]

> +			/*
> +			 * One count + data record per block: a bvec segment can
> +			 * be up to a page, so clamp to blksize - otherwise the
> +			 * count field would describe one oversized record instead
> +			 * of several blksize ones for sub-page block sizes.
> +			 */
> +			part_len =3D min(seg_len, len_to_track_end);
> +			part_len =3D min(part_len, blksize);
> +			seg_len -=3D part_len;
> +			len_to_track_end -=3D part_len;

[ ... ]

> +			last_tidaw =3D add_track_record(itcw, &filldata, &fillsize,
> +						      cyl, head, rec, dst, part_len);

[Severity: High]
Does this emit a separate ECKD COUNT record for each physical memory fragme=
nt
rather than per logical block?

If a logical block spans multiple physical pages and is split into multiple
bvec segments by the block layer, such as an unaligned 4K block crossing a
page boundary, it appears add_track_record() is called unconditionally per
physical fragment.

Will this cause the function to emit two smaller COUNT records instead of a
single 4096-byte COUNT record? This seems like it could break track geometr=
y,
overflow the pre-calculated ctidaw limit by generating additional TIDAWs, a=
nd
prematurely increment the logical record counters.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D11
