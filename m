Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0254341F7C1
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930524; cv=none; b=t8Wodlsi47eKlrmFITmceN1FpHQv0EqNfFTexpirks2fj2laf/zLYCjCDj3agtasXJUqfLspYpz/cHLZxJrOpii1YHT1LQLTzHb5rYBkiaZ1zSadHqm/dKh2FxH+UQf/HAAWeB6J7iKwt+53xu7sOxyMp8tTdfhyaFonCvyQ4sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930524; c=relaxed/simple;
	bh=xAl5pX2rGBf79ffzDKh5/EeHJtmPUb4gYxCrNGsOJD0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cLUcixwdb/enjYc71Z38lpq7QzCvmicTHoxENf02OBpY8lVTUsEW7W1IZM7af06S0rnpfdQignavbIHALxmO2prFZYlQB8CMxyM9PTH6klXRe/ni6MfqejJslP6OnHzuckZv/dPNaSgCXOeCdnUI+ntSuBwiVwTgwri3atlOVxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjbdKO5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjbdKO5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8364B1F00A3D;
	Wed,  5 Aug 2026 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785930522;
	bh=uaIJuL4Tg3mE8T9hvm+qdAh/LtWznka8unjP8idt/Dg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SjbdKO5Mz9wxwhdl23vRM3CLvhNR+pPKGHLedq8geO8pRrWCMgHwCtgv3lywt67ad
	 yY+Aq+bG1Ewavhvgg3QcG/k/Ph565IvxF0UxCxUJIQWZQX5GrHgOC38LjNC76t67ys
	 Kwwxk+y7FdV1YKGGtOPHhy68OT+CMN3h1Fb5qKsdJKICl3aZ69LIWAzB+jhHtI6LLK
	 pFxflV/XKBvYsYnVnV6NjZJT/iPMbYB3BTEgKMO6S+rG3lt0aLxKrIfER+1cRdSWsY
	 V9ao7uJqBZRhHxVv0ax7UAcuUqFaSnFHAwtr+H77AKIjHUwW4lJIOgmp3yzpSEyIi3
	 1MQnEk+l17ApQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/19] s390/dasd: Do not complete a failed ESE read as
 successful
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260805111612.1285190-2-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 11:48:41 +0000
Message-Id: <20260805114842.8364B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] When dasd_page_cache is enabled, successful ese_read operation=
s for thin-provisioned tracks result in an information leak of uninitialize=
d kernel slab memory to userspace.
- [High] Returning early with DASD_CQR_ERROR without clearing the timer and=
 scheduling the bottom half causes a queue hang for ERP requests.
- [High] A failure to allocate an ERP request when retries are exhausted ca=
uses the block request to hang indefinitely on the ccw_queue.
--

--- Patch [1]: [PATCH 01/19] s390/dasd: Do not complete a failed ESE read a=
s successful ---
commit 63ead90543228523947461ca90de80a29ba45fc6
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Do not complete a failed ESE read as successful

The patch modifies dasd_int_handler() to check the return value of
ese_read() and fail the request via the normal error path if it fails.
This prevents stale or uninitialized memory from being handed to the block
layer when reading an unallocated ESE track.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index d8d912a3b3fec..56ef38243f823 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -1692,8 +1692,10 @@ void dasd_int_handler(struct ccw_device *cdev, uns=
igned long intparm,
>  	if (dasd_ese_needs_format(cqr->block, irb)) {
>  		req =3D dasd_get_callback_data(cqr);
>  		if (!req) {
>  			cqr->status =3D DASD_CQR_ERROR;
>  			return;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but does this early return bypass
timer clearing and queue scheduling when req is NULL?

If an ERP request triggers a NO_REC_FOUND condition on an ESE device,
dasd_ese_needs_format() returns true. dasd_int_handler() then retrieves a
NULL req and returns early without calling dasd_device_clear_timer() or
dasd_schedule_device_bh(). Can this stall the queue until the device timer
eventually expires?

>  		if (rq_data_dir(req) =3D=3D READ) {
> -			device->discipline->ese_read(cqr, irb);
> -			cqr->status =3D DASD_CQR_SUCCESS;
> +			if (device->discipline->ese_read(cqr, irb))
> +				cqr->status =3D DASD_CQR_ERROR;
> +			else
> +				cqr->status =3D DASD_CQR_SUCCESS;
>  			cqr->stopclk =3D now;
>  			dasd_device_clear_timer(device);
>  			dasd_schedule_device_bh(device);

I also noticed a few other pre-existing issues in this area.

> drivers/s390/block/dasd_eckd.c:dasd_eckd_free_cp()
> 	if (dst !=3D cda) {
> 		if (rq_data_dir(req) =3D=3D READ)
> 			memcpy(dst, cda, bv.bv_len);

[Severity: Critical]
This is a pre-existing issue, but does this unconditionally copy the
uninitialized bounce buffer over the original bio page, destroying the zero=
es
written by ese_read()?

If dasd_page_cache is enabled, dasd_eckd_build_cp_cmd_single() allocates a
bounce buffer without __GFP_ZERO. If the device returns NO_REC_FOUND,
dasd_int_handler() calls ese_read(), which zero-fills the original bio
pages. On completion, does this copy overwrite the zeroes with uninitialized
memory, potentially causing an information leak to userspace?


> drivers/s390/block/dasd.c:__dasd_process_block_ccw_queue()
> 	if (cqr->status =3D=3D DASD_CQR_NEED_ERP) {
> 		erp_fn =3D base->discipline->erp_action(cqr);
> 		if (IS_ERR(erp_fn(cqr)))
> 			continue;
> 		goto restart;
> 	}

[Severity: High]
This is a pre-existing issue, but does the continue statement here bypass
the necessary cleanup and queue movement for the failed request?

If dasd_alloc_erp_request() fails to allocate memory under memory pressure
and retries are exhausted, it sets cqr->status =3D DASD_CQR_FAILED and retu=
rns
an ERR_PTR. Because the code continues to the next loop iteration without
calling list_move_tail(), does the request remain on block->ccw_queue,
causing a permanent block device queue hang?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D1
