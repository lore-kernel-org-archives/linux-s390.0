Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0E5318B9C;
	Tue, 28 Jul 2026 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256867; cv=none; b=hQJRkHy6e1pD539C5SbvC0NOPvFcWLCuUxsXWUXO494FRpKnrxx6YXoDjBwCADTGapGxf4CmclidgMg3sJynjik34LyoKWOq6ZAOQB3MvN+ai72qnFQe32CQjNMDAuHB0cIHzvjpl9zpZtclPP8Ag98p5tpUGiM8i47zwdHBJto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256867; c=relaxed/simple;
	bh=h2yASVgT6omJ/ZyQW4BRUI5MDgQstXlGyF93GjEvPWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AfJEonEd+J+yTq1CTdfOPoQT3VDta87LgjFuAYGKWUEYbsbXQIo9oCgE0W2fZWI+SQGjUEEBSHTkuUrCu9Hk5lTI5jomv9Nz5RZ0upHgbQQHUUmErptE6Y4AvbKzXvPEEFgwdmbbboY/JmJQBiyu5gVOFn6izn/MJtD5yzpJ8yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFtKrvZb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFtKrvZb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAC01F000E9;
	Tue, 28 Jul 2026 16:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785256865;
	bh=KyELPn0zegrah0YqqW5JFKleUtcMd+FE7B6nIdVPsCE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mFtKrvZbRovRjqyJY1G2vCIUfgva9uxaKMbtEB0cAGH3uFLTdmk4fH/IZupDYMihp
	 F0nI8aWOhxah8UuAc9zfiQMWqKX9hESj9k+74hl0FBgzZmSFAOIwhRuOiNxULWeqPv
	 FA4ag30zHjdrqpi6f73nGBK89GrgsFhzUe8Xce1AxByAz1nvubay/cfVavgxtqLkMo
	 x6LGNA0grkqi0l4GT/lRRvvzo35E+m93S/n5hE4QLZTU28111HuT+4ehFJTKSTYLjY
	 rB9vbo5YpEtxYH+Q3hbVhyPh69UDX+U3kifigTjQwnUvkfqFXECs0GHcj7CI93lnR4
	 0J3ZpVTQZkODQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390/vfio-ap: fix stale pqap_hook pointer on error
 in vfio_ap_mdev_set_kvm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260728162705.2631004-1-akrowiak@linux.ibm.com>
References: <20260728162705.2631004-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 16:41:04 +0000
Message-Id: <20260728164105.4AAC01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the `mdev_list` iteration from within the `update_locks` =
critical section introduces a Time-Of-Check to Time-Of-Use (TOCTOU) race co=
ndition between `vfio_ap_mdev_set_kvm()` and `vfio_ap_mdev_unset_kvm()` tha=
t silently clobbers KVM APCB masks for a newly attached mdev.
--

--- Patch [1]: [PATCH v2] s390/vfio-ap: fix stale pqap_hook pointer on erro=
r in vfio_ap_mdev_set_kvm() ---
commit 0834fa20c3fb715cac9e1ff09376e43784d44814
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()

This commit changes vfio_ap_mdev_set_kvm() to use pqap_hook to detect
conflicting assignments instead of iterating mdev_list under the update loc=
ks,
resolving a potential stale pointer dereference.

Fixes: 86956e70761b3 ("s390/vfio-ap: replace open coded locks for VFIO_GROU=
P_NOTIFY_SET_KVM notification")
Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 44b3a1dcc1b36..b0a038faa93ac 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> @@ -1821,26 +1821,25 @@ static const struct attribute_group *vfio_ap_mdev=
_attr_groups[] =3D {
>  static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>  				struct kvm *kvm)
>  {
> -	struct ap_matrix_mdev *m;
> -
>  	if (kvm->arch.crypto.crycbd) {
> +		/*
> +		 * Taking the kvm->arch.crypto.pqap_hook_rwsem lock while
> +		 * holding the update locks (below) could result in a
> +		 * deadlock condition, so let's hold the rwsem here while we
> +		 * check and update the pqap_hook.
> +		 */
>  		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
> +		if (kvm->arch.crypto.pqap_hook) {
> +			up_write(&kvm->arch.crypto.pqap_hook_rwsem);
> +			return -EPERM;
> +		}
>  		kvm->arch.crypto.pqap_hook =3D &matrix_mdev->pqap_hook;
>  		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
> =20
>  		get_update_locks_for_kvm(kvm);

[Severity: High]
Can this introduce a race with vfio_ap_mdev_unset_kvm()?

By moving the conflict check outside of the update_locks critical section,
is it possible for the following sequence to occur during concurrent
hot-plug/unplug operations?

Thread 1 (in vfio_ap_mdev_unset_kvm):
    down_write(&kvm->arch.crypto.pqap_hook_rwsem);
    kvm->arch.crypto.pqap_hook =3D NULL;
    up_write(&kvm->arch.crypto.pqap_hook_rwsem);

Thread 2 (in vfio_ap_mdev_set_kvm):
    down_write(&kvm->arch.crypto.pqap_hook_rwsem);
    // Sees pqap_hook is NULL
    kvm->arch.crypto.pqap_hook =3D &matrix_mdev->pqap_hook;
    up_write(&kvm->arch.crypto.pqap_hook_rwsem);
    get_update_locks_for_kvm(kvm);
    vfio_ap_mdev_update_guest_apcb(matrix_mdev);
    release_update_locks_for_kvm(kvm);

Thread 1 (continuing in vfio_ap_mdev_unset_kvm):
    get_update_locks_for_kvm(kvm);
    kvm_arch_crypto_clear_masks(kvm);

If Thread 1 interleaves after Thread 2 sets the guest masks but before Thre=
ad
1 clears them, would this result in Thread 1 unconditionally clearing the K=
VM
APCB masks that Thread 2 just successfully configured, leaving the newly
attached mdev with inaccessible queues?

> -
> -		list_for_each_entry(m, &matrix_dev->mdev_list, node) {
> -			if (m !=3D matrix_mdev && m->kvm =3D=3D kvm) {
> -				release_update_locks_for_kvm(kvm);
> -				return -EPERM;
> -			}
> -		}
> -
>  		kvm_get_kvm(kvm);
>  		matrix_mdev->kvm =3D kvm;
>  		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> -
>  		release_update_locks_for_kvm(kvm);
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728162705.2631=
004-1-akrowiak@linux.ibm.com?part=3D1
