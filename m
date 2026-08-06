Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8145A37C926;
	Thu,  6 Aug 2026 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039013; cv=none; b=pwrhNBPr9Y+hehDyxnvhgk7roD9WkiH6tlyrid+sr/q2VvP8xtPR6Rszkzv5z3cDrQHW7DMOtC1C9RyhVSZ/NTRs+VFIl2O8V83EtDrKWb0SryRfJQk6r8ZCtW+/i95HrnBvGo99XmOLMtLcbaamxX2Db7isWvQ6wZWoR781cbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039013; c=relaxed/simple;
	bh=Gi9+YZqxzC5U/H3r1duCSln5ETVs0zLEDlnnILVT4NM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ChcbKbXISpVtOzQ9EDFEeJXMCuCY9b+xDjJg/S3YXZlQ7bhJx1pOA8X5zMxJvDQbXtqTJIyWqyriRpsDOvr1RhyEn5djsFdSY48HLFw/sxcTwZP7+AHrcYjQWhJofmo2Dxp5GOvjvuwLhCxpGGzY8eOBI+pUK19Z7jEutRt2A8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiZtO5mE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiZtO5mE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01F01F000E9;
	Thu,  6 Aug 2026 17:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786039012;
	bh=CaQlW6cHFmuWddebCtXjR8Mmp9ES/DbEmvhyFyTQg4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NiZtO5mEIgfXc3cnZYUZk/pCgIGTCTbrs3ZmwDe2KIfeQMb1PP+ACfr3LzmXEVg8v
	 9R6m9sjdkmvGeU01lOGfifqHzCGfICjKvY1VPjqfGEQ3bsjaAoiGIFKJhppM4+Thzx
	 /AI0ymHFMX0bsFl65QfhEibafxiLEzD9pLfyIMmav0FWpLu53GUGUX6/wVKhf9sBTJ
	 DdjvxwByGaP6oTL6wmagKzQDMc+o00gqY0u6KZCcqgNHv+XbAO7bBrAfLLGyMNlHHX
	 43uX3K+Cbol+xnXCv+6NaMgxbRVaLC8Pk943qANLJg06CaiFSumswaT7oTfMN/c8z2
	 S7Y3KIU8vvoog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] s390/vfio-ap: fix stale pqap_hook pointer on error
 in vfio_ap_mdev_set_kvm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260806173435.105044-1-akrowiak@linux.ibm.com>
References: <20260806173435.105044-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 17:56:51 +0000
Message-Id: <20260806175651.C01F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional dereference of `matrix_mdev->kvm` when handling host=
 AP configuration changes.
--

--- Patch [1]: [PATCH v5] s390/vfio-ap: fix stale pqap_hook pointer on erro=
r in vfio_ap_mdev_set_kvm() ---
commit ea70bf8efc92cb332a90ca640bf9deec142d0044
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()

This commit fixes a stale pointer use-after-free issue when another mdev is=
=20
already attached to a KVM instance. It avoids iterating the mdev_list under=
=20
the mdevs_lock by changing the rwsem lock order and checking if=20
kvm->arch.crypto.pqap_hook is already set.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 44b3a1dcc1b36..99a0efd999ef9 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> @@ -1883,18 +1881,15 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matr=
ix_mdev *matrix_mdev)
>  	struct kvm *kvm =3D matrix_mdev->kvm;
> =20
>  	if (kvm && kvm->arch.crypto.crycbd) {
> -		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
> -		kvm->arch.crypto.pqap_hook =3D NULL;
> -		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
> -
>  		get_update_locks_for_kvm(kvm);
> +		kvm->arch.crypto.pqap_hook =3D NULL;
> =20
>  		kvm_arch_crypto_clear_masks(kvm);
>  		vfio_ap_mdev_reset_queues(matrix_mdev);
> -		kvm_put_kvm(kvm);
>  		matrix_mdev->kvm =3D NULL;

[Severity: High]
This is a pre-existing issue, but can unattached mdevs cause a crash during
host AP configuration changes?

If an mdev is created but not attached to a guest (meaning matrix_mdev->kvm
is NULL), and a host AP config change occurs, vfio_ap_on_cfg_changed()
eventually triggers vfio_ap_mdev_cfg_remove():

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_cfg_remove() {
    ...
	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
		mutex_lock(&matrix_mdev->kvm->lock);
    ...
}

Will this unconditionally dereference matrix_mdev->kvm and cause a panic
since it isn't checked for NULL?  A similar path exists in
vfio_ap_mdev_hot_plug_cfg() as well.

> =20
>  		release_update_locks_for_kvm(kvm);
> +		kvm_put_kvm(kvm);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806173435.1050=
44-1-akrowiak@linux.ibm.com?part=3D1
