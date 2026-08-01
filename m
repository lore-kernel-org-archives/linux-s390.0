Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C659836605D
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583941; cv=none; b=GFhsZPCX/gkjaHqgDaWfNezupXYIgfv5V6fXpGfpMkq6aJEUbdo45cJfPgKsbjFQwAa+uRB76UbtE2CJ5usbUc0AbVBxirSV/iBoo9QjULRXQjvJYD4evWZKxIhhdHIFomWajV7GrLmLpt7VjG1Ga3qIa8eBCrsTTGajKBx9yIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583941; c=relaxed/simple;
	bh=dYZ1AU9I9sFTfwY5VKc1c6YsjHKecCn0iN5R1iDQoOo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g0xyFHSzVdzYgNNsanq+Y1t7lND2yxgtNNe3i48b3hr3UGQbRh/383WaxA3ySTzzhc60PcxEB8i5k3uQGA9flXQQIoF6LmcyXpKMEYmH7IwHqm0ClHsLhCYtF/fVSNLUWZTTx6uS+FU1ZLgWDzbMebY3u8b2Dwio1/CSjex1lAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GerKIxEj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GerKIxEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4021F00AC4;
	Sat,  1 Aug 2026 11:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785583940;
	bh=aXU6N81UuDQ4mU0/YvxDSNCRohn2ujV3g/yan2mWmMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GerKIxEjK4H7rVk6DnvyfGbQtqR+wx7Sgh6VzDtBwf0NjhbiNTlK7xBL8L4CYSTnp
	 qXYZ2Lb0MUseNrAisNKdxYcnxCPHGaGGB5HP280xv0q0TpCJB+OPrerz9LWWGM7GBI
	 /mOAhd8N3o/TjkCwFcq5z+1rfPXOEVGW2YnZLCy34Thcc5Vnhr3SXntRArh6WFIk1W
	 zB7ymw7enY6LJFsPt/0NRnljjq4oEJidWYImouYMQ87xG9atD3XifUqVJtuGHVmyem
	 R1JkdTL3ijot8u71t3Vrq0mqLVLVwA3OxQRIwmSCb71MqOWxZonTPb7QXJGRcCOgVC
	 hzzywDdnIkRJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/18] s390/dasd: Add infrastructure for ESE
 full-track write
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260801111008.3391031-8-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
 <20260801111008.3391031-8-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:32:19 +0000
Message-Id: <20260801113220.1B4021F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Logic Error / Double Completion. Aborted origin CQRs (DASD_CQR_ABO=
RTED) are erroneously completed to the block layer, leading to double-compl=
etion and UAF of block requests, or infinite hangs for non-block requests.

Pre-existing issues:
- [High] Pre-existing Use-After-Free in `__dasd_cleanup_cqr()` when accessi=
ng `cqr->intrc` after the request memory has been freed.
--

--- Patch [7]: [PATCH v6 07/18] s390/dasd: Add infrastructure for ESE full-=
track write ---
commit 6568e31c69d8658129394132fae86e53a21d2edd
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Add infrastructure for ESE full-track write

This commit adds the driver internals to build WRITE_FULL_TRACK FCX channel
programs for unformatted tracks on ESE devices. It introduces track-filler
buffers, hardirq-safe staging lists, and new CQR states to handle replaced
writes.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -1223,7 +1250,18 @@ void dasd_sfree_request(struct dasd_ccw_req *cqr, =
struct dasd_device *device)
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&device->mem_lock, flags);
> -	dasd_free_chunk(&device->ccw_chunks, cqr->mem_chunk);
> +	/*
> +	 * Free the request block from the pool it came from: smalloc() sets
> +	 * mem_chunk (ccw_chunks), fmalloc() leaves it NULL (ese_chunks). A
> +	 * full-track request also frees its track-filler buffer.
> +	 */
> +	if (cqr->filldata)
> +		dasd_free_chunk(&device->fill_chunks, cqr->filldata);
> +	if (cqr->mem_chunk)
> +		dasd_free_chunk(&device->ccw_chunks, cqr->mem_chunk);
> +	else
> +		dasd_free_chunk(&device->ese_chunks, cqr);
> +
>  	spin_unlock_irqrestore(&device->mem_lock, flags);
>  	dasd_put_device(device);
>  }

[Severity: High]
This is a pre-existing issue, but does the block layer cleanup code access
the cqr memory after it is freed here?

Looking at the call chain starting from dasd_block_tasklet():

__dasd_cleanup_cqr() ->
  discipline->free_cp() (e.g., dasd_eckd_free_cp()) ->
    dasd_sfree_request()

After free_cp() returns, __dasd_cleanup_cqr() evaluates the request state:

    else if (status =3D=3D 0) {
        switch (cqr->intrc) {
            ...

Since the cqr memory is returned to the chunk allocator pool inside
dasd_sfree_request(), could another CPU concurrently reallocate and
overwrite the cqr memory before cqr->intrc is read, resulting in a
use-after-free?

[ ... ]

> @@ -1884,6 +1924,10 @@ static void __dasd_process_cqr(struct dasd_device =
*device,
>  	case DASD_CQR_CLEARED:
>  		cqr->status =3D DASD_CQR_TERMINATED;
>  		break;
> +	case DASD_CQR_ABORT:
> +		cqr->status =3D DASD_CQR_ABORTED;
> +		cqr->callback =3D NULL;
> +		break;
>  	default:
>  		dev_err(&device->cdev->dev,
>  			"Unexpected CQR status %02x", cqr->status);

[ ... ]

> @@ -2761,7 +2806,8 @@ static void __dasd_process_block_ccw_queue(struct d=
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
> @@ -2872,6 +2918,14 @@ static void dasd_block_tasklet(unsigned long data)

[Severity: High]
The commit message states that the DASD_CQR_ABORT state is used to "retire
the origin CQR of a replaced write without completing it to the block layer=
."

However, since __dasd_process_block_ccw_queue() accepts DASD_CQR_ABORTED
and moves it to the final_queue, will __dasd_cleanup_cqr() still process
it?

If __dasd_cleanup_cqr() processes the aborted CQR, it appears to
unconditionally call blk_mq_end_request(req, error) instead of skipping
it. When the replacement ESE format CQR later completes, won't it try to
complete the exact same struct request, leading to a double-completion in
the block layer?

Additionally, for non-block requests, does setting cqr->callback =3D NULL in
__dasd_process_cqr() skip dasd_wakeup_cb()? Could this cause a waiter to
hang indefinitely in wait_event() if the wakeup callback is never executed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801111008.3391=
031-1-sth@linux.ibm.com?part=3D7
