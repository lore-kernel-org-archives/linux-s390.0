Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFC1409610;
	Tue, 30 Jun 2026 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817903; cv=none; b=Lp6wYadu29aAg/+s6Ly676edv5EZVj/OOCsFNptmpmZZH1Zf0AxO/eOHmYPYyvvpISOKqWAQ50hLmPUIPP7GHx/PVJjtme4c7TeQ15Cpv3Ywlz9xKoRh7HL2fW3KNv4veeGHmnbjTMij/vIaSe6YULel0NROEnfBQFroSGKOabM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817903; c=relaxed/simple;
	bh=v8emd0+iJg73lla8cZKdlKAEjPum1TXArUvYoWrvMgg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BTH6rVhV0nusuJw+F3dsFkIbEIVCoIOgWn6rDBZ3bo9vKjarechuZ2ULLTEKpTswQzU7f2ao7xa15SRsyvhNSgOTT9hIlzjdBz4qDE5xUnQF70uyp21uAj67N8Kf2y3WKktR56mSdaos/BaHEhZ4z4M1H/FiOJcZBp+mQZURd5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqSLLoIV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqSLLoIV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F0A1F00A3A;
	Tue, 30 Jun 2026 11:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782817902;
	bh=tzicFelJ83Aw1XQxph/oLJq5DnR+vyQ2AWf/pH5gfKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OqSLLoIVMAas1myasolyFvK8Yl5dBDVZf32u/ZbDGGKE+uQdpx3lgQKpWDEeBRV/g
	 W16wxOFIJ0Hnae5uVAykSI2kLOxE6UgvMTI7LN6z0FYhRXWng4kneuisOQ/xTGRYIO
	 6LuZLMqlhQHqgAZFt1mbXgXHZJH8bIOw7ugxtuf8kJhlbDTG/uCZy9oZlhN1Miqp1A
	 MWA193gJs5f7+ZipTTd7kzBlVBT65Cq37Adw2y8wxZ5bey5x1Z0gXkjzF52p8ZHPAe
	 kJSptIZeJOEBJm0crU1Fw/Mt5Yn9wFwifN0MNOR5axe8NoAD74JNwbIK2eAOL3XEDs
	 CB9N9aC69i0Wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/15] s390-vfio-ap: Callback to get/set vfio device
 mig state during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260630104132.1598851-6-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
 <20260630104132.1598851-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:11:41 +0000
Message-Id: <20260630111142.08F0A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Race condition in `vfio_ap_release_mig_file` accessing `mig_da=
ta` without locking, resulting in Use-After-Free and memory leak.
- [High] Removal of migration file cleanup logic from vfio_ap_reset_migrati=
on_state leaves stale file pointers, causing resource leaks.
- [High] The device state is not updated to VFIO_DEVICE_STATE_ERROR when a =
state transition fails.
- [Medium] Unratelimited dev_err allows unprivileged users to flood the ker=
nel log.
- [Medium] Use of global mutex for device-specific state operations allows =
cross-VM interference.
--

commit d82cbc8a070306f90cbac1743dbb46ba5b58d080
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390-vfio-ap: Callback to get/set vfio device mig state during guest migrat=
ion

Implements two callbacks related to the current state of a vfio-ap device:
* The callback that sets a new migration state of a vfio-ap device during
  live migration of guests with pass-through access to AP devices. This
  callback is mandatory for VFIO_DEVICE_FEATURE_MIGRATION support.

  The function pointer for this callback is specified via the
  'migration_set_state' field of the 'vfio_migration_ops' structure
  which is stored with the VFIO device when the 'vfio_device'
  structure representing the mediated device is initialized.

* The callback that returns the current vfio device migration state during
  live migration of guests with pass-through access to AP devices.

  The function pointer for this callback is specified via the
  'migration_get_state' field of the 'vfio_migration_ops' structure
  which is stored with the VFIO device when the 'vfio_device'
  structure representing the mediated device is initialized.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index c7c71980bdbb8..8274e7b65eea4 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
[ ... ]
> @@ -56,16 +57,140 @@ struct vfio_ap_config {
>  	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
>  };
> =20
[ ... ]
> +static struct file *vfio_ap_set_state(struct vfio_device *vdev,
> +				      enum vfio_device_mig_state  new_state)
>  {
> -	return NULL;
> +	int ret;
> +	struct file *filp =3D NULL;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	enum vfio_device_mig_state next_state;
> +	struct vfio_ap_migration_data *mig_data;
> +
> +	matrix_mdev =3D container_of(vdev, struct ap_matrix_mdev, vdev);
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);

[Severity: Medium]
Does using the global mdevs_lock here allow an attacker controlling a guest=
=20
to heavily contend the lock by repeatedly calling the migration ioctl? Woul=
d=20
it be better to use a per-device lock to prevent potential cross-VM=20
interference?

> +	if (ap_is_se_guest()) {
> +		dev_err(matrix_mdev->vdev.dev,
> +			"Migration not allowed from or to a Secure Execution guest\n");

[Severity: Medium]
Could this unratelimited error message allow an unprivileged user program t=
o=20
flood the kernel log by calling the ioctl in a tight loop?

> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		return ERR_PTR(-EPERM);
> +	}
> +
> +	mig_data =3D matrix_mdev->mig_data;
> +
[ ... ]
> +	while (mig_data->mig_state !=3D new_state) {
> +		ret =3D vfio_mig_get_next_state(vdev, mig_data->mig_state,
> +					      new_state, &next_state);
> +		if (ret) {
> +			filp =3D ERR_PTR(ret);
> +			break;
> +		}
> +
> +		filp =3D vfio_ap_transition_to_state(matrix_mdev, next_state);
> +		if (IS_ERR(filp))
> +			break;

[Severity: High]
If a state transition fails here, should the device be placed into=20
VFIO_DEVICE_STATE_ERROR? The current logic seems to break the loop and=20
return the error, but mig_data->mig_state is left unmodified, so subsequent=
=20
calls might report the old valid state instead of the required error state.

> +
> +		mig_data->mig_state =3D next_state;
> +
> +		if (WARN_ON(filp && new_state !=3D next_state)) {
> +			fput(filp);
> +			filp =3D ERR_PTR(-EINVAL);
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	return filp;
>  }
> =20
>  static int vfio_ap_get_state(struct vfio_device *vdev,
>  			     enum vfio_device_mig_state  *current_state)
>  {
> -	return -EOPNOTSUPP;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	struct vfio_ap_migration_data *mig_data;
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);

[Severity: Medium]
Similar to the concern in vfio_ap_set_state(), could acquiring the global=20
mdevs_lock just to read the device-specific state lead to cross-VM lock=20
contention?

> +
> +	matrix_mdev =3D container_of(vdev, struct ap_matrix_mdev, vdev);
> +	mig_data =3D  matrix_mdev->mig_data;
> +
[ ... ]
> @@ -146,6 +271,5 @@ void vfio_ap_reset_migration_state(struct ap_matrix_m=
dev *matrix_mdev)
>  	if (!matrix_mdev->mig_data)
>  		return;
> =20
> -	vfio_ap_release_mig_files(matrix_mdev);
>  	matrix_mdev->mig_data->mig_state =3D VFIO_DEVICE_STATE_RUNNING;
>  }

[Severity: High]
Is it safe to remove the call to vfio_ap_release_mig_files() here? If=20
userspace starts a new migration, won't the new file pointers overwrite the=
=20
old ones in mig_data? When the old file descriptors are closed later, the=20
driver's release callback won't find a match in mig_data, which appears to=
=20
result in a permanent memory leak of the associated allocations.

[Severity: Critical]
Are there also race conditions related to accessing mig_data without locks=
=20
during release? Looking at vfio_ap_release_mig_file():

    struct ap_matrix_mdev *matrix_mdev =3D filp->private_data;

    if (!matrix_mdev || !matrix_mdev->mig_data)
        return -ENODEV;

    if (filp =3D=3D matrix_mdev->mig_data->stop_copy_mig_file)

Could an unprivileged process cause a use-after-free by closing the VFIO=20
device file descriptor while keeping the migration file descriptor open,=20
and then closing the migration file descriptor? Since mig_data is accessed=
=20
locklessly here, it seems it could be freed concurrently during device=20
closure, leading to a dereference of freed memory.

Additionally, if vfio_ap_release_migration_data() is called concurrently,=20
does it properly free internal allocations like resuming_mig_state.ap_confi=
g,=20
or are those leaked when the parent mig_data is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630104132.1598=
851-1-akrowiak@linux.ibm.com?part=3D5
