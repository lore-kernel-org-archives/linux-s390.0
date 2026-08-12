Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984AF39E185;
	Wed, 12 Aug 2026 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566926; cv=none; b=h6NIUvpSFyds0OF/pcJWuomOK7Ae6o2kkki9kB/eQyRL2LBSknzvsF9PGGQUVrgfGGetxbMHzbg+BM4xjL69/OeDrp/EKzrAIObvvEF46tlKvaLEbjK3/OIJJ2UtTqrtmLXoN2awkJTzuqPf66AvQ48Ea/Lo5Nt3w3N+3JAzMSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566926; c=relaxed/simple;
	bh=WVlsX+AAbNDTX3fIsWurK9hJtQNG5cVAAQ0WzmOhJO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c84GK7gpr0LrOE28aZeBjypbfWKK6riutEzX22HChsN2Ha2Pc80xVYxpCt/RKr8bjXrGB1/68mEKygDzirrPcKX3zh9Z9SbYsWSe/P6+7v/dFMhI/NsXDYrq57TQcO+kDdpvgqRhrVnanTgMYxHHter9FuiNRvhZnQTb2tyHm4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaPehYib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaPehYib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C906C1F000E9;
	Wed, 12 Aug 2026 20:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786566921;
	bh=2aca4ym3jlhlnfvuA2Nd6UfV42/GOJXhPDCx2sEd1B8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YaPehYibBg0KojgJoLYjCinumkLU8n+38DdUDGC+XRi3o4deBIpb0emZfKWKT7Cim
	 QeDwq/loV53VEgTYc5pRHYpN8uJ7tfGGUWGdTyCDFQT81uEpqjRQHK03FfhJ+ciDU4
	 ZsYf5QrP4ppea7wJg2PN2Jp93lXrorMiDct57sziM9NzewW51z/Eh4UKhLV3sLr4kz
	 70r9RAmJbP5+12PM4WbeS9ahw5AsOPeU6RKgvUYOwgbxnBmfBc7TyWsiLs5RRlGBc1
	 vAYsaQXpyYPmSq5+N6u22gN8kDrjV73Sk40B9VuNi3IQXI+uWEodc8fcJOwvZ0pCJL
	 HkrQAKs1EAIwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 9/9] s390/vfio-ap: Fix memory leak when queue removed
 from host AP config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260812200240.818004-10-akrowiak@linux.ibm.com>
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
 <20260812200240.818004-10-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 20:35:20 +0000
Message-Id: <20260812203520.C906C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incomplete fix for resource leak: `vfio_ap_mdev_reset_queue()` doe=
s not handle `AP_RESPONSE_Q_NOT_AVAIL` (0x01), causing KVM GISC/pinned memo=
ry leaks and spurious WARN_ON stack traces.
--

--- Patch [9]: [PATCH v5 9/9] s390/vfio-ap: Fix memory leak when queue remo=
ved from host AP config ---
commit 6c8828db27ae24e9b17bf29e492fb4382c470413
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix memory leak when queue removed from host AP config

This patch aims to fix a memory leak of KVM GISC resources and pinned guest
memory when an adapter or domain is removed from the host's AP configuratio=
n.
It bypasses the queue reset and directly frees the AQIC resources if the
queue is no longer in the host config.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 1edd0b7a3cce7..bd9d239caeba2 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2533,12 +2533,15 @@ void vfio_ap_mdev_remove_queue(struct ap_device *=
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
Can this still trigger a WARN_ON and leak KVM GISC and pinned memory if a g=
uest
shuts down or the mdev is removed before the physical queue is unbound?

When an adapter is removed from the host config, ap_zapq() returns 0x01
(AP_RESPONSE_Q_NOT_AVAIL). If vfio_ap_mdev_reset_queue() receives this resp=
onse
(for example, during guest shutdown), it falls into the default case, logs a
WARN, and skips freeing AQIC resources:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_reset_queue() {
	...
	default:
		WARN(true,
		     "PQAP/ZAPQ for %02x.%04x failed with invalid rc=3D%u\n",
		     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
		     status.response_code);
	...
}

The driver might then clear the kvm or q->matrix_mdev pointers. Later, when
the physical queue is unbound and this else branch is reached,
vfio_ap_free_aqic_resources(q) would hit the WARN_ON checks because the
pointers are now NULL:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_free_aqic_resources() {
	...
	if (q->saved_isc !=3D VFIO_AP_ISC_INVALID &&
	    !WARN_ON(!(q->matrix_mdev && q->matrix_mdev->kvm))) {
	...
	if (q->saved_iova && !WARN_ON(!q->matrix_mdev)) {
	...
}

Should vfio_ap_mdev_reset_queue() be updated to explicitly handle response
code 0x01 and clean up resources there as well to ensure they are freed
before the pointers are cleared?

>  	}
> =20
>  done:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812200240.8180=
04-1-akrowiak@linux.ibm.com?part=3D9
