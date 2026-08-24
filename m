Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E836439004;
	Mon, 24 Aug 2026 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580852; cv=none; b=sx7+mknqHp10BWBVrrdienyU5o7mR+a0kcVzQ9YdmGuJcQ9E8kuCYWE5D8ECskOjJx7IScwksOnKR3C6mOwE9XFe6j9k7pcVsRhlD5fqPp9BdYkQNyC+ppNVMEHTMVQZ63UcbMcFsDj2sROuO1EA7lqldrpuX2jDHZTx9CKzVY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580852; c=relaxed/simple;
	bh=QNemcXc/ucUbmi848q0OU5huFpiLG1sdSNwO7YG4lD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DRuuNmCTF6mfXO1kFpbCy8AFdiIADAIqLbNQP3RwwIgphDR4AyGGngQbHR2npmNJVJqHDRp48xhOdbNXmbnN7rKmwi7vwwWrIDd79AbARD7f/kkJ58pCKVkDfyLEDW5s/GSQurnsXoGfF+1W8QU6hpw+4z9lYU04toyZ82T0Z0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDGztcXt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDGztcXt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C8D1F000E9;
	Mon, 24 Aug 2026 14:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787580848;
	bh=45a/fS+Q+yy37EXXWBn+NNnHkQZCE5WvEMfQFCIY9qI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VDGztcXtctlVbQbikQcsrBwqTQAtUru1P3wnqf1zT/QZrksudMr6EDHMCJLyXU5rA
	 LfbbVOXV5srq0ldp8zeAd6b3aPhbIWjdVwvEg4GhKe0p+9Aounxy8Qy1oGBjo+7eQt
	 ZJVnKUjti9rWFloIoekKLATGHEvZw+UYTtctCmwEnFxJ+12nNs5u0lO7lEV/zMaIPy
	 NOUIzwEzYGBtg1AW12xr7I8F3ydh5DqAvgazmWvaoRRqlaOTEItTMs4zOhUB3bqQyf
	 qjprELbPKMcZdhN5OWtDni7rXH4/RIXfJY8bW8HLM911fB1KmUTBbzqyVrONYknPBq
	 ImI/v/u2uq6gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] s390/vfio-ap: Fix unbounded loop in
 apq_reset_check()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260824135850.503728-4-akrowiak@linux.ibm.com>
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
 <20260824135850.503728-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 14:14:07 +0000
Message-Id: <20260824141408.58C8D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Unpinning the guest NIB page via `vfio_ap_free_aqic_resources(=
)` when `apq_reset_check()` times out causes a critical DMA use-after-free =
vulnerability.

Pre-existing issues:
- [Critical] Unpinning the guest NIB page after `ap_aqic` timeout in `vfio_=
ap_irq_disable()` causes a DMA use-after-free.
- [High] The introduced timeout mechanism fails to break out of the infinit=
e loop when the hardware returns an asynchronous error (yielding `-EAGAIN`).
--

--- Patch [3]: [PATCH 3/4] s390/vfio-ap: Fix unbounded loop in apq_reset_ch=
eck() ---
commit afa7b19f4ae6cc32897da341d31f38a06cb912ec
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix unbounded loop in apq_reset_check()

This commit introduces a timeout mechanism (AP_RESET_MAX_WAIT) in
apq_reset_check() to prevent the worker from spinning indefinitely when
waiting for an AP queue reset. If the reset takes longer than 2000ms, the
worker writes back the status, frees AQIC resources, and exits.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 6e4569d6b9753..c7eebbd0ed40e 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> @@ -1973,6 +1974,12 @@ static void apq_reset_check(struct work_struct *re=
set_work)
>  					      status.response_code,
>  					      status.queue_empty,
>  					      status.irq_enabled);
> +			if (elapsed >=3D AP_RESET_MAX_WAIT) {
> +				/* Timed out waiting for reset to complete */
> +				memcpy(&q->reset_status, &status, sizeof(status));
> +				vfio_ap_free_aqic_resources(q);

[Severity: Critical]
If the hardware gets stuck and we time out here, does unpinning the NIB page
cause a DMA use-after-free regression?

If the hardware is stuck in a busy or reset-in-progress state, it might sti=
ll
hold the physical address of the NIB.

vfio_ap_free_aqic_resources() unpins the active DMA page:

vfio_ap_free_aqic_resources() {
    ...
    if (q->saved_iova && !WARN_ON(!q->matrix_mdev)) {
        vfio_unpin_pages(&q->matrix_mdev->vdev, q->saved_iova, 1);
        q->saved_iova =3D 0;
    }
}

If the hardware later completes an operation or sends an interrupt, could it
execute a DMA write to the now-freed physical page, potentially corrupting
arbitrary memory on the host?

To safely handle permanently busy hardware, does the NIB page need to be
intentionally leaked or quarantined rather than unpinned?

> +				return;
> +			}
>  		} else {
>  			if (q->reset_status.response_code =3D=3D AP_RESPONSE_RESET_IN_PROGRES=
S ||
>  			    q->reset_status.response_code =3D=3D AP_RESPONSE_BUSY ||
>  			    q->reset_status.response_code =3D=3D AP_RESPONSE_STATE_CHANGE_IN_=
PROGRESS ||
>  			    ret =3D=3D -EAGAIN) {
>  				status =3D ap_zapq(q->apqn, 0);
>  				memcpy(&q->reset_status, &status, sizeof(status));
>  				continue;

[Severity: High]
This isn't a bug introduced by this patch, but does this logic still allow =
an
unbounded loop regression?

Because the elapsed timeout check is entirely inside the if (ret =3D=3D -EB=
USY)
block, if apq_status_check() repeatedly returns -EAGAIN, we take this else
branch and continue without ever checking the elapsed time.

Could this still result in the worker thread hanging indefinitely and
permanently blocking global locks?

>  			}

[Severity: Critical]
This is a pre-existing issue, but a similar DMA use-after-free regression
seems to exist in vfio_ap_irq_disable():

vfio_ap_irq_disable() {
    ...
end_free:
    vfio_ap_free_aqic_resources(q);
    return status;
}

If the hardware fails to process the ap_aqic disable command after its retr=
ies,
this code unconditionally calls vfio_ap_free_aqic_resources(), unpinning the
NIB page.

If the hardware is still actively using it and an interrupt fires later,
couldn't this also cause a DMA write to a freed page?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824135850.5037=
28-1-akrowiak@linux.ibm.com?part=3D3
