Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DC744998D
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 02:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857311; cv=none; b=GzoTdgxOikAuWDAjxBrxitb19J3c0oEdfdBcCiLocAiervfAEKLIUm+U6hBEUnc36Q8oG+Pvn2AiOIPlPQU87EeYBvzZrYagqWYkbekTRyZPE75RTOR3d3i3y8wdZRKBpa3PYn/hLLAOtWJYoxQ2Tk9rOc99bscAvfl5fAxQriY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857311; c=relaxed/simple;
	bh=ZO9TD7sIoRZooePeylAL7tpQhnnXpdvsgQplTMY3uAo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nvt2EFHnm4hzXC/Oks2LGxFHFErEPcuxFrrAA6BVHiuvAphL6oOQ6lEV45b4tOO0yA87cGz+bq7DGMkYahlhCwmBic17iRVXArQNA4KtJmKRD/T/YQlp/mPMczrENs18q6C4taWYmHkq0s5qsBsweWMaDMxo+SiBCQtfn1aSFHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUzWzzOO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUzWzzOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4961F00893;
	Tue, 13 Oct 2026 02:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791857310;
	bh=FG8QvzUR+7zOux6omM+dVOzWgBqPC+FiHWq2KA4hwBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lUzWzzOOwg+BM8N+DVnDmpO96vXfUyp4sJ3PQnTFST9vzIJPU9pU9qRE67vpfQrfN
	 9J9Ss/qIwjhfp5edSisitZF5FGonsfhpVZ647BwKatKth7owm1714hJiDkTXBYQf5I
	 JCE849HTzxtW2m1YWx7qKJpI1BiyiORar7TyEiI124E6F47rOKtLKg4Aw9Jr6+s0sH
	 7bNh5PMucf/QWKaJResvlMchn92eyq2aWE0IGA5oPuPG9zQoy3ZPiX/hSccusP9p7B
	 wvNZY5XiVkSeNIttbfsbukQ6eCN+O9HMf36t/XGl7t0FZtzzzAlBPzXC3QAzYe2PbO
	 q6pIh0tf42s1g==
Message-ID: <sashiko-outbox-168846@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] zfcp: Fix integer underflow in status read buffer
 payload length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ajaykumar Rajappa" <ajaykr@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013020122.48495-1-ajaykr@linux.ibm.com>
References: <20261013020122.48495-1-ajaykr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 02:08:29 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] scsi: zfcp: Build failure due to missing argument in zfcp_dbf_pl_wr=
ite()
--

commit afc6c82d8c1360d9a43afb91aa19a62be2e21438
Author: Ajaykumar Rajappa <ajaykr@linux.ibm.com>

zfcp: Fix integer underflow in status read buffer payload length

This commit addresses integer underflows in zfcp_dbf_hba_fsf_uss() and
zfcp_dbf_san_in_els() when srb->length is smaller than the fixed header siz=
e.
It adds validations to avoid out-of-bounds reads or constructing invalid
scatterlists.

> diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
> index 81fb8af408e9c..a71dc0696d809 100644
> --- a/drivers/s390/scsi/zfcp_dbf.c
> +++ b/drivers/s390/scsi/zfcp_dbf.c
[ ... ]
> @@ -65,6 +65,47 @@ void zfcp_dbf_pl_write(struct zfcp_dbf *dbf, void *dat=
a, u16 length, char *area,
>  	spin_unlock(&dbf->pay_lock);
>  }
> =20
[ ... ]
> +static void zfcp_dbf_srb_len_trace_if_bogus(struct zfcp_dbf *dbf,
> +					    struct fsf_status_read_buffer *srb,
> +					    u64 req_id)
> +{
> +	u32 raw_len =3D srb->length;
> +
> +	if (!raw_len ||
> +	    (raw_len >=3D offsetof(struct fsf_status_read_buffer, payload) &&
> +	     raw_len <=3D sizeof(*srb)))
> +		return;
> +
> +	zfcp_dbf_pl_write(dbf, &raw_len, sizeof(raw_len), "fsf_len", req_id);

[Severity: Low]
Does this call to zfcp_dbf_pl_write() result in a build regression?

The function zfcp_dbf_pl_write() requires 6 arguments, but only 5 are
provided here. The level argument is missing.

> +}
> +
[ ... ]
> @@ -253,13 +295,30 @@ void zfcp_dbf_hba_fsf_uss(char *tag, struct zfcp_fs=
f_req *req)
>  	rec->u.uss.s_id =3D ntoh24(srb->s_id);
>  	memcpy(&rec->u.uss.res4, &srb->res4, sizeof(rec->u.uss.res4));
> =20
> -	/* status read buffer payload length */
> -	rec->pl_len =3D (!srb->length) ? 0 : srb->length -
> -			offsetof(struct fsf_status_read_buffer, payload);
> +	/* pl_len is the payload length (srb->length - pay_offset) as long as
> +	 * srb->length is valid. For a bogus srb->length it is only derived
> +	 * from it and the raw length is traced as "fsf_len" below.
> +	 */
> +	rec->pl_len =3D zfcp_dbf_srb_pl_len(srb);
> +
> +	/* Only access payload bytes when srb->length actually covers them.
> +	 * Bounds are checked on the full 32-bit value (before any u16
> +	 * truncation). An oversized srb->length is not dropped: the payload
> +	 * is traced up to the end of the payload array (diagnostic value).
> +	 */
> +	if (srb->length > pay_offset) {
> +		u32 cap_len =3D srb->length - pay_offset;
> =20
> -	if (rec->pl_len)
> -		zfcp_dbf_pl_write(dbf, srb->payload.data, rec->pl_len,
> -				  "fsf_uss", req->req_id, ZFCP_DBF_PAY_LEVEL);
> +		if (cap_len > FSF_STATUS_READ_PAYLOAD_SIZE)
> +			cap_len =3D FSF_STATUS_READ_PAYLOAD_SIZE;
> +		zfcp_dbf_pl_write(dbf, srb->payload.data, cap_len,
> +				  "fsf_uss", req->req_id);

[Severity: Low]
Could this be missing the level argument (ZFCP_DBF_PAY_LEVEL) as well?

This call to zfcp_dbf_pl_write() drops the 6th argument that was present
in the previous implementation, which also causes a build regression.

> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013020122.4849=
5-1-ajaykr@linux.ibm.com?part=3D1
