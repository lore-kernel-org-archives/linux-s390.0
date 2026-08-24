Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2B7438034;
	Mon, 24 Aug 2026 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580687; cv=none; b=snyr3Qv7PXyZe8eLieIujKdDWjYszlJZ8fqQ+T1PRexMFzmAkJ8BkiR1x1lWR6OriaAEwArExE1HQzQhRtBER+qo4U1kVOxHJA2ONFmwAtGIkYKqVGa7zCv3Xg1U8bb+MAPEY9RAd+rvGW+jyTW2iKXyJ/p6PwFM93LWCj8r8So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580687; c=relaxed/simple;
	bh=bbZSlbbsbaUXVmjMspIaL7HdQ2HMf4a2YPZV4fhaJ9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GoOX/o0EhfzarbM5dqfGEbdq+Ib6PYrUnLU+Ye361XAiy5XiwIjUhVNPIrBDzqvtoMB70qOUcmbmX/tlzVpqPeQTokD/jSszOmfvt3y09q9Eh8AFEbI7ZODwbqs+coBiEKTn8BgFqRbHZuo2feFsRAI8Rn/BSp8atu0562J9eh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llkse0UI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llkse0UI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FC91F000E9;
	Mon, 24 Aug 2026 14:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787580685;
	bh=7i3f3pT8X8goQDifASQIbFZi8R+YWhL7YIcGLtffDPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=llkse0UIxBdxzKjxEZQZkhGZimziotEEV5uZqj/9Rh7lp9yM83tC4dJPWZhN8tNVo
	 ZAbdf1oqktDBikmvnAQ+T+ifvh6EZ3nJb8IHeFnXWt7cRutVQvUXZgXLkbZ5BuFzDA
	 BLLPBC59phl2Kk37SO9mYXvS6gaTjsLkupd2syUo4iE4gQXU3ZwOPLwTyXYk4HQCKQ
	 2hAFPyb+hbwgP9wDsAFAZ4Dyn17+yla9ZcrK7R98zhpJJinOOchnk2q1URewbqt47P
	 8VJ3wLTGFptCdgV2FWU7RZ3mDy7PtQafz4sjdKs9hF8PZn/bz1TyHFehbqIUsrlGfq
	 55tAcg2pxWkQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] s390/vfio-ap: Fix leak of pinned NIB and registered
 NISC in vfio_ap_irq_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260824135850.503728-2-akrowiak@linux.ibm.com>
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
 <20260824135850.503728-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 14:11:25 +0000
Message-Id: <20260824141125.56FC91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] `vfio_ap_irq_enable` incorrectly treats `AP_RESPONSE_OTHERWISE=
_CHANGED` (0x07) as a failure, unpinning the NIB while the hardware has suc=
cessfully configured it. This allows the AP hardware to DMA into freed host=
 memory.
- [High] Unprivileged guest can flood the host dmesg by repeatedly triggeri=
ng a `pr_warn()` in the `default` case of the `ap_aqic()` response code swi=
tch.
- [High] A malicious or misbehaving guest can trigger host-side WARN_ONCE m=
acros by disabling IRQs on a checkstopped or busy AP queue, leading to kern=
el panics if panic_on_warn is enabled.
--

--- Patch [1]: [PATCH 1/4] s390/vfio-ap: Fix leak of pinned NIB and registe=
red NISC in vfio_ap_irq_enable() ---
commit c278a02f835924e412b00c7f6b715a44741cbcce
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix leak of pinned NIB and registered NISC in vfio_ap_irq_ena=
ble()

This commit addresses a resource leak of pinned NIB and registered NISC
pages during AP queue interrupt enablement. It updates the error handling
path to unpin and unregister resources directly when an unexpected status
is returned. This avoids incorrectly invoking the interrupt disable routine
on a failing queue.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 940c0ff668bee..a46bf381ab726 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -503,9 +503,14 @@ static struct ap_queue_status vfio_ap_irq_enable(str=
uct vfio_ap_queue *q,
>  		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
>  		break;

[Severity: Critical]
This is a pre-existing issue, but does vfio_ap_irq_enable() incorrectly
treat AP_RESPONSE_OTHERWISE_CHANGED (0x07) as a failure?

When a guest triggers PQAP(AQIC) to enable interrupts on an AP queue that
is not empty, the hardware returns AP_RESPONSE_OTHERWISE_CHANGED. This
indicates successful IRQ modification but a non-empty queue.

Because this code treats it as an error and unpins the NIB pages, couldn't
the AP hardware later DMA interrupt data into the physical address of the
unpinned NIB, corrupting host memory if those pages are reallocated?

>  	default:
> -		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
> -			status.response_code);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to leave this
pr_warn() un-ratelimited in the default case?

If an unprivileged KVM guest executes PQAP(AQIC) in a tight loop on a
queue that is in a state returning an unhandled response code (e.g.,
AP_RESPONSE_Q_NOT_AVAIL), couldn't they flood the host dmesg?

This violates KVM subsystem rules which mandate that guest-reachable
warnings must be rate-limited or removed to prevent log flood Denial of
Service.

> -		vfio_ap_irq_disable(q);

[Severity: High]
This patch correctly removes the call to vfio_ap_irq_disable() here, but
this highlights a pre-existing issue: is it possible for a malicious guest
to trigger the WARN_ONCE macros inside vfio_ap_irq_disable() directly?

If the guest executes PQAP(AQIC) with the interrupt enable bit set to 0
(disable) on a queue that returns AP_RESPONSE_DECONFIGURED or
AP_RESPONSE_CHECKSTOPPED, it will directly invoke vfio_ap_irq_disable():

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_irq_disable() {
    [ ... ]
	case AP_RESPONSE_Q_NOT_AVAIL:
	case AP_RESPONSE_DECONFIGURED:
	case AP_RESPONSE_CHECKSTOPPED:
	case AP_RESPONSE_INVALID_ADDRESS:
	default:
		/* All cases in default means AP not operational */
		WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
			  status.response_code);
    [ ... ]
}

Since this path is fully reachable by an unprivileged guest, couldn't this
lead to a host kernel panic if panic_on_warn is enabled?

> +		pr_warn("%s: PQAP(AQIC) failed with response code %02x for apqn %04x\n=
",
> +			__func__, status.response_code, q->apqn);
> +		/* We could not modify IRQ settings: clear new configuration */
> +		ret =3D kvm_s390_gisc_unregister(kvm, isc);
> +		if (ret)
> +			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=3D%d isc=3D%d, apq=
n=3D%#04x\n",
> +					 __func__, ret, isc, q->apqn);
> +		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824135850.5037=
28-1-akrowiak@linux.ibm.com?part=3D1
