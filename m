Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B518E2EA754;
	Thu, 13 Aug 2026 23:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786665198; cv=none; b=EI18F5S+ieKcSxghoGfEjUI38LFOb+aurOEW4Csu3bNYXUtCVfCnBq1RF+PwQWrAjZeR6EbVRz60lzWdSDD3JlYP1DYAKKuL8QJYeUV1gkgr/0sv3hMYzyPGsXAmlcs5cZtPY2kGuB2RfHFi4rb/gIN8lmwvNGzEsqNIgq4Qj6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786665198; c=relaxed/simple;
	bh=1o2u40WRtfREJ+3WT4dxvCKpJOzrfYn4Vc7NpnEwezE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dDP9y7dwotXc0Fd6oaC2peLPaw/z20dOqvVzmeqvQ5sNY6WQE05y2wX/WIlcC2XzT/BGkxXZm3iMHApSuBVYdMWjBkoCJrp55rsodBd2lux97aF6P3IlQpuoKIGcZcZ487ow8CqSkrzCcE+VhCrjvtKbG7GHOtdff2cg2E9XKfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+/Zj09N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+/Zj09N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E2E1F000E9;
	Thu, 13 Aug 2026 23:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786665197;
	bh=t8RhoIHj5CleEc2biqryfd+DQauSF72ZOQqryXOLRKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G+/Zj09NqZiitfFDXPsSYFtVYHK9Hz5TQ9iL6VX9c6qTHXLqrIAntUziP4OIR4dc6
	 AolTM9V1H/ZSksTARDOXRMlQODLIeQuhlPOvh6Sd3CtA4/fiWEAmMu1SIi1UEfXyVb
	 KVbrzE7/IsyZiyTkpbeDd5sQvboRPbhVe1x9D4/M3SP+3LMwyPBEMnuPW0Pw20I84a
	 8/WwgHXkSQPrjXJoJ+HaHOGZrifkKHO9xt7SHAWhOTuFmWU2EJ/blKo+kR/IMLMVI1
	 rVJgFOX+Cy/UYHFoF25Vet1T1JQ5ps5DQhn0sccjz0Mx3xaJFp+MT88hyQcKgwsvwy
	 ZSy5GZQ55tpYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/16] s390/vfio-ap: Transition device migration
 state from RESUMING to STOP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260407205100.331150-11-akrowiak@linux.ibm.com>
References: <20260407205100.331150-11-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:53:12 +0000
Message-Id: <20260813235317.00E2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Userspace can trigger a host kernel panic via a NULL pointer d=
ereference by calling read/write on the migration file descriptor concurren=
tly with or after a state transition.
- [Critical] NULL pointer dereference during post-copy validation if a targ=
et queue is not bound to the vfio_ap driver.
--

--- Patch [10]: [PATCH v2 10/16] s390/vfio-ap: Transition device migration =
state from RESUMING to STOP ---
commit 198a0563141b8b9148b57d67d870dea7883422b2
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Transition device migration state from RESUMING to STOP

Leaving the RESUMING state terminates a data transfer of the internal
state of the vfio-ap device on the source host to the vfio-ap device on the
target host. This state transition indicates the vfio_ap driver should
complete the incorporation of data written to the data transfer FD. Since
a vfio-ap device does not virtualize a physical device, the only thing
left to do is release the migration files used to help facilitate the
migration process.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index ce16028e50a41..ebb3b78b1e195 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -915,10 +915,20 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *=
matrix_mdev,
>  		return migf->filp;
>  	}
> =20
> +	/*
> +	 * Terminates the data transfer session of the vfio-ap device state
> +	 * between the source and target hosts. Since the vfio-ap device does
> +	 * not virtualize a DMA device, there is no internal device state to
> +	 * incorporate into the vfio-ap device on the target; so, the only
> +	 * thing left to do is release the migration files used to process
> +	 * the vfio device migration. Note that this state transition is for
> +	 * the vfio-ap device on the target host.
> +	 */
>  	if (cur_state =3D=3D VFIO_DEVICE_STATE_RESUMING &&
>  	    new_state =3D=3D VFIO_DEVICE_STATE_STOP) {
> -		/* TODO */
> -		return ERR_PTR(-EOPNOTSUPP);
> +		vfio_ap_release_mig_files(matrix_mdev);

[Severity: Critical]
Can this regression cause a host kernel panic via a NULL pointer
dereference if userspace calls read or write on the migration file
descriptor concurrently with or after this state transition?

When vfio_ap_release_mig_files() is called, it sets migf->matrix_mdev =3D N=
ULL
and migf->disabled =3D true.

If a userspace process continues to read or write to the migration file
descriptor, it can block on matrix_dev->mdevs_lock and then blindly
dereference migf->matrix_mdev once unblocked:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_resume_write() {
    ...
    mig_data =3D migf->matrix_mdev->mig_data;
    ret =3D validate_resume_write_parms(migf, len, pos);
    ...
}

Does the error logging also directly dereference migf->matrix_mdev after
confirming migf->disabled is true, even though disabled =3D=3D true guarant=
ees
matrix_mdev =3D=3D NULL?

drivers/s390/crypto/vfio_ap_migration.c:validate_save_read_parms() {
    ...
    if (migf->disabled) {
        dev_err(migf->matrix_mdev->vdev.dev,
                "%s (%d): migration file is disabled\n",
                __func__, __LINE__);
    ...
}

[Severity: Critical]
Is it also possible to hit a NULL pointer dereference during post-copy
validation if a target queue is not bound to the vfio_ap driver?

If userspace writes an AP configuration containing an apqn that is assigned=
 to
the guest matrix, but the physical queue object is not bound to the host
vfio_ap driver (e.g., it is offline or unassigned), vfio_ap_mdev_get_queue()
returns NULL.

drivers/s390/crypto/vfio_ap_migration.c:matrixes_compatible() {
    ...
    q =3D vfio_ap_mdev_get_queue(matrix_mdev, apqn);
    memcpy(&src_hwinfo, &migf->ap_config->qinfo[i].data,
           sizeof(src_hwinfo));

    if (!qinfo_compatible(matrix_mdev, apqn, &src_hwinfo, &q->hwinfo))
    ...
}

Will this dereference q->hwinfo and pass it to qinfo_compatible() when q is
NULL, leading to a host crash?

> +
> +		return NULL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260407205100.3311=
50-1-akrowiak@linux.ibm.com?part=3D10
