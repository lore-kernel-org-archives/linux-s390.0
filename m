Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95F3F20E7;
	Tue, 30 Jun 2026 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819971; cv=none; b=B+zwCkbb8aZGVgE/qnZJXvuQ8bS9BKsaH7LRzkLZ7McDj39XvaJpL0dzNwTAtNICMHWb5IUbcL34ufcTfW1RWGTnOchcR+5Y2TOU82Gn4zQGS2m5kt7q44aH9pFRQqeisHSJhPQ1bJUMJPC3jwE5CiK0fpyttbx0jH4wBNfttbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819971; c=relaxed/simple;
	bh=0M8BWWo9/GxP5o5rF8LuNNvbjnZhOjooxiqmThhj2xM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FRRHLId+SxLezgpiEV23KD8zOZgn10MWOeoyOFclNvF8l0EvZ8Hrw06KPc4aHZqfhYCrfSJ6CaXBAfh/PXoyTIA5AnEqMZ0OTg40UtEEFGjtRpCUhq2Kj972zABjA7wVOHtW81cLq7pFGUpQ2Plg8wWtQrnWvXJ85YSIDWoBnR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6k0k2Uz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6k0k2Uz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5D31F000E9;
	Tue, 30 Jun 2026 11:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782819970;
	bh=WtiAOhoHW6NEQnN1cC1a3zGTJjkSZxBWxk4Xva6XtKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z6k0k2UzA0xIK49BIHXy8JfNTxSo96nL0m+bVIolbLj3tg3iekiHt+toKUlAUt8ZB
	 FtPzUMD3ob3U8USLS6IHZ/vv1rEYfIfmLh8e4qTeUHnXZrmk9vAmWaw3WQey3jZvw6
	 XyG6Fj9LVR9IySpuoprs+RTnnkKIAmfUzm08sEXjCoUCmKuhYIPoXiI052od9k9ur5
	 SBg9+QwjWJaYcg6ZxMNGTdnYObxsNpjsoWTDOvyDx21ZDhzwFb2k9bTdHvbJB0OEsT
	 Yd6CYRb1mIKpPaQUJApFVw12JSt3HXFdeBmDityWaqd2ngHkst/0mcdk3fZeVsEILO
	 GQjRcKQF1NQbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/15] s390/vfio-ap: Transition device migration
 state to STOP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260630104132.1598851-12-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
 <20260630104132.1598851-12-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:46:09 +0000
Message-Id: <20260630114609.DE5D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Migration stream file descriptors are not invalidated upon transit=
ioning out of data transfer states, allowing untrusted userspace to modify =
running guest state.
- [High] The driver unconditionally allows the transition from RESUMING to =
STOP, failing to reject incomplete migration data as required by the VFIO s=
pecification.

Pre-existing issues:
- [Critical] Chunked or partial writes to the RESUMING fd leak memory and c=
ause a NULL pointer dereference on subsequent chunks.
- [Critical] Migration file descriptors do not hold a reference to the `vfi=
o_device` or `matrix_mdev`, leading to a Use-After-Free if the device is re=
moved while the migration FD is kept open.
- [Critical] vfio_ap_release_mig_file accesses and modifies migration state=
 without holding matrix_dev->mdevs_lock, leading to UAF.
- [High] Writing fewer than `sizeof(struct vfio_ap_config)` bytes to the re=
suming stream bypasses size validation, triggering a Heap Out-of-Bounds rea=
d.
- [High] The dynamically allocated `ap_config` is permanently leaked if the=
 VFIO device is closed while the migration file descriptor remains open.
--

commit 1ef55b17508b1d713795918bce912d07492d77e0
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Transition device migration state to STOP

This commit updates the vfio-ap migration state machine to allow
transitions to the stop state. It allows returning null when
transitioning from resuming or stop copy to stop.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 9cd1e7a3f7430..1b526b743ad02 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -1159,12 +1159,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev=
 *matrix_mdev,
>  		return filp;
>  	}
> =20
> +	/*
> +	 * Terminates the data transfer session of the vfio-ap device state
> +	 * between the source and target hosts. Since the vfio-ap device does
> +	 * not virtualize a DMA device, there is no internal device state to
> +	 * incorporate into the vfio-ap device on the target.
> +	 */
>  	if ((cur_state =3D=3D VFIO_DEVICE_STATE_RESUMING &&
>  	     new_state =3D=3D VFIO_DEVICE_STATE_STOP) ||
>  	    (cur_state =3D=3D VFIO_DEVICE_STATE_STOP_COPY &&
>  	     new_state =3D=3D VFIO_DEVICE_STATE_STOP)) {
> -		/* TODO */
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return NULL;

[Severity: High]
Does transitioning to the stop state here leave the active file stream
pointers open for abuse? By simply returning null without clearing
mig_data->resuming_mig_state.filp, userspace might be able to
transition the device to stop and then running, while keeping the
resuming file descriptor open to write to it.

In validate_resuming_write_parms(), it only validates that filp matches
the cached pointer without checking if the device is actually in the
VFIO_DEVICE_STATE_RESUMING state:

validate_resuming_write_parms() {
    if (filp !=3D matrix_mdev->mig_data->resuming_mig_state.filp) {
        ret =3D -ENXIO;
        goto done;
    }
}

Could this trigger asynchronous mutation of the AP hardware
configuration of a live guest?

[Severity: High]
Does unconditionally returning null here bypass verifying the completeness
of the migration data transfer?

If userspace writes a partial configuration and transitions to stop,
will the device silently remain unconfigured without signaling an error
to userspace?

>  	}
> =20
>  	if ((cur_state =3D=3D VFIO_DEVICE_STATE_STOP &&

[Severity: Critical]
This is a pre-existing issue, but do chunked or partial writes to the
resuming file descriptor leak memory and cause a null pointer dereference?

If a user writes a partial chunk in vfio_ap_resuming_write() where the size
is less than cfg_sz, it skips assigning the dynamically allocated ap_config
back to the global state:

vfio_ap_resuming_write() {
    ...
    if (*pos + len =3D=3D cfg_sz) {
        ret =3D do_post_copy_validation(mdev_name, ap_config);
    ...
}

On the subsequent write chunk, retrieving ap_config from mig_data fetches
null, which then gets passed to reallocate_ap_config():

reallocate_ap_config() {
    struct vfio_ap_config *ap_config =3D *mig_ap_config;
    ...
    cur_cfg_sz =3D ap_config->config_sz;
}

Will this dereference cause a kernel oops?

[Severity: High]
This is a pre-existing issue, but does writing fewer than the expected size
bypass size validation and trigger a heap out-of-bounds read?

In allocate_ap_config(), writing an undersized buffer sets config_size
to the short length:

allocate_ap_config() {
    ...
    } else {
        config_size =3D len;
    }
}

If vfio_ap_resuming_write() sees that the received size matches cfg_sz,
it assumes the configuration is fully received and passes the undersized
buffer for validation.

Since userspace controls num_queues, will iterating over it read out
of bounds?

queues_available_on_target_system() {
    for (int i =3D 0; i < source_config->num_queues; i++) {
        apqn =3D source_config->qinfo[i].apqn;
    ...
}

[Severity: High]
This is a pre-existing issue, but is the dynamically allocated ap_config
permanently leaked if the device is closed while the migration file
descriptor remains open?

If userspace closes the main device file descriptor, the container struct
is freed:

vfio_ap_release_migration_data() {
    ...
    kfree(matrix_mdev->mig_data);
    matrix_mdev->mig_data =3D NULL;
}

When the migration file descriptor is later closed, it bails out early
if the container is null, leaving the nested ap_config allocation orphaned:

vfio_ap_release_mig_file() {
    if (!matrix_mdev || !matrix_mdev->mig_data)
        return -ENODEV;
    ...
}

[Severity: Critical]
This is a pre-existing issue, but do migration file descriptors fail to
hold a reference to the vfio_device or matrix_mdev?

When opening the stream, anon_inode_getfile() is called without bumping
the reference count:

vfio_ap_open_file_stream() {
    filp =3D anon_inode_getfile("vfio_ap_mig_file", fops, matrix_mdev, flag=
s);
    ...
}

If the device is removed via sysfs while the migration file descriptor
is open, will the final reference be dropped?

vfio_ap_mdev_remove() {
    ...
    vfio_put_device(&matrix_mdev->vdev);
}

Could subsequent operations on the open migration file descriptor
dereference the freed matrix_mdev and result in a use-after-free?

[Severity: Critical]
This is a pre-existing issue, but does accessing the migration state
locklessly in vfio_ap_release_mig_file() lead to a use-after-free?

The function checks mig_data without holding a lock:

vfio_ap_release_mig_file() {
    if (!matrix_mdev || !matrix_mdev->mig_data)
        return -ENODEV;

    if (filp =3D=3D matrix_mdev->mig_data->stop_copy_mig_file)
    ...
}

If userspace concurrently triggers closure of the primary device, can
the memory be freed under the mdevs_lock?

vfio_ap_release_migration_data() {
    kfree(matrix_mdev->mig_data);
    matrix_mdev->mig_data =3D NULL;
}

Could this allow vfio_ap_release_mig_file() to dereference mig_data
immediately after it is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630104132.1598=
851-1-akrowiak@linux.ibm.com?part=3D11
