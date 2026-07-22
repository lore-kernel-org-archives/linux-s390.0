Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B251933A9DA;
	Wed, 22 Jul 2026 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730215; cv=none; b=UhyKkbZSy2oHQLoLuCX07G7V7xh47oLA2G3m+kzfRdZcVu6HJqD0EyWGBufXXK+kMFmFtoYov5UaWTW5DS7/XAo1yg/Ad7PTkM/PPKZ4FBlsnu8A1dTSej2GH9ZomNY0mEBXhy1M7NIKmCrRPFu+ZGp/eAerfUzvDcBUqj5B+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730215; c=relaxed/simple;
	bh=5vcSvTfAYWyeK8d6AFXQkBCSTNADsEqKidNRYQSBSfM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J7h4Rb3AkeLhUbeZ/xU68egIOrFf+GkQJnpT1uizm2bC+gqKBjpZh1SL5ypTtZ99sxBB2ReNCG/Me6AQ2ibojkerpXUVv1RB1u4dEJzlCWC7y6bXv6bsgcGsIXpLAbMv77fvdNTJV0vCYoY4/N91L+id7W5QYilp/GqU0LkwmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ9f8uoh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ9f8uoh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC8B1F000E9;
	Wed, 22 Jul 2026 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784730214;
	bh=VlZ2RnDEUi2LxGL6CxdbTbnCKyM/iXSLFAMMrkxeYIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FZ9f8uoh/Netc7ev7ej6/jbEHi9HSj6dGxJjjGzqGiVqcJjv23yid1E0PSnRWx+KY
	 kms9KVtwxt6/Vbmop8jOr7vrVDiM0mvMocUlWyIYoetk/FrX7wWaXQLjsfaXwy3aDv
	 pahO5/R4nA8mG+gH/23mfpcPGl2Lg6cC9dsI5D0dxotdzEeZ3+IA/sUq3kaw8911v+
	 gYsqoxTJujDTepbQUsrB9kJvH79f/Xh1goK7q8wjL2tIF29qODOCQFrQpDeNB2Ltc3
	 LrnxUkX3b7f93hEGvtwqJ4AUClTdJMAUCXj5U6llYhanm5UOQ7S7GMKLDXxZ8YIQWL
	 JgwqfRt/4ZVqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/vfio-ap: fix stale pqap_hook pointer on error in
 vfio_ap_mdev_set_kvm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260722140927.892342-1-akrowiak@linux.ibm.com>
References: <20260722140927.892342-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 14:23:34 +0000
Message-Id: <20260722142334.5BC8B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Restoring `kvm->arch.crypto.pqap_hook` to `&m->pqap_hook` afte=
r releasing update locks creates a TOCTOU race condition leading to an expl=
oitable Use-After-Free.
--

--- Patch [1]: [PATCH] s390/vfio-ap: fix stale pqap_hook pointer on error i=
n vfio_ap_mdev_set_kvm() ---
commit 3eedf7c518752f33e7b7b7758dc2098b54d797b9
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()

This commit addresses an issue where the pqap_hook pointer is left pointing
at a failing matrix_mdev when a conflicting assignment is detected. It fixes
this by restoring the hook to the legitimately attached mdev discovered
during the error path.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 44b3a1dcc1b36..e18540fd6dc75 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> @@ -1833,6 +1839,10 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_m=
dev *matrix_mdev,
>  		list_for_each_entry(m, &matrix_dev->mdev_list, node) {
>  			if (m !=3D matrix_mdev && m->kvm =3D=3D kvm) {
>  				release_update_locks_for_kvm(kvm);
> +				/* Undo the hook installation since we're failing */
> +				down_write(&kvm->arch.crypto.pqap_hook_rwsem);
> +				kvm->arch.crypto.pqap_hook =3D &m->pqap_hook;

[Severity: Critical]
Is there a race condition introduced here since the update locks are releas=
ed
right before restoring the hook pointer?

Looking at vfio_ap_mdev_set_kvm() in drivers/s390/crypto/vfio_ap_ops.c,=20
release_update_locks_for_kvm() drops the mutexes that protect the mdev
list. Once those locks are dropped, could another thread concurrently remove
and free the existing mdev (m)?

If m is freed while we are waiting to acquire the pqap_hook_rwsem, this code
would then assign a dangling pointer to kvm->arch.crypto.pqap_hook. Later,
when the guest executes a PQAP instruction, it might dereference this freed
memory, resulting in a use-after-free.

Would it be safer to restore the hook pointer before calling
release_update_locks_for_kvm() to ensure m remains valid?

> +				up_write(&kvm->arch.crypto.pqap_hook_rwsem);
>  				return -EPERM;
>  			}
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722140927.8923=
42-1-akrowiak@linux.ibm.com?part=3D1
