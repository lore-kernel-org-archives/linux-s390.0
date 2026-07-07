Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCB739937C;
	Tue,  7 Jul 2026 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416830; cv=none; b=KbclL7+P3AuHOf3IqoJ+5U15nUCBd2PE5jfa7SzhW86TpD3rpuwWm8OSiefDydqXmOD/qAPrBI/v9OAr873z4bU+LDL5c7hP2INO87wfNU6+6XKZ4E+33mkfinHpN1FCVEoeYOyHIrhxe7QuyD3AgJe7/WS7zNyK4E/IZdF2qZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416830; c=relaxed/simple;
	bh=Y8aExjF5hLCJ2HJAUiai7i2/xZohBXhjKIRnl7Shwx0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d/Hg9T/8E6fLyqJGxVbdH0ihcm52ZDywD3r3ECfZ48o+jKmiPQ4BZxGQEzlIMtGLVFFWoWUWbmYkQbgLDAg2gmj4wTgGffNnviYe+8zeqM9dtV/IDTVHzlDi0bAxsCBeB7x9PPWocHBzwYDMrRfRaanFoANfi7/sP6vBAqvCUTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqNo3QSe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqNo3QSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73271F000E9;
	Tue,  7 Jul 2026 09:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783416829;
	bh=4cYwtQKdomSMr61HQEw4mQfmiSbktJ6LpcdkOFwTXl0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QqNo3QSek7/9XXXt9/a0glLr/QUjnAi6aUHNKOd3Ks/WrbOcZQcorIAAuItITUrYS
	 aOkCwJlcD/eIA5l18e42TqBExiUGdSA+mDyN3ODYqiUGlYkPJZY0gHUwGxhpE4kMp3
	 jylf+d2bV5zn1zEVUWu4Na+Mt+owsAbBKwzxKNW4RUr1mtskhgcGYEr3fAH5nIRBHM
	 qVnMZmdMSOd/BazzyDBRsSoTGc436Zi9L05bKfUYps0JYyrtmjAlP+pYaY9or/TpuV
	 xPIgAIJ+GXw8TJeMUWMclCBlTIrVR7Ivxlyqlna9wRBIubKusrc1P6ZKCn4XXyB+DY
	 LqEPozmwmtM4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/15] s390/vfio-ap: Transition device migration
 state from STOP to RUNNING and vice versa
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260707090226.3206695-13-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
 <20260707090226.3206695-13-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:33:48 +0000
Message-Id: <20260707093348.B73271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] The transition to VFIO_DEVICE_STATE_STOP does not quiesce the AP h=
ardware queues, leaving the device running during and after migration.

Pre-existing issues:
- [Critical] Writing fewer bytes than `sizeof(struct vfio_ap_config)` leads=
 to a ZERO_SIZE_PTR panic or Slab Out-of-Bounds read.
- [Critical] A partial write of the AP configuration at `pos =3D=3D 0` perm=
anently leaks the allocated memory and leads to a NULL pointer dereference =
crash.
- [Critical] Error paths and reallocation logic in `vfio_ap_resuming_write`=
 free `ap_config` without clearing the global pointer in `mig_data`.
- [High] The `guest_matrix` stack variable is used without initialization w=
hen setting up the AP matrix.
- [High] Concurrent `write` operations on the migration file descriptors ca=
use a data race on `filp->f_pos`, bypassing bounds checks and corrupting th=
e migration stream state.
- [High] `vfio_ap_release_mig_file` accesses and modifies `mig_data` intern=
al pointers locklessly, racing with concurrent device state transitions.
--

--- Patch [12]: [PATCH v4 12/15] s390/vfio-ap: Transition device migration =
state from STOP to RUNNING and vice versa ---
commit 6d2ef5d46b7ff5343fd3f1a4ec81fec852894cf9
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Transition device migration state from STOP to RUNNING and vi=
ce versa

This commit handles the transition between the STOP and RUNNING states for =
the
vfio-ap device during migration. It indicates that the device is operating
normally and sets the new state by returning NULL instead of an error.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 1b526b743ad02..572db04c4ac15 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -1172,12 +1172,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev=
 *matrix_mdev,
>  		return NULL;
>  	}
> =20
> +	/*
> +	 * These states indicate migration has either not been initiated or
> +	 * has completed and the vfio-ap device is operating normally.Since the
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

[Severity: High]
Does this transition to VFIO_DEVICE_STATE_STOP fully quiesce the hardware?

The VFIO migration specification mandates that VFIO_DEVICE_STATE_STOP must
fully stop the device from executing or performing DMA. By just returning N=
ULL
here without calling vfio_ap_mdev_reset_queues() or similar, won't the AP
queues continue to asynchronously process in-flight requests and perform DMA
writes to the guest's NIB physical address?

>  	}
> =20
>  	/* vfio_mig_get_next_state() does not use arcs other than the above */

While reviewing this migration code, I also noticed several pre-existing is=
sues
in the vfio_ap_migration.c implementation:

[Severity: High]
This is a pre-existing issue, but does setup_ap_matrix_from_ap_config() use=
 an
uninitialized stack variable?

In vfio_ap_resuming_write(), guest_matrix is declared on the stack without
initialization:

    struct ap_matrix guest_matrix;
    ...
    setup_ap_matrix_from_ap_config(mdev_name, ap_config, &guest_matrix);

Inside setup_ap_matrix_from_ap_config(), it only sets bits to 1:

    if (!test_bit_inv(apid, guest_matrix->apm))
        set_bit_inv(apid, guest_matrix->apm);

Can this leave uninitialized stack garbage in the arrays (like the adm arra=
y),
causing the target guest to be configured with unintended AP adapter access?


[Severity: Critical]
This is a pre-existing issue, but does allocate_ap_config() handle small
lengths correctly?

If a user writes a small chunk where len < sizeof(struct vfio_ap_config), t=
he
code falls back to allocating len bytes:

    if (len >=3D sizeof(struct vfio_ap_config)) {
        config_size =3D calculate_ap_config_size(tmp_ap_config.num_queues);
        ...
    } else {
        config_size =3D len;
    }

    *ap_config =3D kzalloc(config_size, GFP_KERNEL_ACCOUNT);

If a user writes 0 bytes, won't kzalloc(0) return ZERO_SIZE_PTR, causing a
kernel panic upon dereference?

Also, if len is small (e.g., 8 bytes), this bypasses the minimum size check.
Could this allow the tiny buffer to be passed to do_post_copy_validation(),
which reads num_queues from the heap, potentially leading to an out-of-boun=
ds
memory access?


[Severity: Critical]
This is a pre-existing issue, but does a partial write leak memory and caus=
e a
NULL pointer dereference?

In vfio_ap_resuming_write(), if the first write is partial, the newly
allocated pointer is not saved to the global state until the entire write
is complete:

    if (*pos + len =3D=3D cfg_sz) {
        ...
        mig_data->resuming_mig_state.ap_config =3D ap_config;
    }

On the next write chunk, the code retrieves the pointer from mig_data:

    ap_config =3D mig_data->resuming_mig_state.ap_config;
    ret =3D reallocate_ap_config(&ap_config, len);

Since the pointer was never stored on the partial write, it retrieves a
NULL pointer. Inside reallocate_ap_config(), it immediately dereferences
ap_config to read config_sz. Won't this cause a guaranteed NULL pointer
dereference crash? Also, doesn't the initially allocated buffer leak entire=
ly?


[Severity: Critical]
This is a pre-existing issue, but do error paths in vfio_ap_resuming_write()
leave dangling pointers?

If an error occurs on a subsequent chunk (such as *pos + len > cfg_sz), the
cleanup path frees the pointer:

    ap_config =3D mig_data->resuming_mig_state.ap_config;
    ...
cleanup:
    kfree(ap_config);

However, mig_data->resuming_mig_state.ap_config is not cleared to NULL. When
the file descriptor is subsequently closed, vfio_ap_release_mig_file() will
unconditionally call kfree() on it again. Can this trigger a double free?


[Severity: High]
This is a pre-existing issue, but is there a data race on the file position?

vfio_ap_resuming_write() uses the file's internal position and locklessly
updates it after dropping mdevs_lock:

    mutex_unlock(&matrix_dev->mdevs_lock);

    if (copy_from_user((char *)ap_config + *pos, buf, len)) {
        ...
    ret =3D len;
    *pos +=3D len;

Since the file stream is opened with stream_open(), FMODE_ATOMIC_POS is
cleared, and the VFS layer does not serialize writes with f_pos_lock. Could
concurrent write syscalls race to read and update *pos, bypassing bounds
checks and corrupting the migration state?


[Severity: High]
This is a pre-existing issue, but does vfio_ap_release_mig_file() safely
handle concurrent device state transitions?

The VFS release callback checks filp and frees ap_config locklessly:

    else if (filp =3D=3D matrix_mdev->mig_data->resuming_mig_state.filp)
        vfio_ap_release_resuming_file(matrix_mdev->mig_data);

If a concurrent VFIO ioctl transitions the device state and overwrites
mig_data->resuming_mig_state.filp before the old file descriptor is release=
d,
won't this callback fail to match the old filp? Could this bypass cleanup a=
nd
leak memory, or improperly free memory belonging to a new migration session?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707090226.3206=
695-1-akrowiak@linux.ibm.com?part=3D12
