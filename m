Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640219;
	b=KI1b5qY1Nj7ltEIExvuzl12AEUkTHEvoY6hjYyU+nBYnrbxfuhw7KMij+a01PFTcfm7k
	 UYu4r5nYJSTp3MlXkCdwOus6vVcbeRmiZGgjdacwBezHUKnn8Bd5ctPPR8o6FkDNR9WpM
	 mwPEO1tSrc66ETuXm2Jn/XdVaWy0vs6Obixxozn48o4OEsqsNUooNkME/RTaRwQkjy/0u
	 q/iHsDeQIWucA1DuYlfi5FynqoZRtpiEj6V+UFsZGK+NkuuEK38kiVbithUkN5VgrGW6H
	 JhpfWn+ri90HTI3qBGoSlAG6tPtzP4XUtSxS0UU9wBRRcZwL5IlFUvsOaTS+zBVIQPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640219;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VxerWY3W23ia/Jh47/CR89uHx8mpniCBvQqevt8gLJQ=;
	b=FkXA4udP3912aTpaJDKk0mPazorqQdojhfff1mz/YX/r/FypBydxvlYUjxKuyu/Oswu6
	 1Z8Aq6oGbD6i9nRIwTfPY3F6S4JrnD6vTZdtvYdRSJI9u/voQyTeAib+7/VtJKgaKp2Ha
	 eGOF0ZkNyaeRVtFH/m/jmnmheDJfy5nWpPQCwBEOzp3tY/vphq9TI/HNWXpPXj9xhx4MQ
	 uEJUQZ2wFGO/F0H1/AHRJ35AinvNLASaTug4SUcgULMfuln4q+kbB+bZLUCPi6jgHq/om
	 3c15juQAsAC18sihgGSz133mdY2lBV5Q4FPjFRokHEye2OOKYWbe1Bz+QkP5XuBaFOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y/sCGi+L";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45108606A32E;
	Mon,  2 Nov 2026 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/sCGi+L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E141F00A16;
	Mon,  2 Nov 2026 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793640219;
	bh=VxerWY3W23ia/Jh47/CR89uHx8mpniCBvQqevt8gLJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y/sCGi+LGLHgPmRhU/8My2TGM4mv+sKf3OXpr8Z2oBz72cjGw6QEmlbtA1UO5bkl3
	 CQRup4eI6eZotBC+RyIGE/UrhZBHnyLBOgFOhsJAHDW6KEdVi4xygdwIZCRxR9/cje
	 mZKGgIH31Q58s6Y6Xh4fbBD4FWwht1KUvUfSDD2xZc7+wyn06p2Htvg1t91/Es4R3V
	 4ihKpj5vIPMFCOIFpR9EU2C2Km7P/t75qeMkMNtWN+exyp5Ead2MhcuoLkm6z8kqkH
	 KGSFJ090r2ysbwMiK0EykyW74sdF5czLPNZ7rnHwZykTVQ4f6SXnnmNjTCsVEkXmg4
	 zmNBiY3IvQRtA==
Message-ID: <sashiko-outbox-193825@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 10/14] s390/vfio-ap: Transition device migration
 state to from/to STOP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261102151604.2150055-11-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-11-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 17:23:38 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] s390/vfio-ap: use-after-free of mig_data when device FD closes=
 before data FD
- [High] s390/vfio-ap: fortify panic on chunked writes in vfio_ap_resuming_=
write()
--

commit 6775fb7f340ff449dd183124e50a9831181c55db
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Transition device migration state to from/to STOP

This commit implements the VFIO migration state transitions to and from
VFIO_DEVICE_STATE_STOP in vfio_ap_transition_to_state(), releasing
migration file state when leaving RESUMING, STOP_COPY, or STOP.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 47f05e43b9e0e..c5534c6ee3cef 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> @@ -1170,20 +1172,46 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev=
 *matrix_mdev,
>  		return filp;
>  	}
> =20
> -	if ((cur_state =3D=3D VFIO_DEVICE_STATE_RESUMING &&
> -	     new_state =3D=3D VFIO_DEVICE_STATE_STOP) ||
> -	    (cur_state =3D=3D VFIO_DEVICE_STATE_STOP_COPY &&
> -	     new_state =3D=3D VFIO_DEVICE_STATE_STOP)) {
> -		/* TODO */
> -		return ERR_PTR(-EOPNOTSUPP);
> +	/*
> +	 * Terminates the data transfer session of the vfio-ap device state
> +	 * to the destination guest.
> +	 */
> +	if (cur_state =3D=3D VFIO_DEVICE_STATE_RESUMING &&
> +	    new_state =3D=3D VFIO_DEVICE_STATE_STOP) {
> +		if (!mig_data->resuming_mig_data_complete)
> +			return ERR_PTR(-EINVAL);
> +
> +		/* Set resuming_mig_data_complete to false for clean reuse */
> +		matrix_mdev->mig_data->resuming_mig_data_complete =3D false;
> +		vfio_ap_release_resuming_file(matrix_mdev->mig_data);
> +		return NULL;
> +	}
> +
> +	/*
> +	 * Terminates the transfer session of the vfio-ap device state from
> +	 * the source guest.
> +	 */
> +	if (cur_state =3D=3D VFIO_DEVICE_STATE_STOP_COPY &&
> +	    new_state =3D=3D VFIO_DEVICE_STATE_STOP) {
> +		vfio_ap_release_stop_copy_file(matrix_mdev->mig_data);
> +		return NULL;
> +	}
> +
> +	/*
> +	 * These states indicate migration has either not been initiated or
> +	 * has completed and the vfio-ap device is operating normally. Since the
> +	 * vfio-ap device does not virtualize a DMA device, there is no internal
> +	 * device state to incorporate into the vfio-ap device on the target.
> +	 */
> +	if (cur_state =3D=3D VFIO_DEVICE_STATE_STOP &&
> +	    new_state =3D=3D VFIO_DEVICE_STATE_RUNNING) {
> +		vfio_ap_release_mig_files(matrix_mdev);
> +		return NULL;
>  	}
> =20
> -	if ((cur_state =3D=3D VFIO_DEVICE_STATE_STOP &&
> -	     new_state =3D=3D VFIO_DEVICE_STATE_RUNNING) ||
> -	    (cur_state =3D=3D VFIO_DEVICE_STATE_RUNNING &&
> -	     new_state =3D=3D VFIO_DEVICE_STATE_STOP)) {
> -		/* TODO */
> -		return ERR_PTR(-EOPNOTSUPP);
> +	if (cur_state =3D=3D VFIO_DEVICE_STATE_RUNNING &&
> +	    new_state =3D=3D VFIO_DEVICE_STATE_STOP) {
> +		return NULL;
>  	}

[Severity: Critical]
As reported by Sashiko on v5 [1], with the transitions to and from
VFIO_DEVICE_STATE_STOP enabled in vfio_ap_transition_to_state(), userspace =
can
now enter VFIO_DEVICE_STATE_STOP_COPY or VFIO_DEVICE_STATE_RESUMING and ope=
n a
migration stream file descriptor.

When vfio_ap_open_file_stream() creates that file descriptor, it sets
filp->private_data to &matrix_mdev->mig_data->stop_copy_mig_file or
&matrix_mdev->mig_data->resuming_mig_file and pins the registration of
matrix_mdev->vdev via vfio_device_try_get_registration(). However, Both
stop_copy_mig_file and resuming_mig_file are embedded inside struct
vfio_ap_migration_data (matrix_mdev->mig_data) rather than struct
ap_matrix_mdev:

struct vfio_ap_migration_data {
	enum vfio_device_mig_state	mig_state;
	bool				resuming_mig_data_complete;
	struct vfio_ap_migration_file	resuming_mig_file;
	struct vfio_ap_migration_file	stop_copy_mig_file;
};

When the VFIO device file descriptor is closed while the migration stream f=
ile
descriptor is still open (including during process exit, since close_files()
closes file descriptors in ascending order), vfio_ap_mdev_close_device() ca=
lls
vfio_ap_release_migration_data(), which destroys the mutexes and frees
matrix_mdev->mig_data:

void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
{
	lockdep_assert_held(&matrix_dev->mdevs_lock);

	if (!matrix_mdev->mig_data)
		return;

	vfio_ap_release_mig_files(matrix_mdev);
	mutex_destroy(&matrix_mdev->mig_data->stop_copy_mig_file.lock);
	mutex_destroy(&matrix_mdev->mig_data->resuming_mig_file.lock);
	kfree(matrix_mdev->mig_data);
	matrix_mdev->mig_data =3D NULL;
}

Doesn't this cause a use-after-free when the open migration file descriptor=
 is
subsequently read in vfio_ap_stop_copy_read(), written in
vfio_ap_resuming_write(), or closed in vfio_ap_release_mig_file(), where
filp->private_data (mig_file) is dereferenced and mig_file->lock is locked =
or
unlocked after matrix_mdev->mig_data has been freed?

[Severity: High]
In addition, with VFIO_DEVICE_STATE_RESUMING now reachable via
vfio_ap_transition_to_state(), can chunked writes in vfio_ap_resuming_write=
()
trigger a fortify_panic() when CONFIG_FORTIFY_SOURCE is enabled?

In struct vfio_ap_config, qinfo[] is annotated with __counted_by(num_queues=
).
While vfio_ap_resuming_init() initializes ap_config->num_queues to
MAX_AP_QUEUES when the stream is opened, vfio_ap_resuming_write() copies
incoming chunks directly into ap_config before checking whether *pos exceeds
expected_sz:

	ap_config =3D mig_file->ap_config;
	memcpy((char *)ap_config + *pos, kbuf, len);
	*pos +=3D len;

If an earlier write chunk overwrites ap_config->num_queues with a smaller
value (or splits the 4-byte num_queues field across two write calls so that
its upper bytes are zeroed first) and a subsequent write chunk writes past
sizeof(struct vfio_ap_config) + ap_config->num_queues *
sizeof(struct vfio_ap_queue_info), won't fortified memcpy() evaluate the
updated ap_config->num_queues and call fortify_panic() before the bounds ch=
eck
after memcpy() is reached?

[1] https://lore.kernel.org/r/20260724182949.EA9C51F000E9@smtp.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102151604.2150=
055-1-akrowiak@linux.ibm.com?part=3D10
