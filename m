Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2E044E66E
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192831; cv=none; b=R0iTjmNwpwVx3XY+a6au9ZFDdJCV2iKCuqKV98SDJGMgge1C+niP6f/2+XkHdf6eNo9fu5JTVEOhO6pTDM9ZbeFlzR7tNdyzLXpW56YcgL7NeO4VaHCreCM3WDPfpPjck9ZHq3Yu8aUNthCuDHiqUIL37VeP1kSDB6x8Qba5NBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192831; c=relaxed/simple;
	bh=zwKtJzJBgMA2iAu6EyGxbg77BRNXSEJiC16RrdgvDwM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kZZvAN64L5l1raY7evgnrx5CugFzSCtscTJQnOIM7vkSjhEQiQnP70y5sB4p/0PB5irZ/jMgXVzZCz9j1nluoG/IlaFn+FB0y5efVHwxDr7Bqmidh/tcHGE+U7ArwauVVY7nsteInI/NDknbm0ZpjAndlQ+KYfYh+eT9ss1vW6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IB7EL/Rw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IB7EL/Rw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661CF1F000FF;
	Mon,  5 Oct 2026 09:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791192819;
	bh=r80NvGhASWk8TvC8TUWo9RITArCcc7fqkzlkSBw8R1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IB7EL/RwFuirajmOcKO7Bkc3x4Z6iuIogKPvv5ov5j6T+gA+ce8IwHcWvc/36KUjc
	 kRawj5bqcouBR04ESeuD6/Z90m7B9M0JUivjAwUahQir/w8fngt+hs3mcI5LyDG9eA
	 4VoHuPTtQLzQVl/14ql7c/EbNJlCCTENd9rGN1VmHnUWT8neJplTuz7xd7kbzBtNAy
	 Oa+ziAe/IaPMBEQhZZd2uBbe65AFhpJr6degqBcWPviAaV09Br8DifEsHhSMnto20Z
	 lxe8cGwmviQB0zImYkO2JHvPRKXn7+Kx7HdQd8RYA9dRuaudNr6U24kBIVSRJUC5J2
	 IYH7AqNY/SclA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] zfcp: Fix integer underflow in status read buffer
 payload length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ajaykumar Rajappa" <ajaykr@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261005092357.2747395-1-ajaykr@linux.ibm.com>
References: <20261005092357.2747395-1-ajaykr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 09:33:39 +0000
Message-Id: <20261005093339.661CF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] scsi: zfcp: build failure due to stray non-breaking space
--

commit 2a8ab7a51f83082138fe5de204f20c12d0e7bf28
Author: Ajaykumar Rajappa <ajaykr@linux.ibm.com>

zfcp: Fix integer underflow in status read buffer payload length

This commit fixes an integer underflow in zfcp_dbf_hba_fsf_uss() and
zfcp_dbf_san_in_els() when srb->length is smaller than the fixed header
size, preventing an out-of-bounds read. It ensures payload access is skipped
if the buffer is too small, while maintaining the correct tracing semantics.

> diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
> index 81fb8af408e9c..d487e9bb15617 100644
> --- a/drivers/s390/scsi/zfcp_dbf.c
> +++ b/drivers/s390/scsi/zfcp_dbf.c

[ ... ]

> @@ -714,17 +716,34 @@ void zfcp_dbf_san_in_els(char *tag, struct zfcp_fsf=
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
> +	if (srb->length < pay_offset) {
> +		/*
> +		 * Invalid buffer: record the reported SRB length in pl_len
> +		 * for tracing, but capture no payload.
> +		 */
> +		length =3D srb->length;
> +		cap_length =3D 0;
> +	} else {
> +		/*
> +		 * Valid buffer: record the payload length in pl_len
> +		 * and capture the payload.
> +		 */
> +		length =3D (u16)(srb->length - pay_offset);
> +		cap_length =3D length;
> +=C2=A0
> +		sg_init_one(&sg, srb->payload.data, length);

[Severity: Low]
Does this code contain a stray non-breaking space character?

The blank line right above the sg_init_one() call in zfcp_dbf_san_in_els()
contains a non-breaking space (U+00A0). This will unconditionally cause a
compiler syntax error ('stray \302\240 in program') when building the
driver.

> +	}
> +
> +	zfcp_dbf_san(tag, dbf, "san_els", cap_length ? &sg : NULL,
> +		     ZFCP_DBF_SAN_ELS, length, fsf->req_id,
> +		     ntoh24(srb->d_id), cap_length);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005092357.2747=
395-1-ajaykr@linux.ibm.com?part=3D1
