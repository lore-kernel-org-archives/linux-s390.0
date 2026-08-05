Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6282E8DEB
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785938562; cv=none; b=VR8+9XUCwX4Kl49irzlwHHMAfT/bPCSHuAdw1yRZQX5o7NJZFRgSGIgvgGLKKVwfH8Uk11KefVj6QRONYNbmwE27AiZ7INLFY2DmM8qaijcJyYG141EnODc9MWdL9yf8COOpTrue2kRWRvN9QCoU44WenrvlE1tLN5QJi0pDzDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785938562; c=relaxed/simple;
	bh=TUv5XPJZpgxvPQssGjya+ly/J7KvkDsbBty+6wPR8G8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CqMpzUeLb5OdtLb53kSZdqe4YKGoY3J+DuPdVXshmLClD3f3A+lwfQxodmJFSOoRs6ZwTSiMqjgFgOo/r+qLlw4NpOSIWk+iEzkZb/Q41fMiJ6crxj/JEwqAdAZPbTCN+0fOaHGB2Ada8ttgXjVTgoR+wZ+touyGAFRSVaFAnhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTdJ+VCx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTdJ+VCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1DF1F000E9;
	Wed,  5 Aug 2026 14:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785938561;
	bh=9NkAsXCQA/q6okS/a1SOqhLxvvEOzofVy1lbzcvBo40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TTdJ+VCxliw0SP9mc9mXzKSePHtDEa0JgS0aSXAcU8k+gKlmFS1pgwMqmZhahZsRg
	 FtSdKR3PXEZV7mfoWg/v4XTA1TQ9wG0Q3VSbB10BcgrpNr3VT0W9VgWHLKNmr2KpWx
	 j+JGMBOloN1y94vztdvn6/PXVOvHsoCZwgIdeZXdWqdvjmNvYGKMk/kOuGdkSVDcft
	 N1wXQe4vW15lhMlAGYGp3v67UkJZQHPx77HIY8sV8iLlbSJGzbmwWpBlpB+WK/KmMv
	 uP12QIpgrqxWcfxL3+kpLS7v+zzHer4CzhJZcFdq4iIOm/oyndfn35LKZ9/1QF5ZT9
	 cRdjET/3JocmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/19] s390/dasd: Add infrastructure for ESE full-track
 write
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260805111612.1285190-9-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-9-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 14:02:39 +0000
Message-Id: <20260805140240.EB1DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Double completion of aborted origin CQR due to flawed completi=
on prevention logic.
- [High] Lockless TOCTOU race in `_wait_for_empty_queues` evaluates queues =
in the wrong order.
--

--- Patch [8]: [PATCH 08/19] s390/dasd: Add infrastructure for ESE full-tra=
ck write ---
commit d9f946540847a2c32306276982008cd999ef5ab9
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Add infrastructure for ESE full-track write

This commit adds the driver internals to build WRITE_FULL_TRACK FCX channel
programs in response to unformatted tracks on ESE devices. It introduces
track-filler buffers, a hardirq-safe staging list for ESE format CQRs,
and new CQR states to retire replaced origin writes.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index 12fa04537fb02..761d559101a91 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
[ ... ]
> @@ -364,7 +390,8 @@ int _wait_for_empty_queues(struct dasd_device *device)
>  {
>  	if (device->block)
>  		return list_empty(&device->ccw_queue) &&
> -			list_empty(&device->block->ccw_queue);
> +			list_empty(&device->block->ccw_queue) &&
> +			list_empty(&device->block->ese_staging);

[Severity: High]
Does this lockless evaluation introduce a time-of-check to time-of-use race
by checking the downstream queue before the upstream queue?

If CPU A checks block->ccw_queue and finds it empty, and CPU B subsequently
splices a request from ese_staging into block->ccw_queue, CPU A will then
check ese_staging and also find it empty. CPU A would return true,
prematurely signaling that all queues are clear while an I/O request
is actually in flight on block->ccw_queue.

[ ... ]
> @@ -1885,6 +1925,17 @@ static void __dasd_process_cqr(struct dasd_device =
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
> +		break;
>  	default:
[ ... ]
> @@ -2779,7 +2831,8 @@ static void __dasd_process_block_ccw_queue(struct d=
asd_block *block,
>  		if (cqr->status !=3D DASD_CQR_DONE &&
>  		    cqr->status !=3D DASD_CQR_FAILED &&
>  		    cqr->status !=3D DASD_CQR_NEED_ERP &&
> -		    cqr->status !=3D DASD_CQR_TERMINATED)
> +		    cqr->status !=3D DASD_CQR_TERMINATED &&
> +		    cqr->status !=3D DASD_CQR_ABORTED)
>  			continue;

[Severity: High]
Can this lead to a double completion and use-after-free for the aborted
origin request?

In __dasd_process_cqr(), the aborted request has its cqr->callback set to
NULL to prevent it from completing. However, here in
__dasd_process_block_ccw_queue(), DASD_CQR_ABORTED is explicitly added to t=
he
finished states, which routes the request to final_queue.

When final_queue is processed by __dasd_cleanup_cqr(), it unconditionally
completes the block request using cqr->callback_data, ignoring the fact that
cqr->callback is NULL.

When the replacement ESE format CQR later finishes, it will complete the sa=
me
request again, resulting in a double completion.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D8
