Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F28E34F46F;
	Thu, 27 Aug 2026 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838201; cv=none; b=nDql/Uz1fIKbGvFVRxugXzprRbCh8lunyOp5QJzw7nreqguG6MbkiXZjQBxRTNvEASFah2QOVSKqacM/36CGJZCVByFyRFIXVc9TC5/A8OGgcd3FNllW/tg6yOWyn9nEbt+VFrH4XqX86IwWfZvs+qXy860oWPefq4b7tlc/R3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838201; c=relaxed/simple;
	bh=9ukJYJ0JAzwyrk/lsGxQunva6jczwSbfBWMViErWfAQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AsyYf5NYZYRjQ9uihpcKB9lfnLeBHgpiKhqn+oZ/ouAABwTaQnwYKxrsanQOx1LmNDLKS1f0sm3FUF2lGgbU9cM39ifzA0XMy0mlIzGoDtVYlPDC3Ch4dXmB+p1nhz+0f8s3RR+O5qVO8wIFCRo35aVdiO6cw6MLVAz/8prOzkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+FGf1O4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+FGf1O4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34871F000E9;
	Thu, 27 Aug 2026 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787838199;
	bh=iADTt/zivX1F/PvjgHFwPcgMibk8fXqCrj/zLsUt2Ko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d+FGf1O41bzBdwdDZXG9jEb+9tm9bb+5sVrXsQYd1XD3rnb/0eARva/xZ4fx3dh3f
	 O5MwiI/fPKRzuR2b1IFMxBpzTg2CkR7yIIqebzC0T/1nznO/yVEkd3wFXAXr+dCROX
	 qRphtx7IgLnPN/d+ou1qHewiTKz1X3HTrTgRJJOsjIfYEOtfJ2Xaocg0z/WRppKpIg
	 Q03tJeCIZ/qqapoKsIj1Skmgv13QspYg7QP2z8970xIs2MBFHG+C8GJQ9bgovvLTqY
	 Dsd7NQ9dfl3VazqzPvyJ+lyxARST4WxgMXa972HUHkky1cGUTJWBSBEgS+NFPGnpCZ
	 pGNG63rv0fzVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] s390/vfio-ap: Fix unbounded loop in
 apq_reset_check()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260827132441.555866-4-akrowiak@linux.ibm.com>
References: <20260827132441.555866-1-akrowiak@linux.ibm.com>
 <20260827132441.555866-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:43:18 +0000
Message-Id: <20260827134318.D34871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The timeout condition is evaluated before checking for a successfu=
l reset, causing the driver to falsely report success while skipping requir=
ed resource cleanup if success occurs exactly at the timeout boundary.
- [High] The timeout path fails to clear `q->saved_isc`, leading to Cross-V=
M KVM interrupt routing corruption when the queue is reassigned to a new gu=
est.
--

commit bdd9b4236348c839f4b1d25d5fe39d6e047b2068
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix unbounded loop in apq_reset_check()

This commit introduces a 2000ms maximum wait time for AP queue resets in
apq_reset_check() to prevent indefinite spinning. If the reset times out,
the function breaks out of the loop and leaves the AQIC resources pinned to
avoid use-after-free issues.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 4c32fd6eaaa63..a9a33f4949a0e 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> @@ -2016,8 +2017,32 @@ static void apq_reset_check(struct work_struct *re=
set_work)
>  		elapsed +=3D AP_RESET_INTERVAL;
>  		status =3D ap_tapq(q->apqn, NULL);
>  		ret =3D apq_status_check(q->apqn, &status);
> -		if (ret =3D=3D -EIO)
> +		if (ret =3D=3D -EIO) {
> +			memcpy(&q->reset_status, &status, sizeof(status));
>  			return;
> +		}
> +		if (elapsed >=3D AP_RESET_MAX_WAIT) {
> +		/*
> +		 * Timed out waiting for reset to complete.
> +		 *
> +		 * The AQIC resources associated with this queue - the pinned page
> +		 * containing the NIB and the registered guest ISC - cannot be freed
> +		 * here. The NIB is the active DMA target for AP interrupt delivery
> +		 * until the reset completes; freeing the pinned page while the
> +		 * hardware may still write to it would result in a use-after-free
> +		 * kernel crash.
> +		 *
> +		 * If the reset eventually completes, interrupts will be terminated
> +		 * and the pinned NIB page and ISC registration will be leaked. This
> +		 * is preferable to either a use-after-free or waiting indefinitely:
> +		 * the caller of apq_reset_check() holds mdevs_lock while flush_work()
> +		 * blocks holds the matrix_dev->mdevs_lock mutex, which
> +		 * serializes access to all mdev objects system-wide, so blocking
> +		 * here would stall all other guests using AP queues.
> +		 */
> +			memcpy(&q->reset_status, &status, sizeof(status));
> +			return;

[Severity: High]
Does this code falsely report success while skipping required resource clea=
nup
if the reset succeeds exactly at the timeout boundary?

Because this timeout condition is evaluated before checking if the response=
 is
successful, if ap_tapq() returns AP_RESPONSE_NORMAL on the exact iteration
where elapsed reaches AP_RESET_MAX_WAIT (2000ms), it is treated as a timeou=
t.

The loop exits without calling vfio_ap_free_aqic_resources(), but copies the
success status into q->reset_status, meaning the caller thinks the reset
fully succeeded.

[Severity: High]
Does this timeout path fail to clear q->saved_isc, leading to cross-vm kvm
interrupt routing corruption when the queue is reassigned to a new guest?

When apq_reset_check() times out, it skips vfio_ap_free_aqic_resources() to
leak the memory, but leaves q->saved_isc populated since the vfio_ap_queue
struct persists across mdev assignments.

When a new guest later enables AP interrupts, vfio_ap_free_aqic_resources()
uses the stale q->saved_isc to call:

    kvm_s390_gisc_unregister(new_kvm, q->saved_isc);

This unregisters the stale ISC against the new guest's KVM object,
decrementing the new guest's ISC reference count and wrongly disabling aler=
ts
for that ISC.

> +		}
>  		if (ret =3D=3D -EBUSY) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827132441.5558=
66-1-akrowiak@linux.ibm.com?part=3D3
