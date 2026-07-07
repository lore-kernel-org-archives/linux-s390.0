Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CD438B140;
	Tue,  7 Jul 2026 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416382; cv=none; b=DTPixD50DMBwH4BdiDcT0w8fBv52f6UrSbScVSPCtUa+DeF4MtbKhY6xFsqfF/H0klkhiMWDPnikQzKQwuSE7tkWXW44FU+rYnWfXEq1R1XaRB4qz1m3ljZD64C/PXfJ1vGRmwIECVxPHGYXgDDgtYujdPUMSU15q3xAPN9+nJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416382; c=relaxed/simple;
	bh=ig5+JxvrN1rMYNy5wOTysY37LZ7zml6s82gWcE3ffNo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yv1UzsqeBp3kZL/LQSK0rsyG0xBHmOQJrOeGjjA8bVNnPJUL/TJ3CRlrWFud42KuIBE1jgEkAG0s81BMSSLQ+PZj8BtIZbS9OrZa/jPKnYmO/isxQbdPoI7muPr128x2aGDb3cHqpH+ga2HR9u1rLHFfeNY/v5isexdYhzemaZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdpEDfCZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdpEDfCZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F3C1F00A3A;
	Tue,  7 Jul 2026 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783416380;
	bh=Fc96iWF2tT0T1Wq3UjSUz0hdj1UeZP0XQ3PiWdLdP1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RdpEDfCZx6VOiA4pwsPrkmpmWN4GGs1M8E3LPFCv5fdXcpKiixObrLj6D5AnjB2EZ
	 7rdl47UMl93x1jn800lC4tKr94w2vHRsP5uOYFeBAB7+WDxTDaKwt4tgeAUc7Ys9fz
	 7l+ceq4qmfX+hJCCm/Edeigv9+XB9gEGwjjRb+TUjU5VpQtLfppDvFUStAxQ6H1ggE
	 2/ozBn4vE3T5HR2BZQULmy+Oz3J01OWqO7z0so2tqEtpIzcOLPAbcHZz7MH0gg9vLf
	 uIBboERiKhMqc9qXZZmP9hIKSBriJGBPmpkloN7qQ0ZVd7TKTt85WHf2UhGA4O5OyK
	 5MwtlPsfP6lxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/15] s390/vfio-ap: File ops called to resume the
 vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260707090226.3206695-11-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
 <20260707090226.3206695-11-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:26:19 +0000
Message-Id: <20260707092620.72F3C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] A time-of-check to time-of-use (TOCTOU) vulnerability exists d=
ue to a double fetch of the migration configuration, leading to out-of-boun=
ds memory access.
- [Critical] The stack-allocated `guest_matrix` is used without initializat=
ion, leading to random AP devices and domains being assigned to the guest.
- [Critical] Error and reallocation paths free the `ap_config` buffer while=
 leaving a dangling pointer in the persistent migration state, causing a Us=
e-After-Free or Double Free.
- [Critical] Misuse of `mutex_is_locked` to conditionally release `mdevs_lo=
ck` wrongfully unlocks a mutex actively held by a concurrent thread.
- [High] `vfio_ap_resuming_write` unconditionally aborts normal write opera=
tions because the `pos` argument is never NULL.
- [High] Writing a payload smaller than `sizeof(struct vfio_ap_config)` all=
ocates an undersized buffer but triggers configuration validation, causing =
an out-of-bounds heap read.
- [High] Writing the migration stream in chunks skips saving the configurat=
ion pointer, causing a memory leak and completely breaking stream resumptio=
n.
- [Medium] A strict equality check on the `fac` bitfield incorrectly reject=
s compatible device classifications, breaking the intended backward compati=
bility logic.
--

--- Patch [10]: [PATCH v4 10/15] s390/vfio-ap: File ops called to resume th=
e vfio device migration ---
commit 2ee7fca0e8467c278538f305a2be0b05605513a9
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: File ops called to resume the vfio device migration

Implements the 'write' callback function that was added to the
'file_operations' structure for the file stream created to restore the
state of the vfio-ap device on the destination system when the migration
state transitioned from STOP to RESUMING.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> +static ssize_t allocate_ap_config(struct vfio_ap_config **ap_config,
> +				  const char __user *buf, size_t len)
> +{
> +	struct vfio_ap_config tmp_ap_config;
> +	ssize_t config_size;
> +	size_t copy_size;
> +
> +	/*
> +	 * If the length of the data sent exceeds the size of the vfio_ap_config
> +	 * structure, then we will copy enough data from userspace to get the
> +	 * number of queues which we can use to allocate enough space all of
> +	 * the queue information.
> +	 */
> +	copy_size =3D min(len, sizeof(tmp_ap_config));
> +
> +	if (copy_from_user(&tmp_ap_config, buf, copy_size))
> +		return -EIO;

[Severity: Critical]
Could this initial fetch allow a time-of-check to time-of-use (TOCTOU) race?

The first copy_from_user() here reads tmp_ap_config to calculate the
allocation size based on num_queues. Later in vfio_ap_resuming_write():

    if (copy_from_user((char *)ap_config + *pos, buf, len)) {

The entire payload is copied again from userspace. If a concurrent userspace
thread modifies num_queues between these two fetches, it can bypass the size
calculation and inject an arbitrarily large num_queues into the heap buffer,
which will then be used during the validation loops causing out-of-bounds
access.

> +
> +	/*
> +	 * If the length of data sent includes the number of queues
> +	 * in the AP configuration, then calculate its size; otherwise
> +	 * set config_size to the length of data sent.
> +	 */
> +	if (len >=3D sizeof(struct vfio_ap_config)) {
> +		config_size =3D calculate_ap_config_size(tmp_ap_config.num_queues);
> +
> +		/* If the calculation returned an error */
> +		if (config_size < 0)
> +			return config_size;
> +	} else {
> +		config_size =3D len;
> +	}

[Severity: High]
If userspace writes a payload smaller than sizeof(struct vfio_ap_config),
could this allocate an undersized buffer?

If config_size is set to len here, and then *pos + len =3D=3D cfg_sz evalua=
tes
to true in vfio_ap_resuming_write(), the code proceeds to
verify_ap_configs_are_compatible().

verify_ap_configs_are_compatible() will then iterate:

    for (int i =3D 0; i < source_config->num_queues; i++) {
        apqn =3D source_config->qinfo[i].apqn;

using the num_queues value read from the small buffer, potentially reading
far beyond the allocated memory.

[ ... ]

> +static bool queue_hardware_info_is_compatible(const char *mdev_name,
> +					      unsigned long apqn,
> +					      struct ap_tapq_hwinfo *src_hwinfo,
> +					      struct ap_tapq_hwinfo *target_hwinfo)
> +{
> +	unsigned long src_bits, target_bits;
> +
> +	src_bits =3D src_hwinfo->value & QINFO_DATA_MASK;
> +	target_bits =3D target_hwinfo->value & QINFO_DATA_MASK;
> +
> +	/* If all bits match the queues are compatible */
> +	if (src_bits =3D=3D target_bits)
> +		return true;
> +
> +	if (src_hwinfo->fac =3D=3D target_hwinfo->fac &&
> +	    src_hwinfo->at <=3D target_hwinfo->at &&
> +	    classes_compatible(src_hwinfo, target_hwinfo) &&
> +	    (src_hwinfo->bs =3D=3D 0 && target_hwinfo->bs =3D=3D 0)) {
> +		return true;
> +	}

[Severity: Medium]
Will this strict equality check on the fac bitfield reject compatible device
classifications?

The 32-bit fac union field encompasses the 8-bit class bitfield. If the sou=
rce
queue has stateless functions and the target has full native functions, the=
ir
class sub-fields differ, causing their encompassing fac fields to differ.
This causes the strict equality check on fac to fail, bypassing the fallback
logic in classes_compatible().

[ ... ]

> +static ssize_t vfio_ap_resuming_write(struct file *filp, const char __us=
er *buf,
> +				      size_t len, loff_t *pos)
> +{
> +	struct vfio_ap_migration_data *mig_data;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	struct vfio_ap_config *ap_config;
> +	struct ap_matrix guest_matrix;

[Severity: Critical]
Is it possible this passes uninitialized stack memory as the guest matrix?

guest_matrix is declared on the stack without initialization here.
setup_ap_matrix_from_ap_config() sets bits in guest_matrix using
set_bit_inv() but never zeros the rest of the struct:

    if (!test_bit_inv(apid, guest_matrix->apm))
        set_bit_inv(apid, guest_matrix->apm);

This uninitialized matrix is then passed to vfio_ap_set_new_guest_config(),
which might grant the guest access to random AP hardware resources based on
the uninitialized stack memory.

> +	ssize_t ret =3D 0, cfg_sz;
> +	const char *mdev_name;
> +
> +	/*
> +	 * When userspace calls write() with an explicit offset (pwrite), pos is
> +	 * non-NULL and the function rejects it with -ESPIPE (illegal seek). For
> +	 * normal write() calls, pos is NULL, so we'll use the file's internal
> +	 * position filp->f_pos
> +	 */
> +	if (pos)
> +		return -ESPIPE;

[Severity: High]
Does this unconditionally abort normal write operations?

The VFS layer (vfs_write) always passes a valid loff_t *pos pointer to the
write callback, so pos will never be NULL here, resulting in -ESPIPE for
every write attempt.

[ ... ]

> +	/* Check if we've completed writing the entire configuration */
> +	if (*pos + len =3D=3D cfg_sz) {
> +		ret =3D do_post_copy_validation(mdev_name, ap_config);
> +		if (ret < 0)
> +			goto cleanup;
> +
> +		setup_ap_matrix_from_ap_config(mdev_name, ap_config,
> +					       &guest_matrix);
> +
> +		/* Acquire locks required to update the guest's AP config */
> +		mutex_lock(&ap_attr_mutex);
> +		get_update_locks_for_mdev(matrix_mdev);
> +
> +		ret =3D vfio_ap_set_new_guest_config(matrix_mdev, &guest_matrix,
> +						   false);
> +		if (!ret) {
> +			mig_data->resuming_mig_state.ap_config =3D ap_config;
> +			mig_data->resuming_mig_state.config_sz =3D cfg_sz;
> +		}
> +
> +		release_update_locks_for_mdev(matrix_mdev);
> +		mutex_unlock(&ap_attr_mutex);
> +
> +		if (ret)
> +			goto cleanup;
> +	}
> +
> +	ret =3D len;
> +	*pos +=3D len;
> +	goto done;

[Severity: High]
Does writing the migration stream in partial chunks result in a memory leak
and break stream resumption?

When *pos + len < cfg_sz, the code jumps directly to done here. This skips
saving the allocated pointer to mig_data->resuming_mig_state.ap_config,
leaking the allocation.

On the next sequential write, validate_resuming_write_parms() executes:

    if ((!matrix_mdev->mig_data->resuming_mig_state.ap_config && *pos !=3D =
0) ||
    ...
        ret =3D -EFAULT;

Since the pointer was never saved, the first condition is met, permanently
aborting the migration stream.

> +
> +cleanup:
> +	kfree(ap_config);

[Severity: Critical]
Does this leave a dangling pointer in the migration state if an error occurs
after the configuration pointer was saved?

When a complete configuration is written, the pointer is saved:

    mig_data->resuming_mig_state.ap_config =3D ap_config;

If a subsequent write triggers a reallocate_ap_config() failure, or an I/O
error, the code jumps to cleanup and frees the memory. However,
mig_data->resuming_mig_state.ap_config is not cleared. Releasing the file
descriptor later or subsequent operations might access or double free this
pointer.

> +done:
> +	if (mutex_is_locked(&matrix_dev->mdevs_lock))
> +		mutex_unlock(&matrix_dev->mdevs_lock);

[Severity: Critical]
Can this mistakenly release a mutex actively held by a concurrent thread?

mutex_is_locked() only checks if the mutex is held by any thread, not
strictly the current one. Since the lock was explicitly released earlier in
the function (before copy_from_user), if another thread acquired mdevs_lock
in the meantime, this will return true and unlock the mutex while the other
thread still owns it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707090226.3206=
695-1-akrowiak@linux.ibm.com?part=3D10
