Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B37346AD6;
	Tue, 30 Jun 2026 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820139; cv=none; b=QyKSVdAVpNuR4SqQ3RfSpEzG5W3AHjMRn0ciLfVyqi3mKTkWJvv+M92NdArpDfPYGlR9RUtf2OTgdoy4v5bYPtU2wFKU2mld0/BXfIf9rW4AIkIWdzhNwG2zhePPbNbkOpTuJ3Zj0Hk0RDgrDHE4c8LcXg+H41JksvdJQ+hEaQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820139; c=relaxed/simple;
	bh=OgmCjS6pgSchaBHCHg7VL6stYmdSppyZI8BZMbnXHYI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UIjP13Bp+Zr9bw5JenZP6UZE5/OVOAmtWhapaQp+GyaG2iR06XGj/ahdTsda2sAG3x6A8BHshRTLIYiIk57CIPPFMtFF3u7bYzMMyLb8lCaN8/q5i4AnYuCnZxmzZkbS9sCe8WtaoniRXZasFSON3eBSpb2ibTkvkctk5cFtrwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajHrzUyb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajHrzUyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26E71F000E9;
	Tue, 30 Jun 2026 11:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782820138;
	bh=3TwUGXL3du4bm8TSviGU7N1KPCBTbk+vt7b/ldYru7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ajHrzUybC/NJMBAyZ/ofFKT1sDivt8woJQr2x5rVOSixlrQ9HM5bf5h2AA0FtO1lK
	 dMRmUWtOa8UPrvl7o0nOrV3+TNVREp0gVpkpUUL2cSH27TZEVfeHkI0bIoOHfkjQ7I
	 tGk6gDC0RV1b93gmVspUyA0Op7sPzG1tvt5WHGQNmGQxd1DGKsS8eIVckxhdYPb4W6
	 g5ZSR+sK9GE7MTK6DxSkH4tnJUiGfzZGGKpREVUZwBt7jzliCIdmXB3lw+EA3Ro90a
	 3FoXS6RPk3cXQ+PN9iYuP0gRL1Gzx2ANBtsrxkvgvv8kEZrIa8hbrMXKaKOWk4kUan
	 solujumpXjKjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/15] s390/vfio-ap: Transition device migration
 state from STOP to RUNNING and vice versa
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260630104132.1598851-13-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
 <20260630104132.1598851-13-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:48:57 +0000
Message-Id: <20260630114857.B26E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Transitioning the VFIO AP device from RUNNING to STOP state does n=
ot quiesce or reset the underlying AP queues, potentially allowing hardware=
 to modify guest memory asynchronously.

Pre-existing issues:
- [Critical] Writing a chunk smaller than `sizeof(struct vfio_ap_config)` t=
o the resuming file allocates an undersized buffer, triggering an out-of-bo=
unds read during validation.
- [Critical] A partial initial write to the vfio-ap migration resuming stre=
am file skips saving the configuration pointer, leading to a memory leak an=
d a subsequent NULL pointer dereference.
- [Critical] Error paths after a successful initial write double-free the c=
onfiguration pointer, or leave a dangling pointer leading to a Use-After-Fr=
ee.
- [High] The function `vfio_ap_resuming_write` conditionally unlocks a glob=
al mutex using `mutex_is_locked()`, incorrectly dropping the lock when held=
 by other threads and corrupting mutex state.
- [High] The driver allocates large, potentially fragmented user-controlled=
 memory chunks using `kzalloc()`, leading to unreliable device migration.
--

commit a3f4b819ba0ee66ec445b971234644e51eeab7e9
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Transition device migration state from STOP to RUNNING and vi=
ce versa

This commit updates the device migration state transitions to handle the
transition from STOP to RUNNING and vice versa. It treats these state
changes as a normal operation state where no internal device state needs
to be migrated.

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
Does returning NULL here safely quiesce the underlying AP queues when
transitioning from RUNNING to STOP?

The VFIO migration specification requires that when a device transitions to
the STOP state, it must cease processing commands, generating interrupts, a=
nd
writing to guest memory. If the queues are not stopped or reset during a
RUNNING to STOP transition, the hardware may continue to modify memory after
the page is migrated, which could result in missed completion events.

>  	}
> =20
>  	/* vfio_mig_get_next_state() does not use arcs other than the above */

[Severity: Critical]
This is a pre-existing issue, but can writing a small chunk to the resuming
file lead to an out-of-bounds read?

If userspace writes a chunk smaller than the configuration struct size,
allocate_ap_config() appears to allocate an undersized buffer:

drivers/s390/crypto/vfio_ap_migration.c:allocate_ap_config() {
    ...
    *ap_config =3D kzalloc(config_size, GFP_KERNEL_ACCOUNT);
    ...
}

If this data is copied and triggers early validation in
vfio_ap_resuming_write():

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_resuming_write() {
    ...
    if (*pos + len =3D=3D cfg_sz) {
        ret =3D do_post_copy_validation(mdev_name, ap_config);
    ...
}

Could this result in do_post_copy_validation() reading past the allocation
since the buffer was sized based on the short length rather than the full
struct?

[Severity: Critical]
This is a pre-existing issue, but does a partial initial write skip saving
the configuration pointer?

In vfio_ap_resuming_write(), if the initial write does not equal the full
configuration size, it seems to jump to done without saving the newly
allocated ap_config:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_resuming_write() {
    ...
    ret =3D len;
    *pos +=3D len;
    goto done;

cleanup:
    kfree(ap_config);
    ...
}

If a subsequent write occurs, reallocate_ap_config() might dereference a
null pointer because the pointer was never saved during the first partial
write:

drivers/s390/crypto/vfio_ap_migration.c:reallocate_ap_config() {
    ...
    struct vfio_ap_config *ap_config =3D *mig_ap_config;
    ...
    cur_cfg_sz =3D ap_config->config_sz;
    ...
}

Could this sequence lead to a memory leak and a null pointer dereference?

[Severity: Critical]
This is a pre-existing issue, but can error paths in vfio_ap_resuming_write=
()
cause a double-free or use-after-free?

If an additional write triggers an error, the code jumps to cleanup and fre=
es
ap_config:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_resuming_write() {
    ...
    ret =3D reallocate_ap_config(&ap_config, len);
    if (ret < 0)
        goto cleanup;
    ...
cleanup:
    kfree(ap_config);
    ...
}

However, the persistently tracked pointer in resuming_mig_state is not
nullified. When the file is released, the pointer is freed again:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_release_resuming_file() {
    ...
    kfree(mig_data->resuming_mig_state.ap_config);
    mig_data->resuming_mig_state.ap_config =3D NULL;
    ...
}

Does this leave a dangling pointer that gets double-freed when the file is
closed?

[Severity: High]
This isn't a bug introduced by this patch, but does vfio_ap_resuming_write()
incorrectly unlock the global mutex if it is held by another thread?

At the end of the write operation, the function conditionally unlocks the
mutex:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_resuming_write() {
    ...
done:
    if (mutex_is_locked(&matrix_dev->mdevs_lock))
        mutex_unlock(&matrix_dev->mdevs_lock);
    ...
}

Since mutex_is_locked() checks if the lock is held by any thread, not just
the current thread, could this cause the current thread to erroneously unlo=
ck
it when it is safely held by a completely different thread?

[Severity: High]
This is a pre-existing issue, but is kzalloc() safe for large allocations
when getting the AP configuration?

Both allocate_ap_config() and vfio_ap_get_config() use kzalloc() for memory
that can exceed 1MB depending on the user-supplied queue length:

drivers/s390/crypto/vfio_ap_migration.c:allocate_ap_config() {
    ...
    *ap_config =3D kzalloc(config_size, GFP_KERNEL_ACCOUNT);
    ...
}

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_get_config() {
    ...
    ap_configuration =3D kzalloc(*ap_config_size, GFP_KERNEL_ACCOUNT);
    ...
}

Since this requires large contiguous physical chunks, could this lead to
sporadic ENOMEM failures due to memory fragmentation? Would it be more
reliable to use kvzalloc() here since contiguous physical pages are not
strictly required for staging buffers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630104132.1598=
851-1-akrowiak@linux.ibm.com?part=3D12
