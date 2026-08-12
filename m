Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7123F0AA9;
	Wed, 12 Aug 2026 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536299; cv=none; b=ZVvmMlcJ6pfwsY5KVcL31jIdRdq0LwS7i275pjlrY/jBmnPsbhGvfg1qACmWgD29jCte27LqGOcOxEe2OwAeXWzYUb+vh08aOZSqt9FPPNA7DILAqZyaWOrMiSItIbgq3NfPMjC2Ah7QzQ44p6u9MHxvE8SUOHUn4X2WqLHnYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536299; c=relaxed/simple;
	bh=TxC0/JW/cYHlTRAFrH8Dpo1NMZh9Lm2rq7yhVW0bQLY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=btaUOGTSikS9/XMesfagBtpaXJs7RNA1Mqt/EoXlDRXynHjx2jKbTmY307TmqUwMiAiBKIhuUjRIgSCELNr5Sk6O7PBlD3wNjVtdN0+Sm3zPEx15Ibdc18u34G/EPGb0TLhVmxJqa+nMZpGgek5rIXxIOPKWypI1x1mb9FgBecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0vZodDs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0vZodDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F3D1F000E9;
	Wed, 12 Aug 2026 12:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786536297;
	bh=pyUvfxVmKiG3dJEqSONJvxBh0t+g3hYb+6oTdeoKM2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I0vZodDsQeLQfpkYkEuZSXovPNl1DNqyTfZYLbs66jMzrZLG6Vyw2ApuadfHCMv8S
	 Xnv+72Ln3FoqHAHImcHl+dmLUIm4O2Pl81m2kKp/DHyu64JzUx3kUczRYQRz2iw9CH
	 YZfWnDHEyAFjM+a2vEQnoiTo4QiPSrdWOiEQLTpjOilQn+fkLRNTaI4ETdSHAKHuz1
	 UHQDCBN6wwgNWHVs84Gt8v/aJL8eGCOVX4NqSze/1rCnvsac2MXc00G+NDrVufrtfh
	 WmEZG6K2mUlvcXk5t1V82E8+p7lEImRhegLZ84kyUq+U5Bk9nW+vja5YfL0Vv3Qc3y
	 slKEMVFqBnFPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] s390/vfio-ap: fix potential use of uninitialized
 apm_filtered bitmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260812115139.576303-7-akrowiak@linux.ibm.com>
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
 <20260812115139.576303-7-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 12:04:56 +0000
Message-Id: <20260812120457.25F3D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential subsystem-wide hang due to an unbounded infinite loop in=
 `apq_reset_check()` while holding global mutexes.
--

--- Patch [6]: [PATCH v3 6/9] s390/vfio-ap: fix potential use of uninitiali=
zed apm_filtered bitmap ---
commit 54d6a10b5f4c5f98506b757af68f95ada615865b
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: fix potential use of uninitialized apm_filtered bitmap

This commit fixes a bug where the apm_filtered bitmap was used uninitialized
if a hot plug configuration change only added control domains. It zeroes the
bitmap using bitmap_zero() at the start of the function to prevent using
stack garbage.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index b6d0c988cc810..cdc9bf5c5e53d 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2840,6 +2840,8 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_mat=
rix_mdev *matrix_mdev)
>  	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
>  	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug =3D fals=
e;
> =20
> +	bitmap_zero(apm_filtered, AP_DEVICES);
> +

[Severity: High]
This isn't a bug introduced by this patch, but can the subsystem hang if the
hardware continuously returns -EBUSY?

Looking at apq_reset_check(), there is a loop that continues indefinitely
without a timeout bounds:

drivers/s390/crypto/vfio_ap_ops.c:apq_reset_check() {
	while (true) {
		msleep(AP_RESET_INTERVAL);
		elapsed +=3D AP_RESET_INTERVAL;
		status =3D ap_tapq(q->apqn, NULL);
		ret =3D apq_status_check(q->apqn, &status);
		if (ret =3D=3D -EIO)
			return;
		if (ret =3D=3D -EBUSY) {
			pr_notice_ratelimited(WAIT_MSG, elapsed,...);
}

If a user process triggers a reset, it queues a reset and subsequently waits
for it using flush_work() while holding the global matrix_dev->mdevs_lock
and matrix_dev->guests_lock:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_reset_queues() {
	hash_for_each(matrix_mdev->qtable.queues, loop_cursor, q, mdev_qnode) {
		flush_work(&q->reset_work);
}

Could this create a permanent kernel thread hang that persistently holds
global locks if the hardware is unresponsive or repeatedly returns
AP_RESPONSE_BUSY?

>  	filter_adapters =3D bitmap_intersects(matrix_mdev->matrix.apm,
>  					    matrix_mdev->apm_add, AP_DEVICES);
>  	filter_domains =3D bitmap_intersects(matrix_mdev->matrix.aqm,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812115139.5763=
03-1-akrowiak@linux.ibm.com?part=3D6
