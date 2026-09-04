Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B0E4457A3;
	Fri,  4 Sep 2026 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515613; cv=none; b=BYGXsM9H+fMGhZK/j9NpmqdbbDWvSxKAuE1phz4JK2DKT0ECCbp5U0zlFqF4Fvr0tIBJV/I6pI6cxZVUjWv9iw9axMYpZrl3HWugLt/pspQGf/Eikv6BFb8ZkCr40KZS9kpMLZ0j7k0+kclTfOcc3enp5FFbzGa1p00SvPQA3OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515613; c=relaxed/simple;
	bh=YkFhUfRQ8hpKftc/26TrZOO8csXQAZrAMbk+o5xuRxw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XxiacTcqClaTEGETYoX/W1ICH2+axYpsw6bp3C/ymc6DP6O5zanYSgnkpDgNdCg9JhCA4MHaeZWtEMtNzA1zjZ2/xSOp3zkJSma2EWXSIfSALQc9XaZZlSM6fOOx7duHL+Vow3zUSfZ7JiCNXRCM/gEG4FPgqL1qCEGzx6b1wDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLPZKRaa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLPZKRaa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF6E1F00A3D;
	Fri,  4 Sep 2026 09:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788515610;
	bh=CeiLp+Wp1fXFyP1ZD3s97YechdzCpHMNwUmvflb/hbY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OLPZKRaa4UR/EGgdXfJFwJFldX62KiTcF6SR+Y5zVaw1fU3xVWlarbrQmCRFskU3y
	 es6DmxoYEpq1ehtnxGizQgOOW+KId0dJ04/AjCdro0d64yxnp1diCuArSyvCSWm01M
	 GuhWjXGYVR7Fegtu0xKfiOB9VPQBUSDZ4wYdHN0clBLNP99raNUq1lHo1wSeD1XyDc
	 IHX2EkP5Zf+ZcLrOa9tPpfpC2DZ1KgwBsPMuMHk0qDO7fAOj6ytGbNrmW4qI0PiUes
	 HBdOvqv+FELBxT5PDRazZjgDP0ednVl8gPr7PLlHJH3P4dogWMDNFqg5Oe8jFlPWwt
	 xJDRX8cU1l0Hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] s390/vfio-ap: fix queue state leakage to guest
 and host
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260904093435.1161402-6-akrowiak@linux.ibm.com>
References: <20260904093435.1161402-1-akrowiak@linux.ibm.com>
 <20260904093435.1161402-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 09:53:29 +0000
Message-Id: <20260904095329.EEF6E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] `apq_reset_check()` fails to update `q->reset_status` on successfu=
l completion, breaking queue assignment and state tracking.
- [High] `matrix_mdev` is accessed after its protecting locks are released =
in `vfio_ap_mdev_remove_queue()`, leading to a UAF.
- [Medium] Unconditional queue resets during probe and removal bypass the h=
ost configuration check, triggering unhandled kernel WARNINGs.

Pre-existing issues:
- [High] Early return on `-EIO` in `apq_reset_check()` bypasses freeing AQI=
C resources, leading to a resource leak and Use-After-Free.
--

commit 0e38aebd52e81cf78709732210a4726b0f1c0dfa
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: fix queue state leakage to guest and host

This patch modifies the queue reset logic to prevent state leakage to guests
and hosts. It changes the passable state for queues to strictly require
AP_RESPONSE_NORMAL, introduces a variable maximum wait time for resets, and
ensures queues are properly reset and verified during probe and removal.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 6a964f82c8e89..e054fd4a94970 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2113,7 +2113,7 @@ static void apq_reset_check(struct work_struct *res=
et_work)
>  		ret =3D apq_status_check(q->apqn, &status);
>  		if (ret =3D=3D -EIO)
>  			return;

[Severity: High]
This isn't a bug introduced by this patch, but does returning early on -EIO
here bypass resource cleanup at the done: label?

If a hardware failure causes an unrecognized response code,
vfio_ap_free_aqic_resources() is skipped here and in the default switch cas=
e of
vfio_ap_mdev_reset_queue(), but q is eventually freed.

Can the guest's gmap notifier remain registered, holding a pointer to q,
resulting in a use-after-free when the notifier dereferences the freed q
pointer?

> -		if (elapsed >=3D AP_RESET_MAX_WAIT) {
> +		if (q->reset_max_wait && elapsed >=3D q->reset_max_wait) {
>  			/*
>  			 * Zeroization confirmed (ret =3D=3D 0): the TAPQ status bits
>  			 * indicate the async portion of the ZAPQ completed

[ ... ]

> @@ -2161,6 +2161,8 @@ static void apq_reset_check(struct work_struct *res=
et_work)
> =20
>  			return;
>  		}
> +		if (!ret || ret =3D=3D -ENODEV)
> +			goto done;

[Severity: High]
Does this early exit skip updating the queue's reset_status with the actual
final state?

If apq_reset_check() loops until ap_tapq() indicates successful zeroization
(ret =3D=3D 0), but jumps to done without updating q->reset_status to
AP_RESPONSE_NORMAL, does this mean _queue_passable() will incorrectly reject
successfully zeroized queues?

Furthermore, could this cause the new logic in vfio_ap_mdev_remove_queue() =
to
evaluate q->reset_status.response_code !=3D AP_RESPONSE_NORMAL to true,
triggering an incorrect redundant reset that blocks indefinitely?

>  		if (ret =3D=3D -EBUSY) {
>  			pr_notice_ratelimited(WAIT_MSG, elapsed,
>  					      AP_QID_CARD(q->apqn),

[ ... ]

> @@ -2675,8 +2675,10 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apd=
ev)
> =20
>  	q->apqn =3D apqn;
>  	q->saved_isc =3D VFIO_AP_ISC_INVALID;
> -	memset(&q->reset_status, 0, sizeof(q->reset_status));
> +	q->reset_max_wait =3D AP_RESET_MAX_WAIT;
>  	INIT_WORK(&q->reset_work, apq_reset_check);
> +	vfio_ap_mdev_reset_queue(q);
> +	flush_work(&q->reset_work);

[Severity: Medium]
Will this unconditional reset during probe trigger a WARN if the probed dev=
ice
is not in the host's AP configuration?

When an AP device is bound to the vfio_ap driver but is not present in the
host's AP configuration, ap_zapq() fails with response code 0x01.

Does this feed the 0x01 response code into vfio_ap_mdev_reset_queue(), which
falls through to the default switch case and triggers a WARN?

> =20
>  	if (matrix_mdev) {
>  		vfio_ap_mdev_link_queue(matrix_mdev, q);

[ ... ]

> @@ -2759,8 +2761,19 @@ void vfio_ap_mdev_remove_queue(struct ap_device *a=
pdev)
>  		vfio_ap_unlink_queue_fr_mdev(q);
> =20
>  	dev_set_drvdata(&apdev->device, NULL);
> -	kfree(q);
>  	release_update_locks_for_mdev(matrix_mdev);
> +
> +	if (q->reset_status.response_code !=3D AP_RESPONSE_NORMAL) {

[Severity: High]
Are the locks protecting matrix_mdev dropped before the blocking reset
operations, exposing it to concurrent freeing?

vfio_ap_unlink_queue_fr_mdev() unlinks the queue but leaves the dangling
pointer q->matrix_mdev intact.

If flush_work() blocks indefinitely and a concurrent unbind tears down the
mdev and frees matrix_mdev, will vfio_ap_free_aqic_resources() dereference
q->matrix_mdev->kvm, resulting in a use-after-free?

> +		/*
> +		 * Loop until zeroization of queue is verified so we don't leak
> +		 * the internal state of the queue to the caller.
> +		 */
> +		q->reset_max_wait =3D 0;
> +		vfio_ap_mdev_reset_queue(q);
> +		flush_work(&q->reset_work);

[Severity: Medium]
Does this fallback reset completely ignore the test_bit_inv() host
configuration check present earlier in this function, hitting the same WARN=
 on
unbind if the device is not in the host's AP configuration?

> +	}
> +
> +	kfree(q);
>  }
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904093435.1161=
402-1-akrowiak@linux.ibm.com?part=3D5
