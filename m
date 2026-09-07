Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8734E22E3F0
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 05:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758519; cv=none; b=BOCfG5ltmfu7mY+EfWyMA0NCz/AAqASZo3/95zY7iyQLtz6IQvT61D4dxAjlgqzTCxx1fwWbs5vtSGCIvmxBCy8FSHF3zffSiXnlFsM/9OwXBOklXErKPwUfo0DCwzjk2lVe3XTGpV0AQR14bTZUlVwBHbCMzv51NapZfWH8rWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758519; c=relaxed/simple;
	bh=ZkTy8Ybz0Mj8KwyqOIiiPCOZB535ln3umkjjie++wGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QnJX7VvyUeIYsyZ1L4dCFOoFdcwZXCgzjDfPxhDiB5NTx6eWqC4GHQw9XOjIGIGl+GdpE3QhGfe8k55NKond4e128XF6B8T6BPZ0WPSdysJGheGvE5IyMmb/lEjSK4DheOLDMfNgP94b1mZT1/Kwht2bZhz+3GJ614Xtg+I4GjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H634ofWJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H634ofWJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6D51F00A3A;
	Mon,  7 Sep 2026 05:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788758518;
	bh=MAuBAIjFPxIOHT84cH28rJM5NrV9/tJJhiOE11PaVc8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H634ofWJ5GmNKBvPVR1OslEg/fupsnllWMfGCULLs1lWfEI0ZC9ALjG6aKx/RJHks
	 y1dEFwXBe6wRgE4/B0YgJncNi/A2OcXEyeY/2cTJ/Eke43+D3aU8ISnf8ZFq8ieQlN
	 fO1bsrEF6cX1c0SDnA1QebTAkp4LsXIUm71itW3uAzlSB/S5UAofmsWwJdEesbses5
	 08qj2l2S3Foi+PZEWTrcmN1c7Aw6KYRPPdZ9OwLwuSzNBEj3td/q+aR3joF3z3GdDN
	 drf13pYHTN8TvaFNmkGOsamaxB2rwS4qUXuYhgdMAmLBFdv8oKfE++36wsCTD2PKDl
	 r/IWfljUO0plA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] s390/qdio: Ensure QDIO_IRQ_STATE_ACTIVE is set only
 after firmware activates.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nihar Panda" <niharp@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260907051016.1296884-1-niharp@linux.ibm.com>
References: <20260907051016.1296884-1-niharp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 05:21:57 +0000
Message-Id: <20260907052157.AC6D51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Lockless execution of cio_update_schib() causes a data race on the=
 shared sch->schib structure.
- [High] The timeout polling loop is vulnerable to a preemption bug resulti=
ng in a spurious -ETIMEDOUT failure.
- [High] Missing I/O cancellation on timeout leaves a dangling channel prog=
ram.

Pre-existing issues:
- [High] qdio_set_state() is called locklessly, potentially overwriting a S=
TOPPED/ERR state.
--

commit f5d84619d7d33842d3cc7f120e8e2f08b030d3f4
Author: Nihar Panda <niharp@linux.ibm.com>

s390/qdio: Ensure QDIO_IRQ_STATE_ACTIVE is set only after firmware activate=
s.
   =20
This commit modifies the activation sequence for QDIO queues to poll the
Subchannel Status Word (SCSW) instead of relying on an intermediate interru=
pt.
It checks for both SCSW_ACTL_SCHACT and qact to become set within a loop be=
fore
transitioning the state to QDIO_IRQ_STATE_ACTIVE.

> diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
> index c1e09fa34e774..821d501efdccf 100644
> --- a/drivers/s390/cio/qdio_main.c
> +++ b/drivers/s390/cio/qdio_main.c

[ ... ]

> @@ -1178,23 +1197,32 @@ int qdio_activate(struct ccw_device *cdev)
>  			      0, DOIO_DENY_PREFETCH);
>  	spin_unlock_irq(get_ccwdev_lock(cdev));
>  	if (rc) {
> -		DBF_ERROR("%4x act IO ERR", irq_ptr->schid.sch_no);
> -		DBF_ERROR("rc:%4x", rc);
> +		DBF_ERROR("%4x act IE:%d", irq_ptr->schid.sch_no, rc);
>  		goto out;
>  	}
> =20
> -	/* wait for subchannel to become active */
> -	msleep(5);
> +	rc =3D -ETIMEDOUT;
> +	timeout =3D jiffies + HZ;
> =20
> -	switch (irq_ptr->state) {
> -	case QDIO_IRQ_STATE_STOPPED:
> -	case QDIO_IRQ_STATE_ERR:
> -		rc =3D -EIO;
> -		break;
> -	default:
> -		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ACTIVE);
> -		rc =3D 0;
> +	while (time_before(jiffies, timeout)) {

[Severity: High]
Does this loop risk spurious timeouts under preemption or high CPU load?

By checking the timeout condition before evaluating the hardware state, if
preemption occurs right after the timeout is set and lasts longer than HZ,
the loop will terminate immediately.

This causes a spurious -ETIMEDOUT failure without ever checking the hardware
status.

> +		msleep(1);
> +		if (irq_ptr->state !=3D QDIO_IRQ_STATE_ESTABLISHED) {
> +			rc =3D -EIO;
> +			DBF_ERROR("%4x act WS:%d", irq_ptr->schid.sch_no, irq_ptr->state);
> +			break;
> +		}
> +		/* Query hardware */
> +		if (cio_update_schib(sch) =3D=3D 0) {

[Severity: High]
Is it safe to call cio_update_schib() without holding the subchannel lock h=
ere?

The lock get_ccwdev_lock(cdev) was released earlier, and cio_update_schib()
performs a lockless memcpy():

drivers/s390/cio/cio.c:cio_update_schib() {
    ...
	if (stsch(sch->schid, &schib))
		return -ENODEV;

	memcpy(&sch->schib, &schib, sizeof(schib));
    ...
}

This results in a data race with concurrent interrupt handlers that might be
updating sch->schib, potentially causing torn writes and state corruption.

> +			if ((sch->schib.scsw.cmd.actl & SCSW_ACTL_SCHACT)
> +					&& sch->schib.scsw.cmd.qact) {
> +				qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ACTIVE);

[Severity: High]
This is a pre-existing issue, but is it safe for qdio_set_state() to assign
the state locklessly?

By directly assigning irq_ptr->state without serialization, it can overwrit=
e a
QDIO_IRQ_STATE_STOPPED or QDIO_IRQ_STATE_ERR state set concurrently by an
interrupt handler.

This could mask concurrent hardware errors and leave the device in a
false-active state.

> +				rc =3D 0;
> +				break;
> +			}
> +		}
>  	}
> +	if (rc =3D=3D -ETIMEDOUT)
> +		DBF_ERROR("%4x act TIMEOUT", irq_ptr->schid.sch_no);
>  out:
>  	mutex_unlock(&irq_ptr->setup_mutex);
>  	return rc;

[Severity: High]
If this returns -ETIMEDOUT, is the pending asynchronous I/O left uncancelle=
d?

When the timeout expires, the function returns the error while the channel
program started by ccw_device_start() may still be active in hardware.

This could lead to use-after-free and memory corruption if the uncancelled =
CCW
eventually completes and performs DMA writes to memory that has since been
freed or repurposed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907051016.1296=
884-1-niharp@linux.ibm.com?part=3D1
