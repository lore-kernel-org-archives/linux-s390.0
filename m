Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD35C334C3C;
	Wed, 12 Aug 2026 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538073; cv=none; b=t+7261M2iU9bLKV4RLrw0K6AFHXKldlgGUg9FN0KYqtrGZvJLeokQpXVkDIr+pkrA6sD3lO2NazfNAnFrnrdm0I3bXUzhYcr+vW8vxcSkrHOVRAHcc8/fZW5tUYBy2qRmWddSe5O9HVVFCnVAsevP0zhXTMU4j7TwppNOg3UXL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538073; c=relaxed/simple;
	bh=DB7nQuVoyxIsDg9rBkKnW5lnJxI5yqWlS44mNgvpC9A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mUzrQUt5vOtcSI3HYttsrGBfhseraD5kKtBieMLA2lq9J2S1cufgYUJkwwRrBFM8VGO1EXCdTUAV56HF2BxIh02Uo32LafFoBV9wyFq83GBI/KtlJIy0cCECjwJFJ2CyYB9LrtTnCwlldOqCMgV/liY4o443X4NZurUQCh1Iidc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps2zKNmO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps2zKNmO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BE01F000E9;
	Wed, 12 Aug 2026 12:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786538071;
	bh=LXjB/Gq/5VBcb1pYlOQr6v+GbBBqEZXJtvKJojh1n9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ps2zKNmOb2Jrsk2H+bwDnd2UxJgrGo1Mz5r7QvBxNgF7bQdpktU/WXmTCWm4pY1Ry
	 IxBqa9nqbb9evGalDIruTUBGBQNc4VsXrD9CU2JmJ+ohQqDddR7C82hDaFvePNZsxU
	 r62QoaYzDROgkhDlip+3Hl76nLlWUBvgcZtwHJ7fMozFVAeRNJctDcn4c2xjoJ/5l+
	 I6VuEqdzwP9qMDBJbSBN4wgqW1dZoFQrJ/2fGn63y5rR4cg+APs3xIByJ+89pOVqvq
	 Ksa25PvM1nrFpBkJto5VuesHhNpjxOthd4iotNhxC2qW7HE4b8OQAOnYu5TMgNRcwX
	 YhfXNZOGnZY9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 9/9] s390/vfio-ap: Fix memory leak when queue removed
 from host AP config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812115139.576303-10-akrowiak@linux.ibm.com>
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
 <20260812115139.576303-10-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 12:34:30 +0000
Message-Id: <20260812123431.12BE01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Software resources (KVM GISC registration and pinned guest memory)=
 are permanently leaked if hardware reset fails unexpectedly.
--

--- Patch [9]: [PATCH v3 9/9] s390/vfio-ap: Fix memory leak when queue remo=
ved from host AP config ---
commit b591517cf03c156d327043d4900cb31e47ff080b
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix memory leak when queue removed from host AP config

When an adapter or domain is removed from the host's AP configuration,
vfio_ap_mdev_remove_queue() can bypass resetting the queue. This patch fixes
a leak of KVM GISC resources and pinned guest memory by calling
vfio_ap_free_aqic_resources() if the adapter or domain is no longer in the
matrix configuration.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 3652ba792be73..faab5e9179ff1 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2507,12 +2507,15 @@ void vfio_ap_mdev_remove_queue(struct ap_device *=
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

[Severity: High]
This is a pre-existing issue, but does vfio_ap_mdev_reset_queue() leak
software resources (KVM GISC registration and pinned guest memory) if=20
hardware reset fails unexpectedly?

In vfio_ap_mdev_reset_queue(), if ap_zapq() returns an unexpected response
code, the default case is hit:

	default:
		WARN(true,
		     "PQAP/ZAPQ for %02x.%04x failed with invalid rc=3D%u\n",
		     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
		     status.response_code);
	}

This default path returns without queuing the reset work or calling
vfio_ap_free_aqic_resources().

A similar situation occurs in the asynchronous worker thread apq_reset_chec=
k()
if ap_tapq() returns an unexpected response code:

		ret =3D apq_status_check(q->apqn, &status);
		if (ret =3D=3D -EIO)
			return;

Since vfio_ap_mdev_remove_queue() continues on to call kfree(q) regardless =
of
the outcome of vfio_ap_mdev_reset_queue():

	dev_set_drvdata(&apdev->device, NULL);
	kfree(q);
	release_update_locks_for_mdev(matrix_mdev);

Are these resources permanently lost when this happens?

>  		flush_work(&q->reset_work);
> +	} else {
> +		vfio_ap_free_aqic_resources(q);
>  	}
> =20
>  done:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812115139.5763=
03-1-akrowiak@linux.ibm.com?part=3D9
