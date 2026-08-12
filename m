Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DDF449B09;
	Wed, 12 Aug 2026 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556323; cv=none; b=SRdA/IR9FbQYq/hE3z+v5Bujai3py9TDmS7ObHg0ToKO1nBbuqlwgnFiCb/n5V6BTt+trcPdDaKXep/v8wZEyc/j4eqJFO9an1eNuwW5BzBIJ68efDDwkOKs0/19jP3W3pQedjUKBP1dJyC4gy640wZdDy5XXmotqBaB78kIYT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556323; c=relaxed/simple;
	bh=3Go29JJO6X2G3d3LWaeFzIN2F+YQZqxVPltw9X7TD7g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fdjLRu66nXWyieMvntGZQrq1PTqD6EUlQUVPumnvJWfvKVwUlgP3JomQ2TeU3rHvx9I8M60cWLDw38La4mJ6C00uat9R6i/x05dIcziXPtXe/cqsu588TW62yVKwRpH9MmEgFnqcTaPW6t8FYbXCCnYUDJO7DjUkv/pBdYqvGPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEmezSoQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEmezSoQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FAD1F000E9;
	Wed, 12 Aug 2026 17:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786556322;
	bh=Esp5tca4upMfW5W5zYjys9R0fgsrkME8I/GKgTrYgB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SEmezSoQqC6hFgjtjs9IG4HUIKcECLeUyE7WV+6FI8I5xs0s7hvU3UWUoZRs4II/J
	 7YmhWDqZM3Fb0eNiih2kRzqc+MlzV04JipLdWMucHOLMrCOn3olhEtQsuBzUsuuB8q
	 3IyzRTBh3uxVwGSEOao68gnb+0AsQ1ae4FdRJMuSwBK73/xICRU9fmI+VXBH3VYGRe
	 jTurmarz61LjxI/iIfphjC9TpFjOEVGbEO2JXBxbzTv/ZFpofO1eLX/+sNHXiCMSpp
	 O2it8y0R7Yq1l80boMlmrZiMBpwPgP7D6885kgh1hfaw56o5lUokXgjgC2ebXR6FXj
	 8UeaOWwXFfTcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] s390/vfio-ap: Fix memory leak when queue removed
 from host AP config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260812170945.738351-10-akrowiak@linux.ibm.com>
References: <20260812170945.738351-1-akrowiak@linux.ibm.com>
 <20260812170945.738351-10-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:38:41 +0000
Message-Id: <20260812173841.A7FAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch introduces potential `WARN_ON` kernel splats and fails t=
o fully fix the resource leak if the mdev is destroyed or the queue is unas=
signed before the AP bus invokes `vfio_ap_mdev_remove_queue()`.
--

--- Patch [9]: [PATCH v4 9/9] s390/vfio-ap: Fix memory leak when queue remo=
ved from host AP config ---
commit 29bff4de7f99aebfbf379edfd50ba6273390d8d9
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix memory leak when queue removed from host AP config

When an adapter or domain is removed from the host's AP configuration, the
AP bus invokes vfio_ap_on_cfg_changed() to notify the vfio_ap device
driver. For each ap_matrix_mdev object to which the adapter or domain
is assigned, vfio_ap_mdev_hot_unplug_cfg() is called and removes the
adapter or domain from the matrix_mdev->shadow_apcb (i.e., the guest's AP
configuration) and hot unplugs it if a guest is using it.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index b0454a296c67e..a8de98d5e71ed 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2515,12 +2515,15 @@ void vfio_ap_mdev_remove_queue(struct ap_device *=
apdev)
>  	/*
>  	 * If the queue is not in the host's AP configuration, then resetting
>  	 * it will fail with response code 01, (APQN not valid); so, let's make
> -	 * sure it is in the host's config.
> +	 * sure it is in the host's config. If it is not, then free the KVM GISC
> +	 * resources.
>  	 */
>  	if (test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm) &&
>  	    test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm)) {
>  		vfio_ap_mdev_reset_queue(q);
>  		flush_work(&q->reset_work);
> +	} else {
> +		vfio_ap_free_aqic_resources(q);

[Severity: High]
Can this bypass the resource cleanup and cause kernel splats if the mdev is=
=20
destroyed or the queue is unassigned before this point?

If userspace unassigns the queue or QEMU closes the mdev, paths like
vfio_ap_mdev_unset_kvm() or unassign_adapter_store() will attempt to reset=
=20
the queue by calling vfio_ap_mdev_reset_queue().

Since the adapter is no longer in the host config, ap_zapq() returns 0x01
(AP_RESPONSE_Q_NOT_AVAIL). However, vfio_ap_mdev_reset_queue() does not han=
dle
this response code in its switch statement. This bypasses the synchronous
cleanup in vfio_ap_free_aqic_resources(), leaving q->saved_isc and
q->saved_iova valid.

The cleanup routines then proceed to clear q->matrix_mdev or
q->matrix_mdev->kvm.

When the AP bus later asynchronously calls vfio_ap_mdev_remove_queue(), this
newly added else block is reached.

Inside vfio_ap_free_aqic_resources():

	if (q->saved_isc !=3D VFIO_AP_ISC_INVALID &&
	    !WARN_ON(!(q->matrix_mdev && q->matrix_mdev->kvm))) {
		kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->saved_isc);
		...
	if (q->saved_iova && !WARN_ON(!q->matrix_mdev)) {
		vfio_unpin_pages(&q->matrix_mdev->vdev, q->saved_iova, 1);

Because q->matrix_mdev or q->matrix_mdev->kvm is now NULL, the WARN_ON chec=
ks
evaluate to true. This triggers a kernel splat and bypasses the actual clea=
nup
calls, leaking the KVM GISC resources and pinned pages.

>  	}
> =20
>  done:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812170945.7383=
51-1-akrowiak@linux.ibm.com?part=3D9
