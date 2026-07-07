Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D512874F5;
	Tue,  7 Jul 2026 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415741; cv=none; b=SMAi9035ldZBd7jX8wuOaI0vxkDHZBIEDNlKh9e0UmvJoxn3Oklh02VpKZW3+ZnYpOuHTc2ybSyQwj7JC4fw5K6NjJCWrtGmGICTl6SL65W603WFIYb4Gjwg3FFfj35ad4OaBDdm9Agh/gofW2AJ00HCv4wAseYMeVcW/f40niQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415741; c=relaxed/simple;
	bh=Af4U8eoV5qNBEFig4GwKhz/ApJyJyoJP+jBO1yxA0yM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FMrU8wc63dJ5zTNaEwop7JpLSbka3PgWhXnv8G/zwIIoZWIf5rWVrBnLfCV+YwRtvZYZ1o/eQQlgfSP3/GLSu7rsQDiUDUNvFPG+BZK7kHY1rdK5rznGDX23kbXzT1TxuKyaad5p8xUb6xVg4B/36OoUxawrl5R3BM1ajoYiz9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0ldHxNS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0ldHxNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013561F00A3A;
	Tue,  7 Jul 2026 09:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783415740;
	bh=jkH4e3snEfctqMuwZ1ikqwpz1mjL//7T4y0BEmqhCbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U0ldHxNS2UG3kTSUwYS75PQmgnB70Ca3wgusA9ULD9CdRgXzkSQQPL5X/zf/M55Ng
	 +bdKXzfpQnTdOKeuoHa6kMGU6GnG5PF/vwB0jUrplLWNDunsyFvnAF6RQD/hd+8Dt6
	 JEaJBRHn6hjYqjMXWRE7FbVBmadXfX5IFVjaZSYZRKNDCDlN6n+iiJ423FqEwOKOfn
	 3zJpqcQ3TQAfLqHtY1mHv0HZNpz//tui3BkYN2OjTAAG/q00aqhOkAUBYCJSHFMJzl
	 FHZpO4S2bYJZB/D9XuliSZ2A5SMTOwMQpfdi3ZNphGUrcF2BN32IKMPuziDq8ub1U9
	 V3iWG4vkm6x7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/15] s390/vfio-ap: Reset migration state in
 VFIO_DEVICE_RESET ioctl handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260707090226.3206695-5-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
 <20260707090226.3206695-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:15:39 +0000
Message-Id: <20260707091540.013561F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Build Failure / Undefined Function / Potential NULL Pointer De=
reference in `vfio_ap_reset_migration_state`.
- [Low] Typo in comment: 'stte' instead of 'state'.

Pre-existing issues:
- [High] System-wide Denial of Service via unbounded wait holding the globa=
l `matrix_dev->mdevs_lock`.
--

--- Patch [4]: [PATCH v4 04/15] s390/vfio-ap: Reset migration state in VFIO=
_DEVICE_RESET ioctl handler ---
commit 35f281972b36c8fc12cff370107f5d4f61c3aa01
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Reset migration state in VFIO_DEVICE_RESET ioctl handler

This patch adds a function called during VFIO_DEVICE_RESET to release
migration files and free allocated storage for migration state. It resets
the device migration state to RUNNING as required by the specification.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 5b6d48ccf332c..c7c71980bdbb8 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
[ ... ]
> @@ -129,3 +129,23 @@ void vfio_ap_release_migration_data(struct ap_matrix=
_mdev *matrix_mdev)
>  	kfree(matrix_mdev->mig_data);
>  	matrix_mdev->mig_data =3D NULL;
>  }
> +
> +/**
> + * vfio_ap_reset_migration_state - Reset the vfio-ap migration state
> + *
> + * @matrix_mdev: pointer to the object maintaining the vfio-ap device st=
ate
> + *
> + * Called during VFIO_DEVICE_RESET to clean up any active migration
> + * stte and reset the device to RUNNING state as required by the VFIO

[Severity: Low]
This isn't a bug, but there is a typo here. Did you mean "state" instead of
"stte"?

> + * migration specification.
> + */
> +void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	if (!matrix_mdev->mig_data)
> +		return;
> +
> +	vfio_ap_release_mig_files(matrix_mdev);

[Severity: Critical]
Does vfio_ap_release_mig_files() exist in the kernel? I could not find a
definition or declaration for it.

If the intention was to call vfio_ap_release_migration_data() to free the
storage as mentioned in the commit message, wouldn't that set
matrix_mdev->mig_data to NULL?

> +	matrix_mdev->mig_data->mig_state =3D VFIO_DEVICE_STATE_RUNNING;

If matrix_mdev->mig_data is freed and set to NULL just prior to this, won't
this line unconditionally dereference the newly NULL pointer and cause a
crash?

> +}
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 8132902148669..8a9e83921f74e 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2332,6 +2332,10 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_devi=
ce *vdev,
>  		break;
>  	case VFIO_DEVICE_RESET:
>  		ret =3D vfio_ap_mdev_reset_queues(matrix_mdev);

[Severity: High]
This is a pre-existing issue, but can this lead to a system-wide deadlock?

In vfio_ap_mdev_ioctl(), the global matrix_dev->mdevs_lock is acquired
before calling vfio_ap_mdev_reset_queues().=20

Inside vfio_ap_mdev_reset_queues(), flush_work() is called, which
synchronously waits for apq_reset_check() to complete:

vfio_ap_mdev_reset_queues()
    flush_work(&q->reset_work);

If the hardware faults, apq_reset_check() polls indefinitely in its
infinite while (true) loop. Because the global mdevs_lock is held during
this time, would this permanently block all other operations across all
vfio-ap mediated devices?

> +		if (ret =3D=3D 0) {
> +			/* Reset migration state per VFIO migration spec */
> +			vfio_ap_reset_migration_state(matrix_mdev);
> +		}
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707090226.3206=
695-1-akrowiak@linux.ibm.com?part=3D4
