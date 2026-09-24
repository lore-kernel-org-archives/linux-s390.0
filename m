Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AE747AF6A
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 12:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251465; cv=none; b=XbKDRBtvHZ4PFGb2BJ7v64fqtfPB2lFpXMAe77XWzQ7vUNZpwUsuKyyrG+UtZvJ1Hhs927juvR/beLr3q6O+0UfG2aPIaAJ5ZZOapV0IXwwb4q6ecpLApahyEtXpYxdJww0YGsv2IKXF7XEB8ulWOglnJSdbPYQhkqPG9h5xoes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251465; c=relaxed/simple;
	bh=21WojGKhbMLkTB8jpF9NNkA5mtnTXieui1vKLjeGYxo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pk89jpVbkaAYEYi3lN754b1NjT8+6IBD040FNYknv4+uKDPFcHcluWZaCwcbnX+k0iQMII3U+6w0Cy27Hqc1I/IVBq42NU/i8tR3+5gAFkUEvIuhuCWE5VTpuXhgK56OOinL8Vwt239QR/1ma+BlPzueXNvpxKOZpB5Bbx5yh0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5eBUttL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5eBUttL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7031F000FF;
	Thu, 24 Sep 2026 12:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790251463;
	bh=jZ+pV2ccrYFnoR2hEed/zAqQJ28jB+4YlLkAucROS8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A5eBUttL4UlIjZrbY7yO5RPZEd5kbfxMwfmb8Vpd//Pt7C5vX5I5vEevOQrSVzROs
	 iAzjJBWJq6k85gFTg9a1wTet8UPQoCdYoocItUmqppqP0xJtjkF9wSk06rsA2imcpN
	 9THZztz8aaXJSPIj20JEYP7C4Kgf+sbb8GxgSjp8A63UUHBw0G2VRJXVvp9E59z9/u
	 +UNoARMX7uiY2kHbGfl3vrdfO9x6fWcqiF+MqtV54xLpeEGYKcZKiBEZVqWCeE89GV
	 WK3KY+D7zJNNX0mmPsNn2RkLjFoWPrPICudeslIpYslVY3UY7TIekYe/a4mWPN+607
	 s0h+olZn/Q5Zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] zfcp: Fix integer underflow in status read buffer
 payload length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ajaykumar Rajappa" <ajaykr@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260924115204.1090452-1-ajaykr@linux.ibm.com>
References: <20260924115204.1090452-1-ajaykr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 12:04:22 +0000
Message-Id: <20260924120423.6A7031F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] scsi: zfcp: payload capture artificially truncated in zfcp_dbf_s=
an_in_els()
--

commit 041b21a7756415603296020fe0feb75f0060af3c
Author: Ajaykumar Rajappa <ajaykr@linux.ibm.com>

zfcp: Fix integer underflow in status read buffer payload length

This commit prevents integer underflows when processing the status read
buffer payload length in zfcp_dbf_hba_fsf_uss() and zfcp_dbf_san_in_els().
It validates that the buffer length reaches the payload area before
subtraction and skips scatterlist setup when the payload is empty.

> diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
> --- a/drivers/s390/scsi/zfcp_dbf.c
> +++ b/drivers/s390/scsi/zfcp_dbf.c

[ ... ]

> @@ -716,15 +717,20 @@ void zfcp_dbf_san_in_els(char *tag, struct zfcp_fsf=
_req *fsf)
>  		(struct fsf_status_read_buffer *) fsf->data;
>  	u16 length;
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
> +	length =3D (srb->length < pay_offset) ? 0 :
> +		 (u16)(srb->length - pay_offset);
> +
> +	if (length)
> +		sg_init_one(&sg, srb->payload.data, length);
> +
> +	zfcp_dbf_san(tag, dbf, "san_els", length ? &sg : NULL, ZFCP_DBF_SAN_ELS,
> +		     length, fsf->req_id, ntoh24(srb->d_id),
> +		     min_t(u16, length, ZFCP_DBF_PAY_MAX_REC));

[Severity: Medium]
Does this artificially truncate the debugging trace payload for incoming ELS
frames?

When an ELS frame larger than 256 bytes is received while tracing is active,
passing min_t(u16, length, ZFCP_DBF_PAY_MAX_REC) here limits the capture to
the first 256 bytes, discarding the remainder of the payload and potentially
losing important debugging information.

The commit message states:

"Payload capture remains bounded by ZFCP_DBF_PAY_MAX_REC, preserving
existing trace behavior for valid status read buffers."

However, the previous code passed length directly as the capture length
argument, allowing zfcp_dbf_san() to write multiple 256-byte trace records
in a loop to capture the entire payload. Could this be updated to preserve
the original behavior of capturing the full payload length?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924115204.1090=
452-1-ajaykr@linux.ibm.com?part=3D1
