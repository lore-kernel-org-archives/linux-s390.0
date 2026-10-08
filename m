Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E845430F927
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455335; cv=none; b=OxB8a+Wb8tOu9OLJOyyy6aMkE8JwjkHDaWZMNVPFmYD4m4Y1q/KegzPpOStXM8Qmuf2aJpixGyf+DdjHIdqws96IRmqU5kCEhgZzemnY1edcNyGjA1TloFSJjk3JBu9wm8f8Exy9ruTYeNXBCUUJH/5wZ569p1tjrictCpkrtt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455335; c=relaxed/simple;
	bh=phPLK2chpoY1VKziP4mhFA1iN/j31N8qksQmfYdoe5I=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GH+ns+3o+3h2z26aeHs+ZPsn9Fek24VIPTu+9jA4FDeZeQVtjDsRuLqA6AKO1xuUknGFyHB82dLVNHeMSzmI0gxUAHhr1JjXQ4w7NcCEmr/xo43zlFLr5781GtaDYGNpX7w6SgLiveNqyOqZJyiZwdTvvENjakzWtpq67GSNiI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gE3MMJpY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gE3MMJpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336761F000FF;
	Thu,  8 Oct 2026 10:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791455333;
	bh=1RYkxuxfQX0GBnCQX+yPyNWtucOaVKeuPTTTtiNfeqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gE3MMJpYxD9CZiILuuvf119nMXws1pQ7bTeVuuxSO2BoIpArKKMR/JwmMihfxlfDj
	 C11UnFdd17Oy9+GplR7wXRh7ag8QfA1PSXHgv1MtJlOrdlz/uI1b4JSclEyK9y792W
	 YSiyoiZrzaqfeiCs2CbD163KXvtDwuU8NBLdbp4VA28doeM8WRvfqoW6zemtIWFwuo
	 5ioMhRnGYDSUSamLHa/SVyZ0KdyIDOtE6Y/XqnDw2zssmEAZidUP5Jz/X16ZVxzRc3
	 vMbqHDQbLqvfq1b0VNSiWVSobr/E27Q2huAEBzBwHfE1yDKrvRaHCxnzm+VF35r+lS
	 HPBV6J/CEHJxQ==
Message-ID: <sashiko-outbox-164011@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] zfcp: Fix integer underflow in status read buffer
 payload length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ajaykumar Rajappa" <ajaykr@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261008101707.2708257-1-ajaykr@linux.ibm.com>
References: <20261008101707.2708257-1-ajaykr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 10:28:52 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] zfcp: missing upper-bound check on srb->length causes out-of-bound=
s read in tracing
- [Medium] zfcp: trace skipping optimization in zfcp_dbf_san() is broken by=
 full SRB length
--

commit 20c6d5c42ce9fd226b707fb82b26a43e90bfdc4b
Author: Ajaykumar Rajappa <ajaykr@linux.ibm.com>

zfcp: Fix integer underflow in status read buffer payload length

This commit adds checks to prevent integer underflow when calculating
the payload length of a status read buffer (SRB) by verifying that
srb->length is greater than the payload offset. It also modifies
tracing logic for both HBA and SAN paths to conditionally access the
payload only when it exists, while preserving length reporting.

> diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
> index 81fb8af408e9c..fb55d58e363b9 100644
> --- a/drivers/s390/scsi/zfcp_dbf.c
> +++ b/drivers/s390/scsi/zfcp_dbf.c
[ ... ]
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
> +		zfcp_dbf_pl_write(dbf, srb->payload.data, rec->pl_len,
> +				  "fsf_uss", req->req_id, ZFCP_DBF_PAY_LEVEL);

[Severity: High]
Does this code allow an out-of-bounds read if the hardware or firmware retu=
rns
an unusually large srb->length?

While the lower bound underflow is now checked, the srb->length field is an
untrusted 32-bit value populated by hardware/firmware via DMA into a buffer
allocated as a single PAGE_SIZE (4096 bytes) element.

If srb->length is a large value (e.g., 0xFFFF), rec->pl_len will be very
large.

Since there is no upper-bound check against FSF_STATUS_READ_PAYLOAD_SIZE,
could zfcp_dbf_pl_write() read thousands of bytes beyond the allocated
page boundary?

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
> +	length =3D (u16)srb->length;
> +	cap_length =3D 0;
> +	if (srb->length > pay_offset) {
> +		/* Payload present beyond the fixed header. */
> +		cap_length =3D (u16)(srb->length - pay_offset);
> +		sg_init_one(&sg, srb->payload.data, cap_length);

[Severity: High]
Could an unvalidated large srb->length result in an oversized cap_length he=
re
as well?

If a large value is returned, sg_init_one() will initialize a scatterlist
length that extends well beyond the page boundary, causing zfcp_dbf_san() to
read out-of-bounds memory.

> +	}
> +
> +	zfcp_dbf_san(tag, dbf, "san_els", cap_length ? &sg : NULL,
> +		     ZFCP_DBF_SAN_ELS, length, fsf->req_id,
> +		     ntoh24(srb->d_id), cap_length);

[Severity: Medium]
Will this change break the trace skipping optimization in zfcp_dbf_san()?

By passing the full srb->length (including the header) as the len parameter
(the 6th argument) to zfcp_dbf_san(), the len value will always be at least
64 bytes for any valid payload.

Inside zfcp_dbf_san(), the optimization checks:

    if (len <=3D rec_len)
        goto out; /* skip pay record if full content in rec->payload */

Since rec_len is capped at ZFCP_DBF_SAN_MAX_PAYLOAD (48 bytes), this
condition will always evaluate to false, causing the driver to unconditiona=
lly
duplicate small payloads into the secondary pay_buf trace ring.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008101707.2708=
257-1-ajaykr@linux.ibm.com?part=3D1
