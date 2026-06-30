Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD783FFFB8;
	Tue, 30 Jun 2026 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819476; cv=none; b=pCBCwWJo3mzIjs1ajXJ3mzecrBlb8GJnrAInEqN9YQOrJ0ZL/qDgzEgvzfuk3OXl1NZ52GnxFHIrvDomgarIcTHodsaKzqdi/QZoTow+SPHvNaKBy8OK2g8C3GsySs96VAuxWkjbLYuVQFTth/6Y/KnCb4yWYTA327Le/H+zwYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819476; c=relaxed/simple;
	bh=1flJO7IUa2mJJoFYYUiSjZ8P8cMprvT/eeHFRkdkJfA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LqvXnBC68epY/83rh53VimM95cO0Qzav1Kp0cquQvK0MoICbhVOgCjQW3eQ28NHzF3+DIVSdvnQlJZwRG2jhrJoWmMyAQaPGb2m7mPNs+pVvlys85wrexBjJFtEZFXZZVYvBPcrYElbVqbqe2GDzxDNynysrsdAn2c5LhLO9ve0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBuf3vLS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBuf3vLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A56B1F00A3D;
	Tue, 30 Jun 2026 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782819474;
	bh=CjK4yXnQcEmtWgxVwe4yZ7wSnJ5q5zRlpnDa0Y29+I8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PBuf3vLSPvjJ8ZQ7pCUvEFJiGBIZgyD6OGkaj8xnSO/HSO03V5eq5lG2bcG+XExrN
	 jzMQmrUdXC6+3f+2X7i3ILvJa8U9XEM333r8eXNSJ9gXNY0libaWUreGqTk5HhWXoH
	 b3JjsbjQSrFrP4BysZzsLZwEXP9pF7VXrlP1dAwSGFz8gEK2m7fAxV72CcDyQqEnZw
	 4UkLSgxur0FKAZZ4sI8R1AQnA5bFjmkref6rV8bgolLB43BW9NCE3sTaDl0L42zyin
	 0Z6uvzoZTP9N4YMI27qEtWL87SuJ6KHzhwfzKt+y9Ynq/cBBBDglRmDHS6yLBnjOZ/
	 g11X1qm0AQ8eA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/15] s390/vfio-ap: File ops called to resume the
 vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260630104132.1598851-11-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
 <20260630104132.1598851-11-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:37:53 +0000
Message-Id: <20260630113754.1A56B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:
- [Critical] The `guest_matrix` struct is allocated on the stack without in=
itialization, leading to uninitialized kernel stack memory being applied to=
 the guest's AP configuration.
- [Critical] Error paths and `krealloc` usage leave dangling pointers in `m=
ig_data->resuming_mig_state.ap_config`, resulting in Use-After-Free and Dou=
ble Free vulnerabilities.
- [High] Unsafe use of `mutex_is_locked` to conditionally unlock `mdevs_loc=
k` can release a mutex held by another thread.
- [High] A short write smaller than `sizeof(struct vfio_ap_config)` bypasse=
s size checks and prematurely triggers post-copy validation, leading to out=
-of-bounds heap reads.
- [High] A double fetch of the `num_queues` field from userspace allows an =
attacker to bypass bounds checks and trigger out-of-bounds heap reads.
- [High] Partial writes to the migration stream leak the dynamically alloca=
ted configuration buffer and permanently break the state machine.
- [High] The `vfio_ap_resuming_write` function unconditionally returns `-ES=
PIPE` because it assumes `pos` can be NULL for normal writes, breaking migr=
ation entirely.
- [High] Dropping `mdevs_lock` while using `&filp->f_pos` on a stream witho=
ut `FMODE_ATOMIC_POS` leads to data races.
- [Medium] The hardware compatibility check bypasses the requirement that B=
S bits must be 0 if the source and target queues have identical hardware in=
formation.
- [Medium] Strict equality checks on the `fac` bitfield override and break =
the intended backward compatibility for functionality classes.
- [Medium] The migration functionality completely ignores AP control domain=
s (`adm`), silently dropping them during live migration.
--

commit 1f07710d77bb19f343d29ddba26d02cffa013a44
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: File ops called to resume the vfio device migration

This commit implements the write callback function to restore the state
of the vfio-ap device on the destination system during migration. It
copies the source guest's AP configuration from userspace, validates it,
and configures it on the destination host.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index e917cc995d352..9cd1e7a3f7430 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
[ ... ]
> @@ -187,10 +219,12 @@ static int vfio_ap_store_queue_info(struct ap_matri=
x_mdev *matrix_mdev,
>  {
>  	unsigned long *apm, *aqm, num_queues, apid, apqi, apqn;
>  	struct ap_tapq_hwinfo source_hwinfo;
> +	const char *mdev_name;
>  	int ret;
> =20
>  	lockdep_assert_held(&matrix_dev->mdevs_lock);
> =20
> +	mdev_name =3D dev_name(matrix_mdev->vdev.dev);
>  	apm =3D matrix_mdev->shadow_apcb.apm;
>  	aqm =3D matrix_mdev->shadow_apcb.aqm;
>  	num_queues =3D 0;
> @@ -199,7 +233,7 @@ static int vfio_ap_store_queue_info(struct ap_matrix_=
mdev *matrix_mdev,
>  		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
>  			apqn =3D AP_MKQID(apid, apqi);
> =20

[Severity: Medium]
Are we missing the control domains (adm) here? It appears the migration
functionality iterates over apm and aqm, but leaves out adm entirely. Will
guests with AP control domain capabilities silently lose these resources
after live migration?

> -			ret =3D get_hardware_info_for_queue(matrix_mdev,
> +			ret =3D get_hardware_info_for_queue(mdev_name,
>  							  &source_hwinfo, apqn);
>  			if (ret)
>  				return ret;
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
> +

[Severity: High]
We are copying tmp_ap_config from userspace here to validate num_queues
and size the buffer. In vfio_ap_resuming_write(), a second copy_from_user
is performed directly into the allocated buffer without re-validating
num_queues.

Could userspace modify num_queues between these two fetches to a large
value, bypassing bounds checks and leading to out-of-bounds heap reads
during subsequent validation loops?

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
> +

[Severity: High]
If len is less than sizeof(struct vfio_ap_config), we set config_size to
len. Does this bypass the size validation and allocate an undersized
buffer? Later in vfio_ap_resuming_write(), this can prematurely trigger
post-copy validation on uninitialized heap memory.

> +	*ap_config =3D kzalloc(config_size, GFP_KERNEL_ACCOUNT);
> +	if (!*ap_config)
> +		return -ENOMEM;
> +
> +	return config_size;
> +}
> +
> +/**
> + * reallocate_ap_config:
[ ... ]
> +static ssize_t reallocate_ap_config(struct vfio_ap_config **mig_ap_confi=
g,
> +				    size_t len)
> +{
> +	struct vfio_ap_config *ap_config =3D *mig_ap_config;
> +	struct vfio_ap_config *new_ap_config;
> +	size_t new_cfg_sz, cur_cfg_sz;
> +	unsigned int num_queues;
> +
> +	cur_cfg_sz =3D ap_config->config_sz;
> +	num_queues =3D ap_config->num_queues;
[ ... ]
> +	new_ap_config =3D krealloc(ap_config, new_cfg_sz, GFP_KERNEL_ACCOUNT);
> +	if (!new_ap_config)
> +		return -ENOMEM;
> +
> +	*mig_ap_config =3D new_ap_config;
> +
> +	return new_cfg_sz;
> +}
> +

[Severity: Critical]
krealloc() frees the old memory and returns a new pointer, updating the
local variable but not the global mig_data pointer until the transfer is
fully complete in vfio_ap_resuming_write(). Can a subsequent write or an
error path dereference the freed pointer?

> +/**
> + * qdev_is_bound_to_vfio_ap:
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

[Severity: Medium]
The specification requires that the Bind/Associate State (BS) bits must be
0 for both queues. Does returning true early when src_bits =3D=3D target_bi=
ts
bypass this requirement if both queues have identical, non-zero BS bits?

> +	if (src_hwinfo->fac =3D=3D target_hwinfo->fac &&
> +	    src_hwinfo->at <=3D target_hwinfo->at &&
> +	    classes_compatible(src_hwinfo, target_hwinfo) &&
> +	    (src_hwinfo->bs =3D=3D 0 && target_hwinfo->bs =3D=3D 0)) {
> +		return true;
> +	}
> +

[Severity: Medium]
The fac bitfield structurally encompasses the class field. If the source
and target queues have different classes (e.g., stateless vs native), will
src_hwinfo->fac =3D=3D target_hwinfo->fac unconditionally evaluate to false=
 and
break the intended backward compatibility logic in classes_compatible()?

> +	report_qinfo_incompatibilities(mdev_name, apqn, src_hwinfo, target_hwin=
fo);
> +
> +	return false;
> +}
[ ... ]
> +static void setup_ap_matrix_from_ap_config(const char *mdev_name,
> +					   struct vfio_ap_config *ap_config,
> +					   struct ap_matrix *guest_matrix)
> +{
> +	struct vfio_ap_queue_info qinfo;
> +	unsigned long apid, apqi;
> +
> +	for (int i =3D 0; i < ap_config->num_queues; i++) {
> +		qinfo =3D ap_config->qinfo[i];
> +		apid =3D AP_QID_CARD(qinfo.apqn);
> +		apqi =3D AP_QID_QUEUE(qinfo.apqn);
> +
> +		if (!test_bit_inv(apid, guest_matrix->apm))
> +			set_bit_inv(apid, guest_matrix->apm);
> +		if (!test_bit_inv(apqi, guest_matrix->aqm))
> +			set_bit_inv(apqi, guest_matrix->aqm);
> +	}
> +}
> +

[Severity: Medium]
Similar to vfio_ap_store_queue_info(), this reconstruction appears to
discard the adm control domains.

>  static ssize_t vfio_ap_resuming_write(struct file *filp, const char __us=
er *buf,
>  				      size_t len, loff_t *pos)
>  {
> -	/* TODO */
> -	return -EOPNOTSUPP;
> +	struct vfio_ap_migration_data *mig_data;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	struct vfio_ap_config *ap_config;
> +	struct ap_matrix guest_matrix;
> +	ssize_t ret =3D 0, cfg_sz;
> +	const char *mdev_name;
> +

[Severity: Critical]
Is guest_matrix fully initialized before use? It is allocated on the stack,
and setup_ap_matrix_from_ap_config() only modifies the apm and aqm bits.
Does passing this to vfio_ap_set_new_guest_config() apply uninitialized
kernel stack memory (including the uninitialized adm bits) to the guest's
cryptographic configuration?

> +	/*
> +	 * When userspace calls write() with an explicit offset (pwrite), pos is
> +	 * non-NULL and the function rejects it with -ESPIPE (illegal seek). For
> +	 * normal write() calls, pos is NULL, so we'll use the file's internal
> +	 * position filp->f_pos
> +	 */
> +	if (pos)
> +		return -ESPIPE;
> +

[Severity: High]
The VFS layer always passes a valid pos pointer to the write callback
(never NULL). Does this mean normal writes will unconditionally fail with
-ESPIPE and break migration entirely?

> +	mutex_lock(&matrix_dev->mdevs_lock);
> +	pos =3D &filp->f_pos;
> +
> +	ret =3D validate_resuming_write_parms(filp, len, pos);
> +	if (ret)
> +		goto done;
> +
> +	matrix_mdev =3D filp->private_data;
> +	mig_data =3D matrix_mdev->mig_data;
> +	mdev_name =3D dev_name(matrix_mdev->vdev.dev);
> +
> +	/*
> +	 * If this is the first write operation, then allocate storage for the
> +	 * AP configuration information; otherwise, reallocate the
> +	 * struct vfio_ap_config object used to store the AP configuration data
> +	 * sent from userspace.
> +	 */
> +	if (*pos =3D=3D 0) {
> +		ret =3D allocate_ap_config(&ap_config, buf, len);
> +
> +		/* If the allocation failed, we'll return the error */
> +		if (ret < 0)
> +			goto done;
> +
> +		cfg_sz =3D ret;
> +	} else {
> +		ap_config =3D mig_data->resuming_mig_state.ap_config;
> +
> +		ret =3D reallocate_ap_config(&ap_config, len);
> +		if (ret < 0)
> +			goto cleanup;
> +
> +		cfg_sz =3D ret;
> +	}
> +
> +	if (*pos + len > cfg_sz) {
> +		ret =3D -EIO;
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * We don't want to lock all mdevs while copying data from userspace so
> +	 * we don't block all other mdevs in case the I/O takes a long time.
> +	 * From here on out we don't need this lock because we are not
> +	 * accessing the matrix_mdev until we need to get the update
> +	 * locks to set the new destination guest's AP configuration in which
> +	 * case this lock will be taken then.
> +	 */
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +

[Severity: High]
Since the file is opened with stream_open (which unsets FMODE_ATOMIC_POS),
f_pos_lock is not held by VFS. Does dropping mdevs_lock here allow
concurrent writes to race on filp->f_pos, leading to data races and memory
corruption?

> +	if (copy_from_user((char *)ap_config + *pos, buf, len)) {
> +		ret =3D -EIO;
> +		goto cleanup;
> +	}
> +
> +	/* Check if we've completed writing the entire configuration */
> +	if (*pos + len =3D=3D cfg_sz) {
> +		ret =3D do_post_copy_validation(mdev_name, ap_config);
> +		if (ret < 0)
> +			goto cleanup;
> +

[Severity: High]
If a short write occurred where len is less than sizeof(struct
vfio_ap_config), could *pos + len =3D=3D cfg_sz evaluate to true prematurel=
y?
Will this trigger post-copy validation on an undersized and partially
uninitialized buffer, leading to out-of-bounds heap reads?

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

[Severity: High]
If a write is partial, it returns before hitting this block. Does this leak
the dynamically allocated configuration buffer since it isn't assigned to
mig_data? And does this permanently break the state machine, as the next
write will fail the validation in validate_resuming_write_parms()?

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
> +
> +cleanup:
> +	kfree(ap_config);

[Severity: Critical]
In the error path, we kfree(ap_config). Because krealloc() might have freed
the memory stored in mig_data->resuming_mig_state.ap_config during a prior
reallocate_ap_config(), could calling kfree(ap_config) here without
clearing the global state lead to a Double Free later when the file is
released?

> +done:
> +	if (mutex_is_locked(&matrix_dev->mdevs_lock))
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +

[Severity: High]
The mutex_is_locked() function only checks if the lock is held by any
thread, not necessarily the current thread. If another thread has acquired
mdevs_lock while this thread was unlocked, will we erroneously unlock it
here and destroy mutual exclusion?

> +	return ret;
>  }
> =20
>  static const struct file_operations vfio_ap_resume_fops =3D {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630104132.1598=
851-1-akrowiak@linux.ibm.com?part=3D10
