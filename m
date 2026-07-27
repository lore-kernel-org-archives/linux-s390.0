Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A1A4314AE;
	Mon, 27 Jul 2026 18:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176934; cv=none; b=gybHVjf/PhQEs5jFcuilxk9oZlp98byKEI8PjqyQ5+3xh0cRRckSOw9MCv3BOls35jH/WOnQd1ElnX4kK094ArGshQ7FZowEG+es7hr6A3RrD0xfjUCSGq15trrbk8WwAhiw0MLV+N7I2n9OPai/5bHt7+ctUSuav3oJndrMzzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176934; c=relaxed/simple;
	bh=7JdENFOk+aoCCqT+Vk0D3s6afaKovGXoJuJfcVuyAeY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=doNQxI+9N/PR6EO6epyIwWzg6K0Qf5clytckZoNLRuAPMrF3zGBpefFl5d0AqgOqiw5CBEPggQIATOGDWNuKZkfsxqIY92IVU163FdZ8eD74R0Z1JG6ZgiGlbFtkBJaCNTkr6TqCABKHVCj0QJQUjXq0qmh9WcTTFwzbm83p0vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2wobdMq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2wobdMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF2A1F000E9;
	Mon, 27 Jul 2026 18:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785176933;
	bh=/vBVtVoYCG+H6IHcqOkaswvrR3mVzpP9mR8NQ/P066k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B2wobdMqvyhO84vhKE2VncQXh+MRvZmTldmeNc5/rVJ5jLnssA/F8mJRKGWInhDx4
	 djlE2sNFs2SfASlQc0c0bsrKjOqf8RlCcnF/Sla/4Nv6KR1BlYO9OjkINgg4U5Li8K
	 ZMjDaOh/BMJDM58GXRE8KfmHw66fbHw+JCSoSXrGXMSuJK6x6RLKmPdk8JQD1Srukz
	 sRpd8/spRTZWIlTDwY5JQKxvxnxaxHnOF7uhcXJX+nD3gB7WnshxrSnBuk5lnN4n7A
	 HChCtV1689UvFIpkuZq42njT7CAW36kN4BddXj60KIn7XRVFDJ7t7TnKFyC0Yw9Ty5
	 Kv07bw3H97LWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/15] s390/vfio-ap: Transition device migration
 state from STOP to RUNNING and vice versa
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260727173239.2420754-13-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-13-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:28:52 +0000
Message-Id: <20260727182852.ABF2A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Concurrent device reset, closure, or state transitions during =
migration data transfer cause Use-After-Free or Write-After-Free of `ap_con=
fig`.
- [High] Overwriting the active migration file descriptor during state tran=
sitions allows silent migration of stale state and leaks file references.
--

--- Patch [12]: [PATCH v6 12/15] s390/vfio-ap: Transition device migration =
state from STOP to RUNNING and vice versa ---
commit 2b837152c9f64c5082507b5aa41ffc56027c1e29
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Transition device migration state from STOP to RUNNING and vi=
ce versa

The transition from STOP to RUNNING and vice versa indicates that
the vfio device is operating normally and migration is not
currently taking place. In this case, just set the new state.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index fc4cb893f0f00..1c385908fc39b 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -1280,12 +1280,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev=
 *matrix_mdev,
[ ... ]
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

[Severity: High]
Does returning NULL here instead of -EOPNOTSUPP allow userspace to silently
leak the active migration file and state?

If a live migration is aborted and transitioned gracefully from STOP to
RUNNING, the old file descriptor could remain active in mig_data because
the driver still holds a reference to the file.

If the process later starts a new migration and transitions to STOP_COPY
again, it looks like vfio_ap_transition_to_state() unconditionally
overwrites mig_data->stop_copy_mig_file.filp:

vfio_ap_transition_to_state() {
    ...
    if (cur_state =3D=3D VFIO_DEVICE_STATE_STOP &&
        new_state =3D=3D VFIO_DEVICE_STATE_STOP_COPY) {
        ...
        mig_data->stop_copy_mig_file.filp =3D filp;
        return filp;
    }
    ...
}

Will this cause the driver's reference to the old file to be permanently lo=
st?

If the old fd is read, vfio_ap_stop_copy_read() might observe that
mig_file->ap_config is already populated and skip updating it, serving
stale configuration to the target.

Additionally, when userspace closes the old fd, its release handler might
fail to match the overwritten filp pointer, which would skip
vfio_device_put_registration() and permanently pin the device.

[Severity: Critical]
With these new state transitions, is there also a risk of use-after-free or
write-after-free regressions during concurrent migration data transfers?

If a userspace process calls read() or write() on the migration file
descriptor, mdevs_lock is temporarily dropped during the data copy:

vfio_ap_stop_copy_read() {
    ...
    mutex_unlock(&matrix_dev->mdevs_lock);

    if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len))
    ...
}

Similarly in vfio_ap_resuming_write():

vfio_ap_resuming_write() {
    ...
    mutex_unlock(&matrix_dev->mdevs_lock);

    if (copy_from_user((char *)ap_config + write_pos, buf, len)) {
    ...
}

Can a concurrent thread issue a VFIO_DEVICE_RESET ioctl, close the
device fd, or trigger a state transition that acquires mdevs_lock and
frees ap_config and mig_data?

If so, when the read/write thread resumes execution, it appears it
would access the freed ap_config memory, leading to arbitrary kernel
memory corruption or information leaks.

>  	}
> =20
>  	/* vfio_mig_get_next_state() does not use arcs other than the above */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727173239.2420=
754-1-akrowiak@linux.ibm.com?part=3D12
