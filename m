Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A014376BF4
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791789115; cv=none; b=HBtIkGfhNgdnjSXXmqlf8Gji7e6pa+6Xsc+d09XwZ2FpwmCb8g4QtMa5TboohVf3Qi/3mQtIlmTUOur+J9SOrTnrO1HsFK1t/dNNxbtjHZyfMt4j++qKidEpohgKSYa4b67ZIwkLXRJ4D9Fsoc+yWxi+vfoahtsnghy17X8hGZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791789115; c=relaxed/simple;
	bh=bKGvTrX2DSB+tAD9zViC7isBe7ZN4KeKNY1ErgZ2TLI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dop+wMKRM6HS4R5p5/GhLNFZNkaTvEyxSss42Q6cfJVPuTNT0/Iy/PKbOP2AQRySCnwRjY8aHgQ5r+uFMIQfpaEkL1GuyV9kM0ku0W8tatszpThNA+LI4Uq2ncIa7LlSFHcalz380U6owjLUuP79fi3T0ExSofCbw+SaqIOKp6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvEEg3Tk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvEEg3Tk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540951F0089B;
	Mon, 12 Oct 2026 07:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791789113;
	bh=ka+IQ1F2+PE3xlXCKH2rUyNMDLcN0CDWb/miEOIFVuE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gvEEg3Tk4dCizUuYSUj4b8I3OMEzU11DKYj5fS/QIRjwHyoN3jHbQf20GrAGStVGq
	 6PgMt7e/PUm9hshbPXTejgm9uZLqK7r8jnf2pRKhRrbOCORLc32VxnTYicOyd8SIqA
	 Is3P7/dKHh1uR8ne4TlHmv7bXk9P5aFvNvvHPV7mpHEYctZ4h0UMXRJuU0mnVD/if8
	 0CLSJAGovcj9g3vIUX59nbnSUwgQi5RB5WlNliUau3LhHTCKQrw9tFoncL/M6IV4ho
	 3PIUn1HZ+JfiWd7lkbWvUrsgFjInxNhjCEYdxUP8bjtBNBjSSHvUyk058H8k3QiYz6
	 2Yb3BeKj09Gwg==
Message-ID: <sashiko-outbox-167780@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] zfcp: Fix integer underflow in status read buffer
 payload length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ajaykumar Rajappa" <ajaykr@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261012070220.2113411-1-ajaykr@linux.ibm.com>
References: <20261012070220.2113411-1-ajaykr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 07:11:52 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] scsi: zfcp: redundant trace records generated due to srb->length se=
mantics change
- [Low] scsi: zfcp: 32-to-16 bit truncation breaks trace ambiguity goal for=
 large anomalous lengths
--

commit 461d7fe95c4b53bf3dfb0dc33b64ab47c7c0b0f4
Author: Ajaykumar Rajappa <ajaykr@linux.ibm.com>

    zfcp: Fix integer underflow in status read buffer payload length

This patch fixes an integer underflow when calculating the payload
length of a status read buffer in zfcp_dbf_hba_fsf_uss() and
zfcp_dbf_san_in_els(). It validates payload access against the
payload offset before reading payload bytes, while keeping the
serviceability trace records intact.

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

[Severity: Low]
Could this 16-bit truncation break the trace ambiguity goal for large
anomalous lengths?

The inline comment claims this creates a "bijective map" that makes anomalo=
us
lengths unambiguously distinguishable from a genuine empty payload. However,
srb->length is a 32-bit field, whereas rec->pl_len is a 16-bit field.

If the hardware provides an anomalously large length (for example,
srb->length =3D=3D 65536 + pay_offset), the subtraction yields 65536, which
truncates to exactly 0 when cast to u16.

Would this map the anomalous length to exactly 0, making it entirely
indistinguishable from a genuine empty payload and mathematically violating
the stated tracing design goal?

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
> +	}
> +
> +	zfcp_dbf_san(tag, dbf, "san_els", cap_length ? &sg : NULL,
> +		     ZFCP_DBF_SAN_ELS, length, fsf->req_id,
> +		     ntoh24(srb->d_id), cap_length);

[Severity: Low]
Does passing the full srb->length to zfcp_dbf_san() break the length
optimization check inside the trace function?

Inside zfcp_dbf_san(), this length argument is compared against a maximum
inline payload size (ZFCP_DBF_SAN_MAX_PAYLOAD, 48 bytes) to optimize tracing
by determining if a separate payload trace record can be skipped:

    if (len <=3D rec_len)
        goto out;

Because the full srb->length includes the 60-byte fixed header (pay_offset),
length will always be at least 60 for any valid incoming ELS request.

Consequently, the check length <=3D rec_len will always evaluate to false.

Can this lead to unconditional and redundant generation of payload trace
records for all payloads, needlessly duplicating data and wasting trace
buffer space?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012070220.2113=
411-1-ajaykr@linux.ibm.com?part=3D1
