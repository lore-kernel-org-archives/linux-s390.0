Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386683A83B1
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027865; cv=none; b=lOYcVVxWtbOUzq07+cZJ+BzW+ciovZZTuyxWuwOV3vhRGiJfG/IdLkKc7lgXQwdpa0gQPiYJx9tMU0DkraHHr/AW5Cy9W2JDx64SLpY5su/aLVjUFUVO9GcLiDMm9tjNm0l+GMwZF+p5eERXO7ia91HrbDWXd9LGqw7hOb4II4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027865; c=relaxed/simple;
	bh=GelrUXw7TWTvcp95yi2i6p2Q8KK8Sr7tE4wIJUyNCaY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z4pE1OTJbjBUYGmBIcR2Ixyi6u37Qf3f6pqSP5BA3hBtLo3akjsTUWnY6HuOty7S+ShkCZDLkKgkSjHdoxqrEUAbff80Jw5EXOsrgJzYrrDkX9nNA8knkXLy9oK2iQ2Dmy9dgYy1OD3rqLq2BejsBhTaFWTbwDg3IhtHquY3SyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvFkHoji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvFkHoji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0820E1F000E9;
	Thu,  6 Aug 2026 14:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786027863;
	bh=jk8lcIQbVq6kjlU4tAKwMb8CbE1DTjUutQ/446ucILQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nvFkHojiPDGK0jClBMsG5T0bb65O3kGqrPHl6rEFMYSiRMHeDH6SnaXMNIP7v8JYt
	 Yw/bhFgPviY7jUitz4jerE4LaJ8gIBopWzOWqttXkasGdE/UCgTDpttOEO1LSzNR5M
	 STpo/gq/eUCIonhqFSy/J4C/3tFdNHSpq/np/WOvOSQCwUCmKSNnN6mqArrDSbjRMf
	 yuYPv+8vPnNzuqw8cd2FSVxsQP+ryqWpLDBk3WhCrjejplxFEb/wDi5B7AYc6C6RmC
	 lCTlLtL5hi25yGvWRIridi1/J/H42ZkaO92kN9XRy6g9h6qm54TRRjqr9yy244S5mO
	 eEzmbIwWHVu6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/2] s390/ctcm: Add __context_unsafe()
 attribute to various functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260805145032.1409325-2-hca@linux.ibm.com>
References: <20260805145032.1409325-1-hca@linux.ibm.com>
 <20260805145032.1409325-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 14:51:02 +0000
Message-Id: <20260806145103.0820E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe conditional locking using `!in_hardirq()` leads to guarante=
ed self-deadlocks on PREEMPT_RT or when using forced threaded interrupts (`=
threadirqs`).
--

--- Patch [1]: [PATCH net-next 1/2] s390/ctcm: Add __context_unsafe() attri=
bute to various functions ---
commit c3d2fbe266a854e35b040af4b1c68b39c513a193
Author: Heiko Carstens <hca@linux.ibm.com>
Subject: s390/ctcm: Add __context_unsafe() attribute to various functions

Disable context analysis for various functions to get rid of context
analysis compile time warnings using clang caused by conditional
locking.

> diff --git a/drivers/s390/net/ctcm_fsms.c b/drivers/s390/net/ctcm_fsms.c
> index bf917f4264532..84fd394d35250 100644
> --- a/drivers/s390/net/ctcm_fsms.c
> +++ b/drivers/s390/net/ctcm_fsms.c

[ ... ]

> @@ -1462,7 +1456,7 @@ static void ctcmpc_chx_rx(fsm_instance *fi, int eve=
nt, void *arg)
>  			spin_lock_irqsave(
>  				get_ccwdev_lock(ch->cdev), saveflags);
>  		rc =3D ccw_device_start(ch->cdev, &ch->ccw[0], 0, 0xff, 0);
> -		if (dolock) /* see remark about conditional locking */
> +		if (dolock)
>  			spin_unlock_irqrestore(
>  				get_ccwdev_lock(ch->cdev), saveflags);

[Severity: High]
This is a pre-existing issue, but does this conditional locking using
!in_hardirq() (which sets dolock earlier in ctcmpc_chx_rx) cause
self-deadlocks on PREEMPT_RT or when using forced threaded interrupts?

Since the CIO interrupt handler already holds the CCW device lock, when
threaded interrupts are enabled, the hardware interrupt handler runs in
process context and in_hardirq() evaluates to false.

Would this cause ctcmpc_chx_rx() to mistakenly attempt to re-acquire the lo=
ck
it already holds, leading to an immediate self-deadlock?

[ ... ]

> diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
> index aeb102537e7f5..08e36685e5788 100644
> --- a/drivers/s390/net/ctcm_mpc.c
> +++ b/drivers/s390/net/ctcm_mpc.c

[ ... ]

> @@ -1774,9 +1775,6 @@ static void mpc_action_side_xid(fsm_instance *fsm, =
void *arg, int side)
>  	CTCM_D3_DUMP((char *)ch->xid_id, 4);
> =20
>  	if (!in_hardirq()) {
> -			 /* Such conditional locking is a known problem for
> -			  * sparse because its static undeterministic.
> -			  * Warnings should be ignored here. */
>  		spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
>  		gotlock =3D 1;
>  	}

[Severity: High]
This is a pre-existing issue, but does checking !in_hardirq() for condition=
al
locking lead to the same self-deadlock here in mpc_action_side_xid()?

If this FSM action is executed from the interrupt handler while threaded
interrupts are active, !in_hardirq() will evaluate to true, causing an atte=
mpt
to acquire the already-held get_ccwdev_lock().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805145032.1409=
325-1-hca@linux.ibm.com?part=3D1
