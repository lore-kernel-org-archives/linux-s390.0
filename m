Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2551480942;
	Wed, 12 Aug 2026 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555704; cv=none; b=m5O+nAY61hUquAljwvcZZCL/Hh/iAY3XJu7ddvt1d3nSCUu4MV6eFZgzz/Loq653qQkLkWVV+QUvo5APfp5LY9QRP/AIuclEdJ0gsxm5KAVN9cvH5WCxUchbQml7O+mG4DOx6Ifofaw8XR1M5azzONeIgcK69KeD+74moJM88LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555704; c=relaxed/simple;
	bh=4FXW24aTakuJq+Z57F/jABxW2z/rHTxHMYcpaIQ22rM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ooUM5hyC5pOgANCPWWpW9JP52LEE3HJIvNhFS0Z5F7yh9h/52s6FJ4kFKKzlHOlxuWd2JboH23k305DO0wS7bHMkgGfY2IvBYWXF/F9uHQal2Qu5COB90tqLsPL7jRc3jwJ2EuN7sx4QUG0YhLpZvSHYAZZZN4zQfOft3yrx0iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UC3gOMeZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UC3gOMeZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B691F000E9;
	Wed, 12 Aug 2026 17:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555702;
	bh=VDH7kr8gEhvrvuS9qT2fYJNha0/Kyh9MrwouODGgtck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UC3gOMeZhL0Xjcu4pOsY9y7AssL+cKuwyIozx7To8gs4f8St7wHhhg1HlYG3qzB3r
	 BnyohofqJPmkE/Er1YzKPvHMbfOlz0NoGx/uYAby4cWtzHNvsTkFcIurm5nwLmypv3
	 SOQq+vPDabgcdKyjfnRGiP7HwFtSZaM615si5WDvGoCj6JR/vqcnO4oCRF7r0COIo1
	 fPbig1rw/9GUL4lH0FfHM+a9LLwstFFUzGTphbTqRv0HYMZS/B9ENiOP2LkGOdz+QN
	 qMYmPkc8q19wnfKmk8OXeFU1CaB55Ydk2hnF11gLEIVQWmt31uULGt3CzoV94TQaLy
	 NsMZHMHvCzYfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/9] s390/vfio-ap: Fix dereference matrix_mdev->kvm
 without checking for NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812170945.738351-3-akrowiak@linux.ibm.com>
References: <20260812170945.738351-1-akrowiak@linux.ibm.com>
 <20260812170945.738351-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:28:21 +0000
Message-Id: <20260812172822.29B691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent modification and traversal of the `matrix_dev->mdev_lis=
t` without a shared lock leads to list corruption.
- [High] Uninitialized stack variable `apm_filtered` causes arbitrary queue=
 resets.
- [High] Use-after-free on `kvm->lock` inside `vfio_ap_mdev_unset_kvm()`.
--

--- Patch [2]: [PATCH v4 2/9] s390/vfio-ap: Fix dereference matrix_mdev->kv=
m without checking for NULL ---
commit cad0d18fff47859a49a2659088e88c6398e464b7
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking fo=
r NULL

This commit fixes a potential NULL pointer dereference in the callback
functions vfio_ap_on_cfg_changed and vfio_ap_on_scan_complete. It adds
checks to ensure matrix_mdev->kvm is not NULL before acquiring the
matrix_mdev->kvm->lock mutex. The lock acquisition in
vfio_ap_mdev_hot_plug_cfg is also moved to the calling functions to
satisfy lock ordering requirements.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 845c86ba8bc30..c6bee69cc22f6 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2605,8 +2605,20 @@ static void vfio_ap_mdev_cfg_remove(unsigned long =
*ap_remove,
>  	DECLARE_BITMAP(cdrem, AP_DOMAINS);
>  	int do_remove;
> =20
> +	/*
> +	 * It is safe to traverse this list here because the
> +	 * required guard - matrix_dev->guests_lock - is taken in the
> +	 * vfio_ap_on_cfg_changed function prior to this function getting
> +	 * called.
> +	 */
>  	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {

[Severity: High]
This isn't a bug introduced by this patch, but does the traversal of
matrix_dev->mdev_list here race with list modifications?

In vfio_ap_mdev_probe(), a newly created mediated device is added to the li=
st
while holding only mdevs_lock:

	mutex_lock(&matrix_dev->mdevs_lock);
	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
	mutex_unlock(&matrix_dev->mdevs_lock);

Here in vfio_ap_mdev_cfg_remove() (and similarly in=20
vfio_ap_on_scan_complete()), the list is traversed while holding only
guests_lock. Since the writer and readers do not acquire a shared lock, can
this concurrent execution lead to a corrupted doubly linked list?

> -		mutex_lock(&matrix_mdev->kvm->lock);
> +		/*
> +		 * The mdevs_lock must be held to access fields within matrix_mdev,
> +		 * and kvm->lock must be taken before mdevs_lock to satisfy the lock
> +		 * ordering requirement and prevent a lockdep splat.
> +		 */
> +		if (matrix_mdev->kvm)
> +			mutex_lock(&matrix_mdev->kvm->lock);
>  		mutex_lock(&matrix_dev->mdevs_lock);

[ ... ]

> @@ -2821,9 +2834,6 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_mat=
rix_mdev *matrix_mdev)
>  	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
>  	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug =3D fals=
e;
> =20

[Severity: High]
This is a pre-existing issue, but could apm_filtered remain uninitialized
before being consumed?

If a host AP configuration change adds only control domains, filter_adapters
and filter_domains will evaluate to false:

	filter_adapters =3D bitmap_intersects(matrix_mdev->matrix.apm,
					    matrix_mdev->apm_add, AP_DEVICES);
	filter_domains =3D bitmap_intersects(matrix_mdev->matrix.aqm,
					   matrix_mdev->aqm_add, AP_DOMAINS);

This causes the code to skip calling vfio_ap_mdev_filter_matrix(), which
normally initializes apm_filtered.

The uninitialized stack variable is then passed to reset_queues_for_apids():

	reset_queues_for_apids(matrix_mdev, apm_filtered);

Does this cause reset_queues_for_apids() to iterate over random stack garba=
ge
and reset unintended queues?

> -	mutex_lock(&matrix_mdev->kvm->lock);
> -	mutex_lock(&matrix_dev->mdevs_lock);
> -
>  	filter_adapters =3D bitmap_intersects(matrix_mdev->matrix.apm,
>  					    matrix_mdev->apm_add, AP_DEVICES);
>  	filter_domains =3D bitmap_intersects(matrix_mdev->matrix.aqm,

[ ... ]

Additionally, there appears to be another pre-existing issue in
vfio_ap_mdev_unset_kvm() which isn't part of this diff:

[Severity: High]
Is there a potential use-after-free on kvm->lock in vfio_ap_mdev_unset_kvm(=
)?

In vfio_ap_mdev_unset_kvm(), the code acquires kvm->lock via=20
get_update_locks_for_kvm(kvm) and later drops the KVM reference:

	get_update_locks_for_kvm(kvm);
	kvm_arch_crypto_clear_masks(kvm);
	vfio_ap_mdev_reset_queues(matrix_mdev);
	kvm_put_kvm(kvm);
	matrix_mdev->kvm =3D NULL;
	release_update_locks_for_kvm(kvm);

If userspace has already closed the KVM VM file descriptor, kvm_put_kvm()
could drop the final reference and free the kvm structure.

Immediately after this, release_update_locks_for_kvm(kvm) attempts to unlock
the mutex residing in the freed memory:

	if (kvm)
		mutex_unlock(&kvm->lock);

Could this result in a use-after-free on kvm->lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812170945.7383=
51-1-akrowiak@linux.ibm.com?part=3D2
