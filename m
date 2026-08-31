Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF25C326951;
	Mon, 31 Aug 2026 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206611; cv=none; b=s0gFMJWtL7nnuhVErpR0AQ7214Pn4ro5zyKhHGC7dyZmJNPyn6Pz73l4FylFSqF1s6qW0R2w5A3J5y4DjW7uhGEy8Sgn6CzpGohdvj62lNraMqh/1GiE2FcfypFmPoGkUz4xBSuHh0uIzVQ87+zIihR39ivJjRfNAgdFGiaUkos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206611; c=relaxed/simple;
	bh=wNYLq9RdkNurcOS3tQ6sIoRYgykQi6usW3dwaD0Bi28=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=shzUJGaiv6kMNeH6ngprRsHLmGtvQwWM+9F3r+enkH3AvXs//XTunzOVB9LyzJoUke7xYZGFMUxztFVpZ6HPXdhH5uKIM2++7CE9FCapcUhFEZbE69V+Yc+ZvSq2warA6vPVVYEZVEHEBlw68FL/BYzlUuvz4K8Hwlx+8LzjtTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwB8akpr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwB8akpr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0318B1F000E9;
	Mon, 31 Aug 2026 20:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788206609;
	bh=VhEC1Y2XFvsKNV6GckQv0ZMZU5S3q7MGHvYILDLsvdg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PwB8akpr89TY3e/MoVNMxR0m0XqpkxoFIpt7d7OO5oAlXZQwpNM5+Gt3qOjcNkhNO
	 FSqniPnftzhHTVxYJZAUtkaMmLmmPIPKrWPAWGoAQUQdp3bensomj6d1KvS3d6Wz2+
	 rSxGyDglk1jIdEDmtoG4lu+zkA757yuftop82KSm7M6wPkya748O81NpHmn0w3yXNS
	 L2G0vVEqJbo8amcJ4cSKFXj/nGgYtBmKTiimHFK/Fwgdo4qJx+j3XtpJDRSNpv5jli
	 8I95ri3Vw203tvekDVaEbpZ9/T1xeYYhxApuEdpI6m4pLSGpUtpF1DMD9UheEsIv5X
	 W7CXvov7rz4bA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] s390/vfio-ap: Fix unbounded loop in
 apq_reset_check()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260831171443.222225-4-akrowiak@linux.ibm.com>
References: <20260831171443.222225-1-akrowiak@linux.ibm.com>
 <20260831171443.222225-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:03:28 +0000
Message-Id: <20260831200329.0318B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The loop in apq_reset_check() may exit successfully on timeout wit=
hout issuing a ZAPQ reset if the queue becomes idle on the final iteration,=
 leaving cryptographic keys intact.
- [High] The mitigation to prevent a DMA Use-After-Free by intentionally le=
aking the pinned NIB page fails when the VFIO container is closed, leading =
to host memory corruption.
- [High] When queue reset times out, the `saved_iova` and `saved_isc` field=
s in `vfio_ap_queue` are not cleared, leading to incorrect unpinning of a f=
uture guest's memory when the queue is reassigned.
--

commit e937a4dd6769f8e257a811535be3b02a7ed57fa8
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

    s390/vfio-ap: Fix unbounded loop in apq_reset_check()
   =20
    This patch introduces a 2000ms timeout to apq_reset_check() to prevent =
an
    unbounded loop when hardware continuously returns busy responses. It
    intentionally leaks AQIC resources on timeout to avoid a use-after-free,
    and correctly checks status bits for completion of queue zeroization.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index a4980d993b681..6c315d7a0a088 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> @@ -2067,6 +2115,47 @@ static void apq_reset_check(struct work_struct *re=
set_work)
>  		ret =3D apq_status_check(q->apqn, &status);
>  		if (ret =3D=3D -EIO)
>  			return;
> +		if (elapsed >=3D AP_RESET_MAX_WAIT) {
> +			/*
> +			 * If the status check determined that the reset completed
> +			 * successfully or the queue is not operational, clean up
> +			 * the AQIC resources because queue reset disables
> +			 * interrupts and interrupts are not possible on a
> +			 * non-operational queue.
> +			 */
> +			if (!ret)
> +				goto done;

[Severity: High]
Does this early exit skip issuing a required ZAPQ retry if the queue happens
to become idle on the final iteration?

If the initial ap_zapq() fails with AP_RESPONSE_BUSY and the queue becomes
idle exactly on the 100th iteration (2000ms), apq_status_check() will retur=
n 0.
The timeout check intercepts this with goto done, which successfully exits
without ever executing the else block that re-issues the ap_zapq() command.

Can this leave cryptographic keys intact on a supposedly reset queue, leaki=
ng
them to the next assigned guest?

> +			/*
> +			 * Timed out without being able to verify reset completed.
> +			 *
> +			 * The AQIC resources associated with this queue - the pinned page
> +			 * containing the NIB and the registered guest ISC - cannot be freed
> +			 * here. The NIB is the active DMA target for AP interrupt delivery
> +			 * until the reset completes; freeing the pinned page while the
> +			 * hardware may still write to it would result in a use-after-free
> +			 * kernel crash.
> +			 *
> +			 * If the reset eventually completes, interrupts will be terminated
> +			 * and the pinned NIB page and ISC registration will be leaked. This
> +			 * is preferable to either a use-after-free or waiting indefinitely:
> +			 * the caller of apq_reset_check() holds mdevs_lock while flush_work()
> +			 * blocks holds the matrix_dev->mdevs_lock mutex, which
> +			 * serializes access to all mdev objects system-wide, so blocking
> +			 * here would stall all other guests using AP queues.
> +			 */
> +			report_aqic_resource_leak(q);
> +			/*
> +			 * Report the actual non-zero hardware response code, or synthesize
> +			 * AP_RESPONSE_RESET_IN_PROGRESS if TAPQ completed normally but
> +			 * the status bits failed to transition to their post-reset states.
> +			 */
> +			if (status.response_code =3D=3D AP_RESPONSE_NORMAL)
> +				q->reset_status.response_code =3D AP_RESPONSE_RESET_IN_PROGRESS;
> +			else
> +				q->reset_status.response_code =3D status.response_code;
> +
> +			return;

[Severity: High]
Will intentionally leaking the pinned NIB page actually prevent a
use-after-free on host KVM shutdown?

The timeout logic skips vfio_unpin_pages() and returns here to intentionally
leak the page. However, when the KVM guest is shut down and the VFIO contai=
ner
is closed, the VFIO IOMMU Type1 driver automatically unpins and frees all
remaining pinned pages.

Since the mdev driver does not take an independent reference (e.g., using
get_page()), the physical page is returned to the host buddy allocator while
the AP hardware may still be performing DMA writes to it. Could this still
lead to host memory corruption?

[Severity: High]
Could returning here without clearing saved_iova and saved_isc corrupt a
future guest's memory when the queue is reassigned?

Because the vfio_ap_queue struct outlives the guest, the saved_iova and
saved_isc fields remain populated with the old guest's state. When this que=
ue
is assigned to a new mdev and the new guest calls vfio_ap_irq_enable(),
vfio_ap_free_aqic_resources() will be called against the new q->matrix_mdev.

Will this erroneously unpin the old guest's IOVA from the new guest's VFIO
container, potentially freeing active memory belonging to the new guest and
unregistering the old ISC from the new KVM instance?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831171443.2222=
25-1-akrowiak@linux.ibm.com?part=3D3
