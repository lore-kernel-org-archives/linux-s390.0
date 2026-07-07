Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A63AB267;
	Tue,  7 Jul 2026 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416851; cv=none; b=Kf1YtGhVY+IAatzWa54c9cqi06+b4snZEraxFLcDDRxTwBUr2fnf6JVix31ZHfwzv6El964JbT65g8QzlIsjOHv18jzHwraWPDy7jmKPrD4QDVgfs8O0nIH5KESOfM7jZ5cShinJo1dphrfvxXgSR0Ctaw7o2digIjhPr8e4g7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416851; c=relaxed/simple;
	bh=uM6M2qG3h6sgbovnCE92g0ohK4fP11XqKs3zCQb+fSw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sjiAo2RPBzK6FdCBVlG4Pdy/bHX8Ld4LEWhJEWRuLiWKv3A15gJbKoxlca2YlqOYQNLzR8WrLJJg0ZSmcWTCoO25mPYQ0+1DEON26qDgJzZJaE5Uhclt8MTUBaU44Fz2HbWzK5iLzo8ohw5/O0cOroc7ygBSIaQX/MEfwL0ZsVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHTldl/m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHTldl/m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD521F000E9;
	Tue,  7 Jul 2026 09:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783416849;
	bh=9py1P+XK0Yk6jlka0Nuk7MUScBs6aXV5R0FF0HGAfaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RHTldl/mdG42NtHELaaGbCt3aFRvQtzz1nDoxyUTdjvY4k7GmhhfC2PCtgcYOLTMY
	 5jkDlGHz0kiUegUdxukMzJRcnRPbGjUGwlPgZdYV3hkRFyKbhhwI8z/XWbdWaNSkwT
	 eCG+E2KX2hijkZ6glP+NBrzUbVAj9zaU5aMzO2Mk3Gc7AyPHm55sNShrxmjeJNZMWo
	 BBKe1L2toyM+c8rC+RK+UjvH7bC+B/OtQ9/IhmwPY/XI6n7zw3YcgLFwCTKp8nBHp+
	 BS5O9oOVFHbyD5l8VrFgvQbPwMy4jr9iWqytGLBTl9THJ1SNdB94Pr1BSnyLAcVDPD
	 sCq839VHFxyBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/15] s390/vfio-ap: Transition device migration
 state to STOP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260707090226.3206695-12-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
 <20260707090226.3206695-12-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:34:09 +0000
Message-Id: <20260707093409.8FD521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Fragmented or malformed writes to the resuming file descriptor=
 trigger severe memory corruption bugs (Double Free, NULL Dereference, Leak=
).
- [Critical] Insufficient length check in allocate_ap_config allows out-of-=
bounds heap read during post-copy validation.
- [Critical] Uninitialized stack variable `guest_matrix` is used to configu=
re the guest AP matrix.
- [High] Improper handling of RESUMING -> STOP transition enables state mac=
hine bypass, lack of validation, and memory leaks.
- [High] The `config_sz` field in the serialized `struct vfio_ap_config` is=
 never set during the STOP_COPY phase, breaking allocation logic on the tar=
get host.
- [High] Transitions between RUNNING and STOP states incorrectly return `-E=
OPNOTSUPP`.
- [High] Missing locking in `vfio_ap_release_mig_file` leads to a TOCTOU da=
ta race and Use-After-Free of migration state pointers.
- [Medium] `vfio_ap_release_migration_data` leaks `ap_config` when the devi=
ce is closed.
--

--- Patch [11]: [PATCH v4 11/15] s390/vfio-ap: Transition device migration =
state to STOP ---
commit 07eb7dcf0820cdb3df175eeebfcfafc28e35382d
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Transition device migration state to STOP

This commit modifies the VFIO AP migration state machine to return NULL
when transitioning to the STOP state from RESUMING or STOP_COPY. It
removes the unsupported error return to allow the migration framework to
clean up the file streams.

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
Does returning NULL here without explicitly closing the file or clearing
mig_data->resuming_mig_state.filp allow a state machine bypass?

If a misbehaving userspace keeps the file descriptor open and transitions
the device back to RUNNING, it appears it could bypass migration state
machine constraints. Because vfio_ap_resuming_write() only checks that the
file descriptor matches resuming_mig_state.filp rather than verifying the
current mig_state, could userspace overwrite the active AP configuration
while the device is fully running?

Also, would initiating another migration cycle blindly overwrite filp and
cause a memory leak?

>  	}
> =20
>  	if ((cur_state =3D=3D VFIO_DEVICE_STATE_STOP &&

[Severity: High]
Are transitions between RUNNING and STOP states incorrectly returning
-EOPNOTSUPP in this adjacent block?

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_transition_to_state() {
	...
	if ((cur_state =3D=3D VFIO_DEVICE_STATE_STOP &&
	     new_state =3D=3D VFIO_DEVICE_STATE_RUNNING) ||
	    (cur_state =3D=3D VFIO_DEVICE_STATE_RUNNING &&
	     new_state =3D=3D VFIO_DEVICE_STATE_STOP)) {
		/* TODO */
		return ERR_PTR(-EOPNOTSUPP);
	}
	...
}

The VFIO migration specification mandates that devices must support
transitions between VFIO_DEVICE_STATE_RUNNING and VFIO_DEVICE_STATE_STOP.
When vfio_mig_get_next_state() attempts to transition the device through the
state machine, will this stub logic instantly fail and render the device
migration feature broken?

[Severity: Critical]
Can fragmented or malformed writes to the resuming file descriptor trigger
memory corruption?

In vfio_ap_resuming_write():

	if (*pos + len =3D=3D cfg_sz) {
		ret =3D do_post_copy_validation(mdev_name, ap_config);
		...
		mig_data->resuming_mig_state.ap_config =3D ap_config;
	}

If a short write occurs where len < sizeof(config), it appears ap_config is
allocated locally but not saved to mig_data because *pos + len =3D=3D cfg_sz
evaluates to false, causing a memory leak.

Then, if a subsequent write fetches the unsaved (NULL) pointer and passes it
to reallocate_ap_config():

	cur_cfg_sz =3D ap_config->config_sz;

Could this unconditionally dereference ap_config, causing a kernel crash?

Alternatively, if a full write is followed by an extra write,
reallocate_ap_config() executes krealloc(). If the bounds check fails and
cleanup frees the local ap_config pointer, does
mig_data->resuming_mig_state.ap_config still hold the freed pointer, leading
to a Double Free when vfio_ap_release_resuming_file() is called?

[Severity: Critical]
Is allocate_ap_config() allocating an undersized buffer if the input payload
is smaller than expected?

drivers/s390/crypto/vfio_ap_migration.c:allocate_ap_config() {
	...
	} else {
		config_size =3D len;
	}

	*ap_config =3D kzalloc(config_size, GFP_KERNEL_ACCOUNT);
	...
}

If userspace writes a payload strictly smaller than sizeof(struct
vfio_ap_config), and vfio_ap_resuming_write() considers the configuration
fully written, the undersized buffer is passed to do_post_copy_validation().

In queues_available_on_target_system():

	for (int i =3D 0; i < source_config->num_queues; i++) {
		apqn =3D source_config->qinfo[i].apqn;

Does this allow an out-of-bounds heap read based on the untrusted
and undersized config buffer?

[Severity: Critical]
Could the stack variable guest_matrix be used without initialization?

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_resuming_write() {
	...
	struct ap_matrix guest_matrix;
	...
		setup_ap_matrix_from_ap_config(mdev_name, ap_config,
					       &guest_matrix);
	...
}

In setup_ap_matrix_from_ap_config():

		if (!test_bit_inv(apid, guest_matrix->apm))
			set_bit_inv(apid, guest_matrix->apm);

It looks like guest_matrix is declared on the stack without being
zero-initialized, and setup_ap_matrix_from_ap_config() only sets individual
bits. Does this leave uninitialized bits in the apm, aqm, and adm bitmaps,
potentially granting the target guest hardware access to unauthorized AP
adapters and domains?

[Severity: High]
Are we missing the initialization of the config_sz field during the
STOP_COPY phase?

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_get_config() {
	ap_configuration =3D kzalloc(*ap_config_size, GFP_KERNEL_ACCOUNT);
	if (!ap_configuration)
		return -ENOMEM;

	ap_configuration->num_queues =3D num_queues;
	...
}

The allocation succeeds, but it doesn't look like
ap_configuration->config_sz is initialized before returning it to be copied
to user space. If this structure is transferred and the target host receives
config_sz =3D=3D 0, would a fragmented write on the target erroneously call
krealloc() to shrink the buffer to merely len bytes, breaking fragmented
migrations?

[Severity: High]
Is there a locking issue in vfio_ap_release_mig_file() that could lead to a
data race and Use-After-Free?

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_release_mig_file() {
	...
	if (!matrix_mdev || !matrix_mdev->mig_data)
		return -ENODEV;

	if (filp =3D=3D matrix_mdev->mig_data->stop_copy_mig_file)
		vfio_ap_release_stop_copy_file(matrix_mdev->mig_data);
	...
}

This accesses matrix_mdev->mig_data entirely locklessly. Since
vfio_ap_release_migration_data() and vfio_ap_transition_to_state() modify
and free this data under matrix_dev->mdevs_lock, could a concurrent close of
the migration file descriptor result in a Time-of-Check to Time-of-Use race?

If vfio_ap_release_mig_file() evaluates matrix_mdev->mig_data as valid but a
concurrent teardown thread kfrees it, would this result in a Use-After-Free
when dereferencing mig_data->stop_copy_mig_file?

[Severity: Medium]
Will vfio_ap_release_migration_data() leak ap_config when the device is
closed?

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_release_migration_data() {
	if (!matrix_mdev->mig_data)
		return;

	kfree(matrix_mdev->mig_data);
	matrix_mdev->mig_data =3D NULL;
}

This frees mig_data without cleaning up the dynamically allocated
mig_data->resuming_mig_state.ap_config buffer inside it.

Because the pointer is nulled, when VFS eventually drops the final reference
to the RESUMING migration file, vfio_ap_release_mig_file() will abort early
with -ENODEV. Will this bypass the kfree call within
vfio_ap_release_resuming_file() and permanently leak the allocated ap_config
memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707090226.3206=
695-1-akrowiak@linux.ibm.com?part=3D11
