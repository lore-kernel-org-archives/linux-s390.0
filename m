Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F83624C9;
	Fri, 24 Jul 2026 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917791; cv=none; b=teqTO5l0ibvudaYrAxqbSVc0jv5rNdZC1vjCZe9ZMm6BN2e5tWf5iUfOmPbJ/wHkCzpARo6SmNNdehMmJLsTI6b6kTVNDjQXMCtbIgT+fcyGGHNwot475qJU6ByhxlhD3Sp8RkeXongp03QO2fRR15IURcWwdxhQP2liTDltnfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917791; c=relaxed/simple;
	bh=z05R3D4eZgBQDjQI93CwNAMzPURLt5dgpv/BCRecRqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GUC5DUhe+3VBamF8p83Zq1PMvXwpRDhRrx3oLjYXdyD7tfvCUkBwPi/gs4tWy+ixSq3JKMdI6LsC6VaA3uI6XADb1aerwd9IaPaM0bYz1eQWxsSNnxSqz7CUwv/jULsYX5WnUJeQO+k8nrLs4HT2UjZGkcKns1pJuKeu4p5scO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/N9rQTn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/N9rQTn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9C51F000E9;
	Fri, 24 Jul 2026 18:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784917790;
	bh=CRBIchiOVGFfQUoqEAwa60NXkuRofY/UAe2W/Kz/eoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z/N9rQTnzcNXi5QqI6gxYpAodLaMEPbWjYqLl4aoCV5NhmGKyPCn8CcA/EvLcXp34
	 VBBSEYsrXw35wXs1hLpkjoN2akQe8UZHv4lxCzpCeFxnbp31AsAQ0z3spExIhYkdSh
	 tCpG7mAIsgjvyPhuiXFGYpB7/v1F/qfXmcN+KxrG1O3EhGKpFIL7alJKSAXnArLzuT
	 Hp/dqoJUpW0M+O6G3qwMlE6plNnlIh+XzwO1zNIHk5wXJEm1+dp1s1bbR4UI3uy8Bh
	 xjlEGMxzTdshRnfrtqgIh9OP+cnwen+mFTDYtzFzDFF5EzlNMVCr2wwc6+He+B54lg
	 qy+Si6nvMFR0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/15] s390/vfio-ap: Transition device migration
 state from STOP to RUNNING and vice versa
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260724161351.1802644-13-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
 <20260724161351.1802644-13-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 18:29:49 +0000
Message-Id: <20260724182949.EA9C51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] TOCTOU data race on filp->f_pos in migration stream read/write=
 operations causing heap out-of-bounds access.
- [High] Transitioning from RUNNING to STOP state fails to quiesce AP hardw=
are queues, violating the VFIO migration protocol.
- [High] Unbalanced fput() in vfio_ap_release_mig_files() causes a Use-Afte=
r-Free of the migration struct file.
- [High] Use-After-Free of `matrix_mdev` via migration data file descriptor.
- [Medium] Stale migration data due to failure to clear ap_config across re=
peated STOP_COPY or RESUMING state transitions.
- [Low] Missing space in the newly added comment.
--

--- Patch [12]: [PATCH v5 12/15] s390/vfio-ap: Transition device migration =
state from STOP to RUNNING and vice versa ---
commit d2d58b5a535e0fa830f65967da774eb5f768e3ae
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Transition device migration state from STOP to RUNNING and vi=
ce versa

This commit handles the transition between STOP and RUNNING migration states
by setting the new state without returning an error. It assumes the device =
is
operating normally and that no internal state needs to be incorporated on t=
he
target since vfio-ap does not virtualize a DMA device.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 21cd9810a18c4..8876338d28980 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -1317,12 +1317,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev=
 *matrix_mdev,
>  		return NULL;
>  	}
> =20
> +	/*
> +	 * These states indicate migration has either not been initiated or
> +	 * has completed and the vfio-ap device is operating normally.Since the

[Severity: Low]
This isn't a bug, but there is a missing space after "normally." in the com=
ment.

> +	 * vfio-ap device does not virtualize a DMA device, there is no internal
> +	 * device state to incorporate into the vfio-ap device on the target.
> +	 */
>  	if ((cur_state =3D=3D VFIO_DEVICE_STATE_STOP &&
>  	     new_state =3D=3D VFIO_DEVICE_STATE_RUNNING) ||
>  	    (cur_state =3D=3D VFIO_DEVICE_STATE_RUNNING &&
>  	     new_state =3D=3D VFIO_DEVICE_STATE_STOP)) {
> -		/* TODO */
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return NULL;
>  	}

[Severity: High]
Does this return from the RUNNING to STOP transition arc leave the physical
AP hardware queues active?

The VFIO migration specification mandates that a device must be fully quies=
ced
in the STOP state, meaning no DMA, no asynchronous execution, and no interr=
upts.

Since this arc simply returns NULL instead of quiescing the device, could
pending asynchronous hardware operations continue and write to guest memory
after QEMU considers the device stopped?

While reviewing this patch, I noticed a few related regressions in the
migration file handling.

[Severity: High]
Can an unbalanced fput() in vfio_ap_release_mig_files() cause a use-after-f=
ree
of the migration file?

When anon_inode_getfile() creates the migration stream, it returns a file w=
ith
a refcount of 1. If userspace triggers a reset while the migration file str=
eam
is open, the driver executes this fput() without having taken its own refer=
ence
via get_file():

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_release_mig_files() {
        ...
        if (mig_data->stop_copy_mig_file.filp) {
                fput(mig_data->stop_copy_mig_file.filp);
                mig_data->stop_copy_mig_file.filp =3D NULL;
        }
        ...
}

Does this drop the userspace-owned reference to 0, freeing the file while t=
he
user's file descriptor is still open?

[Severity: Medium]
Could this logic result in migrating stale device state?

If userspace transitions the device STOP_COPY -> STOP -> STOP_COPY while
keeping the old migration stream file descriptor open, ap_config is not cle=
ared
because the file release callback hasn't fired:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_stop_copy_read() {
        ...
        matrix_mdev =3D filp->private_data;
        if (!matrix_mdev->mig_data->stop_copy_mig_file.ap_config) {
                ret =3D vfio_ap_get_config(matrix_mdev);
        ...
}

Will the next STOP_COPY transition skip fetching the updated hardware state=
 and
silently serve the stale configuration?

[Severity: High]
Is there a possibility of a use-after-free of matrix_mdev via the migration
file descriptor?

The migration file descriptor is created without taking a reference to the
vfio_device:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_open_file_stream() {
        ...
        filp =3D anon_inode_getfile("vfio_ap_mig_file", fops, matrix_mdev, =
flags);
        ...
}

If userspace keeps the migration file descriptor open but closes the VFIO
device file descriptor, matrix_mdev and mig_data are freed. A subsequent re=
ad
or write on the migration file descriptor would dereference them:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_stop_copy_read() {
        ...
        matrix_mdev =3D filp->private_data;
        if (!matrix_mdev->mig_data->stop_copy_mig_file.ap_config) {
        ...
}

Does the driver need to tie the lifetime of the migration file descriptor to
the vfio_device?

[Severity: Critical]
Does this code allow concurrent modifications to cause an out-of-bounds acc=
ess
on the kernel heap?

Because the migration file is opened with stream_open(), the VFS sets
FMODE_STREAM and bypasses f_pos_lock, allowing concurrent I/O syscalls.

In vfio_ap_stop_copy_read(), pos is assigned to &filp->f_pos and validated
under mdevs_lock. The lock is then dropped before dereferencing pos during
the copy:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_stop_copy_read() {
        ...
        pos =3D &filp->f_pos;
        ret =3D validate_stop_copy_read_parms(filp, pos, len);
        ...
        mutex_unlock(&matrix_dev->mdevs_lock);

        if (copy_to_user(buf, (char *)ap_config + *pos, len)) {
        ...
}

If another thread advances filp->f_pos after the bounds check but before the
copy, could copy_to_user() read past the end of the ap_config buffer?

A similar issue appears during the write operation:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_resuming_write() {
        ...
        mutex_unlock(&matrix_dev->mdevs_lock);

        if (copy_from_user((char *)ap_config + *pos, buf, len)) {
        ...
}

Could this lead to copy_from_user() writing past the buffer if filp->f_pos =
is
advanced concurrently?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724161351.1802=
644-1-akrowiak@linux.ibm.com?part=3D12
