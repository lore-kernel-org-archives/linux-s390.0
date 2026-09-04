Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD4F3DDDCD;
	Fri,  4 Sep 2026 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515320; cv=none; b=l9dMOEMOc6py6c3N0gCOaqqOVoyywmgu2VA6wHvMqqlwPO/7YE7OciUs6Yz3h6MvLM4Z2UQwR4a9+LA9Fp3ENNCFnr6x9z7W769phe/wA2Y/XHq8tFwHwQsGZLjEmPGPpFcWLWeswpVGumvboqFGfVmKZWhx5xE4Ifq4Zj2NeWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515320; c=relaxed/simple;
	bh=zrAJiLuyHIX+20SU1WBGA07bZsn9K3AGht7oHd6EwMo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aZfhApp89j/0MIlfIxdsHSldIojs0MkRFF0uf7ZH9ZPYujfsT4wxqHnP6bvEepc5Ftm6jRG2XxZFMjDS9oaBrdUDc93AeF5rgpm7lEWJNtNyEvO5Npb0P+YEMy3T9J01WJReDJngGlwn2FcZhfibvTzNdRkuWebpWdfC3Zlb9/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxN+nY2l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxN+nY2l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E72F1F00A3D;
	Fri,  4 Sep 2026 09:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788515319;
	bh=+omG4jRD8rgxg8KVSVMRg9iAmjR20pdt1/ERs7ue6xk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gxN+nY2laTOrG0BFmH7LlOWUigNdKBcSETu7DRJT/Hk/rFTlTh9mdKVcIU1rbjqMd
	 40FMc6wqKY0DeLOEmkEpcRrYiwnjoIfS2hm1DbyAmizCsBwkeCjHouJVX4QR9K1q7w
	 yOCPMV4OHuvqxgf7OyAz/FADr+U/YJvkihhe1DUYlH0WpQCQk+r5KktAI/vGLsaMqo
	 hlWUh8MA555EFydvZwXudw6BER5uEocm2nQztUi+V/Y2zAHXzqGc6UC8D+GHl83w3O
	 /5rG+dcgmCmXKCJy8zt5ts9nvuJqodWKX4cAaRX8cL44BORVdkqspQAI7BGxWX5guI
	 diCwZ3UihfZpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/5] s390/vfio-ap: Fix unbounded loop in
 apq_reset_check()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260904093435.1161402-4-akrowiak@linux.ibm.com>
References: <20260904093435.1161402-1-akrowiak@linux.ibm.com>
 <20260904093435.1161402-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 09:48:38 +0000
Message-Id: <20260904094839.1E72F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Dangling AQIC resources after a reset timeout cause arbitrary IOVA=
 unpinning in a subsequent guest's VFIO container.

Pre-existing issues:
- [High] Early return on an unknown hardware response code (-EIO) silently =
leaks AQIC resources and fails to update the queue's reset status.
--

commit fec86a42ae1833abad22bf816bcbaaa29965a88e
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
s390/vfio-ap: Fix unbounded loop in apq_reset_check()

This commit fixes an unbounded loop in the queue reset worker by introducin=
g a
maximum wait time of 2000ms. It also adds logic to verify the asynchronous
completion of queue zeroization and intentionally leaks AQIC resources on
timeout to avoid a potential host crash from wild DMA writes.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index ea0625f10c7e8..32b80d91a6431 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> @@ -2050,6 +2113,54 @@ static void apq_reset_check(struct work_struct *re=
set_work)
>  		ret =3D apq_status_check(q->apqn, &status);
>  		if (ret =3D=3D -EIO)
>  			return;

[Severity: High]
This is a pre-existing issue, but does this early return on an unknown
hardware response code (-EIO) silently leak AQIC resources?

By returning immediately, this path bypasses the resource cleanup in
vfio_ap_free_aqic_resources(). This leaves q->saved_iova dangling and fails
to update q->reset_status.response_code.=20

Since the status remains 0 (AP_RESPONSE_NORMAL), callers might incorrectly=
=20
believe the queue is securely zeroed. If the queue is then reassigned to a=
=20
new guest, could the next successful reset unpin the old IOVA from the new=
=20
guest's IOMMU domain and corrupt memory?

> +		if (elapsed >=3D AP_RESET_MAX_WAIT) {
> +			/*
> +			 * Zeroization confirmed (ret =3D=3D 0): the TAPQ status bits
> +			 * indicate the async portion of the ZAPQ completed
> +			 * successfully. Free AQIC resources and return.
> +			 *
> +			 * Queue non-operational (ret =3D=3D -ENODEV): the queue is
> +			 * deconfigured or checkstopped; interrupts are not
> +			 * possible so AQIC resources can be safely freed.
> +			 * Zeroization cannot be confirmed in this state, but the
> +			 * queue cannot generate interrupts, so the NIB page is
> +			 * no longer a DMA target and it is safe to free it.
> +			 */
> +			if (!ret || ret =3D=3D -ENODEV)
> +				goto done;
> +			/*
> +			 * Timed out without being able to verify zapq completed.
> +			 *
> +			 * The AQIC resources associated with this queue - the pinned
> +			 * page containing the NIB and the registered guest ISC -
> +			 * cannot be freed here. The NIB is the active DMA target
> +			 * for AP interrupt delivery until the reset completes;
> +			 * freeing the pinned page while the hardware may still
> +			 * write to it would result in a wild DMA write that could
> +			 * corrupt host memory.
> +			 *
> +			 * If the reset eventually completes, interrupts will be
> +			 * terminated and the pinned NIB page and ISC registration
> +			 * will be leaked. This is preferable to either a wild DMA
> +			 * write or waiting indefinitely: flush_work() callers hold
> +			 * the matrix_dev->mdevs_lock mutex which serializes access
> +			 * to all mdev objects system-wide, so blocking here would
> +			 * hang all guests to which those mdevs are attached.
> +			 */
> +			report_aqic_resource_leak(q);
> +			/*
> +			 * Report the actual non-zero hardware response code, or
> +			 * synthesize AP_RESPONSE_RESET_IN_PROGRESS if TAPQ
> +			 * completed normally but the status bits failed to
> +			 * transition to their post-reset states.
> +			 */
> +			if (status.response_code =3D=3D AP_RESPONSE_NORMAL)
> +				q->reset_status.response_code =3D AP_RESPONSE_RESET_IN_PROGRESS;
> +			else
> +				q->reset_status.response_code =3D status.response_code;
> +
> +			return;
> +		}

[Severity: High]
Does this early return on timeout leave dangling AQIC resources that could
cause arbitrary IOVA unpinning in a subsequent guest's VFIO container?

When the worker exits on timeout without clearing the dangling q->saved_iova
field, and the adapter is unassigned from the current guest and hot-plugged
into a new guest, q->matrix_mdev is updated to the new guest.

When the new guest successfully resets the queue, vfio_ap_free_aqic_resourc=
es()
will be called. Because q->matrix_mdev is now the new guest's mdev and
q->saved_iova is still the old guest's IOVA, it seems this would erroneousl=
y=20
unpin an arbitrary IOVA from the new guest's VFIO container:

vfio_ap_free_aqic_resources() {
    ...
    if (q->saved_iova && !WARN_ON(!q->matrix_mdev)) {
        vfio_unpin_pages(&q->matrix_mdev->vdev, q->saved_iova, 1);
        q->saved_iova =3D 0;
    }
}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904093435.1161=
402-1-akrowiak@linux.ibm.com?part=3D3
