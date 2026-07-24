Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D2E2E7F2C;
	Fri, 24 Jul 2026 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784914510; cv=none; b=fduWQ1AhJxhHe+u/WwbEEKy1PkOta5HqL8+Sph1+o/3gRIHUX1sG5wsizGsSaCxY9LeWk6YQhJlVymYjuT0S0UAQU0FLuGVgXNPfp2GrccXuI8eVFK42DUTTBMYBQjiBiDQkz6u2YsbmtHfg3U6Wn9jab+sSyvS219+9fgsvGxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784914510; c=relaxed/simple;
	bh=eTBXV4cXfp0haLEnyQYyYwugSrrwDPcFFEYrLB1Tc3g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R6ZoG3qh2KmUPyI6Mmp5NLjiKtWG+cnwlyo3ktcPznbg6JbHfkkxKeg/KCrBKgWWh+6jLOg/tK+ODgofNawCAV7xLAFnHn0hmB94VwBHMUCY9+Ip5YQHZYLRe94yb4PX6qqIBBeKt4X61G48Bu2zKyInc6zaW77ITz9nmaD8sZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLRxljyi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLRxljyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7F11F000E9;
	Fri, 24 Jul 2026 17:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784914508;
	bh=BC5bxp3bkyH9p+5b04W6vW0JNX48QrQbyUwRJ2M3VPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GLRxljyiCE3TX5OXOWwbvNCHkLIYKRcA6wMtfffSB51+5WhNMfVFtHuc9mjShs8Y5
	 pSN8gKHdIxiRoofOaUgAcpJ9lvqy6nsf7x8+Ob0x6HdTycx5hqa4v+q8/lTCbnENLv
	 YZMTlZVjX6/mstXOnb4dDAAYxwHJfoiNJdO9K7QO1uezwMkD7FF1qlJS1p2vpcO01M
	 x4GFSWpwBdh4cmnUCsCBgtqkVfQ+dtK3sDBVc0pK6kp0GrxD/Kvx84g/yTyOMj7ovC
	 2CMXx5bCCXNsyjdmt1vuRLdgsy5MvvnLJnszLsaypeoeCwq6C7OZoJAvnvCv0IDuLG
	 D7N6edg12lWPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/15] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260724161351.1802644-4-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
 <20260724161351.1802644-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 17:35:07 +0000
Message-Id: <20260724173508.5E7F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] ABBA deadlock (circular locking dependency) between `matrix_dev->m=
devs_lock` and the VFIO core's `dev_set->lock`.

Pre-existing issues:
- [Critical] Failing to attach a second mdev to a KVM instance corrupts `kv=
m->arch.crypto.pqap_hook`, leading to a Use-After-Free.
--

--- Patch [3]: [PATCH v5 03/15] s390/vfio-ap: Functions to initialize/relea=
se vfio device migration data ---
commit ab0b2af7d9f1c49f7cea7a7d2157bcc5a0bb9b7a
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Functions to initialize/release vfio device migration data

Provides the functions that initialize and release the data structures
used during live guest migration:

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 71d3e2c2e07c6..47aca908701d1 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> @@ -797,18 +809,29 @@ static int vfio_ap_mdev_probe(struct mdev_device *m=
dev)
>  	if (IS_ERR(matrix_mdev))
>  		return PTR_ERR(matrix_mdev);
> =20
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +
> +	/*
> +	 * Migration capabilities must be initialized before calling
> +	 * vfio_register_emulated_iommu_dev; otherwise, the VFIO core
> +	 * will see mig_ops as NULL during the registration. This could
> +	 * prevent the VFIO core from properly setting up migration
> +	 * infrastructure like debugfs entries.
> +	 */
> +	vfio_ap_init_migration_capabilities(matrix_mdev);
> +
>  	ret =3D vfio_register_emulated_iommu_dev(&matrix_mdev->vdev);

[Severity: High]
Does taking mdevs_lock before calling vfio_register_emulated_iommu_dev()
introduce an ABBA deadlock?

In vfio_ap_mdev_probe(), we now hold mdevs_lock when calling
vfio_register_emulated_iommu_dev(), which takes dev_set->lock inside the VF=
IO
core via vfio_assign_device_set().

However, in vfio_ap_mdev_open_device() below, which is called by the VFIO c=
ore
with dev_set->lock already held, we now acquire mdevs_lock.

Will this reverse lock ordering trigger a lockdep circular dependency splat
when userspace probes and opens the device?

[ ... ]
> @@ -2052,19 +2075,39 @@ static int vfio_ap_mdev_reset_qlist(struct list_h=
ead *qlist)
> =20
>  static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
>  {
> -	struct ap_matrix_mdev *matrix_mdev =3D
> -		container_of(vdev, struct ap_matrix_mdev, vdev);
> +	struct ap_matrix_mdev *matrix_mdev;
> +	int ret;
> =20
>  	if (!vdev->kvm)
>  		return -EINVAL;
> =20
> -	return vfio_ap_mdev_set_kvm(matrix_mdev, vdev->kvm);
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +	matrix_mdev =3D container_of(vdev, struct ap_matrix_mdev, vdev);
> +	ret =3D vfio_ap_init_migration_data(matrix_mdev);
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	if (ret)
> +		return ret;
> +
> +	ret =3D vfio_ap_mdev_set_kvm(matrix_mdev, vdev->kvm);

[Severity: Critical]
This is a pre-existing issue, but I noticed that if vfio_ap_mdev_set_kvm()
fails (for instance, returning -EPERM because another mdev is already attac=
hed
to this KVM), does it leave kvm->arch.crypto.pqap_hook pointing to the new
mdev's pqap_hook?

Looking at vfio_ap_mdev_set_kvm() in drivers/s390/crypto/vfio_ap_ops.c, it
unconditionally overwrites KVM's pqap_hook before checking if another mdev =
is
already attached:

	down_write(&kvm->arch.crypto.pqap_hook_rwsem);
	kvm->arch.crypto.pqap_hook =3D &matrix_mdev->pqap_hook;
	up_write(&kvm->arch.crypto.pqap_hook_rwsem);
=09
	get_update_locks_for_kvm(kvm);
=09
	list_for_each_entry(m, &matrix_dev->mdev_list, node) {
		if (m !=3D matrix_mdev && m->kvm =3D=3D kvm) {
			release_update_locks_for_kvm(kvm);
			return -EPERM;
		}
	}

If this fails with -EPERM, the pointer is not restored. If this new mdev is
subsequently closed and freed, could a malicious guest executing a PQAP
instruction trigger a use-after-free in the host when handle_pqap()
dereferences this freed pointer?

> +	if (ret) {
> +		/* Clean up migration data on failure */
> +		mutex_lock(&matrix_dev->mdevs_lock);
> +		vfio_ap_release_migration_data(matrix_mdev);
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +	}
> +
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724161351.1802=
644-1-akrowiak@linux.ibm.com?part=3D3
