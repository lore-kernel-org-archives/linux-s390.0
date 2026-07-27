Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFBA42F6EB;
	Mon, 27 Jul 2026 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175346; cv=none; b=iRfrfm2Z4vPWF50Q5v0CN+aUJqpLZ9oLadVx0TKK+K9VQCWvogfHDGIGOLBhQCWIG9/NSVcL6SjnKdCifGXVtaUL1/VxZL/ZQs87v5AcoWNyMTt1SH2X1nOp3hmGTaf+37xVWtnAGPk60Kz/qs9AoJqSk3VzWNfqtD+kfbyAHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175346; c=relaxed/simple;
	bh=jZRnUA1E1thH6U3bFmN284yL41zzheGy+HpSMLtQgNA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I8OsIbPpMZhPrIVrbXFE+1/exOsgr/bjRCeywjEJu54Mvfkzig6CGRR4zqrqTtKC4hUu++ImJa8hOcVe+/rpmaBw2Jose9LfKF7OlVde0Kr2ENFZ9vX3ucNfqKilREUNnOnO+0Y1I/KX3xlkmJiHHr4iR3c0NzV3fSEGs4yl9IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjUGv/e3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjUGv/e3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027021F000E9;
	Mon, 27 Jul 2026 18:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785175344;
	bh=N4pVigLVIVHcPotcg1bNlAX4lUWZ7QjShmtvtGb32mw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PjUGv/e3QsUzvt0nt9et9G5xB2QmRZzFaXFn3lpOwu7GXmi4MVNOlR/FuQuFioBI+
	 pudCAPNLvwXnLoOKdO0geJ415ald7Xg2iEF6NbmJ+6Fz+BwqznkA4qIeBOjwBDMJOY
	 8tSVa1tsCUNb5AtApowSXVApBWlAogqkjXazEW2BZooL6ehG6A8CKCNdHzA2WY5YPQ
	 aUFfLehZJWEBF4gjrh2cybpRcTbO1ncKD0A2IfKV/vzCbqCb77PIbmDm5tFX9BiZQr
	 Z874mWZijmRk576T4HbrNwkM7HmYlbt7bWzrmAxsk8SFc++WpjClm6RzWidoc/Z2KE
	 2h7I1wIhq6onw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/15] s390/vfio-ap: File ops called to save the vfio
 device migration state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260727173239.2420754-8-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-8-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:02:23 +0000
Message-Id: <20260727180224.027021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Pointer casting a 64-bit uninitialized `unsigned long` to a 32=
-bit `int *` on a big-endian architecture leaves the lower 32 bits uninitia=
lized, leading to massive buffer overflows or a `__counted_by` trap.
- [High] Dropping `mdevs_lock` before `copy_to_user()` opens a TOCTOU race =
window that allows concurrent freeing of the `ap_config` buffer and `mig_da=
ta`, causing a double Use-After-Free.
- [High] The global `mdevs_lock` is held across potentially tens of thousan=
ds of slow hardware instructions, explicitly contradicting documented subsy=
stem design and risking host soft lockups.
- [High] The `.read` callback unconditionally rejects all standard read ope=
rations because it erroneously assumes the `pos` pointer is NULL.
--

--- Patch [7]: [PATCH v6 07/15] s390/vfio-ap: File ops called to save the v=
fio device migration state ---
commit 6828e02e20841803a7c3d24379ed9d9979222d55
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: File ops called to save the vfio device migration state

This commit implements the read callback function for the vfio-ap device
migration state file. It copies the guest's AP configuration and hardware
queue information to userspace when the device transitions to the STOP_COPY
state.

> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> +static int vfio_ap_store_queue_info(const char *mdev_name,
> +				    struct vfio_ap_config *ap_config)
> +{
> +	struct ap_tapq_hwinfo source_hwinfo;
> +	unsigned long num_queues;
> +	int ret;
> +
> +	/*
> +	 * ap_tapq() is a hardware instruction that may take time to complete.
> +	 * It must be called without mdevs_lock held to avoid blocking other
> +	 * mdevs. The apqn list was already snapshotted into ap_config->qinfo[]
> +	 * by the caller under the lock.
> +	 */
> +	for (num_queues =3D 0; num_queues < ap_config->num_queues; num_queues++=
) {
> +		ret =3D get_hardware_info_for_queue(mdev_name, &source_hwinfo,
> +						  ap_config->qinfo[num_queues].apqn);

[Severity: High]
Does this loop actually execute with the mdevs_lock held, despite the
comment?

Looking at the call chain, vfio_ap_stop_copy_read() acquires
matrix_dev->mdevs_lock and calls vfio_ap_get_config(), which asserts
the lock is held and then calls vfio_ap_store_queue_info().

Since the lock is never dropped in this chain, will executing PQAP(TAPQ)
in a loop for potentially many queues block other mdev operations across
the host?

[ ... ]

> +static int vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	unsigned long *apm, *aqm, apid, apqi, num_queues;
> +	struct vfio_ap_config *ap_configuration;
> +	const char *mdev_name;
> +	size_t ap_config_size;
> +	int ret;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	ap_config_size =3D vfio_ap_config_size(matrix_mdev, (int *)&num_queues);
> +
> +	ap_configuration =3D kzalloc(ap_config_size, GFP_KERNEL_ACCOUNT);
> +	if (!ap_configuration)
> +		return -ENOMEM;
> +
> +	/*
> +	 * num_queues must be set before writing qinfo[] elements; the
> +	 * __counted_by(num_queues) annotation on qinfo[] causes the compiler to
> +	 * insert bounds checks that evaluate against ap_configuration->num_que=
ues.
> +	 * Writing through qinfo[i] with num_queues still 0 would trap.
> +	 */
> +	ap_configuration->num_queues =3D num_queues;

[Severity: Critical]
Can casting the uninitialized 8-byte unsigned long num_queues to an
int pointer cause uninitialized memory issues on big-endian systems?

On s390x, writing a 32-bit integer to an 8-byte address only initializes
the most significant 4 bytes, leaving the least significant 4 bytes as
stack garbage.

When ap_configuration->num_queues (a u32) is assigned num_queues, will it
truncate the 8-byte value, completely discarding the initialized high
bytes and storing the uninitialized garbage data? Could this lead to
out-of-bounds accesses in the array bounds checks?

[ ... ]

> +static ssize_t vfio_ap_stop_copy_read(struct file *filp, char __user *bu=
f,
> +				      size_t len, loff_t *pos)
> +{
> +	struct vfio_ap_migration_file *mig_file;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	loff_t read_pos;
> +	ssize_t ret;
> +
> +	/*
> +	 * When userspace calls read() with an explicit offset (pread), pos is
> +	 * non-NULL and the function rejects it with -ESPIPE (illegal seek). For
> +	 * normal read() calls, pos is NULL, so we'll use the file's internal
> +	 * position filp->f_pos
> +	 */
> +	if (pos)
> +		return -ESPIPE;

[Severity: High]
Is the assumption that pos is NULL for normal read() calls correct?

The VFS layer unconditionally passes a valid, non-NULL loff_t pointer
(pointing to a local stack variable) to the .read callback for standard
reads. Will this check unconditionally reject all standard read operations
on the migration state file?

[ ... ]

> +	/*
> +	 * Drop the lock only for the copy_to_user().  The ap_config buffer is
> +	 * stable: it is allocated once in vfio_ap_get_config() and freed only
> +	 * in vfio_ap_release_mig_files() / vfio_ap_release_stop_copy_file(),
> +	 * both of which require mdevs_lock.  Since we already advanced *pos
> +	 * above, no other thread will compute an overlapping region.
> +	 */
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len))
> +		return -EFAULT;
> +
> +	return len;
> +}

[Severity: High]
Could dropping mdevs_lock here open a race condition that leads to a
use-after-free?

If a concurrent thread triggers a device close or reset (for example,
via VFIO_DEVICE_RESET) while this thread is at the copy_to_user() call,
the reset path could acquire mdevs_lock and free both the ap_config
buffer and the mig_data struct.

Since mig_file is a pointer into mig_data, will dereferencing it here to
access ap_config cause a double use-after-free, copying freed memory to
userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727173239.2420=
754-1-akrowiak@linux.ibm.com?part=3D7
