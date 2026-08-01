Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A83359A9B
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583783; cv=none; b=piMDqZIFhEw6aUkgLsgMsO6eZG6ZzYNdQbAMFSsy75nzcr8Hqdmx48YNfaqzZLITXsQWvlp5SNae5lcW0HcBtaAqhqDvUBvEFBKr5ZYD/xTR8FVVBlWaoDg/DRAAPQ08A7M+20cUelsM+x/7AeVq6P+5n+HxAS2d5RNMC8e2K5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583783; c=relaxed/simple;
	bh=xkPVFxGkfT9RHrP8AQIP9jLF+KmwOvP/xj8Nxz9FAJc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gR7EpKkOKRRe87IfILYBDdLKu0UZdHoBG5hBeYjmrGum22Kjawe+BDStoj93WQQ02GSw7H5AfmhaTXQqFvpbKOHM/tG8v/jPtdRK6tEPDagfwQ1bgdT5pAvc6jfl2pTJ0Ghiy+hqdz2aqliTzFO9J9Vg+zu7hYgeacMwpNbFBZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNfrAJJr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNfrAJJr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482921F00AC4;
	Sat,  1 Aug 2026 11:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785583782;
	bh=pbBcNcMkJ/O9WLK4yrWpDG7xXGR0BUyBooXHZQmTJSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SNfrAJJre9YE9cg3T9ynEwyuwjGZ2GNod0pwKU7dCmrhQb6lo6863wY9f2UAKQFl3
	 fwWbAxgqWKWICTEovvMHridKBnfUsbvuY/4EbxaShqpQyToADtV8otK9dcxAq2q/9M
	 TGb42tfakuSxVFKUJlMGqPsLFUz4CcXUXKjETKzoz51GxyNKC6NZRIKDTZNFlp80Bt
	 R/fJu64dxzdjLGsdiYL31OtendTgevZMN0MyR8c0uM+VASprFl39ZvkCAUufzx6as+
	 LbkrfE/jCgEsdigptXO0+7nMMNYvIjRmb75ZGXMlsOVbCOuTAJbfQZnaPjmfdeLIfU
	 Rq9b/2UJIvGBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/18] s390/dasd: Add
 dasd_eckd_build_cp_tpm_writefulltrack()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260801111008.3391031-11-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
 <20260801111008.3391031-11-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:29:41 +0000
Message-Id: <20260801112942.482921F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Missing bio_has_data() guard before iterating request segments.
- [High] Negative bitshift in prepare_itcw() exposed by unrestricted track =
count.
- [High] Premature loop termination and disk format corruption due to split=
 bio_vec segments being mapped 1:1 to disk records.
- [Medium] Silent bypass of errors from prepare_itcw() other than -EAGAIN.

Pre-existing issues:
- [Critical] Pre-existing missing bio_has_data() guards in CMD and TPM trac=
k builders.
--

--- Patch [10]: [PATCH v6 10/18] s390/dasd: Add dasd_eckd_build_cp_tpm_writ=
efulltrack() ---
commit c49275335fe037682ab8442e739559068d7eb61c
Author: Stefan Haberland <sth@linux.ibm.com>
Subject: s390/dasd: Add dasd_eckd_build_cp_tpm_writefulltrack()

This commit adds the channel program builder for WRITE_FULL_TRACK requests.
It builds an ITCW with a TIDAW list for formatting and writing tracks
atomically on ESE devices.

> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
[ ... ]
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

[Severity: Medium]
Does this code handle other negative error codes from prepare_itcw() proper=
ly?

If prepare_itcw() returns an error like -EINVAL, the check for -EAGAIN
evaluates to false, and the function will continue as if it succeeded. Could
this submit an incomplete ITCW program to the hardware?

[Severity: High]
Can this lead to a negative bitshift in prepare_itcw()?

The trkcount variable is calculated based on last_trk - first_trk + 1 and
passed as the count parameter to prepare_itcw(). Looking at prepare_itcw()
for the DASD_ECKD_CCW_WRITE_FULL_TRACK case:

prepare_itcw() {
    ...
    case DASD_ECKD_CCW_WRITE_FULL_TRACK:
        ...
        if (count > 8) {
            lredata->extended_parameter[0] =3D 0xFF;
            lredata->extended_parameter[1] =3D 0xFF;
            lredata->extended_parameter[1] <<=3D (16 - count);

If a request spans more than 16 tracks, the count passed in will exceed 16,
resulting in a negative shift amount. Should there be bounds checking on
trkcount before passing it here?

[ ... ]
> +	rec_count =3D 0;
> +	rq_for_each_segment(bv, req, iter) {

[Severity: Critical]
Does this loop need to verify that the bio actually contains data?

According to block layer subsystem guidelines, iterating segments without
checking bio_has_data() can cause a NULL pointer dereference for operations
that have no data buffers (such as REQ_OP_WRITE_ZEROES). Even if op_is_writ=
e()
is true, data fields shouldn't be accessed without this guard.

[ ... ]
> +			last_tidaw =3D add_track_record(itcw, &filldata, &fillsize,
> +						      cyl, head, rec, dst, part_len);
> +			if (!last_tidaw)
> +				goto out_error;
[ ... ]
> +			rec++;
> +			dst +=3D part_len;
> +			rec_count++;
> +			if (rec_count >=3D (last_rec - first_rec + 1))
> +				goto out_skip;
> +		}
> +	}

[Severity: High]
Could this terminate the loop prematurely and corrupt the disk format?

If a logical block crosses a page boundary, the block layer will split it i=
nto
multiple smaller bio_vec segments. Because this loop increments rec_count f=
or
every segment iteration and emits a track record, split segments would be
written as multiple short records rather than a single full block.

Should rec_count be incremented based on the accumulated logical block size
instead of mapping one-to-one with the bio_vec segments?

[ ... ]
> static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_track(
[ ... ]
> 	rq_for_each_segment(bv, req, iter) {

[Severity: Critical]
This is a pre-existing issue, but does this function also need a
bio_has_data() guard before iterating segments?

Similar to the newly added dasd_eckd_build_cp_tpm_writefulltrack(),
iterating over request segments here after only checking
rq_data_dir(req) =3D=3D WRITE will cause a NULL pointer dereference on
operations like REQ_OP_DISCARD or REQ_OP_WRITE_ZEROES that do not carry
data buffers.

[ ... ]
> static struct dasd_ccw_req *dasd_eckd_build_cp_tpm_track(
[ ... ]
> 	if (rq_data_dir(req) =3D=3D WRITE) {
> 		new_track =3D 1;
> 		recid =3D first_rec;
> 		rq_for_each_segment(bv, req, iter) {

[Severity: Critical]
This is also a pre-existing issue, but does the loop in
dasd_eckd_build_cp_tpm_track() suffer from the same missing bio_has_data()
guard?

Operations without data buffers will trigger a NULL pointer dereference
during segment iteration here as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801111008.3391=
031-1-sth@linux.ibm.com?part=3D10
