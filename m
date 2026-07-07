Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7513328FA;
	Tue,  7 Jul 2026 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415885; cv=none; b=t3YMDA7axI5XGk2FXo0ZHOKtv46udXc6UjtN5+sQv24/GvoO9/NEsHFBgmzRJ6zmOWQmX33IVOCX7EqUjWzSv8JFNMdDcLM+J6z/eQPx/+x1DghKJ59nQvh+EjVj213+vIrYstbKIiIa47ywyfQQpjQF/Bk1oWyDrzybOFh1bAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415885; c=relaxed/simple;
	bh=gc9+oFRu/VsEbVBQVMkQbhavqXKk+W9NNXndDtG0HW4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=exqi8l2u88L/JFP1/OP1IykHuYsKie7FE4ePbp4IUgcq++W0xJ63FuVJ9WX7DgNkCgTjhNZ5/5wPHBg+GgBuWtqPm2uxG0eVCHC9bJTz4Wpse2uA8p4uyWSNdzY0QvziM80FsTR1aVaniUMqWS11sHwU3Y5K1hS4yiyH/qcC7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxrCMITv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxrCMITv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C8E1F000E9;
	Tue,  7 Jul 2026 09:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783415884;
	bh=DKsr9/wCWuowkF1mpCLYEUgzaHI0+q7aOaSghoHvzpM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GxrCMITvHUllFhcpPdTetddrXEV8hmMiiLHkq506B4YtZQfHS3mc6qP3xOQoV/5t1
	 AMHksDBbwUcrGjfECQ4/WNT7lzRjFJPzzePsDrLibkzOQhaGWdCK9SWgCxxXrzWkpa
	 nTRYwzS6KbZIzjpGMyT5UwGwRvsJc0NEPZU7E73xSmE+NTrqnbYSP0QwHZ0g3n5ZCc
	 KzEaRcaEhITAmSNSpPoc9B+ZP38eH0WfankhVTXNY7272wYdYvhA0K9yPMZ0Ten/4F
	 GSq60UOoJwnUL39Ef3B5JIr2Gso5xU6HLX1H0KTDYo+eaL6KH9kAm7ZPe2HcxsL1iK
	 ClUWTkwfZcFyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/15] s390-vfio-ap: Callback to get/set vfio device
 mig state during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260707090226.3206695-6-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
 <20260707090226.3206695-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:18:02 +0000
Message-Id: <20260707091803.73C8E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The migration state machine is completely stubbed out, resulting i=
n unconditional migration failures despite advertising migration capabiliti=
es.
- [High] A self-deadlock occurs in the error path of vfio_ap_mdev_probe() w=
hen vfio_register_emulated_iommu_dev() fails.
- [Medium] Migration capabilities are unconditionally advertised to userspa=
ce, but runtime transitions are blocked for Secure Execution (SE) guests.
--

--- Patch [5]: [PATCH v4 05/15] s390-vfio-ap: Callback to get/set vfio devi=
ce mig state during guest migration ---
commit c722c4dee661c005442dd72e3de8888c3305b360
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390-vfio-ap: Callback to get/set vfio device mig state during guest migrat=
ion

This commit implements two callbacks, migration_set_state and
migration_get_state, for the vfio_migration_ops structure. These callbacks
manage the migration state of a vfio-ap device during live migration of
guests with pass-through access.

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
> +static struct file *
> +vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
> +			    enum vfio_device_mig_state new_state)
> +{
> +	struct vfio_ap_migration_data *mig_data;
> +	enum vfio_device_mig_state cur_state;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +	mig_data =3D matrix_mdev->mig_data;
> +	cur_state =3D mig_data->mig_state;
> +	dev_dbg(matrix_mdev->vdev.dev, "%s: %d -> %d\n", __func__, cur_state,
> +		new_state);
> +
> +	if (cur_state =3D=3D VFIO_DEVICE_STATE_STOP &&
> +	    new_state =3D=3D VFIO_DEVICE_STATE_STOP_COPY) {
> +		/* TODO */
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
> +	if (cur_state =3D=3D VFIO_DEVICE_STATE_STOP &&
> +	    new_state =3D=3D VFIO_DEVICE_STATE_RESUMING) {
> +		/* TODO */
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
> +	if ((cur_state =3D=3D VFIO_DEVICE_STATE_RESUMING &&
> +	     new_state =3D=3D VFIO_DEVICE_STATE_STOP) ||
> +	    (cur_state =3D=3D VFIO_DEVICE_STATE_STOP_COPY &&
> +	     new_state =3D=3D VFIO_DEVICE_STATE_STOP)) {
> +		/* TODO */
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
> +	if ((cur_state =3D=3D VFIO_DEVICE_STATE_STOP &&
> +	     new_state =3D=3D VFIO_DEVICE_STATE_RUNNING) ||
> +	    (cur_state =3D=3D VFIO_DEVICE_STATE_RUNNING &&
> +	     new_state =3D=3D VFIO_DEVICE_STATE_STOP)) {
> +		/* TODO */
> +		return ERR_PTR(-EOPNOTSUPP);

[Severity: High]
Does this code cause a regression by unconditionally returning -EOPNOTSUPP?

Since all valid migration state transitions in vfio_ap_transition_to_state()
are caught and unconditionally return -EOPNOTSUPP, could this cause
orchestrators (like libvirt or QEMU) to fail at runtime? Orchestrators
querying the device will see migration as supported, but might unconditiona=
lly
fail when they attempt to change the state.

> +	}
> +
> +	/* vfio_mig_get_next_state() does not use arcs other than the above */
> +	WARN_ON(true);
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
>  static struct file *vfio_ap_set_state(struct vfio_device *vdev,
>  				      enum vfio_device_mig_state  new_state)
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
> +	if (ap_is_se_guest()) {
> +		dev_err(matrix_mdev->vdev.dev,
> +			"Migration not allowed from or to a Secure Execution guest\n");
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		return ERR_PTR(-EPERM);

[Severity: Medium]
Could this runtime check cause a regression with orchestration software?

By advertising migration capabilities unconditionally to userspace, but
blocking transitions for Secure Execution (SE) guests here at runtime,
orchestrators might incorrectly believe migration is supported for SE guest=
s.=20

Could this be rejected earlier during capability checks rather than failing
during the actual migration attempt?

> +	}
> +
> +	mig_data =3D matrix_mdev->mig_data;

[ ... ]

[Severity: High]
Is there a regression involving a self-deadlock in the error path of
vfio_ap_mdev_probe() when vfio_register_emulated_iommu_dev() fails?

The error path in drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_probe()
holds the mdevs_lock while invoking vfio_put_device():

err_put_vdev:
	vfio_put_device(&matrix_mdev->vdev);
	mutex_unlock(&matrix_dev->mdevs_lock);

This triggers the synchronous release callback vfio_ap_mdev_release_dev()
which attempts to acquire the same lock:

	mutex_lock(&matrix_dev->mdevs_lock);
	matrix_mdev =3D container_of(vdev, struct ap_matrix_mdev, vdev);
	vfio_ap_release_migration_data(matrix_mdev);
	mutex_unlock(&matrix_dev->mdevs_lock);

Could this cause a kernel thread freeze when creating an mdev device fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707090226.3206=
695-1-akrowiak@linux.ibm.com?part=3D5
