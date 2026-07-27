Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1143553B;
	Mon, 27 Jul 2026 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176800; cv=none; b=Hf7yj+5SN+3WReQLDWKHImj9jlmmuiX5oBZvLxIHeUb0FW9rJzWoA8Hyo1YkJKlDdTEY9O/cqfZT54lID/mBIEO55li8u6hVb2pYHu/3OHQE9bPxVSIPsT5WIZFUPj7o2MtPNwqdfRCypLdV5FHqH6OK2NWhBPxz80TOtnHGCpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176800; c=relaxed/simple;
	bh=U/juMrovY/J37K8+7FTaEOTa50DXT44rUWAvgpdgREI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bCA6mipPHoND3vxeNoXXrH9Tey+txs8YYD/z20pSVVoxCq9fSR/z821Dr2sSJIwHdNtve/bV07UXKnH49D5ZGbwaPvXSoXYgvGZMWC5RKkpYcMwJXhJHvC9NyeNIkjCQy8KCbHyIB7n1pG81ghqIBoP1rf6BdlTuuwccUDoaYcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IufdLqmZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IufdLqmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8B11F00A3A;
	Mon, 27 Jul 2026 18:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785176797;
	bh=M7qt68miu3KljXxMwBPbHyr5YVVhJvHlhoiIWvICx9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IufdLqmZnFLe/wtoAOffuKi7Zye/68q/raMLby4YTe3KjP8OZkC4DtnjXe9TXbzIA
	 gLN8lcmy9w5nLNWKWm946jX1G2sxU4QTECXkJH8G5pBSxtC+NlJr8ARmyaVku6kyg4
	 xalLGlkvF3iEvhox+GcuMFfy+5J12OaTpx/kiX8/3RraV6lnIhYTFYHGjLufVamSM6
	 pFevGu0Y/pJ5xlk5U0PYOgrqdFlcpzZoZAcvp7ZEmPp/5WXulyBUV8h3lEf2Xy03oB
	 7GPpeDUhdEMTF4ycycHXTy9FGtqjX00QEmq+hgvYLYAfFum+a4oDa8spMqmHXS3pXs
	 3/TZAkX7vsoQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/15] s390/vfio-ap: Transition device migration
 state to STOP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260727173239.2420754-12-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-12-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:26:36 +0000
Message-Id: <20260727182636.BD8B11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Dropping mdevs_lock during copy_to_user and copy_from_user in =
migration data transfers allows concurrent device reset or close to free th=
e ap_config buffer, leading to an exploitable Use-After-Free.
- [Critical] A double fetch of the userspace configuration buffer allows a =
malicious user to modify the num_queues field after size allocation, leadin=
g to an Out-Of-Bounds (OOB) heap read and unauthorized hardware access.
- [High] Permanent leak of migration file streams, ap_config buffers, and V=
FIO device registration references due to missing fput() when transitioning=
 to the STOP state.
- [High] The mdevs_lock is held while calling ap_tapq(), a slow hardware in=
struction, violating the stated subsystem locking rules and risking host st=
alls.
--

--- Patch [11]: [PATCH v6 11/15] s390/vfio-ap: Transition device migration =
state to STOP ---
commit bf4a9d5f155b1c98e5568129336b12baad5821b5
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Transition device migration state to STOP

This commit updates the device migration state machine for vfio-ap to prope=
rly
handle the transition to the STOP state. Since there is no physical direct
memory access device virtualized by vfio-ap, the state transition logic now
terminates the data transfer session by returning NULL.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index c12ba82ec5277..fc4cb893f0f00 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -1267,12 +1267,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev=
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
Does returning NULL here permanently leak the migration file streams and
associated data?

When the state transitions to STOP, vfio_ap_transition_to_state() returns
NULL without relinquishing the driver's extra file reference. The driver
previously takes this extra reference in vfio_ap_open_file_stream():

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_open_file_stream() {
    ...
	get_file(filp);

	return filp;
}

If this reference isn't dropped, wouldn't we leak memory (struct file,
ap_config buffers, anonymous inodes) and vfio device registration pins?
This regression might potentially lead to resource exhaustion or prevent
device unbinding.

>  	}
> =20
>  	if ((cur_state =3D=3D VFIO_DEVICE_STATE_STOP &&

[Severity: Critical]
Can dropping mdevs_lock during copy operations lead to an exploitable
use-after-free regression?

In both vfio_ap_stop_copy_read() and vfio_ap_resuming_write(), the
mdevs_lock is explicitly dropped while a pointer to the ap_config buffer
is passed to copy_to_user() or copy_from_user():

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_stop_copy_read() {
    ...
	mutex_unlock(&matrix_dev->mdevs_lock);

	if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len))
    ...
}

Concurrently, if another thread issues a vfio device reset ioctl,
couldn't vfio_ap_reset_migration_state() acquire mdevs_lock and
synchronously free the ap_config buffers via vfio_ap_release_mig_files()?
The copy operations would then proceed using the freed heap pointer.

[Severity: Critical]
Does this code allow an out-of-bounds heap read due to a double fetch of
the userspace configuration buffer?

In vfio_ap_resuming_write(), allocate_ap_config() performs an initial
copy_from_user() to determine num_queues and allocate the struct:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_resuming_write() {
    ...
		ret =3D allocate_ap_config(&ap_config, buf, len);
    ...
}

Immediately afterward, vfio_ap_resuming_write() performs a second
copy_from_user() using the same unvalidated userspace buffer pointer:

    ...
	if (copy_from_user((char *)ap_config + write_pos, buf, len)) {
    ...

If a malicious user modifies the num_queues field between these fetches,
could the artificially inflated count cause an out-of-bounds read in
setup_ap_matrix_from_ap_config():

drivers/s390/crypto/vfio_ap_migration.c:setup_ap_matrix_from_ap_config() {
    ...
	for (int i =3D 0; i < ap_config->num_queues; i++) {
		qinfo =3D ap_config->qinfo[i];
		apid =3D AP_QID_CARD(qinfo.apqn);
    ...
}

and use it to grant unauthorized hardware access to the guest?

[Severity: High]
Are we holding mdevs_lock while executing a slow hardware instruction?

The ap_tapq() instruction is called in a loop within
vfio_ap_store_queue_info(), which includes a comment stating it must be
called without mdevs_lock held:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_store_queue_info() {
    ...
	/*
	 * ap_tapq() is a hardware instruction that may take time to complete.
	 * It must be called without mdevs_lock held to avoid blocking other
	 * mdevs. The apqn list was already snapshotted into ap_config->qinfo[]
	 * by the caller under the lock.
	 */
	for (num_queues =3D 0; num_queues < ap_config->num_queues; num_queues++) {
		ret =3D get_hardware_info_for_queue(mdev_name, &source_hwinfo,
						  ap_config->qinfo[num_queues].apqn);
    ...
}

However, the call chain vfio_ap_stop_copy_read() -> vfio_ap_get_config()
explicitly takes mdevs_lock, asserts it, and then invokes
vfio_ap_store_queue_info() directly while still holding the mutex:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_stop_copy_read() {
    ...
	mutex_lock(&matrix_dev->mdevs_lock);
    ...
	if (!mig_file->ap_config) {
		ret =3D vfio_ap_get_config(matrix_mdev);
    ...
}

Could this regression stall other mdev operations on the host and cause a
potential denial of service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727173239.2420=
754-1-akrowiak@linux.ibm.com?part=3D11
