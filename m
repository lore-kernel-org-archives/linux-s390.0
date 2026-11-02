Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635563;
	b=Yp/7wPHkiyxU8uMnQoeEYtGuHh4Mh41t/w+4/T4JHibvZCTIE9wVVvRctTQae9fyvXHM
	 gPuR24rkTDwUdnoEIUc/uSn59ywrRXGU9aYaUQPIiqYPADqpRUmp0s8isLkMnwvegiRSY
	 Un1vZNfOV3N8Kr/b3lVoDgml6na/CCXEh6LDoM3QLZvdm7D+MKrhU1RzQqoPmLOz3Mcub
	 kmLwvfsNb8/qgVxqt1Ne8hBjZvj/+dhvfUZx9e7jKmPulllA5H5jmMNjaYQHZcysx9yuu
	 0mArmpxjJK0YEnyeBELK3zzbLcALAYu3VCR9JL92vJrroA99OPAb3LrnfLYWJzTaRjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635563;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fGIjv7+ClkyzsZi+PiXqyWBl1KyJDxmbo8u1P+J448k=;
	b=xWgPufN3GtAZBDm1ZvB3eDBequt1rlMCsGqlreZbXDQkXp0HY1nfutS1FIKiU2xTM6fR
	 LxACLFpqFWSTCGQ0hPErFBGUUnscABwZ+4eE10FF1yTyOmM9qD/itATVlruA5yM96+jvr
	 Fd9n+vjbETl/3nyWN5gQoSKpt75a/phjjAaS54u+oGQOgB0RtbL+5nnA4Co5lURRABQHh
	 voopJRKxSKI/h32CSC2vme4mSx0u01PL/z8LeJQ2581pJ3HTj9AaHI7vo2+HbcQuleO5s
	 86+zBci7vqka5e5VvkIs/ZGZ0PqUm4bxDjqbnVJa33kfQNT/F9D8TkVGjyeIyEzizqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhvKAGh0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2B360703B9;
	Mon,  2 Nov 2026 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhvKAGh0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4CD1F00A16;
	Mon,  2 Nov 2026 16:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793635562;
	bh=fGIjv7+ClkyzsZi+PiXqyWBl1KyJDxmbo8u1P+J448k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NhvKAGh0AT2PDfnJ8mF7gavRaL6r8E+jxoPeA89+gnQ9Q0ByVw8vcnqpZn/2EGFs6
	 6aHA8BUFp4BMteJZEs99+eAaJ4wEsUFep0bUgGY9SSql5CXIBkMeVpBzHdV5y6Y8V0
	 SS11BLrDk9ZTAMS7v0ntF8vfs5T/y4ql4KUuBua0dFnmgDxM9MEhmBnccyXqJlv3sm
	 s/YBzmyK7pv11wTGL6LOnYktGOFH0SCptHIxB4LL0etJXQLCtvX/QWaFpEaRU9MTMY
	 uD8EGvd5gDgRFzO9cpFF0cHadMoXR0yW3gmZ2XJcoNzaitjnTGsrEZNoHbRYq6Ucm3
	 beVzUw3IlV8Rg==
Message-ID: <sashiko-outbox-193730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 05/14] s390/vfio-ap: Callback to get/set vfio device
 mig state during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261102151604.2150055-6-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 16:06:01 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] s390/vfio-ap: wrong SE guest check for migration in vfio_ap_set_=
state()
--

commit 02c085ad3d72e0ded4762a0989bd8c4480446385
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Callback to get/set vfio device mig state during guest migrat=
ion

This commit implements the vfio_ap_set_state() and vfio_ap_get_state()
migration callbacks and defines vfio_ap_migration_ops for vfio-ap mediated
devices.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 6bcb910526c9e..8e4e04e039658 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -143,6 +143,150 @@ static void vfio_ap_release_resuming_file(struct vf=
io_ap_migration_data *mig_dat

[ ... ]

> +static struct file *vfio_ap_set_state(struct vfio_device *vdev,
> +				      enum vfio_device_mig_state  new_state)
> +{
> +	int ret;
> +	struct file *filp =3D NULL;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	enum vfio_device_mig_state next_state;
> +	struct vfio_ap_migration_data *mig_data;
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +
> +	matrix_mdev =3D container_of(vdev, struct ap_matrix_mdev, vdev);
> +	mig_data =3D matrix_mdev->mig_data;
> +
> +	/*
> +	 * The mig_data pointer is set in the vfio_ap_init_migration_data
> +	 * function which is called when the vfio-ap device fd is opened.
> +	 * Since the implicit pre-open state is RUNNING, a request to set
> +	 * RUNNING is a no-op. Any other state transition is invalid before
> +	 * open_device.
> +	 */
> +	if (!mig_data) {
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		if (new_state =3D=3D VFIO_DEVICE_STATE_RUNNING)
> +			return NULL;
> +		return ERR_PTR(-ENODEV);
> +	}

[Severity: Medium]
Does vfio_ap_set_state() allow migration state transitions for Protected
Virtualization (Secure Execution) KVM guests?

In vfio_ap_init_migration_data(), the check intended to skip initializing
migration data for SE guests calls ap_is_se_guest():

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_init_migration_data() {
	/*
	 * Live guest migration is not supported for SE guests, so there is no
	 * need to initialize the migration data.
	 */
	if (ap_is_se_guest())
		return 0;
}

However, ap_is_se_guest() in drivers/s390/crypto/ap_bus.c checks whether the
running host kernel itself is a Protected Virtualization guest:

bool ap_is_se_guest(void)
{
	return is_prot_virt_guest() && ap_sb_available();
}

On a KVM host, is_prot_virt_guest() is false, so ap_is_se_guest() always
evaluates to false and matrix_mdev->mig_data is unconditionally allocated
when vfio_ap_mdev_open_device() calls vfio_ap_init_migration_data().

In addition, a KVM guest only enters Protected Virtualization mode later
during guest boot via kvm_s390_pv_init_vm(), after open_device and
vfio_ap_mdev_set_kvm() have already run. Because vfio_ap_set_state() only
checks !mig_data and does not check whether matrix_mdev->kvm is a protected
guest (for example via kvm_s390_pv_is_protected(matrix_mdev->kvm)), wouldn't
migration state transitions be permitted on SE guests?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102151604.2150=
055-1-akrowiak@linux.ibm.com?part=3D5
