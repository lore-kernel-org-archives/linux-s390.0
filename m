Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E29F51814C;
	Tue, 29 Sep 2026 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685209; cv=none; b=NG8BowPfoyfVq6D9RjPLcYCRZDVoptIhhX5ghwq00O4/BqMs5fU5iK3DdhOqKr0AnyxRK2o7LQ+4rbgHn5Sp5fwbcpVw1xwOhYP3dGfs1VyoRxdI5t4IxVXR+XIj4fgaObsjbfAvZGkQSGDi6Qca3PSAP1hDIP/Vt6g9D9ez/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685209; c=relaxed/simple;
	bh=CJyp9joo2apPJ5BlZ+kMeDS1h5XjOwpadlP3GClqUrM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oZEG1T2T749nXepHVDaSYa0cuvgPCw/VUfPF8Dt8Ak90D72wwFQ+dm/mTOrsq8GVEFYTLxANJQ0Plh1vXMvcRbdyP5RyUO8R0kRQUOxfdHRtF8Q+kjBr1TlYhhGbO8w5h7WLPeXWyEFrj6RH5ammbXaUUWhAQynfKuqK/Gi8uR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhQYGStR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhQYGStR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24FE1F0089A;
	Tue, 29 Sep 2026 12:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685208;
	bh=OrK6IKoj0nvGMQMJz7NkIEpaqPpvg+6EM07/ITIB/Uk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XhQYGStRBGZfaW6QBEw93s2wz3N9je4divjQzj0jWAQjsyIEgT9fNMovs/W2fcpF7
	 +LlrMg29X5092/ujlKv6+XtX1NFx8LDsWGoJiRJjTa6/stKkkUoot61PBOQ0mZ8GNi
	 SROZ939somsPwh5DDiEutdYHVGKCI2Q85TdEuSg+kFbGFVyokkyyesK5Q+ok7YRNDm
	 /ZYy5iOTMlMRslVYBhn6PRqNndS2Cj1OQOBrmH3lx8q2NPEOlrzBfJ8oh+kJTtIE6n
	 7KPwJPGGKPQRrwMBB6bzd5r2txgbIS1qOm4gEa2E8zsbe0n1mWA1N3no0YOdUpyoUi
	 wdnsv8R/Na2jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/6] s390/vfio-ap: Fix leaks of pinned NIB and
 registered GISC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260929121837.2715710-2-akrowiak@linux.ibm.com>
References: <20260929121837.2715710-1-akrowiak@linux.ibm.com>
 <20260929121837.2715710-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 12:33:27 +0000
Message-Id: <20260929123327.D24FE1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] vfio_ap: Use-After-Free of vfio_device on AQIC resource release
- [High] vfio_ap: ABA pointer aliasing causes unintended KVM GISC unregistr=
ation
- [High] vfio_ap: Host panic due to VFIO BUG_ON when queue reset fails duri=
ng unmap
- [Medium] vfio_ap: KVM GISC alert reference leak on dynamic queue unplug
--

commit 83f84bb0e3c067b95ee373106f589b768094e294
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: s390/vfio-ap: Fix leaks of pinned NIB and registered GISC

Several code paths in the vfio_ap driver failed to free the AQIC resources,
specifically the pinned guest NIB page and the registered guest ISC used to
enable interrupts for a queue. This commit adds fixes to handle response
codes and prevent memory exhaustion and depletion of KVM interrupt subclass
registrations during dynamic AP reconfiguration.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 4db878c18f41c..e178b657faa8f 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> @@ -254,90 +276,231 @@ static void vfio_ap_wait_for_irqclear(int apqn)
[ ... ]
>  static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
>  {
>  	if (!q)
>  		return;
> -	if (q->saved_isc !=3D VFIO_AP_ISC_INVALID) {
> -		if (!WARN_ON(!q->matrix_mdev) && q->matrix_mdev->kvm)
> -			kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->saved_isc);
> -		q->saved_isc =3D VFIO_AP_ISC_INVALID;
> +
> +	if (q->aqic_resources.isc !=3D VFIO_AP_ISC_INVALID) {
> +		if (q->aqic_resources.kvm &&
> +		    q->matrix_mdev && q->aqic_resources.kvm =3D=3D q->matrix_mdev->kvm=
) {
> +			kvm_s390_gisc_unregister(q->aqic_resources.kvm, q->aqic_resources.isc=
);

[Severity: High]
Can this equality check fall victim to an ABA problem? If the original gues=
t's
struct kvm is freed and a new guest's struct kvm is allocated at the exact
same memory address, could this evaluate to true and mistakenly unregister
the new guest's GISC, silently stopping its AP interrupts?

[Severity: Medium]
If a queue is hot-unplugged from a running guest via sysfs and the reset
fails, the AQIC resources are intentionally leaked and q->matrix_mdev is set
to NULL. If the queue recovers later, will bypassing
kvm_s390_gisc_unregister() permanently leak the KVM GISA alert reference for
the still-running guest?

> +		} else {
> +			report_gisc_unregister_failure(q);
> +		}
> +		q->aqic_resources.isc =3D VFIO_AP_ISC_INVALID;
> +		q->aqic_resources.kvm =3D NULL;
>  	}
> -	if (q->saved_iova && !WARN_ON(!q->matrix_mdev)) {
> -		vfio_unpin_pages(&q->matrix_mdev->vdev, q->saved_iova, 1);
> -		q->saved_iova =3D 0;
> +
> +	if (q->aqic_resources.iova) {
> +		if (q->aqic_resources.vdev)
> +			vfio_unpin_pages(q->aqic_resources.vdev, q->aqic_resources.iova, 1);

[Severity: Critical]
Is it possible for the q->aqic_resources.vdev pointer to become dangling he=
re
if the original matrix_mdev was destroyed? If a queue reset failed previous=
ly
and the resources were kept leaked, the queue would retain the unreferenced
vdev pointer while the matrix_mdev is freed. Could a subsequent reset or
reassignment trigger a use-after-free when dereferencing it for
vfio_unpin_pages()?

> +		else
> +			pr_warn_ratelimited("APQN %02x.%04x: Failed to unpin NIB page at %pad=
\n",
> +					    AP_QID_CARD(q->apqn),
> +					    AP_QID_QUEUE(q->apqn),
> +					    &q->aqic_resources.iova);
> +		q->aqic_resources.iova =3D 0;
> +		q->aqic_resources.vdev =3D NULL;
>  	}
>  }
[ ... ]
> @@ -489,27 +658,48 @@ static struct ap_queue_status vfio_ap_irq_enable(st=
ruct vfio_ap_queue *q,
>  	status =3D ap_aqic(q->apqn, aqic_gisa, h_nib);
>  	switch (status.response_code) {
>  	case AP_RESPONSE_NORMAL:
[ ... ]
>  		vfio_ap_free_aqic_resources(q);
> -		q->saved_iova =3D nib;
> -		q->saved_isc =3D isc;
> +		q->aqic_resources.iova =3D nib;
> +		q->aqic_resources.isc  =3D isc;
> +		q->aqic_resources.vdev =3D &q->matrix_mdev->vdev;

[Severity: Critical]
Does this code need to acquire a lifecycle reference to the vdev pointer
before storing it here? Snapshooting the embedded pointer from matrix_mdev
without taking a reference appears to expose the use-after-free discussed
above if the mediated device goes away.

> +		q->aqic_resources.kvm  =3D q->matrix_mdev->kvm;
>  		break;
[ ... ]
> @@ -1857,8 +2046,29 @@ static void unmap_iova(struct ap_matrix_mdev *matr=
ix_mdev, u64 iova, u64 length)
>  	int loop_cursor;
> =20
>  	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
> -		if (q->saved_iova >=3D iova && q->saved_iova < iova + length)
> +		if (q->aqic_resources.iova >=3D iova && q->aqic_resources.iova < iova =
+ length) {
>  			vfio_ap_irq_disable(q);
> +			/*
> +			 * If AQIC disable was unable to confirm that interrupts were
> +			 * disabled (IR=3D0), q->aqic_res.iova remains non-zero. VFIO
> +			 * core requires the mapped pages to be unpinned during DMA
> +			 * unmap notifications (or type1 IOMMU will BUG_ON after 10
> +			 * retries).
> +			 *
> +			 * To satisfy VFIO core safely, fall back to a queue reset via
> +			 * ZAPQ. ZAPQ wipes the queue state and clears the hardware's
> +			 * internal NIB address register, neutralizing pending DMA.
> +			 *
> +			 * Flush the reset worker. If the reset completes, the worker
> +			 * frees the AQIC resources (unpinning the NIB). If the reset
> +			 * times out or fails with an error, the resources are kept
> +			 * leaked to guard against wild DMA writes.
> +			 */
> +			if (q->aqic_resources.iova) {
> +				vfio_ap_mdev_reset_queue(q);
> +				flush_work(&q->reset_work);
> +			}

[Severity: High]
If the queue reset times out or fails with an error, the NIB page is kept
leaked and remains pinned. Since the VFIO core requires all mapped pages to
be unpinned during an unmap notifier, could returning to the VFIO core from
unmap_iova() without unpinning the page trigger a BUG_ON or WARN_ON and pan=
ic
the host kernel?

> +		}
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929121837.2715=
710-1-akrowiak@linux.ibm.com?part=3D1
