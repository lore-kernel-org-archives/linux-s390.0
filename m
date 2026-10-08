Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D295484237
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454088; cv=none; b=ahiU0kd2TYHazuChK2zw+Q37TrryQZIbS9abr7MucJcbvVojq65V2fJ37PtpvOH4mYS5TBEar+DnTWTLvD5xzDyflccZL0y00NOs+9V0KoGemh0/FRdqy1wV6z8tlgpTyTS9mh/fqIBzj0FEDi2VivSCpe5iUVnzLbHwpCOHKec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454088; c=relaxed/simple;
	bh=AGXFSIJfQvdSdEzk3LbsPQ2AhE7k2Uq1uDJRbO2mEPo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qs5IKWCLdeCMmKfnmV846u0+qpDkXRuvWfTSy0YtSbn8ZrfmM0/CTYiWhaGCSLcTqbJI5Jc22ejtv3PkPUAEMTKVyhhFk67IlrntKS14MTo50RSuKHd0ov296lieB+SVlmtHFc7VPtPvw6JJ+ApxuK0/Oglnzp31uBgd5iqHTfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgMC9jwi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgMC9jwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705F11F000FF;
	Thu,  8 Oct 2026 10:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791454083;
	bh=TGw1J1vQD8DEBeq1+FVHofOnPBTvLogRJ5KBQZFWHh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GgMC9jwiGuyLoroRXLu7YkqBi1RFEc+2KyFqDIlTTxolF1WB3YvltWAVWpAtiGKxf
	 DmJTxR/07gAmrVOg6pO5lM5j5CBxIgbcqLRNPUaztYwiwbOaxMNfecoVEnvHdJ1XRI
	 BoLD7rmr7AZSXY+gVullmFAkjC3u4xudhn6tQmPkQVtLHMkxAZq9lAvdi51hmZOO5A
	 mpmrZYDyhioNmejdl6Q1OYiPl204peLx1+eHOdsk1wwBLG8jpXCuMkf2IHI5lzY/H+
	 MQJjBi6WHDSpvuth4JwYWquBTflRBAGlSRBfTtQGRmqSa7xsoUS8w3BfPmq+5jNc8Z
	 lJbzrZW1WAGcg==
Message-ID: <sashiko-outbox-163996@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] zfcp: Fix integer underflow in status read buffer
 payload length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ajaykumar Rajappa" <ajaykr@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261008095757.1813357-1-ajaykr@linux.ibm.com>
References: <20261008095757.1813357-1-ajaykr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 10:08:03 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] zfcp: Build failure due to missing 'level' argument in zfcp_dbf_pl_=
write() call
--

commit cd0f8c110960ca9697ab6d9c8ecf78b8b828c640
Author: Ajaykumar Rajappa <ajaykr@linux.ibm.com>

zfcp: Fix integer underflow in status read buffer payload length

This commit fixes an integer underflow in status read buffer length
calculations by validating the payload access against the payload offset.
It prevents payload reads when the buffer length does not reach the payload
area, while maintaining existing tracing formatting.

> diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
> index 81fb8af408e9c..c5501eae99772 100644
> --- a/drivers/s390/scsi/zfcp_dbf.c
> +++ b/drivers/s390/scsi/zfcp_dbf.c

[ ... ]

> @@ -253,13 +254,17 @@ void zfcp_dbf_hba_fsf_uss(char *tag, struct zfcp_fs=
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
> -				  "fsf_uss", req->req_id, ZFCP_DBF_PAY_LEVEL);
> +				  "fsf_uss", req->req_id);

[Severity: Low]
Does this change break the build? The function zfcp_dbf_pl_write() is=20
defined as requiring 6 arguments:

static inline
void zfcp_dbf_pl_write(struct zfcp_dbf *dbf, void *data, u16 length,
                       char *area, u64 req_id, int level)

However, the modified call above drops the 6th argument=20
(ZFCP_DBF_PAY_LEVEL), which will result in a 'too few arguments to function=
'=20
compilation error.

>  log:
>  	debug_event(dbf->hba, level, rec, sizeof(*rec));
>  	spin_unlock_irqrestore(&dbf->hba_lock, flags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008095757.1813=
357-1-ajaykr@linux.ibm.com?part=3D1
