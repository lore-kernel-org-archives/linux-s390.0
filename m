Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D5A2E7391;
	Fri,  7 Aug 2026 22:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142640; cv=none; b=dtah+ODDQR5RtMoWTGNnETSH+zfhakNgz4vEDR+FCVLPYa59IMRPMwB0ghSL83rj6JhG84nJfWKutFtlv6VGAioYbs0vJUppGIfh8qLgwpIzofxjzyPPwL/RWJwn/raRI6KmP3c0GEQhuCl2kSiSjxI2DKF8g0XQ4GV5wpoIiZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142640; c=relaxed/simple;
	bh=b0qnOMEDTER6F+M091lk2JNR3EPCfJNfB0vhwsWd2tQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hM5MVyoW+2SFOQXBjSiNOj5QsTcDT3LDphSYCrTyM8kZ4p0FMnqfcBfD0vyC/kuDhz7xLeiJE2i8Pu4dKGgW1zAsmWFtMS7jFrc8eeRthEACFHLP7/DLk9y56lu6Ad673tGbYOu4t+h4/UkTWR6sXWpPCj2Zl3b81tbdcj5j/rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LA6edz5Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA6edz5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A73B1F000E9;
	Fri,  7 Aug 2026 22:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786142638;
	bh=5nKl3p2LadtDDEfpJ+FbiPdLS//9jB9sSUWQJq2PY1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LA6edz5QL7jt8QzqpM0cphB2ummNU6pOZq+OXYHviIY3oG/U9SdbjEumJMcMsu6Lt
	 hAvFrQlMl+tBm/3Ar8QrUExs768O3auVFHLlh2/Bwj01J1XlFaOwtTq+or6AouwDFS
	 Nw/FEH+3FKcQOz0AcQO83b1Pz0lf07EbXsKvdJ79yxwbHSM59T0nU11KPPCh/cIhkC
	 QB4dY79uZzHU5I4YzNR5ezTtW7lzSA4XeQ0jNlqQ2h7KXJuXRitkFd9MqvAZEpudPW
	 yYwdUzrkDA4g3++mwRsjCC2efEXo/y1sW/8tknMl4mE512fHQivtPA3QVuTIteTyPs
	 lAJy0x9RISAtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/15] s390/vfio-ap: Transition device migration
 state from STOP to RUNNING and vice versa
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260807221834.562851-13-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-13-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 22:43:57 +0000
Message-Id: <20260807224358.3A73B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The vfio_ap_set_state callback incorrectly returns success when at=
tempting to change state while the device is in the VFIO_DEVICE_STATE_ERROR=
 state.
- [High] Missing cleanup of the migration state buffer (ap_config) when mig=
ration is cancelled or completes without a device reset, leading to stale d=
ata on subsequent migrations.
- [Medium] The transition from VFIO_DEVICE_STATE_RUNNING to VFIO_DEVICE_STA=
TE_STOP does not actually halt the physical AP queues, violating the VFIO m=
igration specification.
--

--- Patch [12]: [PATCH v7 12/15] s390/vfio-ap: Transition device migration =
state from STOP to RUNNING and vice versa ---
commit 17303c3774ef0d4972c24647246d0a4f7d6c4f04
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Transition device migration state from STOP to RUNNING and vi=
ce versa

This patch implements the state transitions between VFIO_DEVICE_STATE_STOP =
and
VFIO_DEVICE_STATE_RUNNING for the vfio-ap device. It assumes there is no
internal device state to incorporate and returns success for these transiti=
ons.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 30160e3dddedd..24955f70e13e2 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -1524,12 +1524,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev=
 *matrix_mdev,
>  		return NULL;
>  	}
> =20
> +	/*
> +	 * These states indicate migration has either not been initiated or
> +	 * has completed and the vfio-ap device is operating normally. Since the
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

[Severity: Medium]
Does the transition from VFIO_DEVICE_STATE_RUNNING to VFIO_DEVICE_STATE_STOP
need to halt the physical AP queues?

Since the physical AP queues are not reset (e.g., via
vfio_ap_mdev_reset_queues) during this transition, could asynchronous
requests in flight continue executing?

If they complete, they might post adapter interrupts to the KVM GISA after
the guest state has been saved, altering external state and leading to lost
interrupts on the destination.

[Severity: High]
Does the transition from VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RUNNING
miss cleaning up the migration state buffer?

If a migration is cancelled, transitioning from STOP to RUNNING now returns
success but doesn't call vfio_ap_release_mig_files() to free ap_config.

On a subsequent migration attempt, vfio_ap_stop_copy_read() will see the
non-NULL ap_config and send the stale configuration instead of capturing a
fresh one:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_stop_copy_read() {
    ...
	if (!mig_file->ap_config) {
		ret =3D vfio_ap_get_config(matrix_mdev);
    ...
}

>  	}
> =20
>  	/* vfio_mig_get_next_state() does not use arcs other than the above */

[Severity: High]
With these new state transitions, does vfio_ap_set_state() still handle the
VFIO_DEVICE_STATE_ERROR state correctly?

If a migration error occurs and the device enters VFIO_DEVICE_STATE_ERROR,
userspace might attempt to transition to another state like STOP or RUNNING.

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_set_state() {
	struct file *filp =3D NULL;
    ...
	while (mig_data->mig_state !=3D VFIO_DEVICE_STATE_ERROR &&
	       mig_data->mig_state !=3D new_state) {
        ...
		filp =3D vfio_ap_transition_to_state(matrix_mdev, next_state);
    ...
	return filp;
}

If mig_state is VFIO_DEVICE_STATE_ERROR, the loop condition is false,
bypassing the transition logic. Because filp is initialized to NULL, the
function returns success instead of rejecting the transition.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807221834.5628=
51-1-akrowiak@linux.ibm.com?part=3D12
