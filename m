Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8501D388885
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790150; cv=none; b=EGGBBdP+aRl/bE3bkrO0JOA0ScY1+tu/UoC8uUg6bJCPW8CWrwzC/ghAvo8N8QFYUdaQ46WMG8e3n6XVF77uO9FTk/O3mKqVTtdby6R/K4TkidcElDThxIzIcVYm5sCouOxV7tmlo6gEWDsL9DcJzp6x6SalCQqHEsohMDWHBoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790150; c=relaxed/simple;
	bh=DsDvEbCppFri4yhHvA2DsYoww5fJEyb4A0VXlinUMsE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cN9QB+GSv6n3FCX2GYbiGpji/jeGd0JtOvxipaM2BB073UYoE3vA0zcDq/Z8n9BbKBnvqM4v1ERoagPejBCjbRKH/pUPh6WbZf4A9E9/L84ql0WZ7CyF9NcQFlzWdS3V3C5Oew89LLai1TJuhEl1lkEJiRsaZ/F8d0OOlotv3iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6dV8mJD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6dV8mJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095801F0089B;
	Mon, 12 Oct 2026 07:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791790149;
	bh=sEblkwdrlF2wMSuCNF3KAKUYzCHTVhniG2JBQxbjrfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D6dV8mJDBBhyOdwYbpgZrIlx2FcUCqRZzUByGXGCJ22mSImA4RcEufSFpn/zg86ZN
	 5+aO2UVeeJwjaPLc4TcD9wb5ZymkGAVDd4+PwAiIkERjE69eep8qQMLWebUXNUcJq0
	 XHcI8KYIGj9L7R4yTvbNYic8DVQuqKNmEiZYIJ4qSqLp8QQGWMtX6x/svmwfmybrL+
	 NepI+iOvRUhf4KfOcC45FXyHc9S5fOmcVvWmae/fiD0SX2USwscY9xVi6x+uY/sflc
	 KovND3ASPW2M4gb42v7eOA1jjk61VqNRX/g7sVFispAXN7J+fQEQIKE4DPewIlFUhY
	 kR0eX7+/qHssQ==
Message-ID: <sashiko-outbox-167791@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] zfcp: Fix integer underflow in status read buffer
 payload length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ajaykumar Rajappa" <ajaykr@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261012071448.2615114-1-ajaykr@linux.ibm.com>
References: <20261012071448.2615114-1-ajaykr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 07:29:08 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] scsi: zfcp: missing upper bound check on srb->length causes OOB re=
ad
- [Low] scsi: zfcp: SAN trace records shifted payload length instead of ori=
ginal SRB length
--

commit ec8a852f3f0b67cb59348b79e8e128f1309b9283
Author: Ajaykumar Rajappa <ajaykr@linux.ibm.com>

    zfcp: Fix integer underflow in status read buffer payload length
   =20
    zfcp_dbf_hba_fsf_uss() only guards against a zero-length status read
    buffer. If srb->length is smaller than the fixed header size of
    struct fsf_status_read_buffer, subtracting the payload offset
    underflows and can lead to an out-of-bounds read.

> diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
> index 81fb8af408e9c..6c85f5598a551 100644
> --- a/drivers/s390/scsi/zfcp_dbf.c
> +++ b/drivers/s390/scsi/zfcp_dbf.c
> @@ -253,11 +254,15 @@ void zfcp_dbf_hba_fsf_uss(char *tag, struct zfcp_fs=
f_req *req)
>  	rec->u.uss.s_id =3D ntoh24(srb->s_id);
>  	memcpy(&rec->u.uss.res4, &srb->res4, sizeof(rec->u.uss.res4));
> =20
> -	/* status read buffer payload length */
> -	rec->pl_len =3D (!srb->length) ? 0 : srb->length -
> -			offsetof(struct fsf_status_read_buffer, payload);
> +	/* Unconditionally store value-shifted SRB length: pl_len is a bijective
> +	 * map of srb->length (pl_len + pay_offset =3D=3D srb->length). A bogus
> +	 * srb->length < pay_offset wraps to a large non-zero pl_len, which is
> +	 * unambiguously distinguishable from pl_len =3D=3D 0(genuine empty pay=
load)
> +	 */
> +	rec->pl_len =3D (u16)(srb->length - pay_offset);
> =20
> -	if (rec->pl_len)
> +	/* Only access payload bytes when srb->length actually covers them. */
> +	if (srb->length > pay_offset)
>  		zfcp_dbf_pl_write(dbf, srb->payload.data, rec->pl_len,
>  				  "fsf_uss", req->req_id, ZFCP_DBF_PAY_LEVEL);

[Severity: High]
Does srb->length need an upper bound check in zfcp_dbf_hba_fsf_uss() here?

If the firmware reports a large length (e.g., 65535), rec->pl_len will be
around 65471. Since the status read buffer is only 4096 bytes in size,
wouldn't this cause zfcp_dbf_pl_write() to read out of bounds past the page
boundary and potentially leak adjacent kernel memory into the trace buffer?

[ ... ]

> @@ -714,17 +719,28 @@ void zfcp_dbf_san_in_els(char *tag, struct zfcp_fsf=
_req *fsf)
>  	struct zfcp_dbf *dbf =3D fsf->adapter->dbf;
>  	struct fsf_status_read_buffer *srb =3D
>  		(struct fsf_status_read_buffer *) fsf->data;
> -	u16 length;
> +	u16 length, cap_length;
>  	struct scatterlist sg;
> +	const u32 pay_offset =3D offsetof(struct fsf_status_read_buffer, payloa=
d);
> =20
>  	if (unlikely(!debug_level_enabled(dbf->san, ZFCP_DBF_SAN_LEVEL)))
>  		return;
> =20
> -	length =3D (u16)(srb->length -
> -			offsetof(struct fsf_status_read_buffer, payload));
> -	sg_init_one(&sg, srb->payload.data, length);
> -	zfcp_dbf_san(tag, dbf, "san_els", &sg, ZFCP_DBF_SAN_ELS, length,
> -		     fsf->req_id, ntoh24(srb->d_id), length);
> +	/*
> +	 * Store the original channel-reported SRB length in pl_len.
> +	 * cap_length specifies the number of payload bytes that may be read.
> +	 */
> +	cap_length =3D 0;
> +	length =3D (u16)srb->length - pay_offset;
> +	if (srb->length > pay_offset) {
> +		/* Payload present beyond the fixed header. */
> +		cap_length =3D length;
> +		sg_init_one(&sg, srb->payload.data, length);
> +	}

[Severity: High]
Does this length also need an upper bound check in zfcp_dbf_san_in_els()
for the same reason?

If srb->length is large, this could initialize the scatterlist with an
unbounded length derived directly from firmware.

> +
> +	zfcp_dbf_san(tag, dbf, "san_els", cap_length ? &sg : NULL,
> +		     ZFCP_DBF_SAN_ELS, length, fsf->req_id,
> +		     ntoh24(srb->d_id), cap_length);
>  }

[Severity: Low]
Does this code preserve the original channel-reported SRB length in the
trace record as stated in the commit message?

The commit message and comments state the original SRB length should be
preserved, but this passes the value-shifted length instead of the original
srb->length to zfcp_dbf_san().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012071448.2615=
114-1-ajaykr@linux.ibm.com?part=3D1
