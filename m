Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC31453A35
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932258; cv=none; b=ibB+1xppyM9bz/H4CRdCxZyeLEHGhZ90QdRyuGyP0bsJvp9tnvLVnhqB4WitWVJHirwqsQNkrgRO+SIezrJDwvj3Af3v2H1mSeCdH+fsBziKCfYVlTtQiIx/+FKdvR4usjayhBPqW6qQD6Q7ZvneLE2nv25Y9SKOOJAu0h3fFkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932258; c=relaxed/simple;
	bh=CYKrrXLY+T4xdTBbEfHhQQOE8iVc4/orjFGDDT83m2g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jq8sI2+NSloIe9V4ppp62unWqTInZarP9z6JbP6sTKGzcrtSnC3KmAVGqv6TU7mw+0QOXOAfLXnNsm4PvhIXGVLNGdNJ07eBSOHDXsSU4BfaIwNM3yKHopAQ74SL4lVyfxW4Gvv9ZfrIe27WMgLCxfqaVtD7tqYF1O0NPTE9tnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpcxbp7G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpcxbp7G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD5D1F00A3A;
	Wed,  5 Aug 2026 12:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785932256;
	bh=4WQTU88WNHLE8E6IdMICECnvIVacWR3c6MrtZXjqcn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jpcxbp7G1xFjEsB7H0R15YG0qRXCYMC9cckJ1pXEuXWabWBnSPDVitqhc7Vn0Ohqr
	 bu47Qx5wtA54+ttklTgxmx2ISrFYc6FG8BXL+/71TVyLF8y/Kdxdc03n0EVTJrnYHZ
	 QQOMaAFbWjIrVDk+ZbSWu7HuHy2f4azKFGGRZ7NK/6mLOE/zATEpBDEMFgLDtDxeah
	 qqY71pQpAVa9TwPA3acwJSsPYIP9G8WpIQfNYw3o54X3oYUhuBvEsoyvgWORQMSClH
	 TGVwI6Sugi/ApohqdcvMbc5G4KOkLfAhVvD6HXN01pAY+4pmQD9yQsyuJkoV4q38k+
	 ByGGMjgZJmTSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/19] s390/dasd: Propagate partial completion length
 across ERP recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260805111612.1285190-3-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-3-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 12:17:35 +0000
Message-Id: <20260805121736.5AD5D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] NULL pointer dereference in dasd_eckd_ese_read() when handling ERP=
 requests.
--

--- Patch [2]: [PATCH 02/19] s390/dasd: Propagate partial completion length=
 across ERP recovery ---
commit 3cc15afbf5f352896f1c63d6a8c8e105bd9920f3
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Propagate partial completion length across ERP recovery

dasd_default_erp_postaction() copies the timing and device state from
the finished ERP request back to the original request but drops
proc_bytes. A request that was partially completed, an ESE read of a
not-yet-allocated track returns fewer bytes than requested, and then
recovered through the ERP chain loses its partial-completion length.

> diff --git a/drivers/s390/block/dasd_erp.c b/drivers/s390/block/dasd_erp.c
> index 89d7516b9ec86..468f0b2cc3423 100644
> --- a/drivers/s390/block/dasd_erp.c
> +++ b/drivers/s390/block/dasd_erp.c
[ ... ]
> @@ -147,6 +149,7 @@ struct dasd_ccw_req *dasd_default_erp_postaction(stru=
ct dasd_ccw_req *cqr)
>  	cqr->startclk =3D startclk;
>  	cqr->stopclk =3D stopclk;
>  	cqr->startdev =3D startdev;
> +	cqr->proc_bytes =3D proc_bytes;
>  	if (success)
>  		cqr->status =3D DASD_CQR_DONE;
>  	else {

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under
review, but while looking at ERP recovery, can a NULL pointer dereference
occur in dasd_eckd_ese_read() when an ERP request encounters a 'No Record
Found' error?

In drivers/s390/block/dasd.c:dasd_int_handler(), the code resolves the base
request but passes the ERP request directly to ese_read():

		req =3D dasd_get_callback_data(cqr);
		...
		if (rq_data_dir(req) =3D=3D READ) {
			if (device->discipline->ese_read(cqr, irb))

Inside drivers/s390/block/dasd_eckd.c:dasd_eckd_ese_read(), it directly
reads callback_data:

	req =3D (struct request *) cqr->callback_data;
	...
	first_trk =3D first_blk =3D blk_rq_pos(req) >> block->s2b_shift;

Since ERP requests do not have callback_data assigned, could evaluating req
as NULL lead to an immediate dereference in blk_rq_pos()? Would it be safer
if dasd_eckd_ese_read() used dasd_get_callback_data(cqr) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D2
