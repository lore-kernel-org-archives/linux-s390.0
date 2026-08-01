Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA985221F2F
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608335; cv=none; b=dkzZlwQk3MidQjz/SQjMR393BJ+VGOiRmtx6LiSfQHXtXF0MgjMr23RsFmb6KmprUk6MIxDdEjTc4kQ4vgRU65XQq3lE2KU/ceAJr8WnWKXhuS4O/p76kTbWeCnpfCTbJVB8Q6YF0exbkDRb8/znwMDOj6zCGSKAQy+m0b90yow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608335; c=relaxed/simple;
	bh=1cceo5gWFeOWGKg4wZk0yrpRxKzx5mSRJaZnDmpg2Xg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nFyHTRM2mYiAHUQRUXbB7olTz69fenZXA6L8kXjoPdVLmJNLo82zFg50YpkcsdxYPFU++X7GTpuEnN1BbwTC7nIRpdW/onDRiS5euQ44bBEZYKa42al9A0O0mb5mFMX7l6dRtAGjQ4/IV7g852mdiYaa7/oX+rFh40lPFrM538s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+RbumOZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+RbumOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC8D1F00AC4;
	Sat,  1 Aug 2026 18:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785608333;
	bh=INf7PKw2WpQ8KbpuFNNIXgxrekje0tRo1GTQg1V7/5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a+RbumOZeC1n0X1q8e+ZlTqifAMf6S9pnhht6dD7kDopR0Glaau7MSgfeUrri7/e4
	 4iRy8Rq3wULNcASZDmCHiJqFJQgJ0rWzYbIABYO2t5DhFlC6nzfvb/JyOq9PSBDGXQ
	 dkEiwZdSuODeJurgYdAPcwlAAweS76T2R96AnsSWr0lhcRC5370ldZImKtLs7EcZRC
	 1mP6VIJxkm18hpGJyCyX3vnD+nZxFzNG93jVx11rNO0B6QUmsAgY5VBzWXny/PNh04
	 /4y2laC1JMWxDNcCkWA9eACy1SUbysKMgzjy1eHLg17EdD/JK7xEmXCRzLiHkc7yB4
	 O6vmX8keI+lWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/19] s390/dasd: Snapshot intrc before freeing the
 request block
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260801180033.3679412-5-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-5-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:18:52 +0000
Message-Id: <20260801181853.4BC8D1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Accessing `req->q` after the request has been freed by `blk_mq_end=
_request()`.
- [High] Accessing `req` inside `free_cp()` after it has been requeued to t=
he block layer in `dasd_generic_requeue_all_requests()`.
- [High] `cqr->dq` is dereferenced after `cqr` is freed in `dasd_flush_bloc=
k_queue()`.
--

--- Patch [4]: [PATCH v7 04/19] s390/dasd: Snapshot intrc before freeing th=
e request block ---
commit 0c9b1e836f68d2761aa0c36acf690d7404a26d86
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Snapshot intrc before freeing the request block

__dasd_cleanup_cqr() maps the completion result to a block status by
reading cqr->intrc, but only after discipline->free_cp() has returned the
request block to its memory pool. On SMP another CPU can reallocate that
block and overwrite cqr->intrc before it is read, completing the request
with the wrong error. This patch snapshots intrc before free_cp() is called.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index dbe3caa1e0b4a..f5585c549e09e 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -2687,17 +2687,23 @@ static void __dasd_cleanup_cqr(struct dasd_ccw_re=
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
This isn't a bug introduced by this patch, but further down in
__dasd_cleanup_cqr() we have:

	if (error) {
		blk_mq_end_request(req, error);
		blk_mq_run_hw_queues(req->q, true);

Is it safe to dereference req->q here?

Once blk_mq_end_request() completes and frees the request back to the block
layer's tag pool, could another thread reallocate and modify req before we
access req->q?

The same pattern also appears in dasd_request_done():

	blk_mq_end_request(req, 0);
	blk_mq_run_hw_queues(req->q, true);


[Severity: High]
This is a pre-existing issue, but in dasd_flush_block_queue():

		spin_lock_irqsave(&cqr->dq->lock, flags);
		cqr->endclk =3D get_tod_clock();
		list_del_init(&cqr->blocklist);
		__dasd_cleanup_cqr(cqr);
		spin_unlock_irqrestore(&cqr->dq->lock, flags);

Since __dasd_cleanup_cqr(cqr) calls free_cp() which returns cqr to its
memory pool, is it safe to evaluate cqr->dq in the spin_unlock_irqrestore()
call right after?

If another CPU reallocates and overwrites cqr in the meantime, could
cqr->dq evaluate to NULL or point to unrelated memory causing lock
corruption?


[Severity: High]
This is a pre-existing issue, but looking at dasd_generic_requeue_all_reque=
sts():

		_dasd_requeue_request(cqr);
		list_del_init(&cqr->blocklist);
		cqr->block->base->discipline->free_cp(
			cqr, (struct request *) cqr->callback_data);

Since _dasd_requeue_request() passes ownership of the request back to the
block layer, could the block layer immediately dispatch and complete it?

If so, is it safe to pass req to free_cp() where it might iterate over the
request's bios via rq_for_each_segment() and potentially copy bounce buffer=
s?

Could req be freed or its bios concurrently modified by the block layer bef=
ore
free_cp() completes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D4
