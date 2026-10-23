Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779291;
	b=31Etuc2gKS5BTAw8GyCCb3eBu95bR3I5AB8hqQsyOUoLmgzfVdDbxYWX9jLne9zdgjjz
	 9dFtFJreHhxTdFHweqqJkAWNhr7Zi0Z/9657fnt2lu22n7htw8c2I4sGfH4iHinpMq0bn
	 UhbC3DBHJAsp7o0MRt7AJy6C0wlujqAXOlkrqz7wnuUGHAAQ9T5+UFIMdZw/2WIjeHBBW
	 U69Z8mozkfMSlCzYnBgpiW3UnyPvbgLmNniNKHWsZIaN0/0eAz62VLnklodNViCEsHx2M
	 +QOfML9ZQPxEv8XO1m81JQBdCxnlFKXJg8QNga66RT57NOUyJjr6fT1reyVzRes+uLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779291;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=urb7nVS7/vLoHFbpZu2h6Y3OA5TyfPPeWx7Wbr2knCQ=;
	b=ZO4mR65wDFydKL5KkWXJTSET0/i1qY4WlRUkdKUZGeaL5MNSsPhrqyu7fF9Ywi6Bj3M6
	 luwXdhM1kC1q5+NiuAfjVTZY2910s41rWmH/ZpJiYTK/ISJ1bcFduAjNqSkGI8ESAdv5Y
	 qL7bbi0Qq/zbNZbmXCl0EEp13i2q+8GaussOzbMBfdA4pW4qsLmC0EwjKWfkWbyeo24QB
	 7Omud8kP4Ba/0lAu9m24L46xAFgk1+69yWLs6g846p8+r5CP6zyb902a334SiVTFBe7Ho
	 NGLaKqmV5HsSPU13a69yg74w/xjtKVTqS6BoIPW1pt6WXLhoxhdozqbYo/gkoEjhVXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E/6yWHM1";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207CE606A31A;
	Fri, 23 Oct 2026 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/6yWHM1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF3C1F01825;
	Fri, 23 Oct 2026 18:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779290;
	bh=urb7nVS7/vLoHFbpZu2h6Y3OA5TyfPPeWx7Wbr2knCQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E/6yWHM1bDuWElYKD7EwojiinzWdMCcSxLdO30H9F4haq/DWMpxtw8hfidJyXT62b
	 d9dNsABHaqERSkMNM/MS8x7gKwcCYn3GT9G/bH6Fd/RiU8wQGyQnNIsi009kCc2teW
	 +IKNXD0UZA5nqbHyo1WcUEdNqjmhLuBrmbN5MfFkQFwAQNoySvcreGY3iitsDMIW2p
	 qfpanzx/o+JXU2lTyCavfaivDnDhiDjQGZCz2i2+llHLcW0YxgF4Yx0L8c9l4/e3sk
	 Fmi8Stw4AUe5rZQ9S9Av59+XEHAUsBpRYNIa0piVAIr2GRzz4gdOeGJC8bM4M3qLVq
	 YsOEuww5YF8dQ==
Message-ID: <sashiko-outbox-183054@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 13/15] s390/vfio-ap: Set up for vfio-ap device
 migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023174349.3545941-14-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-14-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 18:14:49 +0000
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
- [High] s390/vfio-ap: wrong SE guest check via ap_is_se_guest() on KVM host
- [Medium] s390/vfio-ap: stale completion flag and f_pos advance in vfio_ap=
_resuming_write()
--

commit 7adada8cbaf0b3057bf058ad4617540b9cea4ec9
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Set up for vfio-ap device migration

This commit wires up VFIO migration operations and sets the
VFIO_MIGRATION_STOP_COPY flag on the vfio-ap mdev during device probe to
enable live migration support.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 38098968eaa2c..660b5a21fe9e8 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -212,6 +212,30 @@ static int vfio_ap_release_mig_file(struct inode *fi=
le_inode, struct file *filp)
>  	return 0;
>  }
> =20
> +static const struct vfio_migration_ops vfio_ap_migration_ops;
> +
> +/**
> + * vfio_ap_setup_vfio_device_migration:
> + *
> + * Plug the object containing the function pointers to the migration cal=
lbacks
> + * required to facilitate VFIO AP migration into the mdev
> + *
> + *
> + * @matrix_mdev: pointer to object containing the mdev state
> + */
> +void vfio_ap_setup_vfio_device_migration(struct ap_matrix_mdev *matrix_m=
dev)
> +{
> +	/*
> +	 * Live guest migration is not supported for SE guests, so there is no
> +	 * need to initialize the migration capabilities.
> +	 */
> +	if (ap_is_se_guest())
> +		return;

[Severity: High]
Does calling ap_is_se_guest() here and in vfio_ap_init_migration_data()
actually detect a Secure Execution guest on the KVM host?

In drivers/s390/crypto/ap_bus.c, ap_is_se_guest() checks whether the
currently running kernel is itself a Protected Virtualization guest:

bool ap_is_se_guest(void)
{
	return is_prot_virt_guest() && ap_sb_available();
}

Since vfio_ap runs in the KVM host kernel where is_prot_virt_guest() is
always false, ap_is_se_guest() will always evaluate to false on the host.

Furthermore, at vfio_ap_mdev_probe() -> vfio_ap_setup_vfio_device_migration=
()
time, matrix_mdev->kvm is still NULL, and a guest only enters Protected
Virtualization mode at runtime via KVM_S390_PV_COMMAND. Should the SE guest
check instead be performed dynamically against matrix_mdev->kvm via
kvm_s390_pv_is_protected() when handling migration state transitions in
vfio_ap_set_state() or vfio_ap_transition_to_state()?

> +
> +	matrix_mdev->vdev.migration_flags =3D VFIO_MIGRATION_STOP_COPY;
> +	matrix_mdev->vdev.mig_ops =3D &vfio_ap_migration_ops;
> +}

[Severity: Medium]
Now that vfio_ap_migration_ops is wired up and exposes the migration stream
and state transitions to userspace, can vfio_ap_resuming_write() leave
resuming_mig_data_complete set to true or leave filp->f_pos advanced when a
write fails?

In drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_resuming_write():

	memcpy((char *)ap_config + *pos, kbuf, len);
	*pos +=3D len;

	if (*pos >=3D offsetofend(struct vfio_ap_config, num_queues)) {
		size_t expected_sz;

		if (ap_config->num_queues > MAX_AP_QUEUES) {
			ret =3D -EINVAL;
			goto out_unlock;
		}

		expected_sz =3D sizeof(struct vfio_ap_config) +
			      ap_config->num_queues *
			      sizeof(struct vfio_ap_queue_info);

		if (*pos > (loff_t)expected_sz) {
			ret =3D -EINVAL;
			goto out_unlock;
		}

		if (*pos =3D=3D (loff_t)expected_sz) {
			ret =3D do_post_copy_validation(matrix_mdev, ap_config);
			matrix_mdev->mig_data->resuming_mig_data_complete =3D !ret;
		}
	}

If userspace writes a valid payload where *pos =3D=3D expected_sz,
resuming_mig_data_complete is set to true. If userspace then issues an extra
write to the resuming FD before transitioning to VFIO_DEVICE_STATE_STOP, the
extra bytes are copied into ap_config, *pos is incremented past expected_sz,
and the function returns -EINVAL without clearing resuming_mig_data_complet=
e.
A subsequent transition from VFIO_DEVICE_STATE_RESUMING to
VFIO_DEVICE_STATE_STOP in vfio_ap_transition_to_state() only checks
mig_data->resuming_mig_data_complete and will still succeed.

Also, when any of the checks on num_queues, expected_sz, or
do_post_copy_validation() fail, *pos has already been incremented even thou=
gh
vfio_ap_resuming_write() returns an error. Should the validation happen
before advancing *pos and clear resuming_mig_data_complete on error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023174349.3545=
941-1-akrowiak@linux.ibm.com?part=3D13
