Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863832DB78C;
	Tue, 14 Jul 2026 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072337; cv=none; b=u7NsPtJg0o4JJ9AGCmmvVKmWybhJUm99oLWINkxIO06XVpX//r1N9HfZOtqcRyT6KvK1b+oNM/Ffv6LwIJCW+bPMz+6lZ8lS5w5qsaO34t4b6Cy997kqtkArxi7qKwizD6t9PTLVEziYZOSBeM9wMjlGBuvbeBfnFr7tWTTB0sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072337; c=relaxed/simple;
	bh=rDAQgcNBv+GTO4VOwAu6y5z9CF/gwmDiLh9wBBng06Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oqBhOmAXHG4k0RXGJ8JrMcnmM2mxDRbByw3zOZIsUhDufmN8gIeOAwV5fSRYUtTkYM3B0IvdjlEFFcV4qw3FFg9pGYSkkMua10fPHGNTbkhAmIX+2zfqqMC2FLrpAi5iqv8ToP0CHWQzqrCgC1JVc2GzGXMEZvMqYxWcgI4YQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaC90gVk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaC90gVk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094791F000E9;
	Tue, 14 Jul 2026 23:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784072336;
	bh=RFwrT58tCymrxI2qvtlXteMxZQdBi4Xjw5ZRJicD6Bw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HaC90gVkQw/3T7IPJYzUvT+q4oX0yexo+yp641h1nvpNSpL8YQtmg667lpVaqkjjY
	 VEHC2VKaHW7uIUYV87uvdYv3VR71TGM9Zxof+MIgBSHpDUhE/K8RpWFJzb/dJ4/Yyg
	 aVH3vMv9fI8hvuvNIEWI6RQ1xqEX+nTyhi0igdid4SOUaG+PySCW0j9m4dG8EbxhdR
	 rah+1MiK3BWh/MWR0AjTgWLon7K2Mh9qK8qbWktvX1eYD9hv2qvkoj2pE4wrCfzdoU
	 ErQ8jaTje3MriCwOa3rLC2YtkJgm69dP9N/w4An6YZ4uie7qGRiKkGMxZDuQvM889l
	 gubci51GO06ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/6] s390/vfio_ccw: lock I/O resources alongside I/O
 regions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260714232208.1683788-7-farman@linux.ibm.com>
References: <20260714232208.1683788-1-farman@linux.ibm.com>
 <20260714232208.1683788-7-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 23:38:55 +0000
Message-Id: <20260714233856.094791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces 'sleeping in atomic context' bugs by adding m=
utex_lock() calls in paths where a spinlock is held and interrupts are disa=
bled.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but concurrent execu=
tion of `cp_free` can lead to a double free because `vfio_ccw_sch_io_todo` =
fails to hold `io_mutex`.
--

--- Patch [6]: [PATCH v1 6/6] s390/vfio_ccw: lock I/O resources alongside I=
/O regions ---
commit 60e83e6e496f63d77b199d14299ecacbd61f8fb1
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: lock I/O resources alongside I/O regions
   =20
The commit expands the scope of the I/O mutex from protecting just the
memory regions to also protecting related resources like channel programs
and subchannel events. It adds mutex locking around CRW queuing and
channel program freeing.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> index 1a095085bc728..385af7daca3b4 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -292,7 +292,9 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_privat=
e *private,
>  	crw->crw.erc =3D erc;
>  	crw->crw.rsid =3D rsid;
> =20
> +	mutex_lock(&private->io_mutex);

[Severity: High]
Does this cause a sleep-in-atomic bug?

The CIO core invokes the chp_event callback with the subchannel lock held
and interrupts disabled:

drivers/s390/cio/chsc.c:__s390_subchannel_vary_chpid() {
    spin_lock_irqsave(&sch->lock, flags);
    if (sch->driver && sch->driver->chp_event)
        sch->driver->chp_event(sch, &link, on ? CHP_VARY_ON : CHP_VARY_OFF);
    ...
}

This eventually calls vfio_ccw_queue_crw(), which now attempts to acquire
the sleeping io_mutex while the spinlock is held.

>  	list_add_tail(&crw->next, &private->crw);
> +	mutex_unlock(&private->io_mutex);
>  	queue_work(vfio_ccw_work_q, &private->crw_work);
>  }

[ ... ]

> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_=
fsm.c
> index 4d7988ea47ef0..96f23da88a396 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -171,7 +171,9 @@ static void fsm_notoper(struct vfio_ccw_private *priv=
ate,
>  	private->state =3D VFIO_CCW_STATE_NOT_OPER;
> =20
>  	/* This is usually handled during CLOSE event */
> +	mutex_lock(&private->io_mutex);

[Severity: High]
Can this also trigger a sleep-in-atomic panic?

Similar to the CRW queuing path, fsm_notoper() is reached from
vfio_ccw_sch_event(), which holds the same subchannel spinlock:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_sch_event() {
    spin_lock_irqsave(&sch->lock, flags);
    ...
    vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does the lack of locking in
vfio_ccw_sch_io_todo() allow a double-free race with this cp_free() call?

While this patch adds io_mutex protection here in fsm_notoper(), the
I/O completion workqueue conditionally calls cp_free() without acquiring
io_mutex:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_sch_io_todo() {
    ...
    if (is_final && private->state =3D=3D VFIO_CCW_STATE_CP_PENDING) {
        cp_free(&private->cp);
    ...
}

Because cp_free() checks and modifies cp->initialized non-atomically:

drivers/s390/cio/vfio_ccw_cp.c:cp_free() {
    if (!cp->initialized)
        return;
    cp->initialized =3D false;
    ...
}

could these two paths execute the freeing logic simultaneously if a
subchannel becomes not operational exactly as its I/O completes?

>  	cp_free(&private->cp);
> +	mutex_unlock(&private->io_mutex);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714232208.1683=
788-1-farman@linux.ibm.com?part=3D6
