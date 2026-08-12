Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C31471263;
	Wed, 12 Aug 2026 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555655; cv=none; b=ZmBFXbLto4fUo9ESR/2AwPw5Y80DMb852J8JSrX0QvjkXZYjhtFjOgQWKyMHb5AGSUlaD2a3E3l5cYnSCeZXp4AbMVXe4eFbyh2hklx4nZy042l9SVaUiCfqYTug68x9jW5wxgI38mCz0HOi22WrlKP5C6D23l3h9jsuEX5LtMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555655; c=relaxed/simple;
	bh=hKmn/F9N3cCzLvpx5n8DEU2Xez+ZDGrOvbq2JFzEWb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SC20FnG712DbZqK4FHeD0B/E+JkcimPY1Ue+uQ9xjwnFcmAYCGWF1Ya4zQcBdaIL3KwWzvEvSakX93B9Ajk6bosONaJv7nhVdGDnkaDhqBL2Dupw425+lMjzlD9Qc+zp2rlBBEuQM60tcFd9iPlBX0tgd+4aqHrxSb/3scT4Bzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJ3IodLe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ3IodLe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAF21F000E9;
	Wed, 12 Aug 2026 17:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555654;
	bh=dY223rn9levgmdfXC4IBgIB5AyUXkNPUQpfLasR3khg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mJ3IodLeM90QBZCElp6tROG4eq6vztyVpMWuD7DWhfqmZ5hUy4JcKDv3FhujXL8EO
	 QCZnSV53NQ1Lkny/2vE7Jo+cpfJ5ysPpd8dQ82vN+MruX6J2zWs0tAnMw+HzJTvKHZ
	 sdc7Epke5Fo9QX9fLE7+CNC0ozqO1FkkNb3stMQlN26unwlPwXqVwPPEIqC6BiaRRa
	 yVeI7/J8AH3Z9sIWURKxRyigCoT5uNpS3EOQfRXKb8KEGb5hIQiR0TLCZf48zfNVSS
	 yYA6hZs86ISUqhKqGGiqQxkumyGzGiqemYzNJ6zLaboFH6wTYVmXjkmVK+CZfSi0X0
	 WY+inmkWY/AGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/9] s390/vfio-ap: Fix NULL deref in status_show()
 during queue probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812170945.738351-9-akrowiak@linux.ibm.com>
References: <20260812170945.738351-1-akrowiak@linux.ibm.com>
 <20260812170945.738351-9-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:27:33 +0000
Message-Id: <20260812172733.ABAF21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch attempts to fix a TOCTOU race by holding update locks du=
ring sysfs group creation, but leaves the exact same race window open on th=
e allocation error path, leading to a NULL pointer dereference.
- [High] Missing flush or cancellation of `q->reset_work` in `vfio_ap_mdev_=
remove_queue` leads to a Use-After-Free.
--

--- Patch [8]: [PATCH v4 8/9] s390/vfio-ap: Fix NULL deref in status_show()=
 during queue probe ---
commit 9b9dde366169d761a8888f77c5299cbff3f3b6ea
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix NULL deref in status_show() during queue probe

This commit acquires the update locks before calling sysfs_create_group()
during queue probe to prevent a NULL pointer dereference in a concurrent
read of the status attribute. It also optimizes APQN retrieval.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> @@ -2472,8 +2474,13 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apd=
ev)
>  	return ret;
> =20
>  err_remove_group:
> +	release_update_locks_for_mdev(matrix_mdev);
>  	sysfs_remove_group(&apdev->device.kobj, &vfio_queue_attr_group);
>  	return ret;

[Severity: High]
This is a pre-existing issue, but does releasing the update locks before
removing the sysfs group reopen the race window on the allocation error pat=
h?

If kzalloc_obj() fails, the error path releases guests_lock before calling
sysfs_remove_group(). This immediately unblocks any concurrent readers of
status_show() while the sysfs file still exists.

Once unblocked, status_show() will retrieve NULL from dev_get_drvdata() and
pass it to vfio_ap_mdev_for_queue(), which unconditionally dereferences it:

vfio_ap_ops.c:status_show()
    q =3D dev_get_drvdata(&apdev->device);
    matrix_mdev =3D vfio_ap_mdev_for_queue(q);

vfio_ap_ops.c:vfio_ap_mdev_for_queue()
    unsigned long apid =3D AP_QID_CARD(q->apqn);

Should sysfs_remove_group() be called before release_update_locks_for_mdev()
here to prevent this NULL pointer dereference?

> +
> +err_release_locks:
> +	release_update_locks_for_mdev(matrix_mdev);
> +	return ret;
>  }
> =20
>  void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
>  {

[ ... ]

>  	if (test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm) &&
>  	    test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm)) {
>  		vfio_ap_mdev_reset_queue(q);
>  		flush_work(&q->reset_work);
>  	} else {
>  		vfio_ap_free_aqic_resources(q);
>  	}
> =20
>  done:
>  	if (matrix_mdev)
>  		vfio_ap_unlink_queue_fr_mdev(q);
> =20
>  	dev_set_drvdata(&apdev->device, NULL);
>  	kfree(q);

[Severity: High]
This is a pre-existing issue, but does this conditional bypass of
flush_work() create a use-after-free risk?

If a hardware hot-unplug races with a background reset operation, and the
queue is not in the host's AP configuration, the teardown path skips flushi=
ng
the reset_work and frees the queue object.

Meanwhile, the background worker continues executing and accesses the freed
structure:

vfio_ap_ops.c:apq_reset_check()
    q =3D container_of(reset_work, struct vfio_ap_queue, reset_work);
    memcpy(&status, &q->reset_status, sizeof(status));
    ...
    status =3D ap_tapq(q->apqn, NULL);

Should flush_work() or cancel_work_sync() be called unconditionally before
kfree(q) to prevent this memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812170945.7383=
51-1-akrowiak@linux.ibm.com?part=3D8
