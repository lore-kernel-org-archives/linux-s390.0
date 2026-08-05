Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A9646D2C9
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935203; cv=none; b=Gm9hh76bE0DtpwHlrJH9UnoaqJox4TYqWMM84yy5S6J2AHc3QNVmNo0CYtftAu0B+U0Plm3CurmMo4p2an/MiH/Q5PuiBZTn+V1W1t5X5F0JGJswhRK2n47qQnUqbnKH0Eu2X2DdBJXrw4vgVwoichwumpyNfyuXvZeWRRFpMOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935203; c=relaxed/simple;
	bh=PPLuGQbkfhNkzYtHVWvKi9F6jl9hU2ygnYWhH3YcDtY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R3cH/nyZSCoips/h8fI9JQ0ySvhc5jnvJfH0S7cxQ7fsGWw2dp2SWggH0RICeH1tRvgu/Hu8hFbAmBFO6JcHSvkeYBg2WM45OlfVVSVxTOR2Co5za3JgYKtx98xTylB3mB4jkRJsSep6V7g/QYGxa+M+jusurq0BvCB4AufgMHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8tY5DVr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8tY5DVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10B21F000E9;
	Wed,  5 Aug 2026 13:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785935201;
	bh=MWbSzO1z+QFuMWJBYh/OpS9/rb6BUxDG/GSCkoKAn3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E8tY5DVrMhtJeVAfoO73WCj2oeGSXQIB96pvcWm56PvrugmmFRw0h3ms7/ACgs3zH
	 C7g3a35zFa27rZmfQw8S44xuB4Ja818L+282nZDukKsmcXzqkD6mrCzaSXPcoic/u7
	 CKVX7H4zJYQgsjwfg+JtpTLUoF3RfV3JJHaUKLP8sAsoYezCmCC3UQT2/2E64xpDoV
	 8omSXK9lh+TZ68P2kK5YiDcSFaZMydIknRYN5syMj6kOpBkeD+i7SAtOaksmuk1e6q
	 3dyAOvF5GNh1DHJCAbc3oa6bF32jPq9944JA5546aHbVBlDOKVaNMp3Tr7q5uR4lr5
	 uV6HU4/4TbvKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/19] s390/dasd: Snapshot intrc before freeing the
 request block
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260805111612.1285190-5-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-5-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 13:06:39 +0000
Message-Id: <20260805130640.E10B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing `blk_rq_has_data()` / `bio_has_data()` guard in `dasd_=
fba_free_cp` causes NULL pointer dereference for dataless requests.
- [High] Accessing `req->q` after calling `blk_mq_end_request()` results in=
 a use-after-free.
- [High] Dereferencing `cqr->dq` to release a lock after `cqr` has been fre=
ed leads to a use-after-free in `dasd_flush_block_queue()`.
- [High] Block layer request use-after-free in `dasd_generic_requeue_all_re=
quests` error path.
--

--- Patch [4]: [PATCH 04/19] s390/dasd: Snapshot intrc before freeing the r=
equest block ---
commit 8cd8a0d1124e90e3f5df17a63495a14c3de26d80
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Snapshot intrc before freeing the request block
   =20
This patch fixes a race condition where the request block's intrc field is
read after the block is returned to the memory pool. By snapshotting intrc
before calling free_cp(), it prevents concurrent reallocations from
overwriting the completion status.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -2699,17 +2699,23 @@ static void __dasd_cleanup_cqr(struct dasd_ccw_re=
q *cqr)
>  	struct request *req;
>  	blk_status_t error =3D BLK_STS_OK;
>  	unsigned int proc_bytes;
> -	int status;
> +	int status, intrc;
> =20
>  	req =3D (struct request *) cqr->callback_data;
>  	dasd_profile_end(cqr->block, cqr, req);
> =20
> +	/*
> +	 * free_cp() returns the request block to its memory pool, so snapshot
> +	 * everything still needed from cqr before calling it - another CPU can
> +	 * reallocate and overwrite the block right after.
> +	 */
>  	proc_bytes =3D cqr->proc_bytes;
> +	intrc =3D cqr->intrc;
>  	status =3D cqr->block->base->discipline->free_cp(cqr, req);
>  	if (status < 0)
>  		error =3D errno_to_blk_status(status);
>  	else if (status =3D=3D 0) {
> -		switch (cqr->intrc) {
> +		switch (intrc) {
>  		case -EPERM:
>  			/*
>  			 * DASD doesn't implement SCSI/NVMe reservations, but it

[Severity: High]
This is a pre-existing issue, but since we are fixing a use-after-free
around free_cp() returning the block to the pool, does
dasd_flush_block_queue() have a similar problem?

drivers/s390/block/dasd.c:dasd_flush_block_queue() {
    ...
    __dasd_cleanup_cqr(cqr);
    spin_unlock_irqrestore(&cqr->dq->lock, flags);
    ...
}

Once __dasd_cleanup_cqr(cqr) completes, free_cp() has been called and
the cqr memory block might be reallocated by another thread. Does the
subsequent access to cqr->dq->lock dereference freed memory?

[Severity: High]
This is also a pre-existing issue, but is there a use-after-free on req->q=
=20
later in __dasd_cleanup_cqr() and dasd_request_done()?

drivers/s390/block/dasd.c:__dasd_cleanup_cqr() {
    ...
    blk_mq_end_request(req, error);
    blk_mq_run_hw_queues(req->q, true);
    ...
}

The blk_mq_end_request() call completes the request, meaning the block
layer can instantly reallocate or poison the memory backing req. Does
accessing req->q on the next line dereference this potentially freed
memory?

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in=20
dasd_generic_requeue_all_requests() expose the request to a concurrent=20
use-after-free?

drivers/s390/block/dasd.c:dasd_generic_requeue_all_requests() {
    ...
    _dasd_requeue_request(cqr);
    list_del_init(&cqr->blocklist);
    cqr->block->base->discipline->free_cp(cqr,=20
            (struct request *) cqr->callback_data);
    ...
}

The _dasd_requeue_request(cqr) call invokes blk_mq_requeue_request(req, tru=
e),
handing the request back to the block layer and asynchronously kicking the
hardware queue. Can another thread immediately dispatch and complete the
request before free_cp() iterates over the request's bios?

[Severity: Critical]
This is a pre-existing issue, but can dataless requests cause a null pointe=
r=20
dereference in dasd_fba_free_cp()?

drivers/s390/block/dasd_fba.c:dasd_fba_free_cp() {
    ...
    rq_for_each_segment(bv, req, iter) {
        dst =3D bvec_virt(&bv);
        for (off =3D 0; off < bv.bv_len; off +=3D blksize) {
    ...
}

Operations like REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES have no data
buffers (bio->bi_io_vec is null) but can have a non-zero bi_size. The
rq_for_each_segment() macro expands to bio_for_each_segment(), which
attempts to fetch the current segment from the null bi_io_vec. Should
this iteration be guarded with a check for blk_rq_has_data(req)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D4
