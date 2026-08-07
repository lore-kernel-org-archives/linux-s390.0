Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A22B282F3A;
	Fri,  7 Aug 2026 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786143244; cv=none; b=oA86Z74ozizOJGMtenrmPZXEoRwgzx9Xwj00NMW3N5sf5LBwu58H7DHK9NAQQ5mpncmdHU498K7dmtewnscYTXm9ZK54IjvSDTtFOCmsk4/Et48hA73kUmb+yRenOdowueMMgnj7XuTHnMFqUn9/89eAhU0lR9rBQq2c2I1culg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786143244; c=relaxed/simple;
	bh=+aAYwfCJ23/M+Lwzv1chzuz/y+Szg+ltYkfHotmyx0Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FIvzhU+berH/MUpbEvbtM+OusNjZ41LvahsXKIHKbNhYTzfGsjmTP0THw82qn7LQNqeeAnFHnfMB/IZtLQFEX2e3Wwl5Dn2OUlI5mlPq6ZWRdnaxOwsizwjfW/kLAGKAB5Y9Vyhv58BrHyAaAdlHmaCLOmHr/6C7AeHyysOIyvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7nR5PWV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7nR5PWV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DB01F000E9;
	Fri,  7 Aug 2026 22:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786143243;
	bh=ogNdvd7NQKygo7PXOXpVbpiCQc4HdfgAsjtuvVRf+Mk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k7nR5PWV43D2OxMks8Z2SxID9TaobNrS06TDHDN2e+cK62hsAT/JvW5SvPH07vOsU
	 Xcol9pf3b2l9Nj1DFdYXfaMZO/FY86rxg5kaaD6B+lFm7Yuc6m5KR/FAuPL0B8hKZI
	 k30SuGrDQWwzD5kWcjXt52vOlmz5NjWbrJPIjO9Jt1gK8hzERCUaUzEjbH4aNvcIK/
	 9oFAw/3RdAgFJIFS4Eor9w8BvbwW7vrFgRknIgQ3FZ2yOBNfhvGkeK3vIcoz3LY7eW
	 RlDKOWO6PIfuwlXZaoqPFotUa4pG4f1z19UTkfYhBVp18y06Bov5O+I9XDsfZQkTxP
	 8JowkJQDVaTrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/15] s390/vfio-ap: Transition device migration
 state to STOP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260807221834.562851-12-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-12-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 22:54:01 +0000
Message-Id: <20260807225402.D7DB01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Memory leak and silent transmission of stale device state due to m=
issing buffer cleanup on FSM STOP transition.
- [High] Migration data file descriptors allow out-of-band manipulation of =
the active AP configuration.

Pre-existing issues:
- [Critical] Unprotected concurrent ioctls cause Use-After-Free, Double Fre=
e, and Memory Leaks during migration reads/writes.
- [High] RESUMING state machine is permanently broken by an incomplete rese=
t.
--

--- Patch [11]: [PATCH v7 11/15] s390/vfio-ap: Transition device migration =
state to STOP ---
commit e7e2429c70da0ea0a7016c096567e78834fcc351
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

    s390/vfio-ap: Transition device migration state to STOP
   =20
    This commit updates the VFIO AP migration state machine to handle
    transitions to the STOP state from RESUMING or STOP_COPY. It returns
    NULL instead of an error, stating that the VFIO migration framework
    will clean up file streams and associated data when releasing files.

> There  only thing to do at this point is return
> NULL to the caller since the file streams and associated data will get
> cleaned up as a result of the VFIO migration framework releasing the file=
s.

[Severity: High]
Is this assumption about the file streams and associated data getting clean=
ed
up accurate?

Looking at the file release callback:

vfio_ap_release_mig_file() {
    ...
    vfio_device_put_registration(&matrix_mdev->vdev);
    return 0;
}

The callback only releases the VFIO registration reference and does not free
the state buffers like stop_copy_mig_file.ap_config or
resuming_mig_file.ap_config.

Could this lead to a memory leak and the silent transmission of stale device
state to the destination host on subsequent migration attempts, for instance
if we skip allocating and fetching a fresh configuration in
vfio_ap_stop_copy_read() because ap_config was leaked and left populated?

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 4dd7373c3d9d9..30160e3dddedd 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -1511,12 +1511,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev=
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
Does returning NULL here successfully change the FSM state without clearing
the active filp pointers in mig_data?

If userspace keeps the migration file descriptor open (or duplicates it)
during an FSM transition to RUNNING, and then issues a write on the stale
file descriptor, could this allow out-of-band manipulation of the KVM guest=
's
AP configuration while the guest is actively running?

The file operations like validate_resuming_write_parms() appear to only che=
ck
if the incoming filp pointer matches the stored pointer:

validate_resuming_write_parms() {
    ...
    if (filp !=3D resuming_mig_file.filp)
        return -ENXIO;
    ...
}

This happens without ensuring the FSM is actually in the RESUMING state,
potentially permitting writes during RUNNING.

[Severity: High]
This is a pre-existing issue, but does a reset or an aborted RESUMING phase
leave the RESUMING state machine permanently broken?

When vfio_ap_release_resuming_file() is called, it frees
resuming_mig_file.ap_config but fails to clear resuming_config_buf.filled:

vfio_ap_release_resuming_file() {
    kvfree(mig_data->resuming_mig_file.ap_config);
    mig_data->resuming_mig_file.ap_config =3D NULL;
    mig_data->resuming_mig_file.config_sz =3D 0;
    mig_data->resuming_mig_file.filp =3D NULL;
}

If userspace initiates a new RESUMING phase, validate_resuming_write_parms()
will evaluate this condition as true:

    if ((resuming_config_buf.filled && !resuming_mig_file.ap_config) ||
        (!resuming_config_buf.filled && resuming_mig_file.ap_config))
        return -EFAULT;

Would this unconditionally reject all subsequent writes with -EFAULT?

[Severity: Critical]
This is a pre-existing issue, but are the migration reads and writes protec=
ted
against concurrent ioctls?

For example, in vfio_ap_resuming_write(), mdevs_lock is dropped before
copying data from userspace and interacting with set_new_ap_configuration():

vfio_ap_resuming_write() {
    ...
    mutex_unlock(&matrix_dev->mdevs_lock);

    if (copy_from_user((char *)ap_config + write_pos, buf, write_len)) {
    ...
    ret =3D set_new_ap_configuration(matrix_mdev, ap_config, cfg_sz);
    ...
    if (!new_allocation)
        kvfree(ap_config);
    ...
}

If a concurrent VFIO_DEVICE_RESET ioctl occurs while the lock is dropped,
could set_new_ap_configuration() assign a locally allocated ap_config into
the now-NULL resuming_mig_file.ap_config?

Would the outer function then call kvfree(ap_config), leaving a dangling
pointer in the device state that could subsequently be used and double-free=
d?

Similarly, in vfio_ap_stop_copy_read(), the lock is dropped before
copy_to_user():

vfio_ap_stop_copy_read() {
    ...
    mutex_unlock(&matrix_dev->mdevs_lock);

    if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len))
        return -EFAULT;
    ...
}

Could a concurrent reset free mig_file->ap_config before or during the copy,
leading to an information leak of freed kernel memory to userspace?

>  	}
> =20
>  	if ((cur_state =3D=3D VFIO_DEVICE_STATE_STOP &&

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807221834.5628=
51-1-akrowiak@linux.ibm.com?part=3D11
