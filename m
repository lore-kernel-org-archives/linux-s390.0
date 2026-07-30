Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5C37B012;
	Thu, 30 Jul 2026 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785426421; cv=none; b=HU4Qy44aaqNxh4yjbrHDM2Fhm5cbvvjqXxvyS0Wo2BjwvyTtJjlYLkT2J3UhJslidxah6eiTvaUZTnCeWKqJRoDewe68edfzAs5zYGo9i2LUrPEGaZIEUI2B4HkTNlc8tdSmkOgy+Yyn2vlLqJW70OLxtdF4hFih5cWwXMbNwNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785426421; c=relaxed/simple;
	bh=+WM9Fv05eGPSbpnl8U8M0nlsC0Ei27t3cMrWugEs8lw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=smjcBiFz09OQpTyGHDJ3tJp3C8+GHrknidGtsNG7E40FRGJXrhqSMlFHjFwaku//madFFuPrWrkJ5ZtQsZrgdjalqgUKRTtq7m5nplLEBMnetqT4xupBIO5CRvel0EAjCeZP0WRNUyQdsc65T7yOpkB2wH7w25C0QWEu1x0FnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1KWAsew; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1KWAsew"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3241F00A3A;
	Thu, 30 Jul 2026 15:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785426419;
	bh=gs3C1zCDvA2wp9wg7YnZk+CxKVlnTztzohVmGraT5p4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T1KWAsewlkov6VqHTBzIxdo9rW5ZcB4KY/yRUYLKzNJ0jv6SCobxqGKwdE4750L6X
	 AaMdYbQjfFwMQA8rs/EaDqhcKqFplE5U8W06nO0UPAlfaD9BeYbqAPhj2y4yu01avs
	 MPIAiMs1ijfXFtyR0yDmVtSOK/aVS4uttia28NEFVALAAr8B/iKN5PjJ3n6SZORqxo
	 zjwcZr6CWRMSET1JbzfKy2t/u3WYxRhQwYQfn5uHgcQYC/JMS5Nh2+MqUJstyHi6vz
	 vpEt4sLcqASjh8MWMjJTpWvkItKO0L6biUfrWE1vZRWbF4eOQVD/g7ka0NSMDZZj9V
	 V03fMTFCm0akg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] s390/vfio-ap: fix stale pqap_hook pointer on error
 in vfio_ap_mdev_set_kvm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260730152628.3158573-1-akrowiak@linux.ibm.com>
References: <20260730152628.3158573-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 15:46:59 +0000
Message-Id: <20260730154659.AE3241F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Lock inversion between KVM's SRCU (`kvm->srcu`), `pqap_hook_rwsem`=
, and `kvm->lock` leads to circular deadlocks.

Pre-existing issues:
- [Critical] Calling `kvm_put_kvm(kvm)` before releasing `kvm->lock` and `p=
qap_hook_rwsem` leads to a potential Use-After-Free of the locks embedded i=
n the `kvm` structure.
--

--- Patch [1]: [PATCH v3] s390/vfio-ap: fix stale pqap_hook pointer on erro=
r in vfio_ap_mdev_set_kvm() ---
commit 5f259db058dc54a89b0a65f6eb549bf2d44cc6f7
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()

In vfio_ap_mdev_set_kvm(), kvm->arch.crypto.pqap_hook is set to
&matrix_mdev->pqap_hook before the update locks are acquired and the
mdev list is checked for a conflicting assignment.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 44b3a1dcc1b36..f9460310d47b1 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1821,27 +1821,20 @@ static const struct attribute_group *vfio_ap_mdev=
_attr_groups[] =3D {
>  static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>  				struct kvm *kvm)
>  {
> -	struct ap_matrix_mdev *m;
> -
>  	if (kvm->arch.crypto.crycbd) {
>  		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
> +		if (kvm->arch.crypto.pqap_hook) {
> +			up_write(&kvm->arch.crypto.pqap_hook_rwsem);
> +			return -EPERM;
> +		}
>  		kvm->arch.crypto.pqap_hook =3D &matrix_mdev->pqap_hook;
> -		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
> =20
>  		get_update_locks_for_kvm(kvm);

[Severity: High]
Does acquiring the locks in this order create a circular deadlock with KVM's
SRCU and kvm->lock?

If a guest executes a PQAP instruction, the KVM intercept handler runs with
srcu_read_lock(&kvm->srcu) held and acquires pqap_hook_rwsem in read mode.

By holding pqap_hook_rwsem in write mode here across
get_update_locks_for_kvm(), which acquires kvm->lock, this introduces a lock
dependency: pqap_hook_rwsem -> kvm->lock.

If a concurrent KVM core operation acquires kvm->lock and then calls
synchronize_srcu(&kvm->srcu), this creates a 3-way circular deadlock:
kvm->srcu -> pqap_hook_rwsem -> kvm->lock -> kvm->srcu.

[ ... ]

> @@ -1885,7 +1878,6 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix=
_mdev *matrix_mdev)
>  	if (kvm && kvm->arch.crypto.crycbd) {
>  		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
>  		kvm->arch.crypto.pqap_hook =3D NULL;
> -		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
> =20
>  		get_update_locks_for_kvm(kvm);
> =20
> @@ -1895,6 +1887,7 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix=
_mdev *matrix_mdev)
>  		matrix_mdev->kvm =3D NULL;
> =20
>  		release_update_locks_for_kvm(kvm);
> +		up_write(&kvm->arch.crypto.pqap_hook_rwsem);

[Severity: Critical]
This is a pre-existing issue, but does dropping the KVM reference before
releasing the locks lead to a use-after-free of the kvm structure?

If userspace closes the KVM file descriptor before closing the mdev file
descriptor, the initial KVM reference is dropped. When kvm_put_kvm(kvm)
is called just before this block in vfio_ap_mdev_unset_kvm(), it drops
the final reference and synchronously frees the kvm structure.

The subsequent calls to release_update_locks_for_kvm() and
up_write(&kvm->arch.crypto.pqap_hook_rwsem) will then attempt to unlock
mutexes within the freed kvm struct, which can corrupt memory.

>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730152628.3158=
573-1-akrowiak@linux.ibm.com?part=3D1
