Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE2D3290AF
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608515; cv=none; b=hw7Fd1FWcCyabHtuqKs6P6td4a9g+f+6oR6XGDxhSt3GIUalc6y9gus8xq65vb0YzfUft1VMxGp6Xu+lnJJAMmXLM8QRj8VzjkcR+vd7IfvtznCJJR43OucAPf6LOEh/MHOg/47Zq8lWExfnEDMKwsUymvAZSMCrFf2YiT3C9l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608515; c=relaxed/simple;
	bh=P+/3gmZM+fI0ND8xRrHQ7UTlDOx7QrQfkchb/vbAbN8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hCaLNTi8UmOvptvYDhGhQgq5KKK96UV37/W8e7aBTIQVuKFLQJVJSvy4A3plLkb0LnUpMIMbx49REfJ5Rbg6QDe1Zd7uDVijn0dWs/Xi9hiFZwowBpdruMxOChBCZp8tJS00sn3w25u4JXD6yHU0B/6bMlhS+UEl8AkKD43WZck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ymg6cfeC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ymg6cfeC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8311F00ACA;
	Sat,  1 Aug 2026 18:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785608514;
	bh=kM1LFl4T1+cUHEjlkrkjVJj0+5yGQj+C6tXoi1b3fGU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ymg6cfeCLxdzj3bnVjOdIB9vKjGjmyyIa1V4rDcGCe4Ck/3Adfk0j/207GXTSb1xH
	 hUV0I5Qs18cFI2RIz7AgtYDCqILVoPc3cSqReLkOpqpbb7AMVQG3s53r7p1FXNy7h0
	 JdpZt4gamn0ydoYsFMcDnpGbzRN0UrT+fWDTBlO1B6p3PMYDWwgtK08ZFoM2bX5naO
	 5rg/GGDKOdrHR6SXJdNQ4vr69meEmL1DPbNKy/utM2dU8TI5DqnmOTszKxzEBn3fMR
	 LTMXlaWQ5lf+beQx/FzBLkREyUiW7CW3LRfCejS3rue2SwU5OsvXraS54j93aFKm1H
	 COfW7orLnrk5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/19] s390/dasd: Add infrastructure for ESE
 full-track write
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260801180033.3679412-9-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-9-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:21:53 +0000
Message-Id: <20260801182154.0D8311F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Block Layer Double Completion due to incorrect handling of aborted=
 origin requests
--

--- Patch [8]: [PATCH v7 08/19] s390/dasd: Add infrastructure for ESE full-=
track write ---
commit f91cc6aad616495ff0e65f3a49886e5137daade3
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Add infrastructure for ESE full-track write

This commit adds the driver internals to build WRITE_FULL_TRACK FCX channel
programs in response to unformatted tracks on ESE devices. It introduces
new CQR states (DASD_CQR_ABORT/ABORTED) intended to retire the origin CQR
of a replaced write without completing it to the block layer.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
[ ... ]
> @@ -1884,6 +1924,17 @@ static void __dasd_process_cqr(struct dasd_device =
*device,
>  	case DASD_CQR_CLEARED:
>  		cqr->status =3D DASD_CQR_TERMINATED;
>  		break;
> +	case DASD_CQR_ABORT:
> +		cqr->status =3D DASD_CQR_ABORTED;
> +		/*
> +		 * ABORT is only set on the block-layer origin write that a
> +		 * full-track format replaces. Clear the callback so the request
> +		 * is not completed here - the replacement completes it. Internal
> +		 * requests never take this path, so no sleep_on waiter is left
> +		 * without its wakeup.
> +		 */
> +		cqr->callback =3D NULL;

[Severity: High]
Will clearing cqr->callback actually prevent the block layer completion?

Clearing the callback avoids the immediate wakeup triggered at the end of
__dasd_process_cqr(), but it appears the request might still be completed
by the block tasklet.

> +		break;
>  	default:
>  		dev_err(&device->cdev->dev,
>  			"Unexpected CQR status %02x", cqr->status);
[ ... ]
> @@ -2767,7 +2819,8 @@ static void __dasd_process_block_ccw_queue(struct d=
asd_block *block,
>  		if (cqr->status !=3D DASD_CQR_DONE &&
>  		    cqr->status !=3D DASD_CQR_FAILED &&
>  		    cqr->status !=3D DASD_CQR_NEED_ERP &&
> -		    cqr->status !=3D DASD_CQR_TERMINATED)
> +		    cqr->status !=3D DASD_CQR_TERMINATED &&
> +		    cqr->status !=3D DASD_CQR_ABORTED)
>  			continue;
> =20
>  		if (cqr->status =3D=3D DASD_CQR_TERMINATED) {

[Severity: High]
If DASD_CQR_ABORTED requests fall through this check, they are moved to the
final_queue. When dasd_block_tasklet() executes, it iterates over
final_queue and calls __dasd_cleanup_cqr() unconditionally for each request:

dasd_block_tasklet()
    list_for_each_entry_safe(cqr, n, &final_queue, blocklist)
        __dasd_cleanup_cqr(cqr);

Since __dasd_cleanup_cqr() ignores cqr->callback and goes on to call
blk_mq_end_request(req, error), could this cause a double-completion in the
block layer, given that the replacement format CQR is also expected to
complete this same request?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D8
