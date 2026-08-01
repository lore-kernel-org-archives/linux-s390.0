Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007573BAD9A
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785609187; cv=none; b=eB9Po8qm1CIF3lNzUyetLwh5xt0CDlQMT6fLP5fAwnrOhg1P7D5nb2xjKgLZdB29SJ9+ePls2cK5+BbZMtYybb9KJtNBub2es/KdRRsp3IWVoxsD/6AfkG7p4XQS1WpGnTONyYx/ntWd6+rTCOTkABzmbSVJETYPAfPQ3oBBAoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785609187; c=relaxed/simple;
	bh=66XDwlpWZb7mIeF9QkMMUFPd1n5G++4hG6Qzl/7FKCg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UH2yke2Z8v5G+phX261uuzGHRk+4rPE+izifzGvUaJhSGspxOXn6r/K2yfokaLeH4af6bSmSPHGBe+JaM3xWTmllXf7+IKgrGmchbGEQLYzC2hfUnkGaHkbaijrmwNMbXw4vwlrCLpNRmYJwSJmCm4AjQ+QCc+w9HwJynm89Kzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRF1LYml; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRF1LYml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733E41F00AC4;
	Sat,  1 Aug 2026 18:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785609185;
	bh=OFQ87fVek4Idd49xuQ5bCRA5vqcoa3xSgPeSAHkP+qo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QRF1LYmlZsh9QYUfX/zqOIUR6qOjyTLApH0ECB6TP/ohYCXOXYjc1bgdbVpPp79fZ
	 vVQQaSp1hF4gtCaXxoS7IcXHLI3Cw/yTuWtG8EQrV28lC70+KTSOZRGmMZNFjGKmXf
	 HC09aldTnqX+/2vQuaee7tYqSZWiwWQjVa96MpKvo+3FlAW5uvf54UVfknuiypyCte
	 BXCyd4C9XNTcwIxQ2xuoujpFUhm9npsODqxPjxa5fM2FHTHhvd0ks8xjqKfspdejdd
	 ItbKkVvcKv9HN30mLnpEq6seHCVS1kIEA4/n9xWnWEg3FBl8FssZx9FUBSqHjolHqs
	 BRgMz4RDIk0cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/19] s390/dasd: Use WRITE_FULL_TRACK in ESE format
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260801180033.3679412-13-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-13-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:33:05 +0000
Message-Id: <20260801183305.733E41F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] When the `dasd=3Dfixedbuffers` (`dasd_page_cache`) module paramete=
r is enabled, `dasd_eckd_free_cp()` misinterprets the unconditionally creat=
ed transport-mode (TPM) ESE format replacement request as a command-mode (C=
CW) request, causing invalid frees of arbitrary memory.
--

--- Patch [12]: [PATCH v7 12/19] s390/dasd: Use WRITE_FULL_TRACK in ESE for=
mat handler ---
commit e3d3248abe2fbc8a98e5dc48c8f9561bcf553195
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Use WRITE_FULL_TRACK in ESE format handler

Wire dasd_eckd_build_cp_tpm_writefulltrack() into the ESE unformated
track handler.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 475c0aca4a5ae..e731d7e183121 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
[ ... ]
> @@ -5328,6 +5399,15 @@ dasd_eckd_free_cp(struct dasd_ccw_req *cqr, struct=
 request *req)
>  	sector_t recid;
>  	int status;
> =20
> +	/*
> +	 * A format-aborted request finished nothing - its replacement
> +	 * completes the block request - so report ABORTED instead of DONE,
> +	 * but still release its bounce buffers like any other request.
> +	 */
> +	if (cqr->status =3D=3D DASD_CQR_ABORTED)
> +		status =3D DASD_CQR_ABORTED;
> +	else
> +		status =3D cqr->status =3D=3D DASD_CQR_DONE;
>  	if (!dasd_page_cache)
>  		goto out;

[Severity: High]
Can this corrupt memory when the dasd_page_cache module parameter is enable=
d?

The new ESE format replacement request created by
dasd_eckd_build_cp_tpm_writefulltrack() unconditionally sets cqr->cpmode =
=3D 1
(Transport Mode) and uses an ITCW, regardless of dasd_page_cache.

However, the replacement request takes ownership of the block request in
dasd_eckd_ese_format():

    fcqr->callback_data =3D base_cqr->callback_data;

This causes the replacement request to be routed here to dasd_eckd_free_cp()
upon completion.

If the kernel is booted with dasd=3Dfixedbuffers (which enables
dasd_page_cache), dasd_eckd_free_cp() will proceed past this check since
dasd_page_cache is true.

Because dasd_eckd_free_cp() lacks a check for cqr->cpmode =3D=3D 0, it appe=
ars
this could cause dasd_eckd_free_cp() to iterate over the ITCW memory as if =
it
were a list of struct ccw1, extract garbage addresses, and pass them to
kmem_cache_free().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D12
