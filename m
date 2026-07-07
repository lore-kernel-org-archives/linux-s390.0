Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FBB3955EC;
	Tue,  7 Jul 2026 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416131; cv=none; b=kVnNPJoCn3dNA59VF5nUN7dORPmPYTKF0KNoErAiSU0F4hFLieKRZaZ1e72OJsQgxSrFNI8nIDR9NZ9wVPL+N7B77LvkLf5Gu1Q1xV+u6tz0MOHN44C9MpEqa7vH/4CjTCoO6QAoU3VcMDjVF/twSCLKHHVH6nauYS/BP8evb40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416131; c=relaxed/simple;
	bh=pgXUlI5Fb5TFfT4oh/MQ6ce9JUIKqI7O9ikz2rBtdPk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=amSqkkrjeXMoYSmMFgInuzr5Uq60Uou4N/TJ2BBLdTPtdmA3X5yEFbVbwWcV1AOYb5qWC1Aip70ITd9hF3uLx15PJ1I2aTWnIWDDtWckb724g9fDgSmpnZntUkviD6PSV5bz7TesLfkAobcSLdulZYDRHLzZJII5fgHQdN72OsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2Vns6UX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2Vns6UX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D631F000E9;
	Tue,  7 Jul 2026 09:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783416128;
	bh=uLus07iwytJCbH68lFd/4rT5JnlXg1KBglZh40TAYxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P2Vns6UXhFPNyaKvKhYtmB6BL8ln0zrtkXACdtWpX48qhRN7JCZpxhjMaSLhQc0C8
	 wHuX8N5rXQN0SZ+3sxQ08itTeOgVRvpsap3E1d1fCYnUDcZsTUC3VV8LYj0Q6dVh5e
	 mgwV+SBQcmPRLIOvGsBcoK0GYAmqgKwmTApfJipJN5AsyGrNvIPW6b8c5OoWb8P741
	 YuYP/wNT/pH1pisZ78legPUuG/3IFjsKrnZKf8tqvKqgWH7Y/IIRoXVyJtLorn4Bh3
	 Dd5mwgtJVLXKt7zD6sf5VWtFknE6uY1qHMfRb++M8+eCl7gBHGnwDLrDA7GBfXoCDB
	 HKBuXsTkQBAJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/15] s390/vfio-ap: File ops called to save the vfio
 device migration state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260707090226.3206695-8-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
 <20260707090226.3206695-8-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:22:08 +0000
Message-Id: <20260707092208.80D631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [Critical] The migration stream file does not hold a reference to the `ma=
trix_mdev` device, allowing a trivial Use-After-Free if the file descriptor=
 outlives the VFIO device.
- [High] Migration state is dynamically regenerated from hardware on every =
chunked `read()`, causing state tearing and massive performance overhead.
- [High] The `config_sz` field in the UAPI `vfio_ap_config` structure is ne=
ver initialized.
- [High] Using `kzalloc` for potentially large variable-sized migration buf=
fers can cause memory allocation failures.
- [High] Inverted condition when handling pending async errors in `get_hard=
ware_info_for_queue` leads to false migration failures and silent data corr=
uption.
- [Medium] Concurrent reads to the migration file race on `filp->f_pos`, co=
rrupting the stream position.
- [Low] A `size_t` variable is used to store negative error codes, creating=
 brittle type conversions.
- [Low] The error log in `get_hardware_info_for_queue` misleadingly states =
it is executing on the target host.
- [Low] Use of architecture-dependent `size_t` in a migration data structur=
e.
--

--- Patch [7]: [PATCH v4 07/15] s390/vfio-ap: File ops called to save the v=
fio device migration state ---
commit eb8c5880a35e9533d3246f99a48030464bf1844e
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: s390/vfio-ap: File ops called to save the vfio device migration st=
ate
   =20
This commit implements the read callback function for the vfio-ap device's=
=20
migration state file. It copies the guest's AP configuration and hardware=20
information to userspace when the migration state transitions to STOP_COPY.=
=20
The state is then transferred to the destination host.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 76e06abe5a9e9..5ef7127b697a5 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -87,6 +80,215 @@ static int vfio_ap_release_mig_file(struct inode *fil=
e_inode, struct file *filp)
>  	return 0;
>  }
> =20

[ ... ]

> +static int get_hardware_info_for_queue(struct ap_matrix_mdev *matrix_mde=
v,
> +				       struct ap_tapq_hwinfo *hwinfo,
> +				       unsigned long apqn)
> +{
> +	struct ap_queue_status status;
> +
> +	status =3D ap_tapq(apqn, hwinfo);
> +
> +	switch (status.response_code) {
> +	case AP_RESPONSE_NORMAL:
> +	case AP_RESPONSE_RESET_IN_PROGRESS:
> +	case AP_RESPONSE_DECONFIGURED:
> +	case AP_RESPONSE_CHECKSTOPPED:
> +	case AP_RESPONSE_BUSY:
> +		/* For all these RCs the tapq info should be available */
> +		return 0;
> +	case AP_RESPONSE_Q_NOT_AVAIL:
> +		dev_err(matrix_mdev->vdev.dev,
> +			"migration failed: Failed to get hwinfo for queue %02lx.%04lx on targ=
et host: TAPQ rc=3D%d",

[Severity: Low]
Is the target host string in this error message misleading?

Since this function is used to read the configuration during the STOP_COPY
state, it executes on the source host rather than the target host.

> +			AP_QID_CARD(apqn), AP_QID_QUEUE(apqn), status.response_code);
> +		return -ENODEV;
> +	default:
> +		/* On a pending async error the tapq info should be available */
> +		if (!status.async)
> +			return 0;

[Severity: High]
Does this logic invert the handling of pending async errors?

The comment indicates that on a pending async error the tapq info should be
available (implying a return of 0). However, the code checks !status.async
to return 0. If an async error is pending (status.async =3D=3D 1), this wil=
l skip
the return and incorrectly log an error and return -EIO. Conversely, if an
unrecognized fatal error occurs (status.async =3D=3D 0), it will silently r=
eturn 0,
potentially corrupting the migration state.

> +
> +		dev_err(matrix_mdev->vdev.dev,
> +			"Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=3D%d",
> +			AP_QID_CARD(apqn), AP_QID_QUEUE(apqn), status.response_code);
> +		return -EIO;
> +	}
> +
> +	return -EINVAL;
> +}

[ ... ]

> +static int
> +vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev,
> +		   struct vfio_ap_config **ap_config, size_t *ap_config_size)
> +{
> +	struct vfio_ap_config *ap_configuration;
> +	int num_queues, ret;
> +
> +	*ap_config_size =3D vfio_ap_config_size(matrix_mdev, &num_queues);
> +
> +	ap_configuration =3D kzalloc(*ap_config_size, GFP_KERNEL_ACCOUNT);

[Severity: High]
Could this kzalloc() fail on long-running systems when scaling to a large
number of queues?

The total contiguous physical allocation size can exceed 1MB (up to 65,536
queues). Requesting such a large memory block (e.g., order-8) via kzalloc()
with GFP_KERNEL is highly susceptible to physical memory fragmentation, whi=
ch
could result in -ENOMEM and abort the migration. Would kvzalloc() be more
appropriate here to allow fallback to vmalloc?

[Severity: Low]
Does the underlying struct vfio_ap_config use an architecture-dependent
type for UAPI/migration?

The struct uses a size_t config_sz field. Since this structure is
serialized and sent to the destination host, using size_t (which is
architecture-dependent) in an external ABI or migration stream could cause
binary layout inconsistencies, even if s390x is exclusively 64-bit.

> +	if (!ap_configuration)
> +		return -ENOMEM;
> +
> +	ap_configuration->num_queues =3D num_queues;
> +
> +	ret =3D vfio_ap_store_queue_info(matrix_mdev, ap_configuration);

[Severity: High]
Is the config_sz field of ap_configuration intentionally left uninitialized?

Since kzalloc() zeroes the memory, the config_sz field remains 0. When
this state payload is received by the destination host, the stream might be
rejected or misparsed if it attempts to validate the size of the incoming
migration data against config_sz.

> +	if (ret) {
> +		kfree(ap_configuration);
> +		return ret;
> +	}
> +
> +	*ap_config =3D ap_configuration;
> +
> +	return 0;
> +}
> +
> +static ssize_t vfio_ap_stop_copy_read(struct file *filp, char __user *bu=
f,
> +				      size_t len, loff_t *pos)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +	size_t ret =3D 0, ap_config_size;

[Severity: Low]
Is it safe to use size_t (an unsigned type) to store negative error codes?

The ret variable receives the results of validate_stop_copy_read_parms()
and vfio_ap_get_config(), which return negative integers like -ENODEV.
While the implicit cast back to ssize_t masks this currently, it creates a
brittle pattern that could introduce bugs if ret is ever checked in a
conditional statement (e.g., if (ret < 0)).

> +	struct vfio_ap_config *ap_config;
> +
> +	/*
> +	 * When userspace calls read() with an explicit offset (pread), pos is
> +	 * non-NULL and the function rejects it with -ESPIPE (illegal seek). For
> +	 * normal read() calls, pos is NULL, so we'll use the file's internal
> +	 * position filp->f_pos
> +	 */
> +	if (pos)
> +		return -ESPIPE;
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +
> +	pos =3D &filp->f_pos;
> +
> +	ret =3D validate_stop_copy_read_parms(filp, pos, len);
> +	if (ret) {
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		return ret;
> +	}
> +
> +	matrix_mdev =3D filp->private_data;

[Severity: Critical]
Does the migration file descriptor hold a reference to matrix_mdev?

When the migration file descriptor is created, filp->private_data points to
matrix_mdev. If a user keeps this file descriptor open and unbinds the
device from sysfs, matrix_mdev is freed. Subsequent VFS operations (like
read() here or close() in vfio_ap_release_mig_file()) will dereference
the freed pointer, leading to a Use-After-Free.

> +
> +	ret =3D vfio_ap_get_config(matrix_mdev, &ap_config, &ap_config_size);

[Severity: High]
Does dynamically regenerating the migration state on every read() cause
tearing and performance issues?

If userspace reads the state in chunks (e.g., 4KB at a time), any hardware =
or
configuration changes between chunks will shift the data layout, causing the
migration stream to contain a torn and inconsistent snapshot.

Additionally, for a large number of queues, repeatedly polling the hardware
via ap_tapq() on every chunk introduces massive O(N^2) overhead, which could
stall the CPU and time out the migration. Should the driver cache a snapshot
upon entering the STOP_COPY state instead?

> +	if (ret) {
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		return ret;
> +	}
> +
> +	/*
> +	 * If the position exceeds the size of the AP configuration data,
> +	 * then indicate EOF; otherwise calculate the length of the data to
> +	 * read such that a buffer overrun is prevented.
> +	 */
> +	if (*pos >=3D ap_config_size)
> +		len =3D 0;
> +	else
> +		len =3D min_t(size_t, ap_config_size - *pos, len);
> +
> +	/* If we've reached an EOF condition, let the caller know */
> +	if (len =3D=3D 0) {
> +		kfree(ap_config);
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		return 0;
> +	}
> +
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	if (copy_to_user(buf, (char *)ap_config + *pos, len)) {
> +		kfree(ap_config);
> +		return -EFAULT;
> +	}
> +
> +	kfree(ap_config);
> +	*pos +=3D len;

[Severity: Medium]
Can concurrent reads corrupt the stream position here?

The migration file is opened with stream_open(), so the VFS f_pos_lock is
not held during read(). Because mdevs_lock is dropped before copying to
userspace, concurrent reads will race on evaluating and incrementing *pos
(which points to filp->f_pos), leading to duplicated data and a corrupted
stream offset.

> +	return len;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707090226.3206=
695-1-akrowiak@linux.ibm.com?part=3D7
