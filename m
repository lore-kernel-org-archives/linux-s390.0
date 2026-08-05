Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893C147D93C
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946879; cv=none; b=KMKJd7KdnQaB11ozsncvI4NQVg7yWedEvo1mqCTA8hEL9wzQyHksdxBJyI9WaGNVVosOd4bgIkmcQiZ66cgbVt70UWkvRR/okqwaHYj67SZrELOYipSCg00yKDEMxBoox+bcSQX2hhphCd21NPYpk6WTiFxhBBOZCs3WnG7jZqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946879; c=relaxed/simple;
	bh=4LRkkV5W+Rl7Dql1sXeR/OOW9LQ5YREP1jT4td2YUew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L56lG5w+kJ+hbGGjLk3iOHw3LoFy20ZQrnSZVoHTDfWNYeBSGCNPXfTHqlPwtauFQTdRreHB0JBi0T9EhgY22vxyW3sFPN3YpN3vH1A31xus+N0rs43fYZL1r5WyB/zpF5TAP8hIqU/FE83SsXu9kB0cFln1BE94E6VKg4RZo6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9y5fwV1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9y5fwV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE841F000E9;
	Wed,  5 Aug 2026 16:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785946878;
	bh=0U+ASXWqak5i4w7/nkx21HJQnDv4MAeQSqSIYxopPhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M9y5fwV17NlDGgdg8CqM1bk9nj0H3Oi5FNRqhgv4al8KbOxWL4bwvUDXCH9RbDQwP
	 fP4ga/oUR0Mq/unp8RlNdpD4E0YyYwzyLbZjrCIBQ/pXaHTaR0LpDcW/gZsTRSB8k6
	 FD3JI5j92pjxLD/RBacLkS5ovIvNdICYsRhN//fpSDlc7RyNxNBK2LVQS8R/t2D4Z3
	 wTFO07AOFJuUUgEwYAsPRiErl8vhRFs6PBul3HqFCpEmO9onTgCcQMwgaSsZuyVbbl
	 6etLhXA2fnYohRnD6ez2Obi8OtG12INPRJW3gbVKAhdQiG9vyGjDkaOj10W8qTGGGl
	 Lb22P2n60BguQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/19] s390/dasd: Use WRITE_FULL_TRACK in ESE format
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260805111612.1285190-13-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-13-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:21:17 +0000
Message-Id: <20260805162118.1CE841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Full-track format requests bypass `test_and_set_format_track()=
` locking, leading to TOCTOU data corruption from concurrent partial-track =
writes.
- [High] Setting cqr->callback =3D NULL for aborted requests during teardow=
n overwrites the flush queue wakeup callback, causing an indefinite deadloc=
k during device offline.
--

--- Patch [12]: [PATCH 12/19] s390/dasd: Use WRITE_FULL_TRACK in ESE format=
 handler ---
commit c79b7434acd3a79782b3c648eaa1de078edf01da
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Use WRITE_FULL_TRACK in ESE format handler

Wire dasd_eckd_build_cp_tpm_writefulltrack() into the ESE unformated
track handler.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 8379c8a40382f..da488c0775fcd 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -3253,50 +3241,94 @@ dasd_eckd_ese_format(struct dasd_device *startdev=
, struct dasd_ccw_req *cqr,
> [ ... ]
> +	if (first_trk !=3D last_trk && last_offs + 1 < recs_per_trk) {
> +		diff =3D last_offs + 1;
> +		last_rec =3D last_rec - diff;
> +		last_trk =3D last_rec;
> +		last_offs =3D sector_div(last_trk, recs_per_trk);
> +		proc_bytes =3D (last_rec - first_rec + 1) * blksize;
> +	}
> +	if (first_offs > 0 || last_offs + 1 < recs_per_trk) {
> +		/* test if tracks are already in formatting by another thread */
> +		if (test_and_set_format_track(first_trk, last_trk, cqr,
> +					      cqr->block, cqr->startdev, &format)) {

[Severity: Critical]
Does bypassing test_and_set_format_track() for full-track requests allow
concurrent partial-track writes to the same track to proceed without
detecting a conflict?

If a partial-track format CCW chain executes after the full-track write, its
zero-padding could silently overwrite the valid data just written by the
full-track write.

> +			/* this is no real error so do not count down retries */
> +			cqr->retries++;
> +			goto out_retry;
> +		}
> +	}
> +
> [ ... ]
> @@ -3304,10 +3336,44 @@ dasd_eckd_ese_format(struct dasd_device *startdev=
, struct dasd_ccw_req *cqr,
> [ ... ]
> +	/*
> +	 * stage under ese_lock; dasd_block_tasklet splices it into ccw_queue.
> +	 * Direct enqueue here would invert queue_lock / ccwdev_lock.
> +	 */
> +	spin_lock(&block->ese_lock);
> +	list_add(&fcqr->blocklist, &block->ese_staging);
> +	spin_unlock(&block->ese_lock);
> +	/* mark origin CQR as aborted; ccwdev_lock is held by the IRQ handler */
> +	cqr->status =3D DASD_CQR_ABORT;

[Severity: High]
If a device is taken offline while an I/O request is being aborted by an ESE
format operation, _dasd_requests_to_flushqueue() sets
cqr->callback =3D _dasd_wake_block_flush_cb.

Will marking the status as DASD_CQR_ABORT here trigger a path in
__dasd_process_cqr() that unconditionally clears cqr->callback =3D NULL?

This would strip the wakeup callback installed by the offline process,
causing the offline process to sleep forever since wake_up(&dasd_flush_wq)
is never called.

> +	goto out;
> +
> +out_retry:
> +	/*
> +	 * If we can't format now, let the request go
> +	 * one extra round. Maybe we can format later.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D12
