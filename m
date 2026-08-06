Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2FD44E046
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032778; cv=none; b=R8Ceh7IbpP2+LP802gYuGIqo0C3NnlFLcSl+MnKxmrBQ8pUQGbt1VleaYjxXR4zxKjWDhr7cCy19VWp4l2Byefw2clWqh0+dtoSGnI1E/czamHGECLG/PG5LfbsgVNge6ejNWR807cI9BYTZ1KuBWQGs8raLwmZzg2/aSD+k3ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032778; c=relaxed/simple;
	bh=1uB6OCVuxQk8HTDSnp6ETxYtibggxrMY1RQfkDzoAQE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hDZ4MG0dZ9p0QARO9aokB7vi2/1Zy3wq47Ytydd61Xxh2K8c6akc72yEgqpiHcbb1nI40VG54tyXZGFWKzy3r5mjfWpkBe/qBSZzoMinMUAB98Xe7MGnJh/yFEPzNAQb8xk5OSYwpJD6aHc29tNLJVHfmRGPlQbckgt6rp+UDiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnL3CPA7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnL3CPA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C031F00A3A;
	Thu,  6 Aug 2026 16:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032777;
	bh=e/6ioxMvd9bu005gm5DoCCLwx9flPFvyfkKgnWLQ510=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jnL3CPA7S3TQyr/oWXgnGQcAOuijxJOg9pzBvYoogaggXK9q77Cf00BEsisL69/is
	 k3r/hO2szi7BB92SV1/BWivQ0bxamRVf3BnK2PusFhEie3skbWVkk9/IFTTxjEiRX1
	 FxFmgMSUCcd+OdlYBdd52ryRMbKGI/f/K54TxHvo33jjlqXIGXZihzu/sZtUWKZfOw
	 UO0zMQcyeZpwI8TBsASrD7iIpyf76hCzwKd6bOPdhseTKszWwugKX+dZ1nSpOGxpkn
	 MMMYLA/kUfhe3pJVrUFaDF4wc2SAErKr1bkVEcPuWddd3/Um2azaziPhFFgggnLy8b
	 HP5sJxY1g+jsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] s390/con3215: Add __must_hold() attribute to
 raw3215_make_room()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260806155303.2675932-2-hca@linux.ibm.com>
References: <20260806155303.2675932-1-hca@linux.ibm.com>
 <20260806155303.2675932-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 16:12:55 +0000
Message-Id: <20260806161256.B4C031F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free during device removal due to concurrent lock dr=
opping and missing console unregistration.
- [High] Sleeping in atomic context during panic/reboot on PREEMPT_RT.
--

--- Patch [1]: [PATCH 1/2] s390/con3215: Add __must_hold() attribute to raw=
3215_make_room() ---
commit bdab109aec8f8a62fc73654df5f2f42b168ab432
Author: Heiko Carstens <hca@linux.ibm.com>

s390/con3215: Add __must_hold() attribute to raw3215_make_room()
   =20
Add __must_hold() attribute to raw3215_make_room() in order to let
clang's context analysis know that "get_ccwdev_lock(raw->cdev)" must be
held on function entry.

> diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
> index 46265f4fbfd80..57fefa8986d6b 100644
> --- a/drivers/s390/char/con3215.c
> +++ b/drivers/s390/char/con3215.c
> @@ -481,6 +481,7 @@ static unsigned int raw3215_drop(struct raw3215_info =
*raw)
>   */
>  static unsigned int raw3215_make_room(struct raw3215_info *raw,
>  				      unsigned int length, bool drop)
> +	__must_hold(get_ccwdev_lock(raw->cdev))
>  {
>  	while (RAW3215_BUFFER_SIZE - raw->count < length) {
>  		if (drop)

[Severity: Critical]
This is a pre-existing issue, but can this sequence lead to a use-after-free
if a concurrent device unbind occurs?

When raw3215_make_room() yields the lock and sleeps, it does so without any
reference counting:

drivers/s390/char/con3215.c:raw3215_make_room() {
    ...
		/* there might be another cpu waiting for the lock */
		spin_unlock(get_ccwdev_lock(raw->cdev));
		udelay(100);
		spin_lock(get_ccwdev_lock(raw->cdev));
    ...
}

If con3215_write() calls raw3215_make_room() and drops the lock here,
could a concurrent sysfs unbind invoke raw3215_remove(), which nullifies
raw3215[0] and calls kfree(raw) without unregistering the console or
synchronizing with the ccwlock?

When raw3215_make_room() wakes up from the udelay, it appears it would
directly dereference the freed raw pointer when calling spin_lock().

[Severity: High]
This is also a pre-existing issue, but does this spin_lock() introduce a
sleepable lock acquisition into an atomic panic context on PREEMPT_RT?

When the system panics or reboots, con3215_notify() uses
spin_trylock_irqsave() to avoid sleeping, as local IRQs are disabled.

If it then calls raw3215_make_room() and the buffer is full, the code drops
the lock and unconditionally calls spin_lock(). On PREEMPT_RT kernels,
spin_lock() maps to a sleepable rt_mutex.

Could calling this with hardware interrupts disabled violate wait-context
rules and trigger a sleeping-in-atomic bug?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806155303.2675=
932-1-hca@linux.ibm.com?part=3D1
